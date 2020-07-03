Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145E420760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593793561;
	bh=7F1X4zquMazIejX1qFVDckVNrvMQPCeEeV21KqUMgQw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D8tIAPlFte+LafT2Awb2cx3w+myq7X38u5YY9xEYU/c6DPOtmbIyrORUPcgS5Hjs2
	 GZ8f9hE+zBTrUzrn7CboVvzMvd8eMhzw2/crXz/mPWZOVi8tSAbs0qEpOxd07LfT5w
	 2loQTsRpqx/wVh1YAjlOsJY3PdQi4AleNhSZ/BYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGCQ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 12:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgGCQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 12:25:59 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E912073E;
        Fri,  3 Jul 2020 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593793559;
        bh=7F1X4zquMazIejX1qFVDckVNrvMQPCeEeV21KqUMgQw=;
        h=From:To:Cc:Subject:Date:From;
        b=1qYfEO29U/AR6nzkGg3y7uXyIAPVmDGsC8iauC523Qrz/zmUTIsIMZBI3AcANp5iz
         8Z1CHFffsgekV8r2xrpsOXCwK8F0VEAZ3FggIUNUCSFW8aS2dI7XzBGhZvONg7RVJW
         QKqSNJqxFwa3sfgtV77ajRS7v63QOdPSfAPGzVW0=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Date:   Fri,  3 Jul 2020 17:25:48 +0100
Message-Id: <20200703162548.19953-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
has no in-tree users. Remove it.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

As discussed in [1], sounds like this should be a domain attribute anyway
when it's needed by the GPU.

[1] https://lore.kernel.org/r/CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com

 drivers/iommu/io-pgtable-arm.c | 3 ---
 include/linux/iommu.h          | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 04fbd4bf0ff9..8f175c02f8e3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -438,9 +438,6 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_SYS_CACHE_ONLY)
-			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
-				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
 	if (prot & IOMMU_CACHE)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..bee1a8fa1fb1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,12 +31,6 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
-/*
- * Non-coherent masters can use this page protection flag to set cacheable
- * memory attributes for only a transparent outer level of cache, also known as
- * the last-level or system cache.
- */
-#define IOMMU_SYS_CACHE_ONLY	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.27.0.212.ge8ba1cc988-goog

