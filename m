Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA717C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D96520702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J62veQDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgBEPzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38437 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgBEPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so1162834pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kl3iIovPAXkFd81DfbgFsEB+vcJ/l3r5RhzJoBZ9OdY=;
        b=J62veQDZUS60iVY4Tlz48ya7YikXvICFzI5tkilkr/axUIwN38abRMd7KF1ZhTF/Zr
         TSlyly3nnAiNKlhLSMR5YjO2eqSmXtWBUCQEc/wuns5dwBOsY84RAJXb4vaLxN3kxR8/
         Mx+mfDIRRZ9AdvEDQ3kSGpxTZ6zNUNelJn0UsX3CaINeg0sNZzHsA9WTrX7OBxakVNeo
         g0Te55AZfOLco/7duWlueQWQxwzmV4tRrmiMl35ft+i5VYXxBrKIiNCiRTS6nKSSH/gA
         XNodw9aPhQFiQsX8vKpTLnk2psWEDQQA+8GEYy+b5A+HmhYxteW9ChW8dhWxxjo8nHqD
         +mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=kl3iIovPAXkFd81DfbgFsEB+vcJ/l3r5RhzJoBZ9OdY=;
        b=Via+UA601eV/tRlvbdE82+yG4MI1OeuCJDb+mmu/IB2Tx/ixID2B4FXGREpZCrW4zk
         GtmgtCcOd4ZZGsocEOryhVj+5IBxYepKP5TBRL6WjUEYx55cyMw+r/nMDfER6nKVn4eJ
         jK1ifiRMxVPTNGTrCfAcxp0eo+i88QcVBKR8X9dek33vr4FwmiMYg17zQXdcaR0CEYWw
         wO0XCiSo8ukravbZh45fmLJyI99GrMjEdBgZGSWs6OqGrD1ukgfEyjofXBSwMlyBpmXY
         ekga/c13x0H/2p5r8rTOtMke5HTn+uMDEL3iiQLtd2XH79VvOIealjRIr+3/tgfRitsp
         PUpw==
X-Gm-Message-State: APjAAAUSzcRzc+J29QkJhXhZUh9pISnOUcEg6519TK3nQUa6ZR6M84L0
        Yy3tSvXZwPayJlx5bkjmMPA=
X-Google-Smtp-Source: APXvYqyRcCHQNKCOABE2MUNH+72Ps51rPx010x3d4I2CzWdLry16tjE5eQfgfYwYROeIk+r8ENOvMw==
X-Received: by 2002:a63:7515:: with SMTP id q21mr38542031pgc.63.1580918103541;
        Wed, 05 Feb 2020 07:55:03 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:03 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 05/15] NTB: return the side info status from amd_poll_link
Date:   Wed,  5 Feb 2020 21:24:22 +0530
Message-Id: <a6bacf6fc59017acf02ba5c69c85da2192365a59.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit 1 of SIDE_INFO register is an indication that
the driver on the other side of link is ready. We
set this bit during driver initialization sequence.
So rather than having separate macros to return the
status, we can simply return the status of this bit
from amd_poll_link(). So a return of 1 or 0 from
this function will indicate to the caller whether
the driver on the other side of link is ready or not,
respectively.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 +++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index f50537e0917b..84723420d70b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -246,7 +246,7 @@ static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
 	if (!ndev->peer_sta)
-		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
+		return ndev->cntl_sta;
 
 	if (ndev->peer_sta & AMD_LINK_UP_EVENT) {
 		ndev->peer_sta = 0;
@@ -896,16 +896,15 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 	u32 reg;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
-	reg &= NTB_LIN_STA_ACTIVE_BIT;
+	reg &= AMD_SIDE_READY;
 
 	dev_dbg(&ndev->ntb.pdev->dev, "%s: reg_val = 0x%x.\n", __func__, reg);
 
-	if (reg == ndev->cntl_sta)
-		return 0;
-
 	ndev->cntl_sta = reg;
 
-	return amd_ntb_get_link_status(ndev);
+	amd_ntb_get_link_status(ndev);
+
+	return ndev->cntl_sta;
 }
 
 static void amd_link_hb(struct work_struct *work)
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 39e5d18e12ff..156a4a92b803 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,10 +53,8 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
-#define NTB_LIN_STA_ACTIVE_BIT	0x00000002
 #define NTB_LNK_STA_SPEED_MASK	0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK	0x03F00000
-#define NTB_LNK_STA_ACTIVE(x)	(!!((x) & NTB_LIN_STA_ACTIVE_BIT))
 #define NTB_LNK_STA_SPEED(x)	(((x) & NTB_LNK_STA_SPEED_MASK) >> 16)
 #define NTB_LNK_STA_WIDTH(x)	(((x) & NTB_LNK_STA_WIDTH_MASK) >> 20)
 
-- 
2.17.1

