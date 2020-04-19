Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C00521974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZkVSLJiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDSOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:04:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC015C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+SHhJHEC/GWthRFPTaIGWJDgkO5X8ypn4Dz5ktkP734=; b=ZkVSLJivHNanwbuSVZ0pniErm
        e5QCV0vA1YkLkDdzVL5pVn/1NmGIaHTl6vPFF7lHwGjnAJCCxPFvyF2yh0pEmgUb4nYklchBwntwD
        KpdpO1TAiiIG/hex8b0aXuy5QaOSbxwAha8mHaQriQ8Ky0W84nGufPJnx+T5ku7+x2FaIX6CqaIrz
        wNFJRgB/7weW5QEeNkyNARAonAswVt/0KtOwMoPdgDkDeb52Ch7z7Vm+8nfDPnkM6gVzwPRxszbhn
        GE0yojL25qeHZeSfevTnYhMJKjJOEf+S8rPTP9aPBoixbV5i+i3n9hnQZZRDdDBgqBkWFD/v+SeYI
        PTUhmR/4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52180)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQAYX-0005xJ-0N; Sun, 19 Apr 2020 15:04:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQAYR-0004tQ-G4; Sun, 19 Apr 2020 15:04:15 +0100
Date:   Sun, 19 Apr 2020 15:04:15 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 1/3] ARM: use .fpu assembler directives instead of
 assembler arguments
Message-ID: <20200419140415.GW25745@shell.armlinux.org.uk>
References: <cover.1587299429.git.stefan@agner.ch>
 <a78f7e5820a6b827c9d68362a94dcbf80a317dc9.1587299429.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78f7e5820a6b827c9d68362a94dcbf80a317dc9.1587299429.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 02:35:49PM +0200, Stefan Agner wrote:
> Explicit FPU selection has been introduced in commit 1a6be26d5b1a
> ("[ARM] Enable VFP to be built when non-VFP capable CPUs are selected")
> to make use of assembler mnemonics for VFP instructions.
> 
> However, clang currently does not support passing assembler flags
> like this and errors out with:
> clang-10: error: the clang compiler does not support '-Wa,-mfpu=softvfp+vfp'
> 
> Make use of the .fpu assembler directives to select the floating point
> hardware selectively. Also use the new unified assembler language
> mnemonics. This allows to build these procedures with Clang.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/762
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Add link in commit message
> 
>  arch/arm/vfp/Makefile |  2 --
>  arch/arm/vfp/vfphw.S  | 30 +++++++++++++++++++-----------
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
> index 9975b63ac3b0..749901a72d6d 100644
> --- a/arch/arm/vfp/Makefile
> +++ b/arch/arm/vfp/Makefile
> @@ -8,6 +8,4 @@
>  # ccflags-y := -DDEBUG
>  # asflags-y := -DDEBUG
>  
> -KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp -mfloat-abi=soft)
> -
>  obj-y		+= vfpmodule.o entry.o vfphw.o vfpsingle.o vfpdouble.o
> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> index b2e560290860..e214007a20a2 100644
> --- a/arch/arm/vfp/vfphw.S
> +++ b/arch/arm/vfp/vfphw.S
> @@ -258,11 +258,13 @@ vfp_current_hw_state_address:
>  
>  ENTRY(vfp_get_float)
>  	tbl_branch r0, r3, #3
> -	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mrc	p10, 0, r0, c\dr, c0, 0	@ fmrs	r0, s0
> +	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,

Apart from the extraneous comma above, this looks fine, thanks.

> +1:	vmov	r0, s\dr
>  	ret	lr
>  	.org	1b + 8
> -1:	mrc	p10, 0, r0, c\dr, c0, 4	@ fmrs	r0, s1
> +	.endr
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	vmov	r0, s\dr
>  	ret	lr
>  	.org	1b + 8
>  	.endr
> @@ -271,10 +273,12 @@ ENDPROC(vfp_get_float)
>  ENTRY(vfp_put_float)
>  	tbl_branch r1, r3, #3
>  	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mcr	p10, 0, r0, c\dr, c0, 0	@ fmsr	r0, s0
> +1:	vmov	s\dr, r0
>  	ret	lr
>  	.org	1b + 8
> -1:	mcr	p10, 0, r0, c\dr, c0, 4	@ fmsr	r0, s1
> +	.endr
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	vmov	s\dr, r0
>  	ret	lr
>  	.org	1b + 8
>  	.endr
> @@ -282,15 +286,17 @@ ENDPROC(vfp_put_float)
>  
>  ENTRY(vfp_get_double)
>  	tbl_branch r0, r3, #3
> +	.fpu	vfpv2
>  	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	fmrrd	r0, r1, d\dr
> +1:	vmov	r0, r1, d\dr
>  	ret	lr
>  	.org	1b + 8
>  	.endr
>  #ifdef CONFIG_VFPv3
>  	@ d16 - d31 registers
> -	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mrrc	p11, 3, r0, r1, c\dr	@ fmrrd	r0, r1, d\dr
> +	.fpu	vfpv3
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	vmov	r0, r1, d\dr
>  	ret	lr
>  	.org	1b + 8
>  	.endr
> @@ -304,15 +310,17 @@ ENDPROC(vfp_get_double)
>  
>  ENTRY(vfp_put_double)
>  	tbl_branch r2, r3, #3
> +	.fpu	vfpv2
>  	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	fmdrr	d\dr, r0, r1
> +1:	vmov	d\dr, r0, r1
>  	ret	lr
>  	.org	1b + 8
>  	.endr
>  #ifdef CONFIG_VFPv3
> +	.fpu	vfpv3
>  	@ d16 - d31 registers
> -	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mcrr	p11, 3, r0, r1, c\dr	@ fmdrr	r0, r1, d\dr
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	vmov	d\dr, r0, r1
>  	ret	lr
>  	.org	1b + 8
>  	.endr
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
