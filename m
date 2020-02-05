Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B4C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C2B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDdm+HKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBEPzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41225 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBEPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so1406621pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bsdxDvHxmIPg1xvhhe9AqHP+aRx23QetwzZU7QbbYOc=;
        b=WDdm+HKOpEsEIQS0RWC3nhmjlhtk/FeT1aUfHH09au7ka4MQr02FaB+S5Ip2wC4yWI
         tPqlkz3MbIqqJp5zFGOANULGu3Sn7/dWty0OEXVcYYZ1u2sCOGVE6/NdrS3NNhOyoP+C
         GCyWJ6GO9lBvkHFEtkgsBmdYeJe827W4M/eT6FTSoMQk4bLLDbGm1RlSjFwcB2Y/8n9a
         F55OcvkCGx/nHeUUgv/zWTAtucDX/WWALsfvc8qvq0Lk4QGh1a13op3hg5otgL1InjNW
         kFEb7iKj5JPJva3oLX//URmkf7MZS6F/MlJ2Ch9riQK6R4177pbGKkqnLC0otJ3Uh6av
         rI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=bsdxDvHxmIPg1xvhhe9AqHP+aRx23QetwzZU7QbbYOc=;
        b=nByv621ta0/ZXMBQ9kLQgBgNB2dVzeKvr8Dc9beYh/FsgKZLvnFwvCKnGiZlBn+YAB
         hmZrr/j69vbJbHPSU0Xm8CWjg4sgrXnSYPUR/EP3F0q2qDteLNZWi5lkb1bdMr9zLKgM
         uezkcZhAslRLF/UKzpjlIz9dsjyFUStrVy0bj0ga5DSjt7c/m6tGsVKNTkKBvhD0oefc
         Lz7mfm5SEgwW4UMXZqYFpFgX9DaeuWct7ou9QTPEVH57kWhhywf2D1bChKHynPkYabk/
         sxdC1TGOjY29YMeKtLFABhs9N0AL0t9pcPFbE5SFtWQvOyJ36YEz7aioY/5bMiODTpsY
         qddg==
X-Gm-Message-State: APjAAAXcoXGbDly8AakqgcvtRoZE/hoPIMK3fBOWGGPqGayf5C2ZdtK4
        /QcXX+s4vW24mZKKd6T0a3I=
X-Google-Smtp-Source: APXvYqzHHowg8oanoCWkld5r4X43w5aHQKeQRrS8kvyfujL32ee8WfVag2/qh59G1TNkd/3Or5DlRw==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr37938712pfl.229.1580918100653;
        Wed, 05 Feb 2020 07:55:00 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:00 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 04/15] NTB: define a new function to get link status
Date:   Wed,  5 Feb 2020 21:24:21 +0530
Message-Id: <d775a8653d3f4550adfdbfaaf03c269ad2896273.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since getting the status of link is a logically separate
operation, we simply create a new function which will
store the link status to be used later.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 93 ++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 111f33ff2bd7..f50537e0917b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -195,6 +195,54 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	return 0;
 }
 
+static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
+{
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pci_swds = NULL;
+	struct pci_dev *pci_swus = NULL;
+	u32 stat;
+	int rc;
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC) {
+		/* Locate the pointer to Downstream Switch for this device */
+		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
+		if (pci_swds) {
+			/*
+			 * Locate the pointer to Upstream Switch for
+			 * the Downstream Switch.
+			 */
+			pci_swus = pci_upstream_bridge(pci_swds);
+			if (pci_swus) {
+				rc = pcie_capability_read_dword(pci_swus,
+								PCI_EXP_LNKCTL,
+								&stat);
+				if (rc)
+					return 0;
+			} else {
+				return 0;
+			}
+		} else {
+			return 0;
+		}
+	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
+		/*
+		 * For NTB primary, we simply read the Link Status and control
+		 * register of the NTB device itself.
+		 */
+		pdev = ndev->ntb.pdev;
+		rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+		if (rc)
+			return 0;
+	} else {
+		/* Catch all for everything else */
+		return 0;
+	}
+
+	ndev->lnk_sta = stat;
+
+	return 1;
+}
+
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
 	if (!ndev->peer_sta)
@@ -845,11 +893,7 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->peer_mmio;
-	struct pci_dev *pdev = NULL;
-	struct pci_dev *pci_swds = NULL;
-	struct pci_dev *pci_swus = NULL;
-	u32 reg, stat;
-	int rc;
+	u32 reg;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	reg &= NTB_LIN_STA_ACTIVE_BIT;
@@ -861,44 +905,7 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC) {
-		/* Locate the pointer to Downstream Switch for this device */
-		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
-		if (pci_swds) {
-			/*
-			 * Locate the pointer to Upstream Switch for
-			 * the Downstream Switch.
-			 */
-			pci_swus = pci_upstream_bridge(pci_swds);
-			if (pci_swus) {
-				rc = pcie_capability_read_dword(pci_swus,
-								PCI_EXP_LNKCTL,
-								&stat);
-				if (rc)
-					return 0;
-			} else {
-				return 0;
-			}
-		} else {
-			return 0;
-		}
-	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
-		/*
-		 * For NTB primary, we simply read the Link Status and control
-		 * register of the NTB device itself.
-		 */
-		pdev = ndev->ntb.pdev;
-		rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
-		if (rc)
-			return 0;
-	} else {
-		/* Catch all for everything else */
-		return 0;
-	}
-
-	ndev->lnk_sta = stat;
-
-	return 1;
+	return amd_ntb_get_link_status(ndev);
 }
 
 static void amd_link_hb(struct work_struct *work)
-- 
2.17.1

