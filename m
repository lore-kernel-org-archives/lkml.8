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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDECC433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898C220771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLSrvlvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGHAZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:25:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA054C08C5DC;
        Tue,  7 Jul 2020 17:25:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 1so1456599pfn.9;
        Tue, 07 Jul 2020 17:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQus+ljnUwyp1pGiCkRRbhhBIjxiQT+G6Qrn+SpwtG0=;
        b=GLSrvlvIvN69TV7OxBzuq9TjyN4gshB1BWT6HHdopqFR45I3v4adMYnXsG6If64dYS
         YuHTDhcAQBnEbQB9pAXgUl6ghLSqOnm0TnXL0YI6+qY4wXmYcXwp01TJWCPNbAD6iBj+
         VGc7bXfxzDvimXwwLpDAMBl4YIrXaDatxpZsG7p3PltoPZfgwKj5HXOEPNznNxK0Dp6K
         0Xt4o4UsQ2l5N63MPnaSigl9FWNH7htK4Emo5oByUWoErbPuZ2UH20BbRatBhBFr69un
         aHD4Fd7Ss8MAzsMadu4ZxeY53UEeqpBCfUAgQQOMO4Q/2pHWJ7Ca+vscusSu8glveb97
         ZsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQus+ljnUwyp1pGiCkRRbhhBIjxiQT+G6Qrn+SpwtG0=;
        b=Gw+5XKy5eycObooJg9yUFEZOZNwRzNQj4qiZveVNhdnRXK28i4/kEL2EBHt8YT0ITD
         AUfR8GyQef+ZGSlXH5TkWdnKIinz88VL1SmHF8GSxcHzcngOFmvmdQdWvZpKBMKUbyiH
         Tv7xkSv6NkFGd2qtUP0P3OAuoy7Y+RfPwrYY0n6Ie1pRcbBkI5fYgqa/1lG6w3IIH2WD
         qBPHAiFnIg4CRYHQTMVNngqNYM+WQuyqvUqUxklTN6Gzjk7GOYTSAzmmcRdIEtOjdPfS
         5PYWc5HFN3yje27RpepJr5XQGBdPjvLdd8WebM/B7Kj5pA8GyRSKhN6l6YbWBTd+9BUW
         IXJg==
X-Gm-Message-State: AOAM531miJsB01Xxyip4dYD7bvIN+bxQvtSUoeVKQ9z8XzZPJWxx3I3Y
        TpaCBbZonyShiCxLOt4RiEg=
X-Google-Smtp-Source: ABdhPJxL/NWGL8FAk9m3PwPtuvoeV3KDtNMvJGoqbcr1lcb+MgvRB1ymTTcfvb646iznVwm3dA3FpA==
X-Received: by 2002:a63:757:: with SMTP id 84mr47654007pgh.275.1594167916427;
        Tue, 07 Jul 2020 17:25:16 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id v197sm12430651pfc.35.2020.07.07.17.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 17:25:15 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] ARM: dts: ZII: update MDIO speed and preamble
Date:   Tue,  7 Jul 2020 17:25:00 -0700
Message-Id: <20200708002500.4563-1-cphealy@gmail.com>
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
index 20350e803377..58cc421042e1 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -720,6 +720,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch: switch@0 {
 			compatible = "marvell,mv88e6085";
diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ce1920c052fc..c27cacbe6a73 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -159,6 +159,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch0: switch0@0 {
 			compatible = "marvell,mv88e6085";
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 95d0060fb56c..9694d3b53607 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -138,6 +138,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 55b4201e27f6..d2ad07ed5318 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -120,6 +120,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch0: switch0@0 {
 			compatible = "marvell,mv88e6190";
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index a6c22a79779e..0bb3dcff0b79 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -106,6 +106,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch0: switch0@0 {
 			compatible = "marvell,mv88e6190";
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 3d05c894bdc0..e12e11805b71 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -134,6 +134,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch0: switch0@0 {
 			compatible = "marvell,mv88e6190";
-- 
2.21.3

