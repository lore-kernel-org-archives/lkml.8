Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBDC2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbgEMQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgEMQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:17:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E0C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:17:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYu42-000053-0g; Wed, 13 May 2020 18:16:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 832EC100605; Wed, 13 May 2020 18:16:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 5/6] Optionally flush L1D on context switch
In-Reply-To: <20200510014803.12190-6-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-6-sblbir@amazon.com>
Date:   Wed, 13 May 2020 18:16:56 +0200
Message-ID: <875zcz3j47.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:

This part:

> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,8 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +/* Flush L1D on context switch (mm) */
> +#define PR_SET_L1D_FLUSH		59
> +#define PR_GET_L1D_FLUSH		60

...

> @@ -2514,6 +2524,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +	case PR_SET_L1D_FLUSH:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_set(me, arg2);
> +		break;
> +	case PR_GET_L1D_FLUSH:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_get(me);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;

wants to be split into a separate patch, really. Then we get a proper
subject lines with proper subsystem prefixes. This part also lacks a
description in Documentation/userspace-api/ and function prototypes for
the arch_prctl* functions.

But looking at this deeper (yes I should have noticed earlier):

    Why do we need yet another PRCTL?

We already have PR_SET_SPECULATION_CTRL/PR_GET_SPECULATION_CTRL. That
L1D flush thingy fits into this category, right?

This makes even more sense if you think about the second use case for
L1D flush, i.e. the flush when a untrusted task comes in. If we ever
want to support that case then this will be imposed by seccomp and then
we'd need yet another interface there.

And for this reason we should also name that current opt-in thingy:
L1D_FLUSH_OUT in the prctl and also for the TIF bits.

Hmm? Kees?

I've applied the first 4 patches to:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/mm

so the polishing I did gets preserved and you don't have to resend the
whole pile.

Thanks,

        tglx
