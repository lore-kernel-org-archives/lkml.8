Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE6DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DEF20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUXuf7lF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBEPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:54:53 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53706 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:54:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so1147970pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8ytOhGE/+q0R3jDpUR03D8eJfWZx9aSG9442bZTQPuk=;
        b=FUXuf7lFFvTe5O9u4I2Pb+peKlNn68HBVOyLN9G1WhtkL5rgSrHFA3FULI3Kg/kFVr
         U1cZ6vYeJHAQyW6L7rkCi1+LEbXz9pUQQ6Y5/f31llips409u/RFAuRiMwug3SM8HSiM
         KgCcp/18O0FknFnfqUqGiDK+eSQYS4LgYk5q/WnKlAS+Q8gVvRl9EN+iSpTYutoRBKz/
         p1WtpcPsXd3uAAostAgAP6hljVUGClT40mC0+cxPNjP5GLDvAC939oDRfeIQb4ba9MkM
         g7l95ibyqMVQeIgBDD1TZ62b20e9eoGrHsLrwpuRyvsytW/3KHsvuD/E+hjJSOg7jRZ7
         TEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=8ytOhGE/+q0R3jDpUR03D8eJfWZx9aSG9442bZTQPuk=;
        b=AsubF5tlxWkg5FZWtT3juTgTg0RrG4bFpHOWfzxr3cOwcZFrGUexA/n4l+Ntcpj0Wd
         I8nGy19wLd9S4DJcmoNeD2/3UBHus3CBk4e9SpezCMSOBcNMiY0oj9wAyvLoPoDr4rlX
         K/RYtSMK2R26t0pAXxHV92mJlLWvZXeP3O1x63yoatfa9ZNPJm2R77XSBpXZC+KAXB4x
         HWcpSg3vaFC8zxX3yWhGv61FagF7HFPKUoH0hjqK1AFG7Pa3HgPdJi/X5SOrVs+RWjGJ
         JI0Qg0xBA849xPo5k4YYupoMVNQjKbt6cNR4oT10RIoeZpUqV1zAUuS/d77tSZ4XwWws
         UHZg==
X-Gm-Message-State: APjAAAVrLps9MPT4+AFyiLrDIEoO/l4uR3lNFjZN/TuyxM5H0iTcOp66
        /Hx1jvdykKVYtycbMI3hRSU=
X-Google-Smtp-Source: APXvYqwlQ+zHscZTiIep684iok3Pst7fyyOAMf8nU8PfwQPytajNbYJhIyXXAy9/NV3GJOAsDjXCkw==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr6109180pjx.13.1580918091468;
        Wed, 05 Feb 2020 07:54:51 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:54:50 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 01/15] NTB: Fix access to link status and control register
Date:   Wed,  5 Feb 2020 21:24:18 +0530
Message-Id: <dff949f3edec4c78549c0a9b26c6932a8190fee3.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The design of AMD NTB implementation is such that
NTB primary acts as an endpoint device and NTB
secondary is an endpoint device behind a combination
of Switch Upstream and Switch Downstream. Considering
that, the link status and control register needs to
be accessed differently based on the NTB topology.

So in the case of NTB secondary, we first get the
pointer to the Switch Downstream device for the NTB
device. Then we get the pointer to the Switch Upstream
device. Once we have that, we read the Link Status
and Control register to get the correct status of
link at the secondary.

In the case of NTB primary, simply reading the Link
Status and Control register of the NTB device itself
will suffice.

Suggested-by: Jiasen Lin <linjiasen@hygon.cn>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 40 ++++++++++++++++++++++++++++++---
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index e52b300b2f5b..9a60f34a37c2 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -842,6 +842,9 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->peer_mmio;
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pci_swds = NULL;
+	struct pci_dev *pci_swus = NULL;
 	u32 reg, stat;
 	int rc;
 
@@ -855,10 +858,41 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	rc = pci_read_config_dword(ndev->ntb.pdev,
-				   AMD_LINK_STATUS_OFFSET, &stat);
-	if (rc)
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
 		return 0;
+	}
+
 	ndev->lnk_sta = stat;
 
 	return 1;
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 139a307147bc..39e5d18e12ff 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
-#define AMD_LINK_STATUS_OFFSET	0x68
 #define NTB_LIN_STA_ACTIVE_BIT	0x00000002
 #define NTB_LNK_STA_SPEED_MASK	0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK	0x03F00000
-- 
2.17.1

