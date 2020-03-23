Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A0C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879C120722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgCWRXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:23:00 -0400
Received: from verein.lst.de ([213.95.11.211]:59662 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgCWRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:23:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDCC068BEB; Mon, 23 Mar 2020 18:22:56 +0100 (CET)
Date:   Mon, 23 Mar 2020 18:22:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200323172256.GB31269@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de> <87sghz2ibh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sghz2ibh.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:07:38PM +0530, Aneesh Kumar K.V wrote:
> 
> This is what I was trying, but considering I am new to DMA subsystem, I
> am not sure I got all the details correct. The idea is to look at the
> cpu addr and see if that can be used in direct map fashion(is
> bus_dma_limit the right restriction here?) if not fallback to dynamic
> IOMMU mapping.

I don't think we can throw all these complications into the dma
mapping code.  At some point I also wonder what the point is,
especially for scatterlist mappings, where the iommu can coalesce.
