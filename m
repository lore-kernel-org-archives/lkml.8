Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A562065D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DLRdhqsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGKMac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:30:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F53C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rtDJWKmdIQAIvER7ZgCV7MNDlvcNqCTl3+erc4m88gU=; b=DLRdhqsLBTdnypFN5X6xRhNDa
        F/JBN6ZEwG1lvF1gd7jyn/zkOfDBPfS0bLStQaXLBg7f6yrqujwcdcRYjRFAS4bcBBGCK7WK5uiC9
        bxhsHYmC0Y/XQ5eKW9msN0WpsCJtRXLzkV14Xvz9Cdy9WwCR4ieFAsTQAhNOhSEGCqwmx31ieNwHc
        0y/gBNw3IXbJXV70mG8RvKavnCfAwhZc0LmPm4YtfZYB8wFQOlVfjAh95BtLT7RhjuD6qhh0n3vaZ
        wr37Cx62T7+7uKe1vLCgMw58TMUKaoeVTX2WKYFydfzvNhkN2mU705VmWzDMaqxZlIVv0EIYUUtfx
        vGzKf+TPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38134)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1juEeB-0002Yr-Pz; Sat, 11 Jul 2020 13:30:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1juEe9-0004H0-Vq; Sat, 11 Jul 2020 13:30:26 +0100
Date:   Sat, 11 Jul 2020 13:30:25 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: arm-linux-gnueabi-ld: section .rodata VMA overlaps section .bss
 VMA
Message-ID: <20200711123025.GM1551@shell.armlinux.org.uk>
References: <202007111901.282t0ZCv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007111901.282t0ZCv%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I doubt anyone is going to fix this; it's an XIP kernel, and it looks
like the .data and .rodata sections are correctly placed as per the
configuration, but for some reason the .text (and sections that follow)
are incorrectly placed in VMA space.  The configuration file says that
the kernel should start at 0x00080000, and there's no way the .text
VMA should be starting at 0x3f0801a0.

Unless one of the XIP using folk can debug this, I doubt there will be
any movement on it.  Especially as it's 5 months old...

What do we do with bugs like this that people won't fix?  Remove XIP
support from the kernel?

On Sat, Jul 11, 2020 at 07:05:04PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1df0d8960499e58963fd6c8ac75e544f2b417b29
> commit: f87b1c49bc675da30d8e1e8f4b60b800312c7b90 ARM: 8958/1: rename missed uaccess .fixup section
> date:   5 months ago
> config: arm-randconfig-c004-20200711 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: section .data VMA [0000000040008000,00000000401e9edf] overlaps section .text VMA [000000003f0801a0,0000000040515887]
> >> arm-linux-gnueabi-ld: section .rodata VMA [0000000040516000,00000000409a24ee] overlaps section .bss VMA [0000000040208000,00000000409d80db]
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
