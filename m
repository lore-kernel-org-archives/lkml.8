Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E46BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DD12074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alFec87B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCMXFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:05:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44447 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgCMXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:05:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id h16so9104882qtr.11;
        Fri, 13 Mar 2020 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K19tWYumSLxb2jgL1zYdrr/V94anTYSOiMqlc5VxdrE=;
        b=alFec87BZpXN0KlqpPOND8yBwUN3qvnWceUs7RmxNXeRDLzbLwA4DYwSftKfaQlb/5
         7CAPgS3YNllTd3voPPiwGOMxjOQZSYwCJA51vA5c2WrbGD0dXJDIk37PRPc9mHoyySa/
         gIQjUk+ytd9tDQFbOxNsYc6bySk+TmEccp59iajt3fu5Fv8UiXif7ksXa1pNMPrSv3II
         c0pFJjeFk7YuM2R/Dsl0S74VPm2Wq6bFgbInkAYrPMvMgz2NxorHElKI3Z7GPyyxPvOO
         UHvD8Ewk/06FHXmloZqLkhsG/pS6FtdDbTO7EKDWK1SBmLHKgaVYuYCuUu7HS5LfHfbd
         JtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K19tWYumSLxb2jgL1zYdrr/V94anTYSOiMqlc5VxdrE=;
        b=cxPVexytEVah9blDzmMz4R5n/i6iI78FtLFAMt2XgUB9rnr36xoFICUT2PIupWfFV/
         At5nEHNs/WjgWQf8DWKH/Yd60dfBdutC3q4GSGbKYyFrHhwGYN+A6cTPUbhCd9YDepCj
         +cj3IBbaK047pygZ5WgpkIa+HQot3nNzFmCPLjqGWc/Z8DEc6CcL3itqHQZI8nTpj17n
         A+R1uaQMERD7guOx2JiIP0KNfo9P1vygUDn+fP+qd95I6LBecrNYHLTaX5sgbzGSm6fb
         eP+EcUdz24NZdfRtfk9Vk/U4DM6y82fz0+C+xi6LEOtjsfcsd53SB5/QVDK0Lohj+VHq
         eqyw==
X-Gm-Message-State: ANhLgQ3u5Jt1eUw5kcx35yrO0NNAIN/7ujeKZnCVJ7cSsEm4zESixHVi
        4m+P6sI6DtBqK1sS43TXquY=
X-Google-Smtp-Source: ADFU+vu2A0jQITKSfb9D6lzWugdRnkulN3l3qRdmwJK7GenwUubT5WBUEj4UMaYTfXtbMNN5smwyEQ==
X-Received: by 2002:ac8:6685:: with SMTP id d5mr15145698qtp.170.1584140730346;
        Fri, 13 Mar 2020 16:05:30 -0700 (PDT)
Received: from localhost.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id i1sm25756015qtg.31.2020.03.13.16.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:05:29 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        npcomplete13@gmail.com, ezequiel@collabora.com, jbx6244@gmail.com,
        akash@openedev.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add Hugsun X99 IR receiver and power led
Date:   Fri, 13 Mar 2020 19:05:13 -0400
Message-Id: <20200313230513.123049-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add Hugsun X99 IR receiver and power led
 - Remove pwm0 node as it interferes with power LED gpio
   pwm0 is not used in factory firmware as well

Tested with LibreElec linux-next-20200305

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
Changes in v2:
	- Changed led trigger from none to default-on
	- Changed led node name from power-led to led-0
---
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts   | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index d69a613fb65a..df425e164a2e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -29,6 +29,26 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_rx>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_led_gpio>;
+
+		led-0 {
+			label = "blue:power";
+			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "default-on";
+		};
+	};
+
 	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -483,6 +503,18 @@
 		};
 	};
 
+	ir {
+		ir_rx: ir-rx {
+			rockchip,pins = <0 RK_PA6 1 &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		power_led_gpio: power-led-gpio {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins =
@@ -539,10 +572,6 @@
 	};
 };
 
-&pwm0 {
-	status = "okay";
-};
-
 &pwm2 {
 	status = "okay";
 	pinctrl-0 = <&pwm2_pin_pull_down>;
-- 
2.20.1

