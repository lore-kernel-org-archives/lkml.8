Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED430C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5EC20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKwXyBMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMTfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:35:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F18C061757;
        Thu, 13 Aug 2020 12:35:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so5052103edv.11;
        Thu, 13 Aug 2020 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WcafXLrIkW0gekBmKMIz/WZuLgKVGf9oTkGw44iFQAY=;
        b=jKwXyBMTVbZIwxzdDbn4XzuY5kWxoEjoYdq44qxpBinPI8Lu1BRbXnTJnVD8BChmT0
         /mYN/YwSOnd2eqZHkP7346RrvyWV3wxi4xUGFyRBdyQL6yn3yISjxVyrdTOmVv7JKhhL
         fZWnuRfbC9Hke/lnF5RnztabNgLVm58WA491/2fh3FGHhsspy/f2HaoZAIEqgkzg5Zqp
         p6EZk8zekcbsd7ftzRQO4HxyyEo9190CNX27eRNeUYZoij3Gw2fIcAytWP9asfAOFOhu
         4zu5kC7Psrt7JOIxeZbE4nbeXavSjoLmybZ71aKZVkQQE/E0kRV81HQSjQ+xj5dDLMAe
         yx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WcafXLrIkW0gekBmKMIz/WZuLgKVGf9oTkGw44iFQAY=;
        b=MF6o6z3vp2S9AIA9CgFJbCCAeGVvWm2wFp6gfP/jnEP9357gbzB2eWq59L4FgrTMEl
         R+keUnn1xbjEa/QpOosAiy/rozKJ2Xq5Ai6ewbwkOZ/LhEwzRrEHRoWqWxWd671OFZAb
         8PrshTLJEfcGguHtXePLuJjgH3yNZBuYpONRSdiSZ7FTE1jBMVXd5J1FpSysU4mMK1SI
         kT7NZtJQVC9tO6QOhIz6N0K3sW6HWejX6baTF4Jz790QKk6M3MYZX71P99CY5+icWUkA
         kpjKcsrOn9ufg0Hferl4Wn2F2ReB5H8uhAu6GQmcdGjCPUKIiiVItWDrVGmLBEo2jsPK
         dZqg==
X-Gm-Message-State: AOAM533/DctiUlfCiZ2b/xEd8r3ZICqZ09obNm2FHUrcvUIS2hP/F39Y
        MHlsU6P/ab+D7zMl9BK3G0w=
X-Google-Smtp-Source: ABdhPJwOrP1UE4L64efXQ7WL1gPe1+nNlyRA7pxgg+eGvVs0QbKOxTAEzQ6DYpByvhQ64IcvTIk/eg==
X-Received: by 2002:aa7:c74f:: with SMTP id c15mr1045294eds.331.1597347303796;
        Thu, 13 Aug 2020 12:35:03 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d9sm4120603edt.20.2020.08.13.12.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:35:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: rockchip: rename and label gpio-led subnodes part 3
Date:   Thu, 13 Aug 2020 21:34:55 +0200
Message-Id: <20200813193455.19772-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200813193455.19772-1-jbx6244@gmail.com>
References: <20200813193455.19772-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'gpio-led' nodes were manually verified.
In order to automate this process leds-gpio.txt
has been converted to yaml. With this conversion a check
for pattern properties was added. In part 3 rename and label
gpio-led subnodes with pinctrl. To make things equal to other
dts files move pinctrl below the compatible property.

Fix with help of the following rules:

1: Add nodename in the preferred form.

2: Always add a label that ends with '_led' to prevent conflicts
   with other labels such as 'power' and 'mmc'

3: If leds need pinctrl add a label that ends with '_led_pin'
   also to prevent conflicts with other labels.

patternProperties:
  # The first form is preferred, but fall back to just 'led'
  # anywhere in the node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/
leds-gpio.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 10 ++++------
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            |  6 +++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index b058ce999..dd6be31f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -49,20 +49,18 @@
 
 	leds: gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&red_led_pin>, <&blue_led_pin>;
 
 		red_led: led-0 {
 			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 			label = "orion:red:led";
-			pinctrl-names = "default";
-			pinctrl-0 = <&led_ctl>;
 			default-state = "on";
 		};
 
 		blue_led: led-1 {
 			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 			label = "orion:blue:led";
-			pinctrl-names = "default";
-			pinctrl-0 = <&stby_pwren>;
 			default-state = "off";
 		};
 	};
@@ -256,11 +254,11 @@
 	};
 
 	leds {
-		stby_pwren: stby-pwren {
+		blue_led_pin: blue-led-pin {
 			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		led_ctl: led-ctl {
+		red_led_pin: red-led-pin {
 			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 236ab0f1b..e29c8d172 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -42,12 +42,12 @@
 
 	leds: gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&work_led_pin>;
 
 		work_led: led-0 {
 			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 			label = "r88:green:led";
-			pinctrl-names = "default";
-			pinctrl-0 = <&led_ctl>;
 		};
 	};
 
@@ -275,7 +275,7 @@
 			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		led_ctl: led-ctl {
+		work_led_pin: work-led-pin {
 			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.11.0

