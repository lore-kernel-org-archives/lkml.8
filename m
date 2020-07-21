Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C969C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B89E20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BES0uEM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGUNV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:21:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2FC061794;
        Tue, 21 Jul 2020 06:21:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so10266969plk.1;
        Tue, 21 Jul 2020 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qvjV4zJ+ljsVrLYY5u3yPmLUInDJuCQrPmhPzG4KVUY=;
        b=BES0uEM4PJ/rIG9EX4hZwteKAx1jygN3UQZXu+mgyPvmne9xny+k5O3BDJlgnUbw0/
         V24eaycp4Rr7qztdthu/dtvL85ZhF3zSMjnWQiyIz/So7rllxGCV+OKgaulRQY0Mo9nx
         eDiTOhJx6aDaYNrDh0jdqt8jQLe+uqyTS1ydmMNqdWS8zM+Fh40nHtN6dfbnvmmuo9nH
         tGMIWFID1uQN0g/hUMa1ZES7vj3Obkky+87hRzY/ABponvu8Ch9aZc8PZ/1izFUtcL6P
         CN5Hck8KUAQeWljihSI257+ber3n7SKOSPmz9P05ItNxz//WmFB7PZFUIHwFNjdjFNDg
         Sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=qvjV4zJ+ljsVrLYY5u3yPmLUInDJuCQrPmhPzG4KVUY=;
        b=mKY2FPTSg+uzknbt4HnJEmcB5pyIv47gqo2/cAW7hJrCAjbbfHK5VGUzPkOMFGvK9p
         547f5r5CeWAtuuz3MLA/lpfgW5ZavkFk5/GK862pb6zHqELTLkjkj1KPpOr3VrtH7Cph
         l3cHOvq4FxH2mrna4PMIYUYE/MZjIfaync6HM/JMBw/4I6YX1s1qEyp1xdU8mTxkEmLM
         vFiKZtndhgIKEMPb+c62eSs2WzLT6e3LIVs4yVbNcO8J6rjmS27Y2IP7oTlu3GGj8/f6
         hjvKvaO3as0AoI/CvvvrsryzGIrIYta1WENJaBz7drIIMLmGoUDGA4ZXcx8J6BH1HifR
         Y72g==
X-Gm-Message-State: AOAM53150dOAWqpV9803q5wvLzOWEcoug724uhnw0Bm+b4eH9cYVPCS2
        Ry6a58A0HwAFV2fc8af+Vmc=
X-Google-Smtp-Source: ABdhPJyTYWQ8cQ3pZgDqPfuKNrJEv4+INxomhkf1hfiXMKffG62IYyX7/QBvttxJakTyM9dEubRXXw==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr4842326pjd.232.1595337717533;
        Tue, 21 Jul 2020 06:21:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s89sm3419637pjj.28.2020.07.21.06.21.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 06:21:57 -0700 (PDT)
Date:   Tue, 21 Jul 2020 06:21:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] csky: Fix build with upstream gcc
Message-ID: <20200721132155.GA27649@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:23:14PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Building a kernel for the CSKY architecture with CONFIG_FRAME_POINTER
> set requires a gcc supporting the non-upstream '-mbacktrace' option.
> Check for the '-mbacktrace' option before enabling CONFIG_FRAMEPOINTER
> and fix building CSKY with an upstream gcc compiler.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/csky/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index bd31ab12f77d..1622e1c56026 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -8,7 +8,7 @@ config CSKY
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
> -	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610
> +	select ARCH_WANT_FRAME_POINTERS if (!CPU_CK610 && STACKTRACE_SUPPORT)
>  	select COMMON_CLK
>  	select CLKSRC_MMIO
>  	select CSKY_MPINTC if CPU_CK860
> @@ -125,7 +125,7 @@ config MMU
>  	def_bool y
>  
>  config STACKTRACE_SUPPORT
> -	def_bool y
> +	def_bool $(success,echo 'int foo(void) { return 0; }' | $(CC) -mbacktrace -x c - -c -o /dev/null)
>  
>  config TIME_LOW_RES
>  	def_bool y
> -- 
> 2.27.0
> 
