Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715D820656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFVRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:31:50 -0400
Received: from verein.lst.de ([213.95.11.211]:35562 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgFVRbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:31:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC32B68AEF; Mon, 22 Jun 2020 19:31:46 +0200 (CEST)
Date:   Mon, 22 Jun 2020 19:31:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     David Rientjes <rientjes@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
Message-ID: <20200622173146.GA15796@lst.de>
References: <20200608132217.29945-1-geert@linux-m68k.org> <20200620200936.GA106151@roeck-us.net> <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com> <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net> <alpine.DEB.2.22.394.2006211308500.195301@chino.kir.corp.google.com> <1287bffd-3363-0764-0309-32222b2b8c9a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1287bffd-3363-0764-0309-32222b2b8c9a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 05:07:55PM +0100, Robin Murphy wrote:
> Another angle, though, is to question why this driver is making such a 
> large allocation with GFP_ATOMIC in the first place. At a glance it looks 
> like there's no reason at all other than that it's still using the legacy 
> pci_alloc_consistent() API, since every path to that appears to have 
> CAN_SLEEP passed as its flag - modernising that would arguably be an even 
> better long-term win.

Maybe we can just try that for now?  If other problems show up we
can still increase the initial pool size later in this cycle.

I'll try to cook up a patch.
