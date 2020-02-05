Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D47C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA978222D9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeLf/aWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBEPzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43131 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBEPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id u131so1149959pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vtj5yU1EsG5Z9W3Ll/6G1xCr4kAz0z3BK+crKJ17lmY=;
        b=OeLf/aWbuDLMyuj4MTFLEpfo549xU+aYym3Kpd8HrN7u8CKP224sK5XU7p6e8LwLEc
         tmB9+ZxfgFDCC29cgTzceAjdWfndiuN7Hca4MYAEr7zNoXaSgjABfVOZggJiHo6SVYz0
         cGLUD37adNr8VnGqdkC/vRDDDRmcjJ4+tVgq1oYJJhYfDVkzTvpIvq9a5R10S0OOONIz
         C1Kv2vhdnGyXh3+ddoOEHmx2is90HCo26dz+pLHKGS07UQ2NeLSISXjCiTuZL7sTezSB
         TWJPkpsVh2GoDjoAOnSYmPCxCT2YkH5Dk2X6D+tZmRvqMl0zsGtuLWnFNh0euuh7mkGt
         I2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=vtj5yU1EsG5Z9W3Ll/6G1xCr4kAz0z3BK+crKJ17lmY=;
        b=AN8IvQURM3XGAVCl7hGoPkGRhBvS87mBdVc8Olypc2v9IySqcvIpyMwXz6yWk+nBoq
         48Blse6hlHesZxTQI1R6UtK5yCPHL5PM2npjSxSxbr/um+T/SwPSHqhuUsQeKU/ZXYPy
         L+GeoBnJpPW8TIRNSLRjc4HfgL87f+oqPQS/q4yvBFK5d2CA8e57jY/LbNipF3WBruYU
         +9jKxAz7tiw5ELVWDinsTzjWpAwYz4z9U9RCRgpx/9T4gEmN5qG8xze0yAa3ozghKnlx
         94XxW6k2iGths9ymj46X9CM57oxb/BRIMspnzF96gUmHBzk4YfVcDgnoYOCKdQzU05g5
         1vLA==
X-Gm-Message-State: APjAAAXmAd/GtAYulV2KDnn2gaohUaFPP5d5qLZka7uyOQ8wD7SIZA5I
        tuVrdvh6wbYBVyvd6SurA+c=
X-Google-Smtp-Source: APXvYqxSz0jQ+f4lNAQjrH6Rd7Xk75OwiJYLZSRmwgb2RmxtRWN4buXM5RWE9wX1JO5O+PCIVgeKxQ==
X-Received: by 2002:a62:6842:: with SMTP id d63mr37654928pfc.113.1580918118279;
        Wed, 05 Feb 2020 07:55:18 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:17 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 10/15] NTB: move ntb_ctrl handling to init and deinit
Date:   Wed,  5 Feb 2020 21:24:27 +0530
Message-Id: <62c2d386903e1ec4a6a1b6a097ec7f5faade72e6.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not really make sense to enable or disable
the bits of NTB_CTRL register only during enable
and disable link callbacks. They should be done
independent of these callbacks. The correct placement
for that is during the amd_init_side_info() and
amd_deinit_side_info() functions, which are invoked
during probe and remove respectively.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index a1c4a21c58c3..621a69a0cff2 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -290,7 +290,6 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
 
 	/* Enable event interrupt */
 	ndev->int_mask &= ~AMD_EVENT_INTMASK;
@@ -300,10 +299,6 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 		return -EINVAL;
 	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
 	return 0;
 }
 
@@ -311,7 +306,6 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
 
 	/* Disable event interrupt */
 	ndev->int_mask |= AMD_EVENT_INTMASK;
@@ -321,10 +315,6 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 		return -EINVAL;
 	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
 	return 0;
 }
 
@@ -927,18 +917,24 @@ static void amd_init_side_info(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->self_mmio;
 	unsigned int reg;
+	u32 ntb_ctl;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (!(reg & AMD_SIDE_READY)) {
 		reg |= AMD_SIDE_READY;
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 	}
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
 static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->self_mmio;
 	unsigned int reg;
+	u32 ntb_ctl;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (reg & AMD_SIDE_READY) {
@@ -946,6 +942,10 @@ static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 		readl(mmio + AMD_SIDEINFO_OFFSET);
 	}
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
 static int amd_init_ntb(struct amd_ntb_dev *ndev)
-- 
2.17.1

