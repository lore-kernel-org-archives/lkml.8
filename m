Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70291C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A052072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NOCOhr0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFJIQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:16:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:16:18 -0400
Received: from zn.tnic (p200300ec2f0c1900a913926cfabdeffc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:a913:926c:fabd:effc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 054CF1EC02B1;
        Wed, 10 Jun 2020 10:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591776977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mAHhGNZmnxv9QcrPJEyPY86D1IMBLsCypkGThqj8cUs=;
        b=NOCOhr0nKgoTZ2khwMzNJbBKhgQPs0AAu3iuqxFslP0VEvkCEGSAIb5caPljLPfI+CnRNN
        0wLWAdIkTX/G2xDuMQuHjX8JlbW6OlC3dv1r5WaIXu0wYJtKQEnh7C43xwRcFg+6nmZMgb
        sd8Kyb/g+zliy5Pi94j3wltQnUo2YJk=
Date:   Wed, 10 Jun 2020 10:16:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610081609.GA14118@zn.tnic>
References: <20200610042911.GA20058@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610042911.GA20058@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:29:11PM +1000, Herbert Xu wrote:
> The x86 microcode support works just fine without FW_LOADER.  In
> fact these days most people load them early in boot so FW_LOADER
> never gets into the picture anyway.

What's the use case here?

$ git grep -E "select.*FW_LOADER" | wc -l
132

so this thing gets selected anyway, practically.

Also, I'm working on removing that homegrown get_builtin_firmware() and
use the one in the fw loader:

https://lkml.kernel.org/r/20200408094526.GC24663@zn.tnic

Leaving in the rest for reference.

> People who need the FW_LOADER capability can still enable it.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1d6104ea8af0..8aac7a65bfbb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1296,7 +1296,6 @@ config MICROCODE
>  	bool "CPU microcode loading support"
>  	default y
>  	depends on CPU_SUP_AMD || CPU_SUP_INTEL
> -	select FW_LOADER
>  	---help---
>  	  If you say Y here, you will be able to update the microcode on
>  	  Intel and AMD processors. The Intel support is for the IA32 family,
> @@ -1318,7 +1317,6 @@ config MICROCODE_INTEL
>  	bool "Intel microcode loading support"
>  	depends on MICROCODE
>  	default MICROCODE
> -	select FW_LOADER
>  	---help---
>  	  This options enables microcode patch loading support for Intel
>  	  processors.
> @@ -1330,7 +1328,6 @@ config MICROCODE_INTEL
>  config MICROCODE_AMD
>  	bool "AMD microcode loading support"
>  	depends on MICROCODE
> -	select FW_LOADER
>  	---help---
>  	  If you select this option, microcode patch loading support for AMD
>  	  processors will be enabled.
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 7019d4b2df0c..5524ea15b3df 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -145,7 +145,6 @@ extern struct builtin_fw __end_builtin_fw[];
>  
>  bool get_builtin_firmware(struct cpio_data *cd, const char *name)
>  {
> -#ifdef CONFIG_FW_LOADER
>  	struct builtin_fw *b_fw;
>  
>  	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
> @@ -155,7 +154,6 @@ bool get_builtin_firmware(struct cpio_data *cd, const char *name)
>  			return true;
>  		}
>  	}
> -#endif
>  	return false;
>  }
>  
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
