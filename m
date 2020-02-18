Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C8C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BB720722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRJ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:28:35 -0500
Received: from 8bytes.org ([81.169.241.247]:54594 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgBRJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:28:35 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D3CCC36C; Tue, 18 Feb 2020 10:28:33 +0100 (CET)
Date:   Tue, 18 Feb 2020 10:28:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5 v2] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200218092827.tp3pq67adzr56k7e@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
 <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Tue, Feb 18, 2020 at 10:38:14AM +0800, Lu Baolu wrote:
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 42cdcce1602e..32f43695a22b 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
> >   static struct dmar_domain *deferred_attach_domain(struct device *dev)
> >   {
> > -	if (unlikely(attach_deferred(dev)))
> > -		do_deferred_attach(dev);
> > -
> 
> This should also be moved to the call place of deferred_attach_domain()
> in bounce_map_single().
> 
> bounce_map_single() assumes that devices always use DMA domain, so it
> doesn't call iommu_need_mapping(). We could do_deferred_attach() there
> manually.

Good point, thanks for your review. Updated patch below.

From 3a5b8a66d288d86ac1fd45092e7d96f842d0cccf Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Mon, 17 Feb 2020 17:20:59 +0100
Subject: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()

The attachment of deferred devices needs to happen before the check
whether the device is identity mapped or not. Otherwise the check will
return wrong results, cause warnings boot failures in kdump kernels, like

	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70

	[...]

	 Call Trace:
	  __intel_map_single+0x55/0x190
	  intel_alloc_coherent+0xac/0x110
	  dmam_alloc_attrs+0x50/0xa0
	  ahci_port_start+0xfb/0x1f0 [libahci]
	  ata_host_start.part.39+0x104/0x1e0 [libata]

With the earlier check the kdump boot succeeds and a crashdump is written.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42cdcce1602e..723f615c6e84 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
 
 static struct dmar_domain *deferred_attach_domain(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
 	return find_domain(dev);
 }
 
@@ -3595,6 +3592,9 @@ static bool iommu_need_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return false;
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	ret = identity_mapping(dev);
 	if (ret) {
 		u64 dma_mask = *dev->dma_mask;
@@ -3958,7 +3958,11 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	int prot = 0;
 	int ret;
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	domain = deferred_attach_domain(dev);
+
 	if (WARN_ON(dir == DMA_NONE || !domain))
 		return DMA_MAPPING_ERROR;
 
-- 
2.25.0

