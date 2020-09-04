Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63689C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40213206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgIDKDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:03:46 -0400
Received: from 8bytes.org ([81.169.241.247]:41080 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:03:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1952D3D5; Fri,  4 Sep 2020 12:03:42 +0200 (CEST)
Date:   Fri, 4 Sep 2020 12:03:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu
 api
Message-ID: <20200904100340.GT6714@8bytes.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tom,

On Thu, Sep 03, 2020 at 09:18:32PM +0100, Tom Murphy wrote:
> Tom Murphy (5):
>   iommu: Handle freelists when using deferred flushing in iommu drivers
>   iommu: Add iommu_dma_free_cpu_cached_iovas function
>   iommu: allow the dma-iommu api to use bounce buffers
>   iommu/vt-d: Convert intel iommu driver to the iommu ops
>   DO NOT MERGE: iommu: disable list appending in dma-iommu

Thanks for your continued work on this. As discussed in the
microconference, Lu Baolu will take this over now and we can hopefully
merge it soon.

Thanks,

	Joerg
