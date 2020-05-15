Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E44C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153A12065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ST8ny/aT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEOBhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEOBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:37:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F31C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:37:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x2so211236pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFLXFjRR5A3gVgBRs/3cq91isvYI/YMEqHqKMfTLIfY=;
        b=ST8ny/aTnC9mJCuv9OK8jmqlpZiMn5kyWYI0wvwNyygnON9LPxQvZtTqf0G/UTNsSJ
         R+CgWeJuedGON5jyUbwwTsKFJW2xBRevUKUY4EsojOOYCogkX4O8OqVbH+jQYQ72qtXH
         LzN9w+jTIbfNxqc6bFlU7ByWxZv8qa4BOq0iYNe6wCetd4n9NZQ7/FtSGKgFYC/EYTA6
         nVR7pMlbnu/VsAQ7JWWd96ppdKWwbCfW62xJ0Wx9oAwr8Yw0AqV5S1pYDQ3c/7pbKbFL
         BKJp7iozPW9djEeW+v8eB/hcGQtQ/A3Z/LbNB1hkGS5bQzLiimnhTjYyrWLHQn8dIOqN
         KHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFLXFjRR5A3gVgBRs/3cq91isvYI/YMEqHqKMfTLIfY=;
        b=XJhS4hL+lyqHHkRnZCSSn5a6oqIGSI1LXCVOLmVuiBCviYAfJQFURPrFc7ELlhdiQO
         9GvK+JHE7xMj4kUK6zT0c7mOHhDaK7oEUD2csqPxSuqJzEcniWn/M8KxfksGiaKzQ0zX
         jJ8x73WK/K1w8dPF5t0V0KpPbWfFeiVpxiydNYvPavUhCl1EJW19793eHku3a8q9yY8n
         B1/HcSxeAti1lBYQn5ECZay/LlBXj4ihK/9Cc2wHvUjMN5KhIMOSJ8lTL6Ug+aacU8f0
         vu1B9HEaohFCIEkNSgJcWxwY0WEe9glr5HzZTIU2Q19G9HY8SB55+8l4YTQvHkgh2R8s
         I4iw==
X-Gm-Message-State: AOAM53105oiNDNauWLqAxeeZjCW9hrypZdnj4Wfuy7cy9diDY9vW0yjZ
        jj28OU+t3K2D5eODnssUztwdeQ==
X-Google-Smtp-Source: ABdhPJwyvaj5ekFAeFD+ATcyuEVMe3JjX7TZN9DC+ER6jwn2dLMGDA5bm8BxjR+yi+0EZCWfn9Kn9w==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr1439871pfc.155.1589506652891;
        Thu, 14 May 2020 18:37:32 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c2sm402675pfp.118.2020.05.14.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 18:37:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: qcom-qmp: Ensure register indirection arrays initialized
Date:   Thu, 14 May 2020 18:36:43 -0700
Message-Id: <20200515013643.2081941-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that struct qmp_phy_cfg->regs references an array that is
smaller than the possible register lookups that is going to be
performed, with the resulting out-of-bounds read resulting in undefined
behavior.

One such example is when during qcom_qmp_phy_com_init() performs a
qphy_setbits() on entry QPHY_PCS_POWER_DOWN_CONTROL (i.e. 17) with
msm8996_ufsphy_regs_layout only being 12 entries long.

Solve this by inflating all "regs_layout" arrays to ensure that any
remaining entries are zero-initialized, as expected by the code.

Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 5942167320a3..c4bf5fd26fa0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -120,14 +120,16 @@ enum qphy_reg_layout {
 	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
 	QPHY_PCS_LFPS_RXTERM_IRQ_STATUS,
 	QPHY_PCS_POWER_DOWN_CONTROL,
+	/* Keep last to ensure regs_layout arrays are properly initialized */
+	QPHY_LAYOUT_SIZE
 };
 
-static const unsigned int msm8996_ufsphy_regs_layout[] = {
+static const unsigned int msm8996_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= 0x00,
 	[QPHY_PCS_READY_STATUS]		= 0x168,
 };
 
-static const unsigned int pciephy_regs_layout[] = {
+static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_COM_SW_RESET]		= 0x400,
 	[QPHY_COM_POWER_DOWN_CONTROL]	= 0x404,
 	[QPHY_COM_START_CONTROL]	= 0x408,
@@ -143,7 +145,7 @@ static const unsigned int pciephy_regs_layout[] = {
 	[QPHY_PCS_STATUS]		= 0x174,
 };
 
-static const unsigned int usb3phy_regs_layout[] = {
+static const unsigned int usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_FLL_CNTRL1]		= 0xc0,
 	[QPHY_FLL_CNTRL2]		= 0xc4,
 	[QPHY_FLL_CNT_VAL_L]		= 0xc8,
@@ -157,7 +159,7 @@ static const unsigned int usb3phy_regs_layout[] = {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x178,
 };
 
-static const unsigned int qmp_v3_usb3phy_regs_layout[] = {
+static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x174,
@@ -166,31 +168,31 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[] = {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
 };
 
-static const unsigned int sdm845_qmp_pciephy_regs_layout[] = {
+static const unsigned int sdm845_qmp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x174,
 };
 
-static const unsigned int sdm845_qhp_pciephy_regs_layout[] = {
+static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x08,
 	[QPHY_PCS_STATUS]		= 0x2ac,
 };
 
-static const unsigned int qmp_v4_usb3phy_regs_layout[] = {
+static const unsigned int qmp_v4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= 0x00,
 	[QPHY_START_CTRL]		= 0x44,
 	[QPHY_PCS_STATUS]		= 0x14,
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x40,
 };
 
-static const unsigned int sdm845_ufsphy_regs_layout[] = {
+static const unsigned int sdm845_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= 0x00,
 	[QPHY_PCS_READY_STATUS]		= 0x160,
 };
 
-static const unsigned int sm8150_ufsphy_regs_layout[] = {
+static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V4_PCS_UFS_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_UFS_READY_STATUS,
 	[QPHY_SW_RESET]			= QPHY_V4_PCS_UFS_SW_RESET,
-- 
2.26.2

