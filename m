Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B1C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A508F20672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IHSaNrlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBEXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:54:47 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45756 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBEXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5aXRAu4MuUd1u+UkGWrwGKaLApXhm4yXkzsV9CVJjT0=; b=IHSaNrlX76PEvKY68PALvoF2i
        vdyQP4DzsFi59MzqPOMbeJKzjuWk6iMOAzGYIzNaCWxNlqkOFSzxj6lmw2bI8eWlYHqDGdcZHYJax
        hBa9FbdRBI16SgV1JE9UOz9M/4nAfYder1jTv6XjvVzIBFp8fQljmMbMAC7v1xYQUd4hH4OSbnPHl
        qv+aU2pmxRmIPELvvWP2BG/9mxvu7iVjoBhpDVV6bJF7TShe5ZmrdnyjemRqtCqWp9fhygFekoX4x
        zvZh2owVVzNYp1HUoaKuWJWoCxTuJPHjVht4yOxucSNgFHho6c/QO31WQ/I/kLdcG88rLjGpwp+3X
        Dc7WiGa9g==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43988)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1izUVE-0003jc-VF; Wed, 05 Feb 2020 23:54:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1izUVE-0002If-5d; Wed, 05 Feb 2020 23:54:40 +0000
Date:   Wed, 5 Feb 2020 23:54:40 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: kexec: drop invalid assembly argument
Message-ID: <20200205235440.GW25745@shell.armlinux.org.uk>
References: <ab67c7c5a1f96af6d22240e57fc27ba766d4193d.1580943526.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab67c7c5a1f96af6d22240e57fc27ba766d4193d.1580943526.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:59:26PM +0100, Stefan Agner wrote:
> The tst menomic has only a single #<const> argument in Thumb mode. There
> is an ARM variant which allows to write #<const> as #<byte>, #<rot>
> which probably is where the current syntax comes from.
> 
> It seems that binutils does not care about the additional parameter.
> Clang however complains in Thumb2 mode:
> arch/arm/kernel/relocate_kernel.S:28:12: error: too many operands for
> instruction
>  tst r3,#1,0
>            ^
> 
> Drop the unnecessary parameter. This fixes building this file in Thumb2
> mode with the Clang integrated assembler.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/770
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Please drop it in the patch system, thanks.

> ---
>  arch/arm/kernel/relocate_kernel.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
> index 7eaa2ae7aff5..72a08786e16e 100644
> --- a/arch/arm/kernel/relocate_kernel.S
> +++ b/arch/arm/kernel/relocate_kernel.S
> @@ -25,26 +25,26 @@ ENTRY(relocate_new_kernel)
>  	ldr	r3, [r0],#4
>  
>  	/* Is it a destination page. Put destination address to r4 */
> -	tst	r3,#1,0
> +	tst	r3,#1
>  	beq	1f
>  	bic	r4,r3,#1
>  	b	0b
>  1:
>  	/* Is it an indirection page */
> -	tst	r3,#2,0
> +	tst	r3,#2
>  	beq	1f
>  	bic	r0,r3,#2
>  	b	0b
>  1:
>  
>  	/* are we done ? */
> -	tst	r3,#4,0
> +	tst	r3,#4
>  	beq	1f
>  	b	2f
>  
>  1:
>  	/* is it source ? */
> -	tst	r3,#8,0
> +	tst	r3,#8
>  	beq	0b
>  	bic r3,r3,#8
>  	mov r6,#1024
> -- 
> 2.25.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
