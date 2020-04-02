Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1089DC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A520757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ncI4RBja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgDBNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:05 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45104 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u0XqJuuRJOzFrykmgcojjMYaPRsJ18B/4np3Z56+V48=; b=ncI4RBja5rdYERBqM4NvyGwVm
        DPLetZf+rqm6Rnk0+GenS5OBeS5K6XcoJmL+snkYK1aUlCUB141cbRo+XBfn+BoGyT9C6LuPp2Cg7
        OVShlyA38X2pga7Ra0T/5o4qMci6439dYHG95gPkl1ei40RPmwrO6kBqGBRY86YrMkXnQhcS/ETDv
        pRtYdXIzvJ4GcT6iZp9W6CpLl8GCVHa78PEpkvso5ixKHPMwUadY2xH1/LG3NPHIBwe0uhPwG5ktM
        ffca3PP8krZFHdjY1fv4xjIFiUOhnQnSHYHZoeo9IjIDqFqVJ+f/fvaUarF0ZkCW8w7FNK1m7n61T
        6qf2s8TRQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40546)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jJzVh-0003Lf-6o; Thu, 02 Apr 2020 14:03:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jJzVg-0001hd-4j; Thu, 02 Apr 2020 14:03:52 +0100
Date:   Thu, 2 Apr 2020 14:03:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ARM: exynos: update l2c_aux_mask to fix alert message
Message-ID: <20200402130352.GY25745@shell.armlinux.org.uk>
References: <b29f34870380093e6268c11d3033033d6def61b7.1585756648.git.guillaume.tucker@collabora.com>
 <20200401163101.GV25745@shell.armlinux.org.uk>
 <35c7cf4b-e6b8-43aa-d934-4a1c2e738372@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35c7cf4b-e6b8-43aa-d934-4a1c2e738372@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:13:24PM +0100, Guillaume Tucker wrote:
> On 01/04/2020 17:31, Russell King - ARM Linux admin wrote:
> > On Wed, Apr 01, 2020 at 05:08:03PM +0100, Guillaume Tucker wrote:
> >> Allow setting the number of cycles for RAM reads in the pl310 cache
> >> controller L2 auxiliary control register mask (bits 0-2) since it
> >> needs to be changed in software.  This only affects exynos4210 and
> >> exynos4412 as they use the pl310 cache controller.
> >>
> >> With the mask used until now, the following warnings were generated,
> >> the 2nd one being a pr_alert():
> >>
> >>   L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> >>   L2C: platform provided aux values permit register corruption.
> >>
> >> This latency cycles value has always been set in software in spite of
> >> the warnings.  Keep it this way but clear the alert message about
> >> register corruption to acknowledge it is a valid thing to do.
> > 
> > This is telling you that you are doing something you should not be
> > doing.  The L2C controller should be configured by board firmware
> > first and foremost, because if, for example, u-boot makes use of the
> > L2 cache, or any other pre-main kernel code (in other words,
> > decompressor) the setup of the L2 controller will be wrong.
> > 
> > So, NAK.
> 
> OK thanks, I guess I misinterpreted the meaning of the error
> message.  It's really saying that the register value was not the
> right one before the kernel tried to change it.  Next step for me
> is to look into U-Boot.

The message "L2C: platform provided aux values permit register
corruption." means that bits are set in both the mask and the value
fields.  Since the new value is calculated as:

	old = register value;
	new = old & mask;
	new |= val;

If bits are set in both "mask" and "val" for a multi-bit field, the
value ending up in the field may not be what is intended.  Consider
a 5-bit field set initially to 10101, and the requested value is
01000 with a mask of 11111.  What you end up with is not 01000, but
11101.  Hence, register corruption.  It is not possible to easily
tell whether the mask and values refer to a multi-bit field or not,
so the mere fact that bits are set in both issues the alert.

The message "L2C: platform modifies aux control register ..." means
that you're trying to modify the value of the auxiliary control
register, which brings with it the problems I stated in my previous
email; platform configuration of the L2C must be done by firmware and
not the kernel for the reasons I've set out.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
