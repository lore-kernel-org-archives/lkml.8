Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCFC28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B854420748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yueH6sFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgIDGhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgIDGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:37:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF41C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 23:37:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so3835856pgl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHhqGr02HJ8Wt0VeQKRyG/qeKmWV0q5duXvcM144S+s=;
        b=yueH6sFM4P0xAvx5CEGo2stclp6h+c7OCFBCXH9LpMsvlYVIhTuyZV7kq/c4WOaaj0
         l2bi6DaxO8LYKQbya0vgCxFF3beSJ0d5VGZ84hs14OUUSi87+etgnqwsn5SibFUiKDmn
         yQA6j7CPd/9W/86YIeTUFYHYUs65K9uJlEHPnxSf5NKvWvPXOYbOw2SAFcd1fKlT5cjR
         VUty7diyJbhRAagDs3wLJO5bTZwJPem+WhEbxqTPTJW2bzR97GV22EZ8HRlVmOxrClDk
         pmbLfpDDQNnaJYQU4r48AyuwXa9W60UOuO+MLuGZsKtNF85mvucpfw0a8jQlQHfLgfFj
         IACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BHhqGr02HJ8Wt0VeQKRyG/qeKmWV0q5duXvcM144S+s=;
        b=jN6av5O+qGAtGEY5i5bhLJfNeTNWuJ7kumxqpZJbbes1EhFzUN/9PGM3ilMyOCCZmB
         uhhY6EnW7Gi5oMrdqGY1lu2pJjAJxmt0DPNq8PL5Uf/yiakNh3UwSvrjqOvZrCl7rqYh
         awCodgx1l8+JzbnwviISUIYthCZm/pD30YhDQAoPSCVddWOJ9DI4FbanOlXCneqXjO/o
         dnR2IrComNad6V6quGw85YytOlTF/JjOtwIQ1awWj9EMFE3e387PmumTeHNqkdPPxzMX
         gsfBOFPz1q3PMiKZ5eSRNrqRFGAnmal+k/Dm01CApQg6kuMV7DSXUIy2CvFSKB82ZXKy
         HsOQ==
X-Gm-Message-State: AOAM532iWVeBrAUdpYbhR95GykjQGOcwz4/umtuPnp5oarx/dt3Ng7eA
        ioPGvZdro4S4WGe+H2Lyii05
X-Google-Smtp-Source: ABdhPJyeY8WKlBMT1NphHgy6y9gY3xjyM7jPeIYtIi4wH3LbsytgasrDdPTx/h8YCw3IBMowNmVWHg==
X-Received: by 2002:a62:1b81:: with SMTP id b123mr7255439pfb.149.1599201423805;
        Thu, 03 Sep 2020 23:37:03 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 143sm5315040pfc.66.2020.09.03.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 23:37:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/6] arm64: dts: qcom: qrb5165-rb5: Add gpio-line-names for TLMM block
