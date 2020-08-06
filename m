Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3828D221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H/C34YG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHFWW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:22:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C6C061574;
        Thu,  6 Aug 2020 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0B+JmvLt0o6PJCqFXoofb/C6EPpAP3z2zrKQYdTIcDA=; b=H/C34YG++FVEse7HSfViTC7XJ
        SQLIyw2UeUWGN+YMszM9OhcjkKsW8+wB7Wb3U/eQyPRnG7RmtEPP68YxY8J9Pn4TR87sJ4U1Jt1tu
        1pX4wBNAkurvYQYc2GLxAxWr1PBz6bTd1qQFT+6sf89hXpGGotHnc/ph9vVqgxcftBFL96kqNtBq7
        oYskhJyX+jUmM0jzOpXNdFtlDH+1fxOS8JYjmIQLNCV1QgI1SkYleeePIvoY8e0b4VAKBSGdkcXCu
        hF7OuE5zSv7sqkRulaj+9DJ9gvvcLuX+JkHFe3/G4F4jp/Wojm/iu5OIlzUL2Bi2hTtmxg4UdnYJF
        WL+yHL1Yw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49234)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k3oHn-000599-JU; Thu, 06 Aug 2020 23:22:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k3oHm-0006YF-8i; Thu, 06 Aug 2020 23:22:54 +0100
Date:   Thu, 6 Aug 2020 23:22:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     nolange79@gmail.com, linux-kernel@vger.kernel.org,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] arm: Add support for ZSTD compressed kernel
Message-ID: <20200806222254.GF1551@shell.armlinux.org.uk>
References: <CAMdYzYoqKcG+LtFZy+TeYWB=GJo8Ya60r3Los4T5j7j3Okdbtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYoqKcG+LtFZy+TeYWB=GJo8Ya60r3Los4T5j7j3Okdbtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 05:46:50PM -0400, Peter Geis wrote:
> Good Evening,
> 
> I had attempted to get this working as well, but have run into
> difficulties with both my implementation and yours as well.
> My implementation was almost the same as yours, with the exception of
> also changing:
> @@ -303,7 +305,7 @@ restart: adr r0, LC1
> 
>  #ifndef CONFIG_ZBOOT_ROM
>   /* malloc space is above the relocated stack (64k max) */
> - add r10, sp, #0x10000
> + add r10, sp, #0x30000
>  #else
>   /*
>   * With ZBOOT_ROM the bss/stack is non relocatable,
> 
> On QEMU this implementation works fine.
> However on bare metal tegra30, I get the following error:
> 
> Jumping to kernel at:4861 ms
> 
> C:0x80A000C0-0x8112BA40->0x8152C700-0x81C58080
> Uncompressing Linux...
> 
> ZSTD-compressed dstSize is too small
> 
>  -- System halted
> 
> The only difference between the bare metal test and the qemu test is
> the zImage with appended dtb is packaged in the android boot format
> for the bare metal test.
> Otherwise it's exactly the same file.

So it's relocating the compressed kernel and decompressor from
0x80A000C0-0x8112BA40 to 0x8152C700-0x81C58080 and then failing.
Does the QEMU version also do similar?

On the off-hand, I'm not sure why it should fail.  I assume that
you've tried the other decompressors and they work fine on the
same setups?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
