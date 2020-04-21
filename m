Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFEC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79074206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PudUaazE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgDUQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729038AbgDUQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:55:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0511C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WjhgbaEbBW3u8OJNr5mxiJDIQfOQFRnAGsSZAkxI4Ck=; b=PudUaazEa9YkVoMl8hUmwa+W8
        eqSVBuyamU1qlNTP5YiSmxvNv1W2N/KygVbgmFZfSaFy8Rhc4fxLVEHReDHAcs2Tg3xJ55V93G+pT
        exKQePYAqn7kKK7DwtH20u25uB3sVQHjJK3FtsadgWf9olHRerEkc6U4NeiJp4jUoAZkFm7ZqlkTA
        Vq0gIeaiLa/Ef4fdpXcY4uepUYDEiIRPx4S7Yr2/krsQARzRnRmazYQMwgFfUsfnCHlPsHQUqhul1
        UVSofi/+2ykyGifMM9yRez2ZWtPZAyZs19LR9x99Qno3v2rPS/2FHXRrAW3fd5b+g+xAkhZ0buphx
        BWrbSmvwg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53318)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQwB7-0002oI-JN; Tue, 21 Apr 2020 17:55:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQwB2-0007Ba-96; Tue, 21 Apr 2020 17:55:16 +0100
Date:   Tue, 21 Apr 2020 17:55:16 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, info@metux.net,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, allison@lohutok.net,
        gregkh@linuxfoundation.org, Tian Tao <tiantao6@hisilicon.com>,
        tglx@linutronix.de, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm32: fix flushcache syscall with device address
Message-ID: <20200421165515.GF25745@shell.armlinux.org.uk>
References: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
 <20200421081239.GA15439@willie-the-truck>
 <20200421121651.000009f0@Huawei.com>
 <d0814ab2-03fc-42c1-e447-bfee2df038da@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0814ab2-03fc-42c1-e447-bfee2df038da@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:50:22PM +0100, James Morse wrote:
> Hi guys,
> 
> (Subject Nit: arm64, as that is what your patch modifies)

That is irrelevent.  This is a compatibility interface which is supposed
to reflect the arm32 implementation.  Augmenting a compatibility
interface to do more than what it's counterpart that it's supposed to
be compatible with is senseless.

The API concerned is an ARM32 API which is expected to only be used
for ensuring I/D cache coherency, it is not for DMA.

Augmenting it on ARM64 for DMA is senseless.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
