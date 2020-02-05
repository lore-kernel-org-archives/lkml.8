Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90685217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INNRrJBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgBEPzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43133 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbgBEPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so1150015pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xDAPz0iqMJV07aH6pLFlhLI9ETQtq7tGyHxeyMeHoMQ=;
        b=INNRrJBgkqSlZIJs/EEFTIbuaaGd2Gz1wXFLCyeoSY4ExA7A+hkzhYptwKbPbQnrNj
         4Y7cbuvBHQlO3zcWPyNUY6deeBVoSF9qF6kGa/mPxBH1AaDbvOFfdmAu1umCmJps0Npb
         HB5oTINYX6bVjqaWD0rL42r245It//Yza07sNxYavesAnEyULIfK3YO9yOv1m0/1T8eS
         zIBgJOielLaNfIU8omLCHEhjwRioONmWeyTRawrUIvmULYOy9hACms7vi6Y6aoqOIxHW
         oYs4/DsRcbOE/vfa/cUb90KvxlOpIE4qcb+BLmUz1MEALvT79k3UG49WLEDRNOf2SLbE
         czUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=xDAPz0iqMJV07aH6pLFlhLI9ETQtq7tGyHxeyMeHoMQ=;
        b=Woq39Xox1LW+UK0ZPfJMsKITa0ff8pZtL/719oSh+7JHOBq+TRcqhzau/sWbYFAS0/
         lcEj8m2BhDziGOnTaFEJiIlo/sTM7dYytolq+lJ93n13Sxim7W96Dh47hB9joYMaob20
         8c+ziqgM+AeWkK7OpgPybsnaSUJEVpj1sUcb2oXZ4U6fWUiZMRFicZe1aqoTgSpLLjIG
         dCF9ix5f2kWhCpAxR/LEH9eswhmmC/OBaHJhp9c4QAJCH8FjmYBkvQUhKcA42E+8+fD2
         q3xvOPS57eugsF815zCxGveqhB/Np4CJACx33I0PbnOEDRgFjKYiwkK+0r5/Nn/X0e3n
         L2YQ==
X-Gm-Message-State: APjAAAXJZ7Y4A+SIBEUOdOjcLx3qz8gwwm3lfCyFR+y02rpK50XR7p90
        fWkKNmRnjp+qUiYIojtX1pc=
X-Google-Smtp-Source: APXvYqyEsi3B+6h6tlMWifqoBfJg32/C3Fv0ZjCKeYhvoVA+VwYvU0rv7J+v4XZpR18Xp+tuBioEGQ==
X-Received: by 2002:a62:e708:: with SMTP id s8mr28926286pfh.122.1580918121222;
        Wed, 05 Feb 2020 07:55:21 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:20 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 11/15] NTB: add helper functions to set and clear sideinfo
Date:   Wed,  5 Feb 2020 21:24:28 +0530
Message-Id: <08593511a6c9c4a4ce937e2c92c08638c051c70f.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define two new helper functions to set and clear
sideinfo registers respectively. These functions
take an additional boolean parameter which signifies
whether we want to set/clear the sideinfo register
of the peer(true) or local host(false).

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 44 +++++++++++++++++++++++++--------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 621a69a0cff2..d4029d531466 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -913,28 +913,32 @@ static int amd_init_isr(struct amd_ntb_dev *ndev)
 	return ndev_init_isr(ndev, AMD_DB_CNT, AMD_MSIX_VECTOR_CNT);
 }
 
-static void amd_init_side_info(struct amd_ntb_dev *ndev)
+static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer)
 {
-	void __iomem *mmio = ndev->self_mmio;
+	void __iomem *mmio = NULL;
 	unsigned int reg;
-	u32 ntb_ctl;
+
+	if (peer)
+		mmio = ndev->peer_mmio;
+	else
+		mmio = ndev->self_mmio;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (!(reg & AMD_SIDE_READY)) {
 		reg |= AMD_SIDE_READY;
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 	}
-
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
-static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
+static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer)
 {
-	void __iomem *mmio = ndev->self_mmio;
+	void __iomem *mmio = NULL;
 	unsigned int reg;
-	u32 ntb_ctl;
+
+	if (peer)
+		mmio = ndev->peer_mmio;
+	else
+		mmio = ndev->self_mmio;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (reg & AMD_SIDE_READY) {
@@ -942,6 +946,26 @@ static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 		readl(mmio + AMD_SIDEINFO_OFFSET);
 	}
+}
+
+static void amd_init_side_info(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	amd_set_side_info_reg(ndev, false);
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
+}
+
+static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	amd_clear_side_info_reg(ndev, false);
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 156a4a92b803..62ffdf35b683 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -215,4 +215,7 @@ struct amd_ntb_dev {
 #define ntb_ndev(__ntb) container_of(__ntb, struct amd_ntb_dev, ntb)
 #define hb_ndev(__work) container_of(__work, struct amd_ntb_dev, hb_timer.work)
 
+static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+
 #endif
-- 
2.17.1

