Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07F52053B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFEKG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:06:27 -0400
Received: from segapp02.wistron.com ([103.200.3.19]:51683 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbgFEKGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:06:24 -0400
Received: from EXCHAPP02.whq.wistron (unverified [10.37.38.25]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf9212466fc0a816729a0@TWNHUMSW4.wistron.com>;
 Fri, 5 Jun 2020 18:06:18 +0800
Received: from EXCHAPP03.whq.wistron (10.37.38.26) by EXCHAPP02.whq.wistron
 (10.37.38.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 18:06:17 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 5 Jun 2020 18:06:17 +0800
From:   Ben Pai <Ben_Pai@wistron.com>
To:     <joel@jms.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <claire_ku@wistron.com>, Ben Pai <Ben_Pai@wistron.com>
Subject: [PATCH v1 1/2] ARM: dts: aspeed: mihawk: IO expander uses TCA9554 driver
Date:   Fri, 5 Jun 2020 18:06:14 +0800
Message-ID: <20200605100614.14726-1-Ben_Pai@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 046AADC4E7378F668BD1404E8B899BEBBB327568BE24F0CF5C33F311765E568B2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set smbus_en of IO expander to 1 in order to be able to read sensor.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 112 ++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index eac6ed2bbc67..25ffe65fbdc0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -820,12 +820,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus0 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus0";
+				};
+			};
 		};
 
 		bus9_mux232: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus1 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus1";
+				};
+			};
 		};
 
 		bus9_mux233: i2c@2 {
@@ -855,12 +883,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus2 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus2";
+				};
+			};
 		};
 
 		bus9_mux236: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus3 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus3";
+				};
+			};
 		};
 
 		bus9_mux237: i2c@2 {
@@ -909,12 +965,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus4 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus4";
+				};
+			};
 		};
 
 		bus10_mux240: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus5 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus5";
+				};
+			};
 		};
 
 		bus10_mux241: i2c@2 {
@@ -944,12 +1028,40 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus6 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus6";
+				};
+			};
 		};
 
 		bus10_mux244: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			tca9554@39 {
+				compatible = "ti,tca9554";
+				reg = <0x39>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				smbus7 {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "smbus7";
+				};
+			};
 		};
 
 		bus10_mux245: i2c@2 {
-- 
2.17.1

