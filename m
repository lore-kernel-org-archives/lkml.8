Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99437C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A610206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgENIt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:49:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:58674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENIt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:49:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C71A7AA4F;
        Thu, 14 May 2020 08:49:58 +0000 (UTC)
Date:   Thu, 14 May 2020 10:49:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] printk: honor the max_reason field in kmsg_dumper
Message-ID: <20200514084954.GP17734@linux-b0ei>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154510.93506-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-05 11:45:06, Pavel Tatashin wrote:
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
>  kernel/printk/printk.c    | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 2e7a1e032c71..cfc042066be7 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -28,6 +28,7 @@ enum kmsg_dump_reason {
>  	KMSG_DUMP_RESTART,
>  	KMSG_DUMP_HALT,
>  	KMSG_DUMP_POWEROFF,
> +	KMSG_DUMP_MAX
>  };
>  
>  /**
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..1aab69a8a2bf 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3157,12 +3157,19 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  	struct kmsg_dumper *dumper;
>  	unsigned long flags;
>  
> -	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
> -		return;
> -
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(dumper, &dump_list, list) {
> -		if (dumper->max_reason && reason > dumper->max_reason)
> +		enum kmsg_dump_reason cur_reason = dumper->max_reason;

If this code is still in the next version, please, rename this variable
to max_reason or so.

"cur" is ambiguous. It might be current dumper or current message
which confused me later in the code ;-)

Best Regards,
Petr

> +
> +		/*
> +		 * If client has not provided a specific max_reason, default
> +		 * to KMSG_DUMP_OOPS, unless always_kmsg_dump was set.
> +		 */
> +		if (cur_reason == KMSG_DUMP_UNDEF) {
> +			cur_reason = always_kmsg_dump ? KMSG_DUMP_MAX :
> +							KMSG_DUMP_OOPS;
> +		}
> +		if (reason > cur_reason)
>  			continue;
>  
>  		/* initialize iterator with data about the stored records */
> -- 
> 2.25.1
