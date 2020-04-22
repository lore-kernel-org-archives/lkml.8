Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F012082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgDVN4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:56:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgDVN4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:56:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CBFC30E;
        Wed, 22 Apr 2020 06:56:47 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6426A3F68F;
        Wed, 22 Apr 2020 06:56:45 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:56:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     James Morse <james.morse@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>, info@metux.net,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        allison@lohutok.net, gregkh@linuxfoundation.org,
        Tian Tao <tiantao6@hisilicon.com>, tglx@linutronix.de,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm32: fix flushcache syscall with device address
Message-ID: <20200422135642.GD3585@gaia>
References: <1587456514-61156-1-git-send-email-tiantao6@hisilicon.com>
 <20200421081239.GA15439@willie-the-truck>
 <20200421121651.000009f0@Huawei.com>
 <d0814ab2-03fc-42c1-e447-bfee2df038da@arm.com>
 <20200421165515.GF25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421165515.GF25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:55:16PM +0100, Russell King wrote:
> On Tue, Apr 21, 2020 at 05:50:22PM +0100, James Morse wrote:
> > (Subject Nit: arm64, as that is what your patch modifies)
> 
> That is irrelevent.  This is a compatibility interface which is supposed
> to reflect the arm32 implementation.  Augmenting a compatibility
> interface to do more than what it's counterpart that it's supposed to
> be compatible with is senseless.
> 
> The API concerned is an ARM32 API which is expected to only be used
> for ensuring I/D cache coherency, it is not for DMA.
> 
> Augmenting it on ARM64 for DMA is senseless.

I fully agree. I don't see any valid reason why this needs to be fixed.
It looks like some broken user process trying to do cache maintenance to
PoU on the mapped PCIe BAR (either inadvertently or for the wrong
reasons).

-- 
Catalin
