Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D634C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D03206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx7arILk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbgGVUd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:33:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303AC0619DC;
        Wed, 22 Jul 2020 13:33:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so1991089pjc.4;
        Wed, 22 Jul 2020 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pq467vccqzYp1M1jQhDSkSEoLcyh52UM7Yn3BzMUZWU=;
        b=Nx7arILkrN9sPH/CCElelQE44Zghok008Plxv4BhLXWXt+XHfYy5W/1vfIA3wMIqW/
         ffpgRqz03Ye1JGTHUJ8LGBSyK23Lx5nDSlEv7Ik+tccqcG6Uo4krJLYRpQrHf/zS+miE
         zX+UIKm2+i33xO/oGQr9F0uP1rnpQ1ZQcLG6xATD+SYibPH+5epS73WP6FmUEoR0qujE
         /rvMgeMMSiPVVrKhfQEWY7MEs9UZPRHrWJIwH3E01rxsydJwD1Yr+tV3A6IDnFFy/C43
         KYw70f20MNMlr5OngghDvY+ereRJ8v+jpEwiv+423ftRySOHlsUURh6j1WUSeqfNa1Wn
         mwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pq467vccqzYp1M1jQhDSkSEoLcyh52UM7Yn3BzMUZWU=;
        b=CBY6FhyDURQvX4voavnpnNfwoSdPIMjcPNYR5XEaL7ZJj5U0gRPYFanFUauhSpXQna
         v1djalkftANBP8lMAuW2jNARNXPR8bHO5OiEPvcgWu8c+hor3ryyjRMFARbcJznWu+hL
         mH85sSO1auDauyXqNEWp6rMeztRHpTmhXeo+SwwXScFj8Ri+BeMBWtrQk9IoDwiZCjMU
         Bja9c2IWYNLFuS4jONn/PnTrcr1qeV2WoykvXJ71h2tbfUaoYfyiEUS6GDjDvfZahIOZ
         2xWRiE4Lj7+Wilv+L+6s1ZYfiVbetw8L82GNyGin3C5yKkZdcfbmy5ZG23YJs1/Gkvkt
         2ICA==
X-Gm-Message-State: AOAM533v5YYBnQkLGE4VibUjbDizdfJYg7ETClnRSmsQAleRUxA2bxz6
        IGVMGUOHkk6iEma2uKGSngY=
X-Google-Smtp-Source: ABdhPJzVZ3YITvtTekh3eUYtyR1c1bsCLWAJSiDCBFxKC2/9tQImXbeKoSRFfAIs9LyUDft8h9FrJQ==
X-Received: by 2002:a17:902:6544:: with SMTP id d4mr1072791pln.138.1595450035501;
        Wed, 22 Jul 2020 13:33:55 -0700 (PDT)
Received: from localhost.localdomain.com (cpe-172-90-68-11.socal.res.rr.com. [172.90.68.11])
        by smtp.gmail.com with ESMTPSA id ml8sm531637pjb.47.2020.07.22.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:33:54 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
X-Google-Original-From: Chris Healy <cphealy@gmail.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] ARM: dts: ZII: Disable HW Ethernet switch reset GPIOs
Date:   Wed, 22 Jul 2020 13:33:41 -0700
Message-Id: <20200722203341.578651-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Healy <cphealy@gmail.com>

Disable Ethernet switch reset GPIO with ZII platforms that have it
enabled.  HW switch reset results in a reset of the copper PHYs
inside of the switch.  We want to avoid this reset of the copper PHYs
in the switch as this results in unnecessary broader network disruption on
a soft reboot of the application processor.

With the HW GPIO removed, the switch driver still performs a soft reset of
the switch core which has been shown to sufficiently meet our needs with
other ZII platforms that do not have the HW switch reset GPIO defined. 

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
v2:
- Update the description to more accurately reflect why we are making the change

 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 --
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 --
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 --
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 64e0e9509226..50da0c94e1b7 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -172,7 +172,6 @@ switch0: switch0@0 {
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 
 			ports {
 				#address-cells = <1>;
@@ -356,7 +355,6 @@ VF610_PAD_PTE13__GPIO_118	0x3043
 	pinctrl_switch: switch-grp {
 		fsl,pins = <
 			VF610_PAD_PTB28__GPIO_98		0x3061
-			VF610_PAD_PTE2__GPIO_107		0x1042
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 9e5187ba3fa6..6c6ec46fd015 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -129,7 +129,6 @@ switch0: switch0@0 {
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -326,7 +325,6 @@ VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index 569614b08f04..73fdace4cb42 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -118,7 +118,6 @@ switch0: switch0@0 {
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -293,7 +292,6 @@ VF610_PAD_PTB24__GPIO_94		0x219d
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index b6b0f302b7b4..fe600ab2e4bd 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -143,7 +143,6 @@ switch0: switch0@0 {
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -333,7 +332,6 @@ VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
-- 
2.26.2

