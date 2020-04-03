Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992FC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07A7206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2iZUdHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404498AbgDCSCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:02:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46771 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgDCSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:02:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so9499221wru.13;
        Fri, 03 Apr 2020 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJW7G8+AK7on97oQRodU2eKPtvCqhsk+Q2DcdPPDzz8=;
        b=Q2iZUdHeWfYgT0GIKTgX9g9cbkvRoWuoAEuQn3SCx/4TX+zhxmCgWBPytSUwlK9CQC
         +VTKZkNxS4G2UHy22CVrDUJzi1XsxQRoKeMSWmY/HeP4hq85+i+i4SwanD6WOXYullwi
         VFCAEMyOcmXXEeduWr8t7L79dOO9A6OMenWqz3hjWHHFujmgZZ5K4jeF0JC7UmIqXyLJ
         ai+YU4zU8oDq/gB2jc8gUMdPeN8NoOntBN2JV7In/2R6vDP8lT+0wGKKHBQ0sxot5Wcl
         PWfQkqZABBI2soimfmlEMd66sKGfu9qcCpuaQjTlro+7/NpNgaERYHIaeMVcv29Y0fk4
         qyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJW7G8+AK7on97oQRodU2eKPtvCqhsk+Q2DcdPPDzz8=;
        b=BuY0bNR6wH7uAYK6ZeUKk4kIoA9sWr2QLp7TeyVc9DgswjYMSOa6J3N9nI2+eJ6tCn
         RthLf0DY1Y6YcN6s+JizrmicObQTC5CPsqwWJ4embVNcDy8h7L2In4bdzqnBIwn+poy5
         Zs5JipqkMpOhXVScQnZAwVsKHg/LB1RYmyID9hebthvxwE4gd6nCQgRV0vIdMwmFjf80
         /LgDOe/iu3oYVWmbBcQCmARTp+d6wli8DgavZt2q6MdwklqW2D+AxtnqKLyLuoxGRMvH
         +IT2rtY7ze09/XGeClyTsASUI7n+nwuUPYX1TLJOVCukjm7QLziKI5GcEzs94lacYlvN
         csRA==
X-Gm-Message-State: AGi0PuaEkrdpNy3LOSOpCipSQqI+Oo1k9+h/y4i+tMpJVdU/9niaOCvN
        B5nGzXIgj2viYIp4yn1KZMM=
X-Google-Smtp-Source: APiQypI7ZLu33/QL0354eqDrhOWt2QusPd92n+8YfQaB7xvV+Xc3kHE37UcC3XsvhlIDo3M9vnJsGA==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr9750425wru.94.1585936932802;
        Fri, 03 Apr 2020 11:02:12 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j11sm13005492wrt.14.2020.04.03.11.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:02:12 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: rockchip: remove include for irq.h
Date:   Fri,  3 Apr 2020 20:01:58 +0200
Message-Id: <20200403180159.13387-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403180159.13387-1-jbx6244@gmail.com>
References: <20200403180159.13387-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'irq.h' file is already included through 'arm-gic.h',
so remove them from all Rockchip dtsi files.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 1 -
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 6f7171290..4820edc7f 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -6,7 +6,6 @@
 #include <dt-bindings/clock/px30-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index ac43bc3f7..a9b98555d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/clock/rk3308-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 470783a48..175060695 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -6,7 +6,6 @@
 #include <dt-bindings/clock/rk3328-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/power/rk3328-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 1ebb0eef4..f22475016 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -5,7 +5,6 @@
 
 #include <dt-bindings/clock/rk3368-cru.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0d895cff5..123b7402a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -6,7 +6,6 @@
 #include <dt-bindings/clock/rk3399-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/power/rk3399-power.h>
 #include <dt-bindings/thermal/thermal.h>
-- 
2.11.0

