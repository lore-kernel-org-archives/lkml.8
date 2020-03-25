Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15220714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYKQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:16:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgCYKQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8114E31B;
        Wed, 25 Mar 2020 03:16:56 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DA83F52E;
        Wed, 25 Mar 2020 03:16:55 -0700 (PDT)
Date:   Wed, 25 Mar 2020 10:16:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable without
 EXPERT
Message-ID: <20200325101652.GJ3901@mbp>
References: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
 <20200324174134.GH3901@mbp>
 <AM0PR04MB44819E95EB1FABF09DEE682788CE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB44819E95EB1FABF09DEE682788CE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:34:15AM +0000, Peng Fan wrote:
> > On Tue, Mar 10, 2020 at 08:48:46PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> > > enables both ZONE_DMA and ZONE_DMA32. The lower 1GB memory will be
> > > occupied by ZONE_DMA, this will cause CMA allocation fail on some
> > > platforms, because CMA area could not across different type of memory
> > > zones.
> > >
> > > Make CONFIG_ZONE_DMA configurable without EXPERT option could let
> > > people build non debug kernel image with CONFIG_ZONE_DMA disabled.
> > 
> > While I see why you need to toggle this feature, I'd rather try to figure out
> > whether there is a better solution that does not break the single kernel image
> > aim (i.e. the same config works for all supported SoCs).
> > 
> > When we decided to go ahead with a static 1GB ZONE_DMA for Raspberry Pi
> > 4, we thought that other platforms would be fine, ZONE_DMA32 allocations
> > fall back to ZONE_DMA. We missed the large CMA case.
> > 
> > I see a few potential options:
> > 
> > a) Ensure the CMA is contained within a single zone. 
> 
> This will break legacy dts with new version kernel.
> 
> > How large is it in your case? 
> 
> It is 1GB
> 
> > Is it allocated by the kernel dynamically or a fixed start set by
> > the boot loader?
> 
> We use alloc-ranges and size in kernel dts.
> 
> But there is only 2GB DRAM in the board.

So I guess without changing the dts, option (a) doesn't really work.

> > b) Change the CMA allocator to allow spanning multiple zones (last time
> >    I looked it wasn't trivial since it relied on some per-zone lock).
> > 
> > c) Make ZONE_DMA dynamic on arm64 and only enable it if RPi4.
> 
> Option c seems a bit easier to me :)
> 
> I will try to explore both, but if you have time to help, that would be
> appreciated.

I don't have time but option (c) was already discussed and there are
patches from Nicolas on the list:

https://lore.kernel.org/linux-arm-kernel/20190820145821.27214-5-nsaenzjulienne@suse.de/

The above series was checking whether the platform is RPi4 and limiting
the ZONE_DMA size to 1GB (otherwise 4GB with ZONE_DMA32 empty). We ended
up with a static 1GB for ZONE_DMA but we missed the fact that it may
break existing platforms.

So I don't think it would be too hard to revive the above series (most
of it was already merged).

-- 
Catalin
