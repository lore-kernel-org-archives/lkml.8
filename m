Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D99C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCXRlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgCXRlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:41:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27F291FB;
        Tue, 24 Mar 2020 10:41:39 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E383F71F;
        Tue, 24 Mar 2020 10:41:37 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:41:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     peng.fan@nxp.com
Cc:     will@kernel.org, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA configurable without
 EXPERT
Message-ID: <20200324174134.GH3901@mbp>
References: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583844526-24229-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:48:46PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> enables both ZONE_DMA and ZONE_DMA32. The lower 1GB memory
> will be occupied by ZONE_DMA, this will cause CMA allocation
> fail on some platforms, because CMA area could not across
> different type of memory zones.
> 
> Make CONFIG_ZONE_DMA configurable without EXPERT option
> could let people build non debug kernel image with
> CONFIG_ZONE_DMA disabled.

While I see why you need to toggle this feature, I'd rather try to
figure out whether there is a better solution that does not break the
single kernel image aim (i.e. the same config works for all supported
SoCs).

When we decided to go ahead with a static 1GB ZONE_DMA for Raspberry Pi
4, we thought that other platforms would be fine, ZONE_DMA32 allocations
fall back to ZONE_DMA. We missed the large CMA case.

I see a few potential options:

a) Ensure the CMA is contained within a single zone. How large is it in
   your case? Is it allocated by the kernel dynamically or a fixed start
   set by the boot loader?

b) Change the CMA allocator to allow spanning multiple zones (last time
   I looked it wasn't trivial since it relied on some per-zone lock).

c) Make ZONE_DMA dynamic on arm64 and only enable it if RPi4.

-- 
Catalin
