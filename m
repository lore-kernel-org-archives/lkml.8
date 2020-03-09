Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188ECC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E789F24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j+KSXz+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCIUgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:36:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgCIUgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:36:31 -0400
Received: from zn.tnic (p200300EC2F05B2005D451D18BD3BAF8F.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:b200:5d45:1d18:bd3b:af8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E1EF1EC0C97;
        Mon,  9 Mar 2020 21:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583786189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wtbqXGqFEsNw2L5GSHjcVunNBOZCwH6CYFPC9DsGy+w=;
        b=j+KSXz+4nd0wrtAVWhGIOSmW6wmKEN1gOm0zZm5rlbhdykhPdRi8iYV2/PxoBjXOf90eT8
        d/sowrm3c2Ox20zrA2NGpZyF4Qp9OGGEsfv/vGQYVBOfNYz61Jx/+og/BR0KH0yLcVUWjo
        ASGFC52u+i96n+qFLF0L8juTCb+kX8M=
Date:   Mon, 9 Mar 2020 21:36:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] x86/Kconfig: make X86_UMIP to cover any X86 CPU
Message-ID: <20200309203632.GB9002@zn.tnic>
References: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583733990-2587-1-git-send-email-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:06:30PM +0800, Tony W Wang-oc wrote:
> While the UMIP (User-Mode Instruction Prevention) is a generic X86 CPU
> feature, there is no need to tie X86_UMIP only to Intel and AMD.

It is not generic - it just lost the "INTEL" in its name.

> So remove that dependency from the Kconfig rules.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5ad3957..ca16b762 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1871,7 +1871,6 @@ config X86_SMAP
>  
>  config X86_UMIP
>  	def_bool y
> -	depends on CPU_SUP_INTEL || CPU_SUP_AMD
>  	prompt "User Mode Instruction Prevention" if EXPERT
>  	---help---
>  	  User Mode Instruction Prevention (UMIP) is a security feature in
> -- 

If you're going to do that, is there even any use for that config option
at all?

AFAICT, it adds ~1K to kernel text so we might just as well remove the
ifdeffery completely. The code ends up built in in 99% of the cases
anyway...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
