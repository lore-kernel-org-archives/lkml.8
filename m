Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FD02088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B2e2R9PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbgE0QDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389427AbgE0QDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:03:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C95C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:03:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so24498180wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KFKU2FIEXjR2LVGipQU8OJxGYrMEcKfupZbFBx9PZZY=;
        b=B2e2R9PE8ZAp1sDLI7S8lrsjRfkvo6x+EJYJrJz0c/qJQagKVvvmzFan3qz6GVfd6w
         ZKbl/Y4xcQche/y9+bbZ5lOKaV7q9ddkacdSC40vxtQbuTw+sN+TPTU7MPDWmrXxy9ax
         3iBMFvXs8pOm6kAt7e6x61xsyeX0RxXmUKZn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KFKU2FIEXjR2LVGipQU8OJxGYrMEcKfupZbFBx9PZZY=;
        b=I9I/KCRuaCH27B0/jlRZ7ZcfcA8ufY2BQuDADMfPYBVQahN+pLAZgkNeOJX1vd4Zhn
         cgUlcYy4ycemQagD6q4EMCVelfDqID28AQmN2ifR3HZXg3sj+966CjhVKyz+maEo8IR1
         eAKja4+qw/9yF187DHWQpwzZMlAHoSEnYKgHwp7w6JKl02GfqX+DsDEaLW89GpxB8X3c
         dr2ZyMa8Eeja00etW39oP2+xZke7yZU0DJQ7G52o7V2OoTAsaPEokCTkHHVliLdtaw8V
         xd9+vecMv5OvwCLWK9rbCcx/SojQ0SW82h1s4tRnPm4qELRbNOPoIO177fWckOE/icbQ
         RcVA==
X-Gm-Message-State: AOAM531bf6fPh6z64UXXX6G9xhq8S9BIS0i3DeTZqwvq3G6P2INuXWtx
        ZbwE1y1Z2/e2se7dLU/jQBTy2w==
X-Google-Smtp-Source: ABdhPJy6zYyWagZxKoXwDNe6/zG4VwLJq8RxTRFygqpQIc/E1CTTwd97wcehZx5+4rvjGpKll243Ug==
X-Received: by 2002:adf:ee47:: with SMTP id w7mr19715593wro.171.1590595413899;
        Wed, 27 May 2020 09:03:33 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t185sm3166536wmt.28.2020.05.27.09.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 09:03:33 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova address
Date:   Wed, 27 May 2020 21:33:18 +0530
Message-Id: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives the provision to change default value of MSI IOVA base
to platform's suitable IOVA using module parameter. The present
hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.

Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
property are reserved.

If any platform has the limitaion to access default MSI IOVA, then it can
be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4f1a350..5e59c9d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -72,6 +72,9 @@ static bool disable_bypass =
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
+static unsigned long msi_iova_base = MSI_IOVA_BASE;
+module_param(msi_iova_base, ulong, S_IRUGO);
+MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
 
 struct arm_smmu_s2cr {
 	struct iommu_group		*group;
@@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+	region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
 					 prot, IOMMU_RESV_SW_MSI);
 	if (!region)
 		return;
-- 
2.7.4

