Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F0DC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893C721741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580895377;
	bh=RwByi0XDoyCwQdPe5YV1dEFXavEuBmppr0k662j0vE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1XnhxLRF7L4uhcwX0IlMUbkF0wcXjorSMO1iJ6WpNDHm4AIxV/oZfDv6dhhafhMtX
	 2Llk7OlGB9KtzksEbHuhSe9ovOuJt0FTQWyxHGkQ42YpEPc+cuD77JgG2J55Y0mcpa
	 E4Y5KGIIhcErem+b2ZoKC62grmZyxPl2qBVHIZe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBEJgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgBEJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:36:16 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD5E20661;
        Wed,  5 Feb 2020 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580895375;
        bh=RwByi0XDoyCwQdPe5YV1dEFXavEuBmppr0k662j0vE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVMZpACbv7YDWH+Ckvp13K/sQxq6HMXMZWFjtjxgZOzZCqv9+3Rz5m7YrNUSRGzRo
         8xla3g7gqRFfMK8GwmrjBaSCImKNAg1i5cq0H1VmAJSHqnh8N8ShGFvp+81/Aocfwd
         zPKKa2l7omXB4nxNHq8JHvMsPIqUAf6bH7AZ+bNg=
Date:   Wed, 5 Feb 2020 09:36:12 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min.Liu@mediatek.com
Subject: Re: [PATCH v1 1/1] binder: transaction latency tracking for user
 build
Message-ID: <20200205093612.GA1167956@kroah.com>
References: <1580885572-14272-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580885572-14272-1-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:52:52PM +0800, Frankie Chang wrote:
> Record start/end timestamp to binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),
> if yes, printing related information for tracing.
> 
> Signed-off-by: Frankie Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/Kconfig           |    8 +++
>  drivers/android/binder.c          |  107 +++++++++++++++++++++++++++++++++++++
>  drivers/android/binder_internal.h |    4 ++
>  3 files changed, 119 insertions(+)
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 6fdf2ab..7ba80eb 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  exhaustively with combinations of various buffer sizes and
>  	  alignments.
>  
> +config BINDER_USER_TRACKING
> +	bool "Android Binder transaction tracking"
> +	help
> +	  Used for track abnormal binder transaction which is over 2 seconds,
> +	  when the transaction is done or be free, this transaction would be
> +	  checked whether it executed overtime.
> +	  If yes, printing out the detail info about it.
> +
>  endif # if ANDROID
>  
>  endmenu
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index e9bc9fc..5a352ee 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -76,6 +76,11 @@
>  #include "binder_internal.h"
>  #include "binder_trace.h"
>  
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +#include <linux/rtc.h>
> +#include <linux/time.h>
> +#endif
> +
>  static HLIST_HEAD(binder_deferred_list);
>  static DEFINE_MUTEX(binder_deferred_lock);
>  
> @@ -591,8 +596,104 @@ struct binder_transaction {
>  	 * during thread teardown
>  	 */
>  	spinlock_t lock;
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +	struct timespec timestamp;
> +	struct timeval tv;
> +#endif
>  };
>  
> +#ifdef CONFIG_BINDER_USER_TRACKING
> +
> +/*
> + * binder_print_delay - Output info of a delay transaction
> + * @t:          pointer to the over-time transaction
> + */
> +static void binder_print_delay(struct binder_transaction *t)
> +{
> +	struct rtc_time tm;
> +	struct timespec *startime;
> +	struct timespec cur, sub_t;
> +
> +	ktime_get_ts(&cur);
> +	startime = &t->timestamp;
> +	sub_t = timespec_sub(cur, *startime);
> +
> +	/* if transaction time is over than 2 sec,
> +	 * show timeout warning log.
> +	 */
> +	if (sub_t.tv_sec < 2)
> +		return;
> +
> +	rtc_time_to_tm(t->tv.tv_sec, &tm);
> +
> +	spin_lock(&t->lock);
> +	pr_info_ratelimited("%d: from %d:%d to %d:%d",
> +			    t->debug_id,
> +			    t->from ? t->from->proc->pid : 0,
> +			    t->from ? t->from->pid : 0,
> +			    t->to_proc ? t->to_proc->pid : 0,
> +			    t->to_thread ? t->to_thread->pid : 0);
> +	spin_unlock(&t->lock);
> +
> +	pr_info_ratelimited(" total %u.%03ld s code %u start %lu.%03ld android %d-%02d-%02d %02d:%02d:%02d.%03lu\n",
> +			    (unsigned int)sub_t.tv_sec,
> +			    (sub_t.tv_nsec / NSEC_PER_MSEC),
> +			    t->code,
> +			    (unsigned long)startime->tv_sec,
> +			    (startime->tv_nsec / NSEC_PER_MSEC),
> +			    (tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +			    tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			    (unsigned long)(t->tv.tv_usec / USEC_PER_MSEC));
> +}

Ick, why not use a tracepoint for this instead?

And what is userspace supposed to do with this if they see it?

thanks,

greg k-h
