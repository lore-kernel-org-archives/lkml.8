Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D76205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgCPMqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:46:55 -0400
Received: from verein.lst.de ([213.95.11.211]:54169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbgCPMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:46:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1711468CEC; Mon, 16 Mar 2020 13:46:53 +0100 (CET)
Date:   Mon, 16 Mar 2020 13:46:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316124652.GA17386@lst.de>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com> <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 12:12:08PM +0000, Robin Murphy wrote:
> On 2020-03-14 12:00 am, Nicolin Chen wrote:
>> More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
>> only a handful of drivers call dma_set_seg_boundary(). This means
>> that most drivers have a 4GB segmention boundary because DMA API
>> returns DMA_BIT_MAKS(32) as a default value, though they might be
>> able to handle things above 32-bit.
>
> Don't assume the boundary mask and the DMA mask are related. There do exist 
> devices which can DMA to a 64-bit address space in general, but due to 
> descriptor formats/hardware design/whatever still require any single 
> transfer not to cross some smaller boundary. XHCI is 64-bit yet requires 
> most things not to cross a 64KB boundary. EHCI's 64-bit mode is an example 
> of the 4GB boundary (not the best example, admittedly, but it undeniably 
> exists).

Yes, which is what the boundary is for.  But why would we default to
something restrictive by default even if the driver didn't ask for it?
