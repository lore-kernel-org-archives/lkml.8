Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD8CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FAA2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650687;
	bh=XqLGbdBcZaA8lYAzU8ms0gPFZh7lQ2qCBZX2B4OWvAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h8wzZaq3lgXco44YbywkeYPbksoR4S9BWWTfbno4ows4tfN48yVPwzcqyTQ51JVpl
	 yw40oPr/kXx13K1czsW5rHRwvpkuXB2upMj+vJhpZ1SPmE68/k4ucnYoxahOQe7b0g
	 trhY2kQqTVel7bzUwJs1culhJzOAbkmMRzhb7AnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHQHv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHQHuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:22 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C052087D;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=XqLGbdBcZaA8lYAzU8ms0gPFZh7lQ2qCBZX2B4OWvAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQ30xA+Fhb1Occ5l0m22JcNdUiJ8XQwSZl7u0hpz2mRzqaKdGEPdEhAXcxDashRd6
         VOA2MM7XTPLaY1bY/Qk6mpo9FWl3PAvoJxxzdkgpJ3mxnUnWntDLMBkmwypPxrhyXi
         Iv3vLA0CYj/ru5p7HOvF+/8RH21lyNLlKvFo2MKk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcD-7T; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 08/16] iommu: get rid of map/unmap tile functions
Date:   Mon, 17 Aug 2020 09:50:07 +0200
Message-Id: <37815d4ecb6b94ea82e7a6876f0201ccdc20d23d.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are needed by the ION-specific downstream code.

Such code would require changes at the core iommu header
file. As we won't be using the ION-specific binding, we can
just get rid of those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 201 ----------------------
 1 file changed, 201 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index 9dae0a3067b6..a55b5a35b339 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -518,205 +518,6 @@ static void hisi_detach_dev_lpae(struct iommu_domain *domain,
 	}
 }
 