Date:   Fri,  4 Sep 2020 12:06:36 +0530
Message-Id: <20200904063637.28632-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
References: <20200904063637.28632-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names property for QRB5165 RB5 board for naming all GPIOs
exposed by TLMM block.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 181 +++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 312316e23298..cf6dc0ec1640 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -431,6 +431,187 @@
 
 &tlmm {
 	gpio-reserved-ranges = <40 4>;
+	gpio-line-names =
+		"GPIO-MM",
+		"GPIO-NN",
+		"GPIO-OO",
+		"GPIO-PP",
+		"GPIO-A",
+		"GPIO-C",
+		"GPIO-E",
+		"GPIO-D",
+		"I2C0-SDA",
+		"I2C0-SCL",
+		"GPIO-TT", /* GPIO_10 */
+		"NC",
+		"GPIO_12_I2C_SDA",
+		"GPIO_13_I2C_SCL",
+		"GPIO-X",
+		"GPIO_15_RGMII_INT",
+		"HST_BT_UART_CTS",
+		"HST_BT_UART_RFR",
+		"HST_BT_UART_TX",
+		"HST_BT_UART_RX",
+		"HST_WLAN_EN", /* GPIO_20 */
+		"HST_BT_EN",
+		"GPIO-AAA",
+		"GPIO-BBB",
+		"GPIO-CCC",
+		"GPIO-Z",
+		"GPIO-DDD",
+		"GPIO-BB",
+		"GPIO_28_CAN_SPI_MISO",
+		"GPIO_29_CAN_SPI_MOSI",
+		"GPIO_30_CAN_SPI_CLK", /* GPIO_30 */
+		"GPIO_31_CAN_SPI_CS",
+		"GPIO-UU",
+		"NC",
+		"UART1_TXD_SOM",
+		"UART1_RXD_SOM",
+		"UART0_CTS",
+		"UART0_RTS",
+		"UART0_TXD",
+		"UART0_RXD",
+		"SPI1_MISO", /* GPIO_40 */
+		"SPI1_MOSI",
+		"SPI1_CLK",
+		"SPI1_CS",
+		"I2C1_SDA",
+		"I2C1_SCL",
+		"GPIO-F",
+		"GPIO-JJ",
+		"Board_ID1",
+		"Board_ID2",
+		"NC", /* GPIO_50 */
+		"NC",
+		"SPI0_MISO",
+		"SPI0_MOSI",
+		"SPI0_SCLK",
+		"SPI0_CS",
+		"GPIO-QQ",
+		"GPIO-RR",
+		"USB2LAN_RESET",
+		"USB2LAN_EXTWAKE",
+		"NC", /* GPIO_60 */
+		"NC",
+		"NC",
+		"LT9611_INT",
+		"GPIO-AA",
+		"USB_CC_DIR",
+		"GPIO-G",
+		"GPIO-LL",
+		"USB_DP_HPD_1P8",
+		"NC",
+		"NC", /* GPIO_70 */
+		"SD_CMD",
+		"SD_DAT3",
+		"SD_SCLK",
+		"SD_DAT2",
+		"SD_DAT1",
+		"SD_DAT0", /* BOOT_CFG3 */
+		"SD_UFS_CARD_DET_N",
+		"GPIO-II",
+		"PCIE0_RST_N",
+		"PCIE0_CLK_REQ_N", /* GPIO_80 */
+		"PCIE0_WAKE_N",
+		"GPIO-CC",
+		"GPIO-DD",
+		"GPIO-EE",
+		"GPIO-FF",
+		"GPIO-GG",
+		"GPIO-HH",
+		"GPIO-VV",
+		"GPIO-WW",
+		"NC", /* GPIO_90 */
+		"NC",
+		"GPIO-K",
+		"GPIO-I",
+		"CSI0_MCLK",
+		"CSI1_MCLK",
+		"CSI2_MCLK",
+		"CSI3_MCLK",
+		"GPIO-AA", /* CSI4_MCLK */
+		"GPIO-BB", /* CSI5_MCLK */
+		"GPIO-KK", /* GPIO_100 */
+		"CCI_I2C_SDA0",
+		"CCI_I2C_SCL0",
+		"CCI_I2C_SDA1",
+		"CCI_I2C_SCL1",
+		"CCI_I2C_SDA2",
+		"CCI_I2C_SCL2",
+		"CCI_I2C_SDA3",
+		"CCI_I2C_SCL3",
+		"GPIO-L",
+		"NC", /* GPIO_110 */
+		"NC",
+		"ACCEL_INT",
+		"GYRO_INT",
+		"GPIO-J",
+		"GPIO-YY",
+		"GPIO-H",
+		"GPIO-ZZ",
+		"NC",
+		"NC",
+		"NC", /* GPIO_120 */
+		"NC",
+		"MAG_INT",
+		"MAG_DRDY_INT",
+		"HST_SW_CTRL",
+		"GPIO-M",
+		"GPIO-N",
+		"GPIO-O",
+		"GPIO-P",
+		"PS_INT",
+		"WSA1_EN", /* GPIO_130 */
+		"USB_HUB_RESET",
+		"SDM_FORCE_USB_BOOT",
+		"I2S1_CLK_HDMI",
+		"I2S1_DATA0_HDMI",
+		"I2S1_WS_HDMI",
+		"GPIO-B",
+		"GPIO_137", /* To LT9611_I2S_MCLK_3V3 */
+		"PCM_CLK",
+		"PCM_DI",
+		"PCM_DO", /* GPIO_140 */
+		"PCM_FS",
+		"HST_SLIM_CLK",
+		"HST_SLIM_DATA",
+		"GPIO-U",
+		"GPIO-Y",
+		"GPIO-R",
+		"GPIO-Q",
+		"GPIO-S",
+		"GPIO-T",
+		"GPIO-V", /* GPIO_150 */
+		"GPIO-W",
+		"DMIC_CLK1",
+		"DMIC_DATA1",
+		"DMIC_CLK2",
+		"DMIC_DATA2",
+		"WSA_SWR_CLK",
+		"WSA_SWR_DATA",
+		"DMIC_CLK3",
+		"DMIC_DATA3",
+		"I2C4_SDA", /* GPIO_160 */
+		"I2C4_SCL",
+		"SPI3_CS1",
+		"SPI3_CS2",
+		"SPI2_MISO_LS3",
+		"SPI2_MOSI_LS3",
+		"SPI2_CLK_LS3",
+		"SPI2_ACCEL_CS_LS3",
+		"SPI2_CS1",
+		"NC",
+		"GPIO-SS", /* GPIO_170 */
+		"GPIO-XX",
+		"SPI3_MISO",
+		"SPI3_MOSI",
+		"SPI3_CLK",
+		"SPI3_CS",
+		"HST_BLE_SNS_UART_TX",
+		"HST_BLE_SNS_UART_RX",
+		"HST_WLAN_UART_TX",
+		"HST_WLAN_UART_RX";
 };
 
 &uart12 {
-- 
2.17.1

