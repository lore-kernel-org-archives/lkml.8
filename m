Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655BC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD87620663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPLz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:55:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51450 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:55:57 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is3kb-0005oG-Ds; Thu, 16 Jan 2020 12:55:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 11E1F101B66; Thu, 16 Jan 2020 12:55:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        longman@redhat.com, mingo@kernel.org, mm-commits@vger.kernel.org,
        rppt@linux.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: + watchdog-fix-possible-soft-lockup-warning-at-bootup-v2.patch added to -mm tree
In-Reply-To: <20200107233656.GS5UK5wEy%akpm@linux-foundation.org>
References: <20200107233656.GS5UK5wEy%akpm@linux-foundation.org>
Date:   Thu, 16 Jan 2020 12:55:49 +0100
Message-ID: <878sm7wr7e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@linux-foundation.org writes:

> ------------------------------------------------------
> From: Waiman Long <longman@redhat.com>
> Subject: watchdog: Fix possible soft lockup warning at bootup

Completely empty changelog without any justification for this change.

> Link: http://lkml.kernel.org/r/20200103151032.19590-1-longman@redhat.com
> Signed-off-by: Waiman Long <longman@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  kernel/watchdog.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> --- a/kernel/watchdog.c~watchdog-fix-possible-soft-lockup-warning-at-bootup-v2
> +++ a/kernel/watchdog.c
> @@ -496,9 +496,7 @@ static void watchdog_enable(unsigned int
>  		      HRTIMER_MODE_REL_PINNED_HARD);
>  
>  	/* Initialize timestamp */
> -	if (system_state != SYSTEM_BOOTING)
> -		__touch_watchdog();
> -
> +	__touch_watchdog();
>  	/* Enable the perf event */
>  	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
>  		watchdog_nmi_enable(cpu);
> _
>
> Patches currently in -mm which might be from longman@redhat.com are
>
> watchdog-fix-possible-soft-lockup-warning-at-bootup.patch
> watchdog-fix-possible-soft-lockup-warning-at-bootup-v2.patch

Please drop both. The initial one just papers over timer interrupt loss
and weakens debugging. That V2 thing is just fixing up the wreckage
introduced in the initial one.

Thanks,

        tglx
