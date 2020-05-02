Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80853C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A99821974
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsqzSO7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEBNU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgEBNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:20:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02AC061A0C;
        Sat,  2 May 2020 06:20:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so11971282qkf.3;
        Sat, 02 May 2020 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gO/I+IvtkIZFC4jw7d1M58LLH0WJEijQ4nefSivFRc=;
        b=JsqzSO7Dl9DvRNtQn+Xqsi0073bQnPRngcl3vh8Ds9GolrE5Mt+TLnU06QkC42yTwN
         sEqExDuwAzZbXJCkaK6GH3vg/4wiZ+Mnsk1/e/s9G08but0mNpuZqdVDhd7aVatrJiEl
         ZzUE+gkm/GBRRZX025AzF5kb3ddznbv6vlnlPA0ja2CFsGhnRVbUkzh0DNLwBml4pCAO
         9fF7Jc7rjf0rqzj5dmMSOpjaKNqZ170sAJvRxSDAo9fMxARxlI0oOvXW6h1adZ02uMnw
         fNSU+2I/cpALkmgg3iQA3GgJay57/3F0Z9DA9AYUxIK8kpZicDEVEvA0lM8OlZ0341Ll
         qFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gO/I+IvtkIZFC4jw7d1M58LLH0WJEijQ4nefSivFRc=;
        b=kIjslJ6fceLUXx8MG9Ci/jOXK0mODUKGNcYmga3t8g+2pWdk5GVdhoAk3Fa+fDXTU+
         Yoq2I1UlBTFNMOxZduNwZ3RlrUvELlsDFLb6xg2qFsxAGAQkcEkz5d3TBvxmvDnciErz
         3Dzs6qPN2LnAI7kbi9/iqyR99g8nmLcAC/eXKvzNwdtJnMdOWn/mzMzGvr7CKkvz71Qq
         KrlfFlcFcjy7erMl0rm4VPk8YNaCq3Hn+uzjsV/GhOb6xD/4tYcNwe5rs1QkfyQkSiqZ
         8K4UgiZFF/lTpbFUjr6F1v9K+U/rRwkKqOch22dMy3+LiuPQ4G9iBt0Gb/yFgou8rujS
         9nkA==
X-Gm-Message-State: AGi0PuYM8q62OUV78JJfK2qCqpqI5/BY0ntdmTLDDY4O/Ksb3Q3ZQ8Ma
        f6W7w/0uSVQo+Txf7bnqPDw=
X-Google-Smtp-Source: APiQypIxNQBmn7ptFgUIwXN+1StR7LK8a8epow3LnVkDsEZEU4dvMKVcbgvYqHbyRSla4AZJ9YYZTQ==
X-Received: by 2002:a05:620a:39b:: with SMTP id q27mr8260387qkm.94.1588425624565;
        Sat, 02 May 2020 06:20:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id o6sm4975385qkj.126.2020.05.02.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 06:20:23 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Add node for SPDIF
Date:   Sat,  2 May 2020 08:20:11 -0500
Message-Id: <20200502132011.196045-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini can support SPIDF which is very similar to the
IP used on the i.MX35.

This patch adds the SPIF node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d46e727fc362..00aad55ece65 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -358,6 +358,29 @@ micfil: micfil@30080000 {
 				status = "disabled";
 			};
 
+			spdif1: spdif@30090000 {
+				compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";
+				reg = <0x30090000 0x10000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
+					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
+					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
+					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
+					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

