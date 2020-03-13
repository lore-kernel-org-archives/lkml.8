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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B670C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52372206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX1Hbv73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCMABe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:01:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44766 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgCMABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:01:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id f198so9518097qke.11;
        Thu, 12 Mar 2020 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F6aCvMwJEvodjQcp+3IIHrmQA07dblW9GNp3FIT77w=;
        b=oX1Hbv734WRN6kIB5DlUxS/NzZ85FTGqjDcbH8BscB2d69i7BDHDmpNG4NePCMsrPb
         L6g4qe+BcN5qh4OFhVR7NsBVYCxzJ3ie9u+Jct5RrfkmQqQplDNydj3RVxkXD7aueEWA
         sh1StPdX01hI8xYvS0lklsx6eqDJor2pIgC+yx4n5GKyK2Qpoj4jhq1Qq0pmCdLzJir9
         qII2fu74pN/pVjb9joxsqqs/RDw1LJMwKXvQPVKxl1INCWEwJEqqi2uqx26HxEo4Yyth
         nhQCzpn9m2bDGDaFEIQ/52830KryQX4kDvcG6FEA2eoDNjQ4ebCvDMByczRBFx/pV4H8
         fSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4F6aCvMwJEvodjQcp+3IIHrmQA07dblW9GNp3FIT77w=;
        b=Nj0VPUihDQjtLBPAiVEVpbVAkCelUpdtcvrsLz8YjK4eWxUQERL3BvSB/r9W99EceA
         kBNax59LHrcUu+bX9/ZCLWhQzscXLsUAek2c/IMNeotz/aPuwRO6w50Orw457omUpu2N
         PvspxOE2diNoJfnW/2rZ5pxI6MEdWPOtId0rExOkBcysmjueZswHILZeqTHinzX1FNSe
         UUpymeAMS2DVhrnR6PiYGz82mcwPzclZr7+1wwW/ejItt7zcZoOs5j7oMAuCUkF9l6Mc
         GL9j+Q7FDzlbhqhykKTsdsr/BYVJt0AbUSYfypAfan+3QRqbSjS7RPt+SUr2d3XKxa33
         PzsQ==
X-Gm-Message-State: ANhLgQ3Te21lY75ZG8FlBtHd3B/vJATZzgBfGBB/oqJQNDwlFSw0DWXS
        4v8Lq143JTD+lD2BpfJ2pD0=
X-Google-Smtp-Source: ADFU+vtRT9YtSpWfTr62cQOvqoKlnBy08CT8ETqziryBs19ZCrjhES5yaXYjB8SDzIrv16QSXmQMfg==
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr10283265qkl.226.1584057692741;
        Thu, 12 Mar 2020 17:01:32 -0700 (PDT)
Received: from localhost.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id c190sm6819210qkb.80.2020.03.12.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:01:32 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, jbx6244@gmail.com, akash@openedev.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add Hugsun X99 IR receiver and power led
Date:   Thu, 12 Mar 2020 20:01:12 -0400
Message-Id: <20200313000112.19419-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add Hugsun X99 IR receiver and power led
 - Remove pwm0 node as it interferes with pwer LED gpio
   Also, it's not used in factory firmware
   
Tested with Libreelec kernel v5.6

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
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
+		power-led {
+			label = "blue:power";
+			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "none";
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

