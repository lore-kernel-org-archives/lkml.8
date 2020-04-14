Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26EAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77E6206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406037AbgDNGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:30:49 -0400
Received: from verein.lst.de ([213.95.11.211]:37657 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405991AbgDNGas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:30:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E89D5227A81; Tue, 14 Apr 2020 08:30:43 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:30:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200414063043.GF23154@lst.de>
References: <20200324075402.GJ23447@lst.de> <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru> <20200325083740.GC21605@lst.de> <a705afc5-779d-baf4-e5d2-e2da04c82743@ozlabs.ru> <213b0c7d-f908-b4f4-466d-6240c3622cd6@ozlabs.ru> <20200406115016.GA10941@lst.de> <348046e7-7a38-62d6-4df0-e4a537b98926@ozlabs.ru> <20200406171706.GA3231@lst.de> <95395244-bdec-84d2-b81b-3040c076fe4d@ozlabs.ru> <44ad32a4-7ce5-4f4d-8237-53356f76f53a@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ad32a4-7ce5-4f4d-8237-53356f76f53a@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:21:27PM +1000, Alexey Kardashevskiy wrote:
> > Good points, I'll post revised version when you post your v3 of this.
> 
> 
> 
> Any plans on posting v3 of this? Thanks,

Just back from a long weekend.  I'll take a stab at it soon.
