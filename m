Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EFAC2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198E520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCZRFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:05:20 -0400
Received: from verein.lst.de ([213.95.11.211]:46743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgCZRFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:05:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF3D2227A81; Thu, 26 Mar 2020 18:05:16 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:05:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Graf <graf@amazon.com>
Cc:     iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        dwmw@amazon.com, benh@amazon.com,
        Jan Kiszka <jan.kiszka@siemens.com>, alcioa@amazon.com,
        aggh@amazon.com, aagch@amazon.com, dhr@amazon.com
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200326170516.GB6387@lst.de>
References: <20200326162922.27085-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326162922.27085-1-graf@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:29:22PM +0100, Alexander Graf wrote:
> The swiotlb is a very convenient fallback mechanism for bounce buffering of
> DMAable data. It is usually used for the compatibility case where devices
> can only DMA to a "low region".
> 
> However, in some scenarios this "low region" may be bound even more
> heavily. For example, there are embedded system where only an SRAM region
> is shared between device and CPU. There are also heterogeneous computing
> scenarios where only a subset of RAM is cache coherent between the
> components of the system. There are partitioning hypervisors, where
> a "control VM" that implements device emulation has limited view into a
> partition's memory for DMA capabilities due to safety concerns.
> 
> This patch adds a command line driven mechanism to move all DMA memory into
> a predefined shared memory region which may or may not be part of the
> physical address layout of the Operating System.
> 
> Ideally, the typical path to set this configuration would be through Device
> Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> instead configure the system purely through kernel command line options.
> 
> I'm sure other people will find the functionality useful going forward
> though and extend it to be triggered by DT/ACPI in the future.

I'm totally against hacking in a kernel parameter for this.  We'll need
a proper documented DT or ACPI way.  We also need to feed this information
into the actual DMA bounce buffering decisions and not just the swiotlb
placement.
