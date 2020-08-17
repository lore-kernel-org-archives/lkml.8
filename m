Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786EAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3E20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650634;
	bh=5eopSBJ3EqYWC3PVo/2+SzawN6Ik93iYnKxJjLgDgxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LHKPkAS7yUTFaDocu+2eNn7K3XGuW5GFNApa1EqFRKb9gtLhr5jP8Ce0pMX6o2/jZ
	 gjfwRHnd8t6WxybFAiFLVsu8YCLxuSRplrVDvnpkCqaVWKPUWkhlUQgZpHiKA/SDCz
	 NMhODaEB850QGkHbpQlZFfgFfKatywsswmxlYd3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHQHud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgHQHuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D242E207FB;
        Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=5eopSBJ3EqYWC3PVo/2+SzawN6Ik93iYnKxJjLgDgxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUPFccODSE3t9n6VgxUeKaXbgKmBbntE8HLJXor6Ld59r2ZU1J/lwkIFsvsh+oHd/
         ynDTri00w8skW8gqziKfXOq/9+NF7/uSgMwqrluoNIRgCohhI4pnuUfzr3ZrXUo0YS
         T88NbZLm8gHUAHAk5rg3oGjm9Uu5/r99Wvv6wAKo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuL-00Bfby-VC; Mon, 17 Aug 2020 09:50:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 03/16] iommu: hisilicon: map and unmap ops gained new arguments
Date:   Mon, 17 Aug 2020 09:50:02 +0200
Message-Id: <b104726cca6f943f08f4c47ecfb698545a0caa1b.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As both map() and unmap() ops gained new arguments upstream,
update their headers accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hisi_smmu_lpae.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi_smmu_lpae.c b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
index c5c266fb1c0b..b411ca97f2c2 100644
--- a/drivers/staging/hikey9xx/hisi_smmu_lpae.c
+++ b/drivers/staging/hikey9xx/hisi_smmu_lpae.c
@@ -346,7 +346,8 @@ int hisi_smmu_handle_mapping_lpae(struct iommu_domain *domain,
 static int hisi_smmu_map_lpae(struct iommu_domain *domain,
 			      unsigned long iova,
 			      phys_addr_t paddr, size_t size,
-			      int prot)
+			      int prot,
+			      gfp_t gfp)
 {
 	unsigned long max_iova;
 	struct iommu_domain_data *data;
@@ -437,7 +438,8 @@ unsigned int hisi_smmu_handle_unmapping_lpae(struct iommu_domain *domain,
 }
 
 static size_t hisi_smmu_unmap_lpae(struct iommu_domain *domain,
-		unsigned long iova, size_t size)
+		unsigned long iova, size_t size,
+		struct iommu_iotlb_gather *iotlb_gather)
 {
 	unsigned long max_iova;
 	unsigned int ret;
@@ -593,7 +595,7 @@ static size_t hisi_map_tile_row_lpae(struct iommu_domain *domain, unsigned long
 		/*get the start physical address*/
 		phys_addr = (unsigned long)get_phys_addr_lpae(sg) + sg_offset;
 		ret = hisi_smmu_map_lpae(domain,
-				iova + mapped_size, phys_addr, map_size, prot);
+				iova + mapped_size, phys_addr, map_size, prot, GFP_KERNEL);
 		if (ret) {
 			dbg("[%s] hisi_smmu_map failed!\n", __func__);
 			break;
@@ -719,8 +721,7 @@ static int hisi_smmu_map_tile_lpae(struct iommu_domain *domain,
 static size_t hisi_smmu_unmap_tile_lpae(struct iommu_domain *domain,
 		unsigned long iova, size_t size)
 {
-	return hisi_smmu_unmap_lpae(domain, iova, size);
-
+	return hisi_smmu_unmap_lpae(domain, iova, size, NULL);
 }
 
 static struct iommu_ops hisi_smmu_ops = {
-- 
2.26.2

