Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77411C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C524688
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 22:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="A139eRSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgB2W6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:58:43 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40634 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgB2W6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 17:58:43 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 41C925C181D;
        Sat, 29 Feb 2020 23:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1583017120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bNoDWsqYYisEb5EWkUaz01QS0co4YAIEIGe5+hEj+U=;
        b=A139eRSyQyNXPVTIsJ3cfUjNzmrFsFsTKyMDqp6QhZE4kOTffHOuo2ZbE9wlSFDhc2ico9
        4dnIaiM2FXpRxxeJp711+7dntKFuESDuS9pXPO7aLg5UNAWX5jdDpqzZMIDAjS8MMV+gnC
        8BRLBArPg8ArpQ7NLYHkC2BMk03vWp8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Feb 2020 23:58:40 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, manojgupta@google.com, jiancai@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
In-Reply-To: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <4366c303e707a43071d5bc54f00cce01@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 07:34, Stefan Agner wrote:
> Clang's integrated assembler does not allow to to use the mcr
> instruction to access floating point co-processor registers:
> arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
>         fmxr(FPEXC, fpexc &
> ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEXC_TRAP_MASK));
>         ^
> arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
>         asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   "
> #_vfp_ ", %0" \
>             ^
> <inline asm>:1:6: note: instantiated into assembly here
>         mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
>             ^
> 
> The GNU assembler supports the .fpu directive at least since 2.17 (when
> documentation has been added). Since Linux requires binutils 2.21 it is
> safe to use .fpu directive. Use the .fpu directive and mnemonics for VFP
> register access.
> 
> This allows to build vfpmodule.c with Clang and its integrated assembler.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/905
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/vfp/vfpinstr.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> index 38dc154e39ff..799ccf065406 100644
> --- a/arch/arm/vfp/vfpinstr.h
> +++ b/arch/arm/vfp/vfpinstr.h
> @@ -62,21 +62,17 @@
>  #define FPSCR_C (1 << 29)
>  #define FPSCR_V	(1 << 28)
>  
> -/*
> - * Since we aren't building with -mfpu=vfp, we need to code
> - * these instructions using their MRC/MCR equivalents.
> - */
> -#define vfpreg(_vfp_) #_vfp_
> -
>  #define fmrx(_vfp_) ({			\
>  	u32 __v;			\
> -	asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx	%0, " #_vfp_	\
> +	asm(".fpu	vfpv2\n"	\
> +	    "vmrs	%0, " #_vfp_	\
>  	    : "=r" (__v) : : "cc");	\
>  	__v;				\
>   })
>  
>  #define fmxr(_vfp_,_var_)		\
> -	asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr	" #_vfp_ ", %0"	\
> +	asm(".fpu	vfpv2\n"	\
> +	    "vmsr	" #_vfp_ ", %0"	\
>  	   : : "r" (_var_) : "cc")
>  
>  u32 vfp_single_cpdo(u32 inst, u32 fpscr);

I just found out that this fails with binutils 2.23.1. Since we support
binutils back to 2.21 I guess that is not OK..?

  CC      arch/arm/vfp/vfpmodule.o
/tmp/cc2Vcw98.s: Assembler messages:
/tmp/cc2Vcw98.s:920: Error: operand 1 must be a VFP extension System
Register -- `vmrs r6,FPINST'
/tmp/cc2Vcw98.s:948: Error: operand 1 must be a VFP extension System
Register -- `vmrs r6,FPINST2'

Looking into binutils history reveals that FPINST/FPINST2 has been
allowed with 16d02dc907c5717b5f47076bb90ae3795e73b59f
("gas/config/tc-arm.c (do_vmrs): Accept all control registers") which
made it into binutils 2.24...

I don't have a particular good idea how to make this work for Clang and
GCC other than a some ifdef's...

--
Stefan
