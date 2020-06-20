Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41340C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1757A2168B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nhsvE+A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgFTQK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFTQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:10:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56821C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so13584557ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5uydCkX5XMg6Vg2kQWobypgbsZstWsBiCC6Cgbk3+Q=;
        b=nhsvE+A3vifL+fnfwmTAJC8VIevzUqbZu6HqFjlME6kxed/Iun3chdMWSjKgmdfHmD
         YaVWeVYmQEHxkWTtD50a5JbmMKrhOf7SD9XuXi/0pswqSIzxbVwwWfOZGHpuryIAiI5x
         vgnuMO2okuU1aJaQ/dNKzTznQHtypz2QJOAppTJ2I0FRkMjzsv7v1xQcxnovdfxyIy0P
         1qRUGHZUHSYcTpBO1BU16WdrMlDxEOJs4hAqUaonlzP7CVwON+I/vbJOTRzYdW2are0L
         8pp7R/26C+hYCujzTTf5Ke0If01xhYYL057VUgmrA26vlhuUlnritGLVnMAItXZAyT3F
         wfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5uydCkX5XMg6Vg2kQWobypgbsZstWsBiCC6Cgbk3+Q=;
        b=aRQSdDyhhlVo1tZGHG1zdUXKyucDkKYjrQ8IdH1QdmEQjllHbhtiSXGQMO+KSVHRh0
         9o+DSsrO5zrH56bfjuvZpwv2pUVhEW4s0a8A2xKN6vE8/1zlSg2ckkqImNJrMWW+LtaJ
         2EAffuZtk8j3i2Gy/E9nFqxfUwL8OPwBJEY7bnY884/zhfwY72+AVfUvouifioN3u4zL
         0rQZYlN7hnocXRbR/cp59EenuVphN8SdkTOnCp60jXQuQeE/GLXSCFYceLz/FY6w96Nk
         PtNMZXHCE61x78OERlzs5LlbAOhBag2ACxiQMPlMQB0sjD4WU/bc4lvRk70yuohl00cs
         lE3Q==
X-Gm-Message-State: AOAM533w/qcQj9+WsVCcRMH9s2PzW3D4q0Fr9Lac2W/DrucmJSm+mhAf
        VWmU6QBcbrv5QXjSVSuxh4A=
X-Google-Smtp-Source: ABdhPJw2c5P/OzzIL4pa9igoKMX0/q7FSISR355h6IRga3M61m7Z2yv00+t+VDMnuTdffGkN1LigFg==
X-Received: by 2002:a17:906:1d5b:: with SMTP id o27mr8371956ejh.344.1592669420020;
        Sat, 20 Jun 2020 09:10:20 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a62sm8033207edf.38.2020.06.20.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:10:19 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson8: add power domain controller
Date:   Sat, 20 Jun 2020 18:10:08 +0200
Message-Id: <20200620161010.23171-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
References: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Meson8 SoCs have a power domain controller which can turn on/off
various register areas (such as: Ethernet, VPU, etc.).
Add the main "pwrc" controller and configure the Ethernet power domain.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index a4ab8b96d0eb..3d0ab2ac5332 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/meson8-ddr-clkc.h>
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8-gpio.h>
+#include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
 #include "meson.dtsi"
@@ -452,6 +453,8 @@ temperature_calib: calib@1f4 {
 &ethmac {
 	clocks = <&clkc CLKID_ETH>;
 	clock-names = "stmmaceth";
+
+	power-domains = <&pwrc PWRC_MESON8_ETHERNET_MEM_ID>;
 };
 
 &gpio_intc {
@@ -467,6 +470,16 @@ clkc: clock-controller {
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
+
+	pwrc: power-controller {
+		compatible = "amlogic,meson8-pwrc";
+		#power-domain-cells = <1>;
+		amlogic,ao-sysctrl = <&pmu>;
+		clocks = <&clkc CLKID_VPU>;
+		clock-names = "vpu";
+		assigned-clocks = <&clkc CLKID_VPU>;
+		assigned-clock-rates = <364285714>;
+	};
 };
 
 &hwrng {
-- 
2.27.0

