Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE2BC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512FC20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="InlDpNvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgCKHts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:49:48 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43323 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgCKHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:49:37 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A4A2D23E76;
        Wed, 11 Mar 2020 08:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583912974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+pgnprT5hVRwdgI1jb5OrxhEFbT8w0MgutmfJkuxEY=;
        b=InlDpNvpdS2FUN3+wNhVSqn+xEMlTtiUB96Eu09eHsj4WqDBsqGz7xCGbfnruIV57FxLY2
        VgZIEf6qMFXP7darH5zZEAjp7aBAsBnDV2ZUISRriedtGsbbLZ5XnVf99oPtmb1xKjstwb
        KHsoyt3oJZ4aKoJWyL3zruq3istdjCg=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/4] arm64: dts: ls1028a: sl28: fix on-board EEPROMS
Date:   Wed, 11 Mar 2020 08:49:27 +0100
Message-Id: <20200311074929.19569-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311074929.19569-1-michael@walle.cc>
References: <20200311074929.19569-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A4A2D23E76
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.800];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.57:email,0.0.0.50:email];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module itself has another EEPROM at 50h on I2C4. The EEPROM on the
carriers is located at 57h on I2C3. Fix that in the device trees.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts          |  6 +++---
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts         | 14 ++++++++------
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts     |  6 ++++++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index aaf3c04771c3..32f6c80414bc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -18,10 +18,10 @@
 		     "kontron,sl28", "fsl,ls1028a";
 };
 
-&i2c4 {
-	eeprom@50 {
+&i2c3 {
+	eeprom@57 {
 		compatible = "atmel,24c32";
-		reg = <0x50>;
+		reg = <0x57>;
 		pagesize = <32>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index 7aee14193dbd..0973a6a45217 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -77,6 +77,14 @@
 	};
 };
 
+&i2c3 {
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+};
+
 &i2c4 {
 	status = "okay";
 
@@ -89,12 +97,6 @@
 		assigned-clocks = <&mclk>;
 		assigned-clock-rates = <1250000>;
 	};
-
-	eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
 };
 
 &sai5 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 58603bce5b0e..1648a04ea79f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -178,4 +178,10 @@
 
 &i2c4 {
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
 };
-- 
2.20.1

