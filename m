Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D9C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D112465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBTF6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:58:09 -0500
Received: from segapp02.wistron.com ([103.200.3.19]:63247 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgBTF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:58:09 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Feb 2020 00:58:07 EST
Received: from EXCHAPP04.whq.wistron (unverified [10.37.38.27]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdd6f484d45c0a816721080@TWNHUMSW4.wistron.com>;
 Thu, 20 Feb 2020 13:53:01 +0800
Received: from EXCHAPP04.whq.wistron (10.37.38.27) by EXCHAPP04.whq.wistron
 (10.37.38.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 20 Feb
 2020 13:53:00 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP04.whq.wistron
 (10.37.38.27) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 20 Feb 2020 13:53:00 +0800
From:   Ben Pai <Ben_Pai@wistron.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <wangat@tw.ibm.com>, <Claire_Ku@wistron.com>,
        Ben Pai <Ben_Pai@wistron.com>
Subject: [PATCH v1] ARM: dts: mihawk: Change the name of mihawk led
Date:   Thu, 20 Feb 2020 13:52:55 +0800
Message-ID: <20200220055255.22809-1-Ben_Pai@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 878E35D0BF548269343F48DBF623908D488A6736306ADE4D4D02D482038B268B2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Change the name of power, fault and rear-id.
2.Remove the two leds.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index e55cc454b17f..6c11854b9006 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -120,35 +120,24 @@
 	leds {
 		compatible = "gpio-leds";
 
-		fault {
+		front-fault {
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		power-button {
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_LOW>;
 		};
 
-		rear-id {
+		front-id {
 			retain-state-shutdown;
 			default-state = "keep";
 			gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_LOW>;
 		};
 
-		rear-g {
-			retain-state-shutdown;
-			default-state = "keep";
-			gpios = <&gpio ASPEED_GPIO(AA, 4) GPIO_ACTIVE_LOW>;
-		};
-
-		rear-ok {
-			retain-state-shutdown;
-			default-state = "keep";
-			gpios = <&gpio ASPEED_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
-		};
 
 		fan0 {
 			retain-state-shutdown;
-- 
2.17.1

