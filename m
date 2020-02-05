Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED9C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC50217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFEF6DGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBEPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38803 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgBEPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so1417563pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=r6M3muC17wmFBo6gGHeq8kEyee20Ea6YYRIE9th2DHM=;
        b=hFEF6DGw7r2FGdEhuSp7tjL/ZgbEyEOOx8MDcq/UArDrC+2o8J+ZM5WrEe2FIZzjJc
         2nWMxqn4rv3DpWzdaZRUVNvkSpu/kpmJOvbWRtfYaqdtSSXLh/993hdHeYUE9SDIoxeR
         5mfnVzfnXD4WOFc8eLJmCiMqP4nFy82CitrMctVwqcZQX6nBjvyh2IU9pNLfBaMwVmfh
         7qeLQEUZDtAHntyKmAbKXHSGdB18uho4JvMtw/aKizZN6d/dk60i/FIFwUTiL/rFPSQX
         ML/KC7TbSpbNuFK7gSKdR9dperY8hwJ0YLIvP0eWm24+mwN0oz9nzmqOKhDALBgtOiPv
         JKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=r6M3muC17wmFBo6gGHeq8kEyee20Ea6YYRIE9th2DHM=;
        b=GIlh7kL0SyXV9r6wbqWaGvrWbzp7dd01mYm5nazlVcgiB9qSHX9fairde7Vm8Fv9/d
         PXZPUNYEIbzj1r0l5yaGMNUBmM8uNtVjAwNKmmYjOwqvkPYbFbosOSKM58G3ZMKy1fAk
         77dnu7venXyS5Lv9EoNm45+GKZkzr92GCdA58q/UPRq8elGWrCu97KT2IHLJ/9VVWkvp
         QpDZE/XJLDRuZQacv4+j05kgvq82/ghyIjgusRtUmxd60+eQe5KuNGvXnClXVURaB2AT
         ClG4R6hShX7RUd76In1ZSaz6dqEy5vSUCL/r/nbLGNjK1DDVgqbKabkIBm5IbTUKR/go
         IjlQ==
X-Gm-Message-State: APjAAAVs+LOvuGBgTmarphmcJrjSVaigDARXIvxSxnqc0/ywnqfdI52+
        VthmZUkeWcAv9IGSq7Bee2g=
X-Google-Smtp-Source: APXvYqyVEHQ6m3TpBd0PdG+5jf7VJ8HPen3H8TYuGLVe7GNMB6BngFPaDhLVWpQgt4H5LS6i0XWCkA==
X-Received: by 2002:a63:7a1a:: with SMTP id v26mr717429pgc.51.1580918106459;
        Wed, 05 Feb 2020 07:55:06 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:06 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 06/15] NTB: set peer_sta within event handler itself
Date:   Wed,  5 Feb 2020 21:24:23 +0530
Message-Id: <cb8fdfc226493dd9e80be514c201f92378608081.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_ack_smu() should only set the corresponding
bits into SMUACK register. Setting the bitmask
of peer_sta should be done within the event handler.
They are two different things, and so should be
handled differently and at different places.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 84723420d70b..b85af150f2c6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -541,8 +541,6 @@ static void amd_ack_smu(struct amd_ntb_dev *ndev, u32 bit)
 	reg = readl(mmio + AMD_SMUACK_OFFSET);
 	reg |= bit;
 	writel(reg, mmio + AMD_SMUACK_OFFSET);
-
-	ndev->peer_sta |= bit;
 }
 
 static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
@@ -560,9 +558,11 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	status &= AMD_EVENT_INTMASK;
 	switch (status) {
 	case AMD_PEER_FLUSH_EVENT:
+		ndev->peer_sta |= AMD_PEER_FLUSH_EVENT;
 		dev_info(dev, "Flush is done.\n");
 		break;
 	case AMD_PEER_RESET_EVENT:
+		ndev->peer_sta |= AMD_PEER_RESET_EVENT;
 		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
 
 		/* link down first */
@@ -575,6 +575,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	case AMD_PEER_PMETO_EVENT:
 	case AMD_LINK_UP_EVENT:
 	case AMD_LINK_DOWN_EVENT:
+		ndev->peer_sta |= status;
 		amd_ack_smu(ndev, status);
 
 		/* link down */
@@ -588,6 +589,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		if (status & 0x1)
 			dev_info(dev, "Wakeup is done.\n");
 
+		ndev->peer_sta |= AMD_PEER_D0_EVENT;
 		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
 
 		/* start a timer to poll link status */
-- 
2.17.1

