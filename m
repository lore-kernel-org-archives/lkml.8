Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA430206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgGUPGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:06:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56022 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:06:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jxtqP-000480-BC; Tue, 21 Jul 2020 15:06:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] phy: qualcomm: fix setting of tx_deamp_3_5db when device property read fails
Date:   Tue, 21 Jul 2020 16:06:13 +0100
Message-Id: <20200721150613.416876-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when reading of the device property for "qcom,tx-deamp_3_5db"
fails the default is being assigned incorrectly to phy_dwc3->rx_eq. This
looks like a copy-n-paste error and in fact should be assigning the
default instead to phy_dwc3->tx_deamp_3_5db

Addresses-Coverity: ("Copy-paste error")
Fixes: ef19b117b834 ("phy: qualcomm: add qcom ipq806x dwc usb phy driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
index a7241bf110d7..71f257b4a7f5 100644
--- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
@@ -531,7 +531,7 @@ static int qcom_ipq806x_usb_phy_probe(struct platform_device *pdev)
 
 	if (device_property_read_u32(&pdev->dev, "qcom,tx-deamp_3_5db",
 				     &phy_dwc3->tx_deamp_3_5db))
-		phy_dwc3->rx_eq = SSPHY_TX_DEEMPH_3_5DB;
+		phy_dwc3->tx_deamp_3_5db = SSPHY_TX_DEEMPH_3_5DB;
 
 	if (device_property_read_u32(&pdev->dev, "qcom,mpll", &phy_dwc3->mpll))
 		phy_dwc3->mpll = SSPHY_MPLL_VALUE;
-- 
2.27.0