-static dma_addr_t get_phys_addr_lpae(struct scatterlist *sg)
-{
-	dma_addr_t dma_addr = sg_dma_address(sg);
-
-	if (!dma_addr)
-		dma_addr = sg_phys(sg);
-	return dma_addr;
-}
-
-int iommu_map_tile(struct iommu_domain *domain, unsigned long iova,
-		   struct scatterlist *sg, size_t size, int prot,
-		   struct tile_format *format)
-{
-	if (unlikely(!(domain->ops->map_tile)))
-		return -ENODEV;
-
-	if (WARN_ON(iova & (~PAGE_MASK)))
-		return -EINVAL;
-
-	return domain->ops->map_tile(domain, iova, sg, size, prot, format);
-}
-
-int iommu_unmap_tile(struct iommu_domain *domain, unsigned long iova,
-		     size_t size)
-{
-	if (unlikely(!(domain->ops->unmap_tile)))
-		return -ENODEV;
-
-	if (WARN_ON(iova & (~PAGE_MASK)))
-		return -EINVAL;
-
-	return domain->ops->unmap_tile(domain, iova, size);
-}
-
-/*
- * iova: the start address for tile mapping
- * size: the physical memory size
- * sg: the node of scatter list where are the start node of physical memory
- * sg_offset: the physical memory offset in the sg node ,where is the start
- *            position of physical memory
- * prot: the pape property of virtual memory
- *
- * this function complete one row mapping.
- */
-static size_t
-hisi_map_tile_row_lpae(struct iommu_domain *domain,
-		       unsigned long iova, size_t size, struct scatterlist *sg,
-		       size_t sg_offset,
-		       struct hisi_map_tile_position_lpae *map_position,
-		       unsigned int prot)
-{
-	unsigned long map_size; /*the memory size that will be mapped*/
-	unsigned long phys_addr;
-	unsigned long mapped_size = 0; /*memory size that has been mapped*/
-	int ret;
-
-	while (1) {
-		/*
-		 *get the remain memory,if current sg node is not enough memory,
-		 *we map the remain memory firstly.
-		 */
-		map_size = size - mapped_size;
-		if (map_size > (sg->length - sg_offset))
-			map_size = (sg->length - sg_offset);
-
-		/* get the start physical address */
-		phys_addr = (unsigned long)get_phys_addr_lpae(sg) + sg_offset;
-		ret = hisi_smmu_map_lpae(domain,
-					 iova + mapped_size, phys_addr,
-					 map_size, prot, GFP_KERNEL);
-		if (ret) {
-			dbg("[%s] hisi_smmu_map failed!\n", __func__);
-			break;
-		}
-		/* update mapped memory size */
-		mapped_size += map_size;
-		/*
-		 * if finished mapping,
-		 * we update the memory offset of current node and
-		 * save the memory position. otherwise we clean the sg_offset
-		 * to zero and get next sg node.
-		 */
-		if (mapped_size < size) {
-			sg_offset = 0;
-			sg = sg_next(sg);
-			if (!sg) {
-				dbg("[%s] phy memory not enough\n", __func__);
-				break;
-			}
-		} else {
-			sg_offset += map_size;
-			/* if physcial memory of this node is exhausted,
-			 * we choose next node
-			 */
-			if (sg_offset == sg->length) {
-				sg_offset = 0;
-				sg = sg_next(sg);
-			}
-			break;
-		}
-	}
-	/* save current position */
-	map_position->sg = sg;
-	map_position->offset = sg_offset;
-
-	return mapped_size;
-}
-
-/*
- * domain:the iommu domain for mapping
- * iova:the start virtual address
- * sg: the scatter list of physical memory
- * size:the total size of all virtual memory
- * port:the property of page table of virtual memory
- * format:the parameter of tile mapping
- * this function map physical memory in tile mode
- */
-static int hisi_smmu_map_tile_lpae(struct iommu_domain *domain,
-				   unsigned long iova,
-				   struct scatterlist *sg,
-				   size_t size, int prot,
-				   struct tile_format *format)
-{
-	unsigned int phys_length;
-	struct scatterlist *sg_node;
-	unsigned int row_number, row;
-	unsigned int size_virt, size_phys;
-	unsigned int sg_offset;
-	int ret = size;
-	unsigned int mapped_size, header_size;
-	struct hisi_map_tile_position_lpae map_position;
-
-	/* calculate the whole length of phys mem */
-	for (phys_length = 0, sg_node = sg; sg_node; sg_node = sg_next(sg_node))
-		phys_length += ALIGN(sg_node->length, PAGE_SIZE);
-
-	header_size = format->header_size;
-
-	/* calculate the number of raws */
-	row_number = ((phys_length - header_size) >> PAGE_SHIFT)
-		/ format->phys_page_line;
-	dbg("phys_length: 0x%x, rows: 0x%x, header_size: 0x%x\n",
-	    phys_length, row_number, header_size);
-
-	/* calculate the need physical memory and virtual memory for one row */
-	size_phys = (format->phys_page_line * PAGE_SIZE);
-	size_virt = (format->virt_page_line * PAGE_SIZE);
-
-	sg_offset = 0;
-	sg_node = sg;
-
-	/* set start position */
-	map_position.sg = sg;
-	map_position.offset = 0;
-
-	/* map header */
-	if (header_size) {
-		mapped_size = hisi_map_tile_row_lpae(domain, iova,
-						     header_size, sg_node,
-						     sg_offset, &map_position,
-						     prot);
-		if (mapped_size != header_size) {
-			WARN(1, "map head fail\n");
-			ret = -EINVAL;
-			goto error;
-		}
-		iova += ALIGN(header_size, size_virt);
-	}
-	/* map row by row */
-	for (row = 0; row < row_number; row++) {
-		/* get physical memory position */
-		if (map_position.sg) {
-			sg_node = map_position.sg;
-			sg_offset = map_position.offset;
-		} else {
-			dbg("[%s]:physical memory is not enough\n", __func__);
-			break;
-		}
-		/* map one row*/
-		mapped_size = hisi_map_tile_row_lpae(domain,
-						     iova + (size_virt * row),
-						     size_phys, sg_node, sg_offset,
-						     &map_position, prot);
-		if (mapped_size != size_phys) {
-			WARN(1, "hisi_map_tile_row failed!\n");
-			ret = -EINVAL;
-			break;
-		}
-	};
-error:
-	return ret;
-}
-
-static size_t hisi_smmu_unmap_tile_lpae(struct iommu_domain *domain,
-					unsigned long iova, size_t size)
-{
-	return hisi_smmu_unmap_lpae(domain, iova, size, NULL);
-}
-
 static bool hisi_smmu_capable(enum iommu_cap cap)
 {
 	return false;
@@ -764,8 +565,6 @@ static struct iommu_ops hisi_smmu_ops = {
 	.remove_device	= hisi_smmu_remove_device,
 	.device_group	= generic_device_group,
 	.pgsize_bitmap	= SMMU_PAGE_SIZE,
-	.map_tile	= hisi_smmu_map_tile_lpae,
-	.unmap_tile	= hisi_smmu_unmap_tile_lpae,
 };
 
 static int hisi_smmu_probe_lpae(struct platform_device *pdev)
-- 
2.26.2

