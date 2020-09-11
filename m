Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A44C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15685206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S5AaYjku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgIKKZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:25:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B8C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:25:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gf14so1480197pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e46DHbzTBFXI2qUO06Xr5hYaBwt3naS56LAsBV+A8t0=;
        b=S5AaYjkuSLMxqDh1NKhipUCvP8LgUI4CrWq0Gy+35B9PP8LBCI/Pf2buHxS6pb8Wbt
         yYzgLIwcAA1qjq+oAhM6N2dy39Q70v5y0XGOPpwGVSn9Ihb0wWEQ1LccJDresNLt1Y1l
         MRykiJAhxTBrXPmgcaVL+jKTiqA9B+uniRY8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e46DHbzTBFXI2qUO06Xr5hYaBwt3naS56LAsBV+A8t0=;
        b=S40GNVwBmjpItk/MIEPcvAGlLvGrMfiEl6Rcf73gmOdnHJFDHJkPuKxJyKnGakjQQe
         AWAEUtOCc3b/bF2T+WS9QW8mnlL6limf0pYuzbMftKulIiRBGHB4oFbko8o18Uq98PpV
         D5RgY3LuhAYTJNDcfYfoVDrR9MRct5/cE4x6i37tTZLBgKI/3ML80+xyhG9bEiJtnrRY
         0oL3JT8ZpXZR48O98BwQGac37LdH+t1axDlO6cEEbOdf8nbeczvaC103+sQNBlfvBv41
         xRQy3eiRowegsWZqf+FaxtCnb+p2Up1GfukZHp3y243tfbSLsvLTdXsjuE2IOy3CBeww
         mwZg==
X-Gm-Message-State: AOAM531DAsCj7/GKCIej2Q4XZeSSG5B4uUOkKN0h5+XxT0RqEwIB41WO
        wcs/Q8EFFMgzyig5iqesgVtOfw==
X-Google-Smtp-Source: ABdhPJxPDMHj7bY9B1+rquyIhx1L1LA2oRdhPi5GLC9/YQnGbN3wlM27C1EJ7k/EZkniTjjK6iCpNA==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr1642230pjq.40.1599819948441;
        Fri, 11 Sep 2020 03:25:48 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i17sm1929584pfa.2.2020.09.11.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:25:47 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
Date:   Fri, 11 Sep 2020 15:55:34 +0530
Message-Id: <20200911102534.25218-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IOVA reserve failure in the case when address of first memory region
listed in dma-ranges is equal to 0x0.

Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
Changes from v1:
   Removed unnecessary changes based on Robin's review comments.

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..682068a9aae7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
+		} else if (end < start) {
 			/* dma_ranges list should be sorted */
 			dev_err(&dev->dev, "Failed to reserve IOVA\n");
 			return -EINVAL;
-- 
2.17.1

