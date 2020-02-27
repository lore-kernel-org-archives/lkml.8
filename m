Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CFC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB3624697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wR2VozWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgB0RJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:09:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61978 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgB0RJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:09:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Szg86mjrz9tyl9;
        Thu, 27 Feb 2020 18:09:40 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wR2VozWe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sWRTNANo0VvI; Thu, 27 Feb 2020 18:09:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Szg85cnNz9tyl6;
        Thu, 27 Feb 2020 18:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582823380; bh=FcXtMozaz5aKjR+MsTQyybTO/Ns9vbTusP0TC2E6/Rc=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=wR2VozWeQBdMWkmwLMTgbQha488lPIfS8dqydiYIMk0CxSwz4qFGTKE/7UFBGBAnV
         IvaNU5MzUmAnCSmvKoWvANls5L8e6TnpWVZNMd96+Ty+THmb62qEG/gAjyt5/APY+P
         UW+vQh0rV6A8qEbCbqtzd6QAtLVyhTz67sRrwubo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C2528B880;
        Thu, 27 Feb 2020 18:09:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fDbqYkuli0hU; Thu, 27 Feb 2020 18:09:42 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 803598B799;
        Thu, 27 Feb 2020 18:09:40 +0100 (CET)
Subject: Re: [PATCH v4 13/13] powerpc/ptrace: move ptrace_triggered() into
 hw_breakpoint.c
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        Russell Currey <ruscur@russell.cc>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1582803998.git.christophe.leroy@c-s.fr>
 <d45c91cf5f83424b8f3989b7ead28c50d8d765a9.1582803998.git.christophe.leroy@c-s.fr>
Message-ID: <4e528bf2-2b53-ae93-cdcc-0c80953f40f2@c-s.fr>
Date:   Thu, 27 Feb 2020 18:09:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d45c91cf5f83424b8f3989b7ead28c50d8d765a9.1582803998.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russel,

Le 27/02/2020 à 12:49, Christophe Leroy a écrit :
> ptrace_triggered() is declared in asm/hw_breakpoint.h and
> only needed when CONFIG_HW_BREAKPOINT is set, so move it
> into hw_breakpoint.c

My series v4 is definitely buggy (I included ptrace_decl.h instead 
instead of ptrace-decl.h), how can Snowpatch say build succeeded 
(https://patchwork.ozlabs.org/patch/1245807/) ?

It fails at least on pmac32_defconfig and ppc64_defconfig, see:

http://kisskb.ellerman.id.au/kisskb/head/d45c91cf5f83424b8f3989b7ead28c50d8d765a9/

Christophe

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v4: removing inclusing of hw_breakpoint.h now. Previously it was done too early.
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 16 ++++++++++++++++
>   arch/powerpc/kernel/ptrace/ptrace.c | 19 -------------------
>   2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 2462cd7c565c..2c0be9d941cf 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -427,3 +427,19 @@ void hw_breakpoint_pmu_read(struct perf_event *bp)
>   {
>   	/* TODO */
>   }
> +
> +void ptrace_triggered(struct perf_event *bp,
> +		      struct perf_sample_data *data, struct pt_regs *regs)
> +{
> +	struct perf_event_attr attr;
> +
> +	/*
> +	 * Disable the breakpoint request here since ptrace has defined a
> +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> +	 * We don't have to do anything about that here
> +	 */
> +	attr = bp->attr;
> +	attr.disabled = true;
> +	modify_user_hw_breakpoint(bp, &attr);
> +}
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index a44f6e5e05ff..f6e51be47c6e 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -18,7 +18,6 @@
>   #include <linux/regset.h>
>   #include <linux/tracehook.h>
>   #include <linux/audit.h>
> -#include <linux/hw_breakpoint.h>
>   #include <linux/context_tracking.h>
>   #include <linux/syscalls.h>
>   
> @@ -31,24 +30,6 @@
>   
>   #include "ptrace-decl.h"
>   
> -#ifdef CONFIG_HAVE_HW_BREAKPOINT
> -void ptrace_triggered(struct perf_event *bp,
> -		      struct perf_sample_data *data, struct pt_regs *regs)
> -{
> -	struct perf_event_attr attr;
> -
> -	/*
> -	 * Disable the breakpoint request here since ptrace has defined a
> -	 * one-shot behaviour for breakpoint exceptions in PPC64.
> -	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> -	 * We don't have to do anything about that here
> -	 */
> -	attr = bp->attr;
> -	attr.disabled = true;
> -	modify_user_hw_breakpoint(bp, &attr);
> -}
> -#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> -
>   /*
>    * Called by kernel/ptrace.c when detaching..
>    *
> 
