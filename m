Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C779C214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583267281;
	bh=TQFREpodh737XGIeLodUL4HQM120tMrx7VDRn4FVH5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imbl1dZ///Kteeu538CpiXd1mKoNB5awT/FWa3gJUKpFKOni1/zPXpfnpsPflasw4
	 6ST6FFdJLZfnKzszO0W5gzG1KZu3miGrPFizWxUptlS79kGAlc8mADw1TDPmH8wPUH
	 TI0LG71qSoCCQrNZXj5BzRsAKqb6DkYodlPbv3W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgCCU2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbgCCU17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:27:59 -0500
Received: from localhost.localdomain (unknown [194.230.155.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F0B2146E;
        Tue,  3 Mar 2020 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267279;
        bh=TQFREpodh737XGIeLodUL4HQM120tMrx7VDRn4FVH5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2fxUzPZjjlvmQGv/totKM6I2eRCVswvMRU+oJsWgdKxX8LxcmNzI+0DmamY+/9lr
         Q/LSoVuBXxzH7DCrB7lJtZDOrPuCMA5t85V9dUPBv0FbDfy8IexkAv7TuNRzI/tJtk
         NnpA1DdQMfxWipFvVgd0lut3umhWKdAQ7sWeGp60=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Suman Anna <s-anna@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 2/4] iommu/omap: Fix printing format for size_t on 64-bit
Date:   Tue,  3 Mar 2020 21:27:49 +0100
Message-Id: <20200303202751.5153-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303202751.5153-1-krzk@kernel.org>
References: <20200303202751.5153-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print size_t as %zu or %zx to fix -Wformat warnings when compiling on
64-bit platform (e.g. with COMPILE_TEST):

    drivers/iommu/omap-iommu.c: In function ‘flush_iotlb_page’:
    drivers/iommu/omap-iommu.c:437:47: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 7 has type ‘size_t {aka long unsigned int}’ [-Wformat=]

Acked-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware.
---
 drivers/iommu/omap-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 50e8acf88ec4..887fefcb03b4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -434,7 +434,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 		bytes = iopgsz_to_bytes(cr.cam & 3);
 
 		if ((start <= da) && (da < start + bytes)) {
-			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
+			dev_dbg(obj->dev, "%s: %08x<=%08x(%zx)\n",
 				__func__, start, da, bytes);
 			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
@@ -1352,11 +1352,11 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
-		dev_err(dev, "invalid size to map: %d\n", bytes);
+		dev_err(dev, "invalid size to map: %zu\n", bytes);
 		return -EINVAL;
 	}
 
-	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%x\n", da, &pa, bytes);
+	dev_dbg(dev, "mapping da 0x%lx to pa %pa size 0x%zx\n", da, &pa, bytes);
 
 	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
@@ -1393,7 +1393,7 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
 	size_t bytes = 0;
 	int i;
 
-	dev_dbg(dev, "unmapping da 0x%lx size %u\n", da, size);
+	dev_dbg(dev, "unmapping da 0x%lx size %zu\n", da, size);
 
 	iommu = omap_domain->iommus;
 	for (i = 0; i < omap_domain->num_iommus; i++, iommu++) {
-- 
2.17.1

