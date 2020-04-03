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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF64C2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355202073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsStG8A5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbgDCPno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:43:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbgDCPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:43:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so9100015wrl.1;
        Fri, 03 Apr 2020 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJW7G8+AK7on97oQRodU2eKPtvCqhsk+Q2DcdPPDzz8=;
        b=YsStG8A5lTrfMhCobWLibPDOdgx7uaUkrcKnsgoZ6m7l4uQKiLSkVr7SNnjTh7ecSt
         c4+TngxLVPmQglZ1Os/5j9gQBypVYtZ3B4/Oi0xRLiheN80JUNfcmEcNhynM+q8vU4gV
         r5p9XvbMzKunWGUcQ/Mx8p2OH/2RQj5AaEwZb2VoRT53S9f7HEv9eEivyAofhl1iEQ6n
         s7p+E+blwpKcNAAVjWRu2enj/x9u5i1wjM3x0l4XXLfS42A+jSpUj8/eYJTxQe/eYSDb
         bEIOCC75N0Pjqcvcs0DDGWoJ94L/JB7TyVkbjOV1THRjzFdxPW9zFTp1aE6/YHdHppu1
         MccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJW7G8+AK7on97oQRodU2eKPtvCqhsk+Q2DcdPPDzz8=;
        b=F/HPJ8yrRIwSO0d8htpzT/98ESwOLwPZqecgqRfL0GZtlWc2aKJFBBf8NJMbC5nByD
         4EARS/uIxyB7NILI/EYqtwdL6q3he4QmXTc6ovvOChvoPgWRoE4C7D7klHsyUrqfaqTq
         7ygNqTsKynle/KujQP6QWcPwDnEUaAX/aXYyQx5uqADGquVqgETwTzjUTJCVHXZoiXDL
         u6HchNj/ust/QoWmcsheZcn+4meG8zU5tqpYpdH4n3zHTjg72Jvg4GUc83tflmlFtMgY
         ZzLnICPvP5JrXpG4yIXsx7jVZA+hehBs3YhSn+FQxtkKcshwE1H7PSVvAxBAXtyQX8Id
         nmtg==
X-Gm-Message-State: AGi0PuZ/O6B1fDUPP9JrnGvfkmim4YpX9iu1lLkxNWQWrnbEnIu95SXY
        PjUxsro+aWOqFr+XrF8rUJs=
X-Google-Smtp-Source: APiQypJXUfhLnIeJDO6myvWEkdL4J0QdDbMurE0ImmLwTOsJPOpdKOfj5Ot5kldFmQDBTflYB+Q5fA==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr9491160wrr.127.1585928619208;
        Fri, 03 Apr 2020 08:43:39 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h2sm11701580wmb.16.2020.04.03.08.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:43:38 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: remove include for irq.h
Date:   Fri,  3 Apr 2020 17:43:29 +0200
Message-Id: <20200403154329.11256-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403154329.11256-1-jbx6244@gmail.com>
References: <20200403154329.11256-1-jbx6244@gmail.com>
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

