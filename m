Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D73C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13524658
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgCCJTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgCCJTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:19:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9775CB1C7;
        Tue,  3 Mar 2020 09:18:48 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:18:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200303091847.uyy7gzac52lkl75m@pathway.suse.cz>
References: <20200303044059.1325-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303044059.1325-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-03-03 13:40:59, Sergey Senozhatsky wrote:
> Lech Perczak [0] reports that after commit 1b710b1b10ef
> ("char/random: silence a lockdep splat with printk()")
> user-space syslog/kmsg readers are not able to read new
> kernel messages. The reason is printk_deferred() being
> called too early (as was pointed out by Petr and John).
> 
> Fix printk_deferred() and do not queue per-CPU irq_work
> before per-CPU areas are initialized.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ad4606234545..d951d35a0786 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1147,12 +1159,25 @@ static void __init log_buf_add_cpu(void)
>  static inline void log_buf_add_cpu(void) {}
>  #endif /* CONFIG_SMP */
>  
> +static void __init set_percpu_data_ready(void)
> +{
> +	__printk_percpu_data_ready = true;
> +}
> +
>  void __init setup_log_buf(int early)
>  {
>  	unsigned long flags;
>  	char *new_log_buf;
>  	unsigned int free;
>  
> +	/*
> +	 * Some archs call setup_log_buf() multiple times - first is very
> +	 * early, e.g. from setup_arch(), and second - when percpu_areas
> +	 * are initialised.
> +	 */
> +	if (!early)
> +		set_percpu_data_ready();
> +
>  	if (log_buf != __log_buf)
>  		return;
>  
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index b4045e782743..d9a659a686f3 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -27,7 +27,6 @@
a>   * There are situations when we want to make sure that all buffers
>   * were handled or when IRQs are blocked.
>   */
> -static int printk_safe_irq_ready __read_mostly;
>  
>  #define SAFE_LOG_BUF_LEN ((1 << CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT) -	\
>  				sizeof(atomic_t) -			\
> @@ -51,7 +50,7 @@ static DEFINE_PER_CPU(struct printk_safe_seq_buf, nmi_print_seq);
>  /* Get flushed in a more safe context. */
>  static void queue_flush_work(struct printk_safe_seq_buf *s)
>  {
> -	if (printk_safe_irq_ready)
> +	if (printk_percpu_data_ready())
>  		irq_work_queue(&s->work);

This is not safe. printk_percpu_data_ready() returns true even before
s->work gets initialized by printk_safe_init().

Solution would be to call printk_safe_init() from
setup_log_buf() before calling set_percpu_data_ready().

Or I would keep printk_safe code as it. I hope that it will get
removed rather soon anyway.

Otherwise, it looks good to me.

Best Regards,
Petr
