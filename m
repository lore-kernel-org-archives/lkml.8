Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F524C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4671320848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKbrczXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgCaRCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40067 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbgCaRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id y71so19533824oia.7;
        Tue, 31 Mar 2020 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsoENpy2jwTifAM1fD5pLX9mFDs7jg0pTni7tEt5IGg=;
        b=MKbrczXqOEVLENPHhVTtv8kAwrtvN5vHUwpd+lgl2YbyPhAF/qHbzvLUES2RQIO3IX
         s+PcA1CsLvTGYrN4vzj1JwrBWvDbq+l1p1Hx0M8atZ9r2Ortbp01hvl2+/acF8wK6Fac
         S7iMrmgmM/RmbP3LXDkGXB1evGlSYvXAFhRSS5xLcHSXnH2ylxhXrs1nfcqukc2wX7WL
         aeKPKB1RtOtuAk1CEbSRT6P+30ZiSqb1b7fO3LoNHTz0Wag5bGWjW3XTUSDprK1AF3CV
         kBnYNSRy+eQLWKMgc9nT4arDriakeq75Z3EHZqrXrrJZAft5HkoaX0M94zfVQA/3rhmA
         FPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsoENpy2jwTifAM1fD5pLX9mFDs7jg0pTni7tEt5IGg=;
        b=kVZQb+v9KPVC82XYX805YOckl1AgYMc05mwI3x9S7fBkHDcmyjJ0XWeWahPdQaL8RA
         ymmWqY4OU0f0J7q3Pm0mA5Chwi9DpDOcIb1fKF8zBvmKezZN2wEgOU5lMCUynFlA37/v
         nLVztOrqOov2Q1d+ZfA8nWm5pbqAdGCcvqOQQ3i7V1E77xBcLhCD0ZjVOSulFw2TfUn3
         TnmLtDoeu0wIFRDVmJ50+b7K32Yqk+S1WDzPuqsR0Ym0QsWsyWoJDoUQ1W50ubLnRGKV
         2vK462mLjqvhsx5/V8GPpIk92M6I6PGzOxRnWfhzoK5OPX5grsv3PaLYWGqWgPP4oX4s
         YvNg==
X-Gm-Message-State: ANhLgQ3sldfMOYVIW5lfAGqY1utuQ/IWJsyrkecNwiXD2Hx5e5t+6GO4
        yhXLwPzLIdi9K+Ck/3BDtSf8GyjYAd/gNA==
X-Google-Smtp-Source: ADFU+vvmit3GaQ6YrWCOnhehTfCG2Zwd1krBmjaYHHVxlPhFJnQT53Psinli0KKnkdL8JqlmGB40Xg==
X-Received: by 2002:aca:efd4:: with SMTP id n203mr2853602oih.159.1585674153405;
        Tue, 31 Mar 2020 10:02:33 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:32 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 5/5] ARM: suniv: f1c100s: enable USB on Lichee Pi Nano
Date:   Tue, 31 Mar 2020 12:02:19 -0500
Message-Id: <20200331170219.267732-6-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331170219.267732-1-thirtythreeforty@gmail.com>
References: <20200331170219.267732-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Lichee Pi Nano has a Micro-USB connector, with its D+, D- pins connected
to the USB pins of the SoC and ID pin connected to PE2 GPIO.

Enable the USB functionality.

This patch depends on the previous change to the F1C100s device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 .../arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6c7cb5..c42186e22d45 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include "suniv-f1c100s.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Lichee Pi Nano";
 	compatible = "licheepi,licheepi-nano", "allwinner,suniv-f1c100s";
@@ -19,8 +21,22 @@ chosen {
 	};
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpio = <&pio 4 2 GPIO_ACTIVE_HIGH>; /* PE2 */
+	status = "okay";
+};
-- 
2.26.0

