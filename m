Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32437C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EFF206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rGRXI/ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgGAPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:13:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730883AbgGAPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:13:28 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061F9BVI006050;
        Wed, 1 Jul 2020 17:13:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bdHlVzSiINWMtq0PIwPjyqUpkq3kAK0eh4ceBdGsIYg=;
 b=rGRXI/kyyE85EZYLZt20zTYqIhAI+U5C/XQDdbPrbzdJtUCq6hXoLpKH/uyfAUSsWhbz
 LXwFJzLr4yO1q3+i0oTIvY3uFtqDCkcpau3LEkrUre2/+ivyIrgD/8SIVNAWQgh/8IYK
 gu1PXZwMUc/k6+oWWdzhpxLOkakFNLcqLuJtztumpovOBdN/uQpCkHJ0rDF1nPUPtWe9
 9oowxozR1jCjCDFDTK/2O1S+XEdWmvLkkgHslEtJqmOyHXyqr7kEaBbw632RfuxfLCUr
 UqhlUtNX4+tLR989y2uIpKmBjPvY40AiZrR3ILdQ0LCAC9ti0zqeTZFB4aM13TesgBZL lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wu89u9j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 17:13:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E559710002A;
        Wed,  1 Jul 2020 17:13:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D50652BC7BE;
        Wed,  1 Jul 2020 17:13:17 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul 2020 17:13:17
 +0200
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/synopsys: dsi: allows LP commands in video mode
Date:   Wed, 1 Jul 2020 17:13:16 +0200
Message-ID: <20200701151316.18524-1-yannick.fertre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

Current code only sends LP commands in command mode.

Allows sending LP commands also in video mode by setting the
proper flag in DSI_VID_MODE_CFG.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Change-Id: Ib78fa37bcc7559ce63017acd6ee0bbf00c61a397
Reviewed-on: https://gerrit.st.com/c/mpu/oe/st/linux-stm32/+/153242
Reviewed-by: CITOOLS <smet-aci-reviews@lists.codex.cro.st.com>
Reviewed-by: CIBUILD <smet-aci-builds@lists.codex.cro.st.com>
Reviewed-by: Yannick FERTRE <yannick.fertre@st.com>
Reviewed-by: Philippe CORNU <philippe.cornu@st.com>
Tested-by: Yannick FERTRE <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index d580b2aa4ce9..0cd43e7a69bb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -367,6 +367,13 @@ static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
 
 	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
 	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
+
+	val = dsi_read(dsi, DSI_VID_MODE_CFG);
+	if (lpm)
+		val |= ENABLE_LOW_POWER_CMD;
+	else
+		val &= ~ENABLE_LOW_POWER_CMD;
+	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
 
 static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
-- 
2.17.1

