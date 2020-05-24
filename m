Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F48C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90034207F7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="z0m3R7tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbgEXCOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbgEXCOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 22:14:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23736C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:14:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i5so14634197qkl.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ffefvNAPNL6OuCJUGhGMIvQrUEBuaKsgSuB8aTdboIk=;
        b=z0m3R7tY0kXLMCcxtuyyU+kwRHCaX8fyPv3ajvUn7teIuqC292l49Yg42hOtoQl3RS
         XTkroh6+gmfG88qVKFQ5RVV2Bb0QClo8gqGpFScGuuQe6FpMz65Jw23xt1U6qv9h9/AN
         4f+9cuO97ash6npiyVuepzfFIxwt02vNGUa4Qqokgb6Y16xtUy0yMtmcFl1JttCI8Qj+
         nHA6Y/UmZMQxOzo+oWLaezXbiE/9lamtCcaP7mZBQBZ29CtRYhnfjAv91UveNAHHVDdK
         TPwZXJ4xX6JLXB2FTZYzwbb1ykDqLQP1zNcI7i67MU/Rxb3i92nbwYk9l6In9FnAS+zc
         iEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffefvNAPNL6OuCJUGhGMIvQrUEBuaKsgSuB8aTdboIk=;
        b=HQtNjtgEwCJE61y65hFo4P3i1sxfjIAhB96Us4e4xOuFf28pxiTX3S2UOI5PR4V5Vk
         4o5EdGvBkiZfuBeUbmxToHNJR6HjY/kosSs7oafrflKs81PL/AoxQEzrKrJY19E2+Y/D
         +RxEjC4JbDJov6UcvooGsvenfTWks7GZ4SBjYMlUF265bna4sB7Zyu1oqoNJhnILZLHL
         537efbNnz/QznLZmp41hNVTpYFOPXmre0kvO7YPUyYrFOVgTcPniC7F/AyNNG/OMH06J
         pXvGbmO7O+og2ZOg5B7Dx9TZt3Dg9tiTXMhutV3VfTEYAKRxhdCC8gmwHuZXLiGD3IXl
         gD4g==
X-Gm-Message-State: AOAM532+z+mOsnkdua/cgjaY4VZn9tnJQQ9RtzFwyV0Xrjnlhs80uutL
        Dmk3iiMmQ7SmCLen+Haq8tt7Zg==
X-Google-Smtp-Source: ABdhPJyH8Fd339vGR264eYZt6S0QWDjbe5/ZPmIaL3CqdLT5M7w3VsMmHD/sILELbFsevNntQRw3Pw==
X-Received: by 2002:a37:797:: with SMTP id 145mr18857584qkh.8.1590286444291;
        Sat, 23 May 2020 19:14:04 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id t189sm1625501qkc.87.2020.05.23.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 19:14:03 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 3/3] phy: qcom-qmp: Add QMP V4 USB3 PHY support for sm8250
Date:   Sat, 23 May 2020 22:14:15 -0400
Message-Id: <20200524021416.17049-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524021416.17049-1-jonathan@marek.ca>
References: <20200524021416.17049-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both the DP and UNI PHY for primary/secondary usb controllers.

The tables are very similar to sm8150 (serdes_tbl is identical), but there
are some differences.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 206 ++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h |   2 +
 2 files changed, 208 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 9367f8f793b5..8a597cedfebe 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1532,6 +1532,142 @@ static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
 };
 
+static const struct qmp_phy_init_tbl sm8250_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_TX, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_RX, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x40, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x54, 2),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0xff, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff, 2),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x97),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VTH_CODE, 0x10),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0xb8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_UNI_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_UNI_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
 	/* phy-type - PCIE/UFS/USB */
@@ -1700,6 +1836,11 @@ static const char * const qmp_v4_phy_clk_l[] = {
 	"aux", "ref_clk_src", "ref", "com_aux",
 };
 
+/* the primary usb3 phy on sm8250 doesn't have a ref clock */
+static const char * const qmp_v4_sm8250_usbphy_clk_l[] = {
+	"aux", "ref_clk_src", "com_aux"
+};
+
 static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
@@ -2147,6 +2288,65 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
+static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sm8150_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
+	.tx_tbl			= sm8250_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_tx_tbl),
+	.rx_tbl			= sm8250_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_rx_tbl),
+	.pcs_tbl		= sm8250_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
+	.clk_list		= qmp_v4_sm8250_usbphy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_sm8250_usbphy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+
+	.has_phy_dp_com_ctrl	= true,
+	.is_dual_lane_phy	= true,
+};
+
+static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
+	.type			= PHY_TYPE_USB3,
+	.nlanes			= 1,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sm8250_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sm8250_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8250_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
+	.clk_list		= qmp_v4_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3_uniphy_regs_layout,
+
+	.start_ctrl		= SERDES_START | PCS_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+
+	.has_pwrdn_delay	= true,
+	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
+	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
+};
+
 static void qcom_qmp_phy_configure_lane(void __iomem *base,
 					const unsigned int *regs,
 					const struct qmp_phy_init_tbl tbl[],
@@ -2924,6 +3124,12 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
 		.data = &sm8150_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-usb3-phy",
+		.data = &sm8250_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
+		.data = &sm8250_usb3_uniphy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index f39f7a968228..4277f592684b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -364,7 +364,9 @@
 #define QSERDES_V4_TX_RES_CODE_LANE_TX			0x34
 #define QSERDES_V4_TX_RES_CODE_LANE_RX			0x38
 #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX 		0x3c
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX 		0x40
 #define QSERDES_V4_TX_LANE_MODE_1			0x84
+#define QSERDES_V4_TX_LANE_MODE_2			0x88
 #define QSERDES_V4_TX_RCV_DETECT_LVL_2			0x9c
 #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0xd8
 #define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xdC
-- 
2.26.1

