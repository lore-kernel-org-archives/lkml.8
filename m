Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F28206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBKMnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:43:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgBKMnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:43:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84F0FBC13;
        Tue, 11 Feb 2020 12:43:18 +0000 (UTC)
Date:   Tue, 11 Feb 2020 13:43:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
Message-ID: <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-02-03 15:15:28, Andy Shevchenko wrote:
> Static analyzer is not happy:
> 
> kernel/printk/printk.c:421:1: warning: symbol 'log_wait' was not declared. Should it be static?
> 
> This is due to usage of log_wait in the other module without announcing
> its declaration to the world. I wasn't able to dug into deep history of
> reasons why it is so, and thus decide to make less invasive change, i.e.
> declaring log_wait as external variable to make static analyzer happy.
> 
> Note the above is done if and only if the CONFIG_PROC_FS is enabled,
> otherwise we fallback to static variable.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/printk/printk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 633f41a11d75..43b5cb88c607 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -418,7 +418,14 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>  	} while (0)
>  
>  #ifdef CONFIG_PRINTK
> +
> +#ifdef CONFIG_PROC_FS
> +extern wait_queue_head_t log_wait;	/* Used in fs/proc/kmsg.c */
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +#else
> +static DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +#endif /* CONFIG_PROC_FS */

This looks too complicated as a workaround for a warning.

I got really confused. Probably also because the macro DECLARE_*()
does a definition instead of a declaration.

As a minimal fix, I suggest to rename log_wait -> printk_log_wait
and declare it in include/linux/printk.h.

Even better solution might be to move fs/proc/kmsg.c to
kernel/printk/proc_kmsg.c and declare printk_log_wait only
in kernel/printk/internal.h. I think that this is what
Sergey suggested.

Another great thing would be to extract devkmsg stuff from
kernel/printk/printk.c and put it into kernel/printk/dev_kmsg.c.

I am not sure but it might help people to realize that there
are actually two different interfaces (old in /proc dmesg-like,
and in /dev new for systemd). Sigh.

I am not sure how deep and far you would like to go ;-)

Best Regards,
Petr
