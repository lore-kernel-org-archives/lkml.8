Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32A9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A3B2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YslrSU8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIIFdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIFdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:33:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD3C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:33:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so1210673pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rZs5/qThJgbqO8YqJOp1eEHnebIHaFEtXXl91F8jl2A=;
        b=YslrSU8KqaqEnx/54qD5LexXZKdcw6uaXadQu7jKPZZYbgKe81YCKhCdGNCh8cMfVc
         l9TAkUNmvj3YVhmfq3P8qMJ02GQwJO7Y/+F5OkgyEjMIfxuBKvrYfsGu3/bUoFaniwKc
         shcZzMvquqojMuOhgAL+KZH8abqvjuR8J5EeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rZs5/qThJgbqO8YqJOp1eEHnebIHaFEtXXl91F8jl2A=;
        b=FOOTAv3vnWGswACdXIqv/C4sx3uKVY1zJgyKql/ZALIe9pyNE84bhrAK0qRNxr9q9r
         EqFrbqb3xEJ9zhjqtlcatAxy6BvqUyCby59oIcdBmYaiTcugP3zQ1SYLjS0+nLOg5DWx
         GfjH58mQQ7mDAJzV9LMJALJELPUxJLIARUqCDZamTkOx8gFTEh+hOca3UdS5PWf2v/Bd
         bVoF9Y4lO7tG0BHkgCMS1jS/W3I32vx4VQj9qoPLLUDmyaDVzt2Oj8IYxo8IcGs31QL4
         gpsIzr7m+HhESnMDPddxd7+uYZL95PU2259wJOcmTIk+ykhIxdyhAFApwsl1DmMTSeRx
         LENg==
X-Gm-Message-State: AOAM533D0gkjQTjU0LpMEQO4LuNgM3TFEj2xPtEc8EAZ+t+gL4uX/U+D
        ndNDViEafXMOkna+NIDti3mkng==
X-Google-Smtp-Source: ABdhPJxCZK1FhqkwUgTtKJozciIvYxg2nj5pVXQhC4T8g71p4oTLqM/35nswkzPPVtFDRAn9Ve5LRQ==
X-Received: by 2002:aa7:9494:: with SMTP id z20mr2145768pfk.144.1599629599200;
        Tue, 08 Sep 2020 22:33:19 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w192sm1181791pfd.156.2020.09.08.22.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:33:18 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
Date:   Wed,  9 Sep 2020 11:02:34 +0530
Message-Id: <20200909053234.17027-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IOVA reserve failure for memory regions listed in dma-ranges in the
following cases.

- start address of memory region is 0x0.
- end address of a memory region is equal to start address of next memory
  region.

Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/iommu/dma-iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..0a3f67a4f9ae 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	resource_list_for_each_entry(window, &bridge->dma_ranges) {
 		end = window->res->start - window->offset;
 resv_iova:
+		if (end < start) {
+			/* dma_ranges list should be sorted */
+			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			return -EINVAL;
+		}
+		/*
+		 * Skip the cases when start address of first memory region is
+		 * 0x0 and end address of one memory region and start address
+		 * of next memory region are equal. Reserve IOVA for rest of
+		 * addresses fall in between given memory ranges.
+		 */
 		if (end > start) {
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
-			/* dma_ranges list should be sorted */
-			dev_err(&dev->dev, "Failed to reserve IOVA\n");
-			return -EINVAL;
 		}
 
 		start = window->res->end - window->offset + 1;
-- 
2.17.1

