Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF7C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A903320753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ty5aisb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgEFWR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730102AbgEFWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:17:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:17:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so4505442wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Prp52Y5a00MQ7UiUFWgZ97mkG5T8OKjyV13VHzZiu9w=;
        b=ty5aisb66j++kRcNuPiouXtTHM526s505r/8/KWSGy1fFWSsaW6lvLqi8kpDpWFDGQ
         0G0UPaU1VsEJByjGzxhJozHIEGCuOzRqyaCWzOwWPBJUMSho6m/dAqmANTx/meQ6/9rI
         U5sU9lv2FgJZu1BnANKM1A9joLIMrWoHazw6EIVw39Sf6do1qCJNS/2MuY0EZma/cNYL
         QtmpcnuBMm81K5gDBlJfo2Iktk9WQghJ6K25/O+Abqu+vXwSy4f4QkhgRtSckO3kd3Rg
         psjB/0QACh5xNw1dELfa9BrHntHte31KWln0LhUn4bdPEGJE3b6BG0xPNJzcY/NDyeIF
         gcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Prp52Y5a00MQ7UiUFWgZ97mkG5T8OKjyV13VHzZiu9w=;
        b=JY9xSjm0IsIRClWCQnoUoD6mxqnqXyYEdnKu0lennpN+IOG3hvAbQpohYVnfn+gIbk
         Gjd7a79FKrF6EfHjihu5T2hqCApv0BapJFeMz+Au3Ur46E11Dhk+ssR7sPvJ4C+GQDU6
         KNciGlS8wN5GX3ICBM3DsYwFwKL0EqiMYhsTKbJ6AxjxvyWqrwS1gl6OeB52A2gY6/3T
         Br3tdPC2ht72ZhypQxCsDZXxe7oygKUBAzQ8A/kGAbZ86cTnvFkzvhKIf9zAb/FSzGB5
         iwLJGpCTI1gGX6+OPUjX/qObhBYYIr91YchTqc/0xSkvwmefNUCxDYk+ZlX2+hUulrmk
         xyVQ==
X-Gm-Message-State: AGi0PuaT0hpHHXSrHTG+jpSlJCZs1B393bkErhXoget3JZAIFiWlYI2G
        nbOgyQ4Y3w7CMrZVv7/pPCO2qK25ZUo=
X-Google-Smtp-Source: APiQypIpHP2oFvyp2Nvd8um8TY8hC/bSKyCdRHrOH3fcUf7Mt2X9JVVO9azjqnAb8r6HBLBWYrUKCw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr7095559wmj.161.1588803424929;
        Wed, 06 May 2020 15:17:04 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id f5sm4760671wrp.70.2020.05.06.15.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:17:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: meson: libretech-cc: add internal DAC support
Date:   Thu,  7 May 2020 00:16:52 +0200
Message-Id: <20200506221656.477379-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200506221656.477379-1-jbrunet@baylibre.com>
References: <20200506221656.477379-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the internal DAC support on the libretech CC. The output of this
DAC is provided on the 3.5mm jack connector.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index d81382b36049..5ae7bb6209cb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -22,6 +22,13 @@ aliases {
 		ethernet0 = &ethmac;
 	};
 
+	dio2133: analog-amplifier {
+		compatible = "simple-audio-amplifier";
+		sound-name-prefix = "AU2";
+		VCC-supply = <&hdmi_5v>;
+		enable-gpios = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -129,6 +136,12 @@ vddio_boot: regulator-vddio_boot {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "GXL-LIBRETECH-S905X-CC";
+		audio-aux-devs = <&dio2133>;
+		audio-widgets = "Line", "Lineout";
+		audio-routing = "AU2 INL", "ACODEC LOLN",
+				"AU2 INR", "ACODEC LORN",
+				"Lineout", "AU2 OUTL",
+				"Lineout", "AU2 OUTR";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
@@ -150,6 +163,10 @@ dai-link-1 {
 			codec-0 {
 				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
 			};
+
+			codec-1 {
+				sound-dai = <&aiu AIU_ACODEC CTRL_I2S>;
+			};
 		};
 
 		dai-link-2 {
@@ -159,9 +176,22 @@ codec-0 {
 				sound-dai = <&hdmi_tx>;
 			};
 		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_ACODEC CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&acodec>;
+			};
+		};
 	};
 };
 
+&acodec {
+	AVDD-supply = <&vddio_ao18>;
+	status = "okay";
+};
+
 &aiu {
 	status = "okay";
 };
-- 
2.25.4

