Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC363C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D6A20738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+gI9X9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGHBQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgGHBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:16:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBA5C061755;
        Tue,  7 Jul 2020 18:16:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 72so6898010ple.0;
        Tue, 07 Jul 2020 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf5xTa05S+axsSrxj9MJoIUBmqUzF79JlNFEIaAD9Ss=;
        b=L+gI9X9CuifDWATtBY+AFUkVZ/bDXQki3Galc3UMNjDuzlIP2pctNM5MKq0eLXxVxh
         +CY1Sdom3FBCbvBg2WW4xI2/jc6pMYV+HdVAH5dUWu33k70O8ECzunNHZFBejcdQlUJn
         KnBmnWLlCDD3Ees8OqRNQGKPvjQFA+dkSFJgzGMXcCBxHK4KNfOHQvgan9G2GJpygxzl
         VN2bROyH4Cct80n3WmSq9s87mHhRb6w7MsU4+QiRNKs8BadP+HESjHm9I4IKZqhZtvxV
         tsIhqwymsBGKhJdio9f5Jdstai/57gXaWxq8d43lrRUIFFaRjI5IJUoIEWrOKsiqdM2U
         myqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xf5xTa05S+axsSrxj9MJoIUBmqUzF79JlNFEIaAD9Ss=;
        b=NdB2FX2x4hQehGn6S/OsuYldzc/LU7rgXbf7klNtcqZ7rbc/IfUFZs1Ct/kf2bNfMM
         MVkSi1s4x7srdA/fGAbWibtDeG0vpMAZHHnDhwsNoRpcUIwoNOFPFaTve4qwuSf/m9BE
         GNWnSKcwjGTQx2davX/zUsZaK1JfQXenWh4XhyOuDq87V18J0HUtl+4AyIJ0hsJyZqt+
         cXR10xQ/XAaW/qS5Cen7Sdo4oIOcjUJEZCmKMuqoCe/WYNjmqWkBsnPD8TRgtQd2RsiG
         k90nIzPlzx0XyH8rWuAm6UwyZvFwgGJyHd6Uo+cBhvjtXhMzGnIV+Ph/72Beq2OYpGpn
         5oGQ==
X-Gm-Message-State: AOAM531xCMQM51vwA70FscyfGtw9hW11g4Qiva7tReklkMG+2YdcBmXR
        KQ05c5KY/ez6KZPSG373I0w=
X-Google-Smtp-Source: ABdhPJzVp85jZOQ2rQw+SSGENwOq7++PWabO5WNXLt1ji8aWVKb07Vk4UPBM+LUxaBPJlGEJ5QR9Xg==
X-Received: by 2002:a17:90a:2dcb:: with SMTP id q11mr7147765pjm.135.1594171007146;
        Tue, 07 Jul 2020 18:16:47 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id s89sm3574967pjj.28.2020.07.07.18.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 18:16:46 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v3] arm: dts: ZII: update MDIO speed and preamble
Date:   Tue,  7 Jul 2020 18:16:27 -0700
Message-Id: <20200708011627.7427-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MDIO configuration with ZII devices to fully utilize
MDIO endpoint capabilities.  All devices support 12.5MHz clock and
don't require MDIO preable.

Signed-off-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
v3:
- make "status = okay" the last property
v2:
- Fix subject line to reference ZII:
- Get rid of "=<1>;" from suppress-preamble lines

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi   | 2 ++
 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 ++
 arch/arm/boot/dts/vf610-zii-dev.dtsi      | 2 ++
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 ++
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 ++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 20350e803377..5af9ce977b12 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -719,6 +719,8 @@
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch: switch@0 {
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ce1920c052fc..64e0e9509226 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -158,6 +158,8 @@
 	mdio1: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch0: switch0@0 {
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 95d0060fb56c..f8299f33a692 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -137,6 +137,8 @@
 	mdio1: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 55b4201e27f6..a68eae88174a 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -119,6 +119,8 @@
 	mdio1: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch0: switch0@0 {
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index a6c22a79779e..fa5ac9125af7 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -105,6 +105,8 @@
 	mdio1: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch0: switch0@0 {
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 3d05c894bdc0..801133154e3d 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -133,6 +133,8 @@
 	mdio1: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch0: switch0@0 {
-- 
2.21.3

