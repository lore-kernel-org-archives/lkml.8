Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D2EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBF206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405705AbgFYPUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:20:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404580AbgFYPUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:20:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 099E5AFFC;
        Thu, 25 Jun 2020 15:20:43 +0000 (UTC)
Date:   Thu, 25 Jun 2020 17:20:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: syslog size unread: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200625152042.GI8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 16:55:19, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1609,11 +1633,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Number of chars in the log buffer */
>  	case SYSLOG_ACTION_SIZE_UNREAD:
> +		if (source != SYSLOG_FROM_PROC) {
> +			text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
> +			if (!text)
> +				return -ENOMEM;

The buffer is needed only to count lines to count the size of
added prefixes. Could we use the new prb_read_valid_info() that
allows to get the number of lines without actually reading the buffer?

> +
> +		}
>  		logbuf_lock_irq();
> -		if (syslog_seq < log_first_seq) {
> +		if (syslog_seq < prb_first_seq(prb)) {
>  			/* messages are gone, move to first one */
> -			syslog_seq = log_first_seq;
> -			syslog_idx = log_first_idx;
> +			syslog_seq = prb_first_seq(prb);
>  			syslog_partial = 0;
>  		}
>  		if (source == SYSLOG_FROM_PROC) {

Best Regards,
Petr
