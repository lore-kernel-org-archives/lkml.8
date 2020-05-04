Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E967C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084D92073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgEDRPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgEDRPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F902068E;
        Mon,  4 May 2020 17:15:02 +0000 (UTC)
Date:   Mon, 4 May 2020 13:15:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in
 kmsg_dumper
Message-ID: <20200504131500.5f6c8860@gandalf.local.home>
In-Reply-To: <20200502143555.543636-2-pasha.tatashin@soleen.com>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
        <20200502143555.543636-2-pasha.tatashin@soleen.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 May 2020 10:35:53 -0400
Pavel Tatashin <pasha.tatashin@soleen.com> wrote:

> kmsg_dump() allows to dump kmesg buffer for various system events: oops,
> panic, reboot, etc. It provides an interface to register a callback call
> for clients, and in that callback interface there is a field "max_reason"
> which gets ignored unless always_kmsg_dump is passed as kernel parameter.
> 
> Allow clients to decide max_reason, and keep the current behavior when
> max_reason is not set.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kmsg_dump.h |  1 +
>  kernel/printk/printk.c    | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 2e7a1e032c71..c0d703b7ce38 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -28,6 +28,7 @@ enum kmsg_dump_reason {
>  	KMSG_DUMP_RESTART,
>  	KMSG_DUMP_HALT,
>  	KMSG_DUMP_POWEROFF,
> +	KMSG_DUMP_MAX = KMSG_DUMP_POWEROFF

Hmm, I didn't realize that enums were allowed to have duplicates. That can
usually screw up logic. I would recommend making that a define afterward.

#define KMSG_DUMP_MAX KMSG_DUMP_POWEROFF

As is done in other locations of the kernel.


The rest looks fine to me.

-- Steve

>  };
>  
>  /**
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..04c1e9a9b139 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3085,6 +3085,8 @@ EXPORT_SYMBOL(printk_timed_ratelimit);
>  
>  static DEFINE_SPINLOCK(dump_list_lock);
>  static LIST_HEAD(dump_list);
> +static bool always_kmsg_dump;
> +module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
>  
>  /**
>   * kmsg_dump_register - register a kernel log dumper.
> @@ -3106,6 +3108,12 @@ int kmsg_dump_register(struct kmsg_dumper *dumper)
>  	spin_lock_irqsave(&dump_list_lock, flags);
>  	/* Don't allow registering multiple times */
>  	if (!dumper->registered) {
> +		if (!dumper->max_reason) {
> +			if (always_kmsg_dump)
> +				dumper->max_reason = KMSG_DUMP_MAX;
> +			else
> +				dumper->max_reason = KMSG_DUMP_OOPS;
> +		}
>  		dumper->registered = 1;
>  		list_add_tail_rcu(&dumper->list, &dump_list);
>  		err = 0;
> @@ -3141,9 +3149,6 @@ int kmsg_dump_unregister(struct kmsg_dumper *dumper)
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_unregister);
>  
> -static bool always_kmsg_dump;
> -module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
> -
>  /**
>   * kmsg_dump - dump kernel log to kernel message dumpers.
>   * @reason: the reason (oops, panic etc) for dumping
> @@ -3157,12 +3162,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  	struct kmsg_dumper *dumper;
>  	unsigned long flags;
>  
> -	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
> -		return;
> -
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(dumper, &dump_list, list) {
> -		if (dumper->max_reason && reason > dumper->max_reason)
> +		if (reason > dumper->max_reason)
>  			continue;
>  
>  		/* initialize iterator with data about the stored records */

