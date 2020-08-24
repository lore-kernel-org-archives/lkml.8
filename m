Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4122072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598253356;
	bh=HsUuNkVSd/8OOPLUALtgwBOCnA4t+XeARd/JsxEFnzA=;
	h=From:To:Subject:Date:List-ID:From;
	b=xqcRMb7IjL1ulTIUwN61Anmfh5PwXfpIJssOnlTVLMmH/yP+mbdIhLyjVahCQHsAb
	 eXw9Q+E37mnUSEydDy76X1DTyFM82Tlw7GMUeTYrrCVQrDK9TcJwqZX12NND/tkFd8
	 Y7GVfoyX9Xa2OniJhD8dsXhMyngMLdBNYwvgSBDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHXHPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgHXHPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:15:53 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB5220720;
        Mon, 24 Aug 2020 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598253352;
        bh=HsUuNkVSd/8OOPLUALtgwBOCnA4t+XeARd/JsxEFnzA=;
        h=From:To:Subject:Date:From;
        b=2e5cIF8QLfBRuwYw8HrgVGN6aimaE0rxlrn/SczbT9SBrURv4GxNYmEwWaBuqsv8i
         lrJYH/gAXay+6nJvc3MiiTwG7x5NLmCr0p3D59usKNkyAfe8Q+yt+5sZ818txOoBdL
         +3Ht+9v2ozDeR3Jt7nk1LrwlzZ6lG6Yd+dT6i46A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adam Ford <aford173@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon-baseboard: Correct LED default state
Date:   Mon, 24 Aug 2020 09:15:46 +0200
Message-Id: <20200824071546.10050-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no LED default state "none".  leds-gpio driver maps it to
"off", so correct them to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml:
    leds: led0:default-state:0: 'none' is not one of ['on', 'off', 'keep']

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index baa5f997d018..bf0859f1e1fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -10,19 +10,19 @@
 		led0 {
 			label = "gen_led0";
 			gpios = <&pca6416_1 4 GPIO_ACTIVE_HIGH>;
-			default-state = "none";
+			default-state = "off";
 		};
 
 		led1 {
 			label = "gen_led1";
 			gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
-			default-state = "none";
+			default-state = "off";
 		};
 
 		led2 {
 			label = "gen_led2";
 			gpios = <&pca6416_1 6 GPIO_ACTIVE_HIGH>;
-			default-state = "none";
+			default-state = "off";
 		};
 
 		led3 {
-- 
2.17.1

