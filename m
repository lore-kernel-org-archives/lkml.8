Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4787C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D49222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271478;
	bh=pH3RsqpVld5qfAxEnwf2qQxsd5/8DLGOl92mZwcPoYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nL9RP0361lR+bXVZpDCawK24qpmpMiIMPNGwiqkdV9tIVpO6EdEx/4RaumeQIc3E
	 hCsKUgGoWeTkyXg8QouuUtPdmXooT63moNL+BcVIkN/eMLkAVabzl9E/4LfXdV2Xi2
	 Lq2DunqikiBT1sNTNvzMHQ3zTk55kPW2yFJQFWqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBUHvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgBUHvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:51:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F4F20801;
        Fri, 21 Feb 2020 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271473;
        bh=pH3RsqpVld5qfAxEnwf2qQxsd5/8DLGOl92mZwcPoYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7Qdtl528XYfdMwqPaAcahLDIgI0Ohmw7eRLWkMyFDHyZ8bodrkwyVTrRyhaHNQqO
         ZhoBUxK6In6T0miuqVj2UqgqEJ8s+6DDuWHOGMGBCBT8vaMfUbfao7IuMxf1Si7VYG
         1RZCGXPQ1+Vh532Wuq4pUDEeXC6bv/aq+H3grexY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 179/399] iommu/amd: Only support x2APIC with IVHD type 11h/40h
Date:   Fri, 21 Feb 2020 08:38:24 +0100
Message-Id: <20200221072420.116350331@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 966b753cf3969553ca50bacd2b8c4ddade5ecc9e ]

Current implementation for IOMMU x2APIC support makes use of
the MMIO access to MSI capability block registers, which requires
checking EFR[MsiCapMmioSup]. However, only IVHD type 11h/40h contain
the information, and not in the IVHD type 10h IOMMU feature reporting
field. Since the BIOS in newer systems, which supports x2APIC, would
normally contain IVHD type 11h/40h, remove the IOMMU_FEAT_XTSUP_SHIFT
check for IVHD type 10h, and only support x2APIC with IVHD type 11h/40h.

Fixes: 66929812955b ('iommu/amd: Add support for X2APIC IOMMU interrupts')
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c  | 2 --
 drivers/iommu/amd_iommu_types.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 61628c906ce11..d7cbca8bf2cd4 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1523,8 +1523,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
-		if (((h->efr_attr & (0x1 << IOMMU_FEAT_XTSUP_SHIFT)) == 0))
-			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	case 0x11:
 	case 0x40:
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f8a7945f3df90..798e1533a1471 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -377,7 +377,6 @@
 #define IOMMU_CAP_EFR     27
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
-#define IOMMU_FEAT_XTSUP_SHIFT	0
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
 /* IOMMU Extended Feature Register (EFR) */
-- 
2.20.1



