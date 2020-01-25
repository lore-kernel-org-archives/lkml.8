Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01192C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C14A20716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jDMo/3Cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAYSGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 13:06:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35684 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 13:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NviSb6rLz8itB3Zb7lSO9C2tMpUikxorYtCnHZUsTc4=; b=jDMo/3CqNLZpHfqfiTSusv1fz
        aqFiFnduaHw6BMQY6r9WwdlhPS3PT6K7uVmdCu60AVOKxOXzKvFpOpcpPRNigphgGJdh3SlXwuXyX
        U5qlsjKX85/A7Q7zcCWiFqLLFVzyIIazYBwaUFLhhOnrwjkveMkGBWHfxaLiKacfU0jOo1Hkb/SD1
        xSg46CISWxBgfmoa90xMmiGGPpqhEbwY5S2oAPCda4kum7rHSL7XFUsfsfdeQKemVlUZmxKzggYsU
        mbDb3IO5c29Nb7kQ+QgZ6Ln30DfhF3j5+KlSweFJOzGlm17JkAoV59rWb9tj1f1KPQgvRFsxlq9wa
        +TCjUuucg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43208)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ivPp1-0006xW-3B; Sat, 25 Jan 2020 18:06:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ivPoz-00084f-Dl; Sat, 25 Jan 2020 18:06:13 +0000
Date:   Sat, 25 Jan 2020 18:06:13 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] ARM: 8936/1: decompressor: avoid CP15 barrier
 instructions in v7 cache setup code
Message-ID: <20200125180613.GR25745@shell.armlinux.org.uk>
References: <20200125173950.GA19126@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125173950.GA19126@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 09:39:50AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Nov 08, 2019 at 01:44:32PM +0100, Ard Biesheuvel wrote:
> > Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
> > 
> >   "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the cache"
> > 
> > added some explicit handling of the CP15BEN bit in the SCTLR system
> > register, to ensure that CP15 barrier instructions are enabled, even
> > if we enter the decompressor via the EFI stub.
> > 
> > However, as it turns out, there are other ways in which we may end up
> > using CP15 barrier instructions without them being enabled. I.e., when
> > the decompressor startup code skips the cache_on() initially, we end
> > up calling cache_clean_flush() with the caches and MMU off, in which
> > case the CP15BEN bit in SCTLR may not be programmed either. And in
> > fact, cache_on() itself issues CP15 barrier instructions before actually
> > enabling them by programming the new SCTLR value (and issuing an ISB)
> > 
> > Since all these routines are specific to v7, let's clean this up by
> > using the ordinary v7 barrier instructions in the v7 specific cache
> > handling routines, so that we never rely on the CP15 ones. This also
> > avoids the issue where a barrier is required between programming SCTLR
> > and using the CP15 barrier instructions, which would result in two
> > different kinds of barriers being used in the same function.
> > 
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> This patch causes all qemu emulations for ARM1176 to fail hard (stall with
> no console output even with earlycon enabled). This affects witherspoon-bmc,
> ast2500-evb, romulus-bmc, and swift-bmc. It does not affect emulations
> for other CPU types, even with the same kernel configuration (such as
> ast2600-evb).

Hmm, looks like we're going to have to drop 8936/1, 8941/1 and 8942/1
in that case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
