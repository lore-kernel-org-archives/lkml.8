Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B871C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEFC2053B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFEKGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:06:34 -0400
Received: from segapp02.wistron.com ([103.200.3.19]:51703 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbgFEKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:06:34 -0400
Received: from EXCHAPP04.whq.wistron (unverified [10.37.38.27]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdf921276e5c0a816729a0@TWNHUMSW4.wistron.com>;
 Fri, 5 Jun 2020 18:06:30 +0800
Received: from EXCHAPP03.whq.wistron (10.37.38.26) by EXCHAPP04.whq.wistron
 (10.37.38.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 18:06:29 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP03.whq.wistron
 (10.37.38.26) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 5 Jun 2020 18:06:29 +0800
From:   Ben Pai <Ben_Pai@wistron.com>
To:     <joel@jms.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <claire_ku@wistron.com>, Ben Pai <Ben_Pai@wistron.com>
Subject: [PATCH v1 2/2] ARM: dts: aspeed: mihawk: Add 8 tmp401 thermal sensor
Date:   Fri, 5 Jun 2020 18:06:28 +0800
Message-ID: <20200605100628.14807-1-Ben_Pai@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DDB9BC0458D24F053680539219F4C8D39E075093F38EDD5C6560CD8C1B8894672000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index 25ffe65fbdc0..5bf1f13dda3b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -834,6 +834,11 @@
 					line-name = "smbus0";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux232: i2c@1 {
@@ -854,6 +859,11 @@
 					line-name = "smbus1";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux233: i2c@2 {
@@ -897,6 +907,11 @@
 					line-name = "smbus2";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux236: i2c@1 {
@@ -917,6 +932,11 @@
 					line-name = "smbus3";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux237: i2c@2 {
@@ -979,6 +999,11 @@
 					line-name = "smbus4";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux240: i2c@1 {
@@ -999,6 +1024,11 @@
 					line-name = "smbus5";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux241: i2c@2 {
@@ -1042,6 +1072,11 @@
 					line-name = "smbus6";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux244: i2c@1 {
@@ -1062,6 +1097,11 @@
 					line-name = "smbus7";
 				};
 			};
+
+			tmp431@4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux245: i2c@2 {
-- 
2.17.1

