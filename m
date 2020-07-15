Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962DCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1082065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyqry2rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgGOVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:22:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67342C061755;
        Wed, 15 Jul 2020 14:22:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so2662633pfi.2;
        Wed, 15 Jul 2020 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEOeNcHcUcS12HReWL9QBQ9Se3gqYrNjZVjrRl75LJU=;
        b=fyqry2rVZWAyho5Eh/lPxvweLWsxMh9zcpIYRTREpq3y2NDJsKC7/rMT56NNQvRD4e
         LQuWIoxxf3U2reZ7W8BUO3pPqtK7aHRDda0pwNQVom0QMEim3HwdcusYmkg9rduCJFTN
         xfY4iDUSpEvdYxPjJv55vdjkyug3x+itUG7TNBe3NFpfzqzjeBb8C3I+LPKr+8bfc3bV
         HXz1bD6FXy2Nt8nGGlKkdZOiknjOL+NP3yjjUDAKv0Pg9Uh+esbJkYF9ke+8FBAJCQ3E
         8DasfjZAI6nEZ3pKamRjwFA42SZO24OKiBOc8mayUOHeDGMhFurmereTe9iUGPgqus6m
         418w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zEOeNcHcUcS12HReWL9QBQ9Se3gqYrNjZVjrRl75LJU=;
        b=rThiryXVDEeRE8TAAYkAXDaVhBq/RwtgylPRRmDYb2G2pbPJlWzh70gaW0d9q4m1h5
         PJT6am659BJdCCa9fs29J1XvX9QGskE/zCagB9doPVIqJBxse0XcprcVWqCJ/f3j6oZU
         jj6IO62+bxer472FHRaSXqNTrn58+5YGyBeS8D1MIeA3pso1WRmWXxDz0qxIPjdxfrxC
         iSAr9KLLeUjUjC5mmypJ2kFINgApKsJeHMEXFu7KwmKx3Up54G9aIWpVjnSVHZ1DU7B9
         7wnTJRC+5w0iYn71fhsPXsQC8K+jZSYzxp+qsVayTzukKRjyMk6DCCIRbKabvTgfUj2Y
         X9qQ==
X-Gm-Message-State: AOAM531lJAOl6rv9h8ooUh2FrhK4NvuzqP7Rds8dM4Zm3dqsEUm3WBO4
        lpKEYLeju/qLnivFY+TUlTw=
X-Google-Smtp-Source: ABdhPJy+oKkcsN7ED8Y658Q4NbEL9ZFjkmdguwR8qBBTsjz6SD6Mc9fogzydz7mOVkv3jD3wEAdMfA==
X-Received: by 2002:aa7:942e:: with SMTP id y14mr1046467pfo.58.1594848164745;
        Wed, 15 Jul 2020 14:22:44 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id y63sm2868611pgb.49.2020.07.15.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:22:44 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH] ARM: dts: ZII: Disable HW Ethernet switch reset GPIO
Date:   Wed, 15 Jul 2020 14:22:27 -0700
Message-Id: <20200715212227.26436-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable Ethernet switch reset GPIO with ZII platforms that have it
enabled to sync up with existing ZII platforms that already have
it disabled.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 --
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 --
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 --
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ce1920c052fc..c2668230a4c0 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -170,7 +170,6 @@
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 
 			ports {
 				#address-cells = <1>;
@@ -354,7 +353,6 @@
 	pinctrl_switch: switch-grp {
 		fsl,pins = <
 			VF610_PAD_PTB28__GPIO_98		0x3061
-			VF610_PAD_PTE2__GPIO_107		0x1042
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 55b4201e27f6..261317340189 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -127,7 +127,6 @@
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -312,7 +311,6 @@
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index a6c22a79779e..e37b9643269b 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -113,7 +113,6 @@
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -288,7 +287,6 @@
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index 3d05c894bdc0..b3d6d4b9fa9c 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -141,7 +141,6 @@
 			pinctrl-names = "default";
 			reg = <0>;
 			eeprom-length = <65536>;
-			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
 			interrupt-parent = <&gpio3>;
 			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
@@ -319,7 +318,6 @@
 
 	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
 		fsl,pins = <
-			VF610_PAD_PTE2__GPIO_107		0x31c2
 			VF610_PAD_PTB28__GPIO_98		0x219d
 		>;
 	};
-- 
2.21.3

