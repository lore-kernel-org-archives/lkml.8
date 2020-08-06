Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D7AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8332173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wFJLq5LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHFAau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHFAas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:30:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F60C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k9ZUUoVT/rC8cRMVNQlujKR+wnRdpm96UsegNSVO9/A=; b=wFJLq5LHslH58jU71H4rejyAM
        4BSHcOUv4cOu16/dnhsitej9zJ/2bIvYV7mx0AaxxldC8llbrfQfDj/9AbDeHSHAedxg7zsA6ngPM
        U0Hy1G9c3XvprYmrBpkjTDXrmEVptIxf3uzx7EG3xu3Wyx9ff5xWigyDxyKQ3fpgbQvWmRCrzDgPM
        0ZwxZdKIBvh1F0/9ugKpCj2rVlV6lWWlgra7Zm9TZu8/WvyaVBeQ1Zw069zRVchaNv+eIJrlOHkej
        WBk75kLTC/iUjlSSwQkCbEFFArRbc34oXZ1bOVACOCgfauSU8Tb0oAfdXx0gxpqVTTSvGze4ceeNg
        R5JwVCoTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48850)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k3Tnx-00042b-Lt; Thu, 06 Aug 2020 01:30:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k3Tnu-0005b9-Ji; Thu, 06 Aug 2020 01:30:42 +0100
Date:   Thu, 6 Aug 2020 01:30:42 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Norbert Lange <nolange79@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: [PATCH] arm: Add support for ZSTD compressed kernel
Message-ID: <20200806003042.GB1551@shell.armlinux.org.uk>
References: <20200805230555.84214-1-nolange79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805230555.84214-1-nolange79@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:05:55AM +0200, Norbert Lange wrote:
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 434a16982e34..1af01bfe6638 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -614,7 +614,11 @@ not_relocated:	mov	r0, #0
>   */
>  		mov	r0, r4
>  		mov	r1, sp			@ malloc space above stack
> +#if defined(CONFIG_KERNEL_ZSTD)
> +		add	r2, sp, #0x30000	@ Context needs ~160K

That's going to mess up kexec:

        /*
         * The zImage length does not include its stack (4k) or its
         * malloc space (64k).  Include this.
         */
        len += 0x11000;

I guess we need to add this to the information provided to kexec.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
