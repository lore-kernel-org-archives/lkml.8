Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9191C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E3323E52
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B6X/0atv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgFTQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFTQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:12:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798FAC06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:12:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id y6so10184207edi.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCPVTZi3Nez6HPxmWh69ZvSZD8QNf4zRgd1dOnXR2q4=;
        b=B6X/0atvwu5PDQMgnwBR+YORpKDe80h1eseaDVzLQOM5L7klltwWI8b3WRKZq0fORw
         R3XeciWi1LsZ6DiNRmZPqebM9FEUSBAcUD6ezRH0gH5PHEq0h3mXguqGFOnjNCNzqp+k
         BwkOY/SOBocOyYLSB3z4Jz0ZnpPp0ymkBA77NW4D3pwxL/e/4UeKeNLcsbs7J3Czaxsi
         fpeYAxqXNH46uaHhMjf945pK9oxUXyFMgt6pDyR0W03dQwwhTr2mIo5jD8XEa9AZuKOw
         qpjQ2yfvKuaKLRxvy+k6GjLGbqe1HW+mF0KDSoCD4E0rfQK8VeqoCnKl4MQtd7H6jOCe
         NOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCPVTZi3Nez6HPxmWh69ZvSZD8QNf4zRgd1dOnXR2q4=;
        b=p4jW09cNWlT+od/nHpAQnuVnLnz9PoJOizE8HsIyy9CGgTyUvW9suSlglv/+0PuhEv
         jzNxuNRadp3wCNgbZ1yhIF2fAO7DUF15qQkudl1TCSu9s5KD8z4BkT4obbdEMMXfOpKz
         pOG0wWHt733iAImkHh10h8O8QJF0W++CbDmwH0yclUNZgGSWXrgHW5bqOzaXJnGxv14W
         eUXJ/sI5lU0TL2dyZvAvWI10DDLurSIKDfymZqaOoy2+fPF57y0TVPyAHfBTy5Kj2B/T
         XIC70LnYoPlurUUNkbLTFpLsZNh/cH4/YqCp4oI570eVVZVdSVxeEjo8C2YmvGisMSy0
         C4wQ==
X-Gm-Message-State: AOAM532jrf9P9asSIkf/g/lXkynoc3BRuQmspMYH/WPUq0cfqH0de5wl
        qCc8RmsJ9XztU+lYUjIcjYw=
X-Google-Smtp-Source: ABdhPJyZq7M9k7FRfwFPq1K7C3ijD1E9uIne9dkd1rv1jDJiRYZCeSUaW7C4KJ5nPciOUoUTbKYnPQ==
X-Received: by 2002:aa7:cb4a:: with SMTP id w10mr8446600edt.46.1592669558069;
        Sat, 20 Jun 2020 09:12:38 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id i9sm7648405ejv.44.2020.06.20.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:12:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] arm64: dts: meson-gx: Switch to the meson-ee-pwrc bindings
Date:   Sat, 20 Jun 2020 18:12:11 +0200
Message-Id: <20200620161211.23685-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "amlogic,meson-gx-pwrc-vpu" binding only supports the VPU power
domain, while actually there are more power domains behind that set of
registers. Switch to the new bindings so we can add more power domains
as needed.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 18 ++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  7 +++++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  7 +++++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index ba63c36b22e0..0edd137151f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/meson-gxbb-power.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -60,7 +61,7 @@ simplefb_cvbs: framebuffer-cvbs {
 			compatible = "amlogic,simple-framebuffer",
 				     "simple-framebuffer";
 			amlogic,pipeline = "vpu-cvbs";
-			power-domains = <&pwrc_vpu>;
+			power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
 			status = "disabled";
 		};
 
@@ -68,7 +69,7 @@ simplefb_hdmi: framebuffer-hdmi {
 			compatible = "amlogic,simple-framebuffer",
 				     "simple-framebuffer";
 			amlogic,pipeline = "vpu-hdmi";
-			power-domains = <&pwrc_vpu>;
+			power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
 			status = "disabled";
 		};
 	};
@@ -438,12 +439,6 @@ sysctrl_AO: sys-ctrl@0 {
 				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
-				pwrc_vpu: power-controller-vpu {
-					compatible = "amlogic,meson-gx-pwrc-vpu";
-					#power-domain-cells = <0>;
-					amlogic,hhi-sysctrl = <&sysctrl>;
-				};
-
 				clkc_AO: clock-controller {
 					compatible = "amlogic,meson-gx-aoclkc";
 					#clock-cells = <1>;
@@ -552,6 +547,12 @@ hiubus: bus@c883c000 {
 			sysctrl: system-controller@0 {
 				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
+
+				pwrc: power-controller {
+					compatible = "amlogic,meson-gxbb-pwrc";
+					#power-domain-cells = <1>;
+					amlogic,ao-sysctrl = <&sysctrl_AO>;
+				};
 			};
 
 			mailbox: mailbox@404 {
@@ -574,6 +575,7 @@ ethmac: ethernet@c9410000 {
 			interrupt-names = "macirq";
 			rx-fifo-depth = <4096>;
 			tx-fifo-depth = <2048>;
+			power-domains = <&pwrc PWRC_GXBB_ETHERNET_MEM_ID>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 03c25b9facff..ea50dd434887 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -748,7 +748,7 @@ mux {
 	};
 };
 
-&pwrc_vpu {
+&pwrc {
 	resets = <&reset RESET_VIU>,
 		 <&reset RESET_VENC>,
 		 <&reset RESET_VCBUS>,
@@ -761,6 +761,9 @@ &pwrc_vpu {
 		 <&reset RESET_VDI6>,
 		 <&reset RESET_VENCL>,
 		 <&reset RESET_VID_LOCK>;
+	reset-names = "viu", "venc", "vcbus", "bt656",
+		      "dvin", "rdma", "venci", "vencp",
+		      "vdac", "vdi6", "vencl", "vid_lock";
 	clocks = <&clkc CLKID_VPU>,
 	         <&clkc CLKID_VAPB>;
 	clock-names = "vpu", "vapb";
@@ -867,7 +870,7 @@ &uart_C {
 
 &vpu {
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
-	power-domains = <&pwrc_vpu>;
+	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
 };
 
 &vdec {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 60484bbc7272..beb5fc79d186 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -783,7 +783,7 @@ external_mdio: mdio@2009087f {
 	};
 };
 
-&pwrc_vpu {
+&pwrc {
 	resets = <&reset RESET_VIU>,
 		 <&reset RESET_VENC>,
 		 <&reset RESET_VCBUS>,
@@ -796,6 +796,9 @@ &pwrc_vpu {
 		 <&reset RESET_VDI6>,
 		 <&reset RESET_VENCL>,
 		 <&reset RESET_VID_LOCK>;
+	reset-names = "viu", "venc", "vcbus", "bt656",
+		      "dvin", "rdma", "venci", "vencp",
+		      "vdac", "vdi6", "vencl", "vid_lock";
 	clocks = <&clkc CLKID_VPU>,
 	         <&clkc CLKID_VAPB>;
 	clock-names = "vpu", "vapb";
@@ -902,7 +905,7 @@ &uart_C {
 
 &vpu {
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
-	power-domains = <&pwrc_vpu>;
+	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
 };
 
 &vdec {
-- 
2.27.0

