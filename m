Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500DEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315CB2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCEPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:16:40 -0500
Received: from verein.lst.de ([213.95.11.211]:59929 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgCEPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:16:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 820DF68B05; Thu,  5 Mar 2020 16:16:36 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:16:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Christoph Hellwig <hch@lst.de>, yan-liu@ti.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
Subject: Re: [PATCH] dra7: sata: Fix SATA with CONFIG_ARM_LPAE enabled
Message-ID: <20200305151636.GA4870@lst.de>
References: <20200304090031.30360-1-rogerq@ti.com> <20200304162057.GV37466@atomide.com> <145c0448-ea33-8704-4fde-03fb180100d6@ti.com> <00951cc4-6cbf-a3cf-5f2c-007d5b43ac5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00951cc4-6cbf-a3cf-5f2c-007d5b43ac5b@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 12:30:56PM +0000, Robin Murphy wrote:
> Right - LPAE configs should be getting dma-direct ops since 5.3, which 
> already respect the limit. For non-LPAE configs it means you go from being 
> broken from having no limit at all, to having a limit set but not 
> respected, which is still equally broken, but no *more* so than before.

Actually, dma-direct doesn't automatically respect the bus limit.  For
various architectures including arm it uses the arch_dma_alloc callout,
which for arm just uses the existing arm coherent allocator.

Thay being said I'm still looking for reviewers for the arm dma coherent
allocator bus limit fix..
