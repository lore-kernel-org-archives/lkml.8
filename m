Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2EC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BFE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="OVH6QCj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgATLLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:11:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgATLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:11:17 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KB3duZ020866;
        Mon, 20 Jan 2020 12:10:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hWK6MgmisYVJHmm88uG+uXlwDqS8xjGWqplDvjUmUsM=;
 b=OVH6QCj782dFUzH3SixLd2+21g0BRZqsDvfwcxHaO983aQ+cfRH9YZO1WAZ28F3/Aia/
 IMDcL2o0cNWzwFJjxGiY7pDgFguenYEm1J/a3sIz37nAFjUZVRBKQrJyGzptN+KD0bZH
 UHUGK9QcHZ3P1Nmeyo01iQhpHGwXjb+7y5spltDG7+pgOoLJ3gAojBH5rgEo9K+Uqi3T
 mbBSuKNDMzZVkWkEreWwvhqH/0b6Zl9sFlgvSLImE9D6gLdBR/wgYl2qPGaEAoZY2QTB
 /SmoEM5tXtYbBtJCLw3uKUHQzCNwKG4nOa1Ypzi6ld6q8JjUbQAW4g75+yKl/lU7s0El Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc4s779-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 12:10:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 47F0C10002A;
        Mon, 20 Jan 2020 12:10:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 292592A96F8;
        Mon, 20 Jan 2020 12:10:42 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 12:10:41
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <linux@armlinux.org.uk>, <akpm@linux-foundation.org>,
        <geert@linux-m68k.org>, <sstabellini@kernel.org>,
        <ben-linux@fluff.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] arm: mm: dma-mapping: Fix missing DMA attributs in functions documentation
Date:   Mon, 20 Jan 2020 12:10:40 +0100
Message-ID: <20200120111040.13983-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for DMA attributes in functions documentation.
That fix warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/mm/dma-mapping.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e822af0d9219..5cd122b9e7d0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -118,6 +118,7 @@ static void __dma_page_dev_to_cpu(struct page *, unsigned long,
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * Ensure that any data held in the cache is appropriately discarded
  * or written back.
@@ -147,6 +148,7 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
  * @handle: DMA address of buffer
  * @size: size of buffer (same as passed to dma_map_page)
  * @dir: DMA transfer direction (same as passed to dma_map_page)
+ * @attrs: DMA attributes
  *
  * Unmap a page streaming mode DMA translation.  The handle and size
  * must match what was provided in the previous dma_map_page() call.
@@ -993,6 +995,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  * @sg: list of buffers
  * @nents: number of buffers to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * Map a set of buffers described by scatterlist in streaming mode for DMA.
  * This is the scatter-gather version of the dma_map_single interface.
@@ -1033,6 +1036,7 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * @sg: list of buffers
  * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ * @attrs: DMA attributes
  *
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
@@ -1708,6 +1712,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * @sg: list of buffers
  * @nents: number of buffers to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * Map a set of i/o coherent buffers described by scatterlist in streaming
  * mode for DMA. The scatter gather list elements are merged together (if
@@ -1726,6 +1731,7 @@ static int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
  * @sg: list of buffers
  * @nents: number of buffers to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * Map a set of buffers described by scatterlist in streaming mode for DMA.
  * The scatter gather list elements are merged together (if possible) and
@@ -1761,6 +1767,7 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
  * @sg: list of buffers
  * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ * @attrs: DMA attributes
  *
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
@@ -1778,6 +1785,7 @@ static void arm_coherent_iommu_unmap_sg(struct device *dev,
  * @sg: list of buffers
  * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ * @attrs: DMA attributes
  *
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
@@ -1835,6 +1843,7 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * Coherent IOMMU aware version of arm_dma_map_page()
  */
@@ -1869,6 +1878,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  *
  * IOMMU aware version of arm_dma_map_page()
  */
@@ -1888,6 +1898,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  * @handle: DMA address of buffer
  * @size: size of buffer (same as passed to dma_map_page)
  * @dir: DMA transfer direction (same as passed to dma_map_page)
+ * @attrs: DMA attributes
  *
  * Coherent IOMMU aware version of arm_dma_unmap_page()
  */
@@ -1912,6 +1923,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  * @handle: DMA address of buffer
  * @size: size of buffer (same as passed to dma_map_page)
  * @dir: DMA transfer direction (same as passed to dma_map_page)
+ * @attrs: DMA attributes
  *
  * IOMMU aware version of arm_dma_unmap_page()
  */
@@ -1940,6 +1952,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
  * @phys_addr: physical address of resource
  * @size: size of resource to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  */
 static dma_addr_t arm_iommu_map_resource(struct device *dev,
 		phys_addr_t phys_addr, size_t size,
@@ -1974,6 +1987,7 @@ static dma_addr_t arm_iommu_map_resource(struct device *dev,
  * @dma_handle: DMA address to resource
  * @size: size of resource to map
  * @dir: DMA transfer direction
+ * @attrs: DMA attributes
  */
 static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir,
-- 
2.15.0

