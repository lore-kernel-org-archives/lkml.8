Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA2C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294FF2082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wml2g6j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbgDCPnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:43:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54573 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:43:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so7606806wmd.4;
        Fri, 03 Apr 2020 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EdgXbs5SzoJ+SdfVQVAnWtgLhjo5feNI5qPAURWOdI=;
        b=Wml2g6j7pNDtWoVQC9omTmBXuBRWv/HiHlW4vRZhhgmo8jrIpmBBbVCd9w1W9y27M0
         fRtsAKjTO5kvtO2BgQ3xvfts/vXJDX7BCJw+xDPSHteleOct20B2tmZGf7smnb7l74KA
         Zkm52rOvpUat//aL20YRhEIjYPyl1rg+8dL5uqoNCcEpcj4AtzGPnbEN5qz/2BRbuv71
         K4KKKGmkn+glRYMTFM5HpDu73Tv9qc7l44q68NXpNCUVL2VFv3keCXPVzbnU7Bt6uTDD
         WnTmBnm6mbwYFyNPTJtUj/BYorUJZPXDoS1roIsMhfYNuuT2TeNo09VM8JGsG4Ylm57v
         b/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8EdgXbs5SzoJ+SdfVQVAnWtgLhjo5feNI5qPAURWOdI=;
        b=mJaIV5H+CnbMr5cVVh5nr+nCYkpT0blKZ8sxLFvOQjiJe5t9zKBFHtHEdxaZnl5NOk
         cvYN0lTcK7D2eMFAmEspBark3oI//Jh1KnPqufNV/Gw6Mar/NR9t/5GrOfbqU3jCGLhL
         edW4yEyhXuowulpLwtqLzl2hCFMyLH64cjEyQbBhC43QaXZosK51bMHOh5Hqe80BoY4Y
         zG2tXx5dZJxTvOHS7nSHryvuK4iO0hPjiUZRPbNfnyp5XcVGWZITimf0jyXwSSc/6lmV
         scjhIgJPl3dEe+RT7FE4D3OpCP5CHQdKRlFTm71IB/Ysf6+2QMZOzncV3ojWKRp/AjjA
         t9xg==
X-Gm-Message-State: AGi0PuZ84VNTpTrJq520h39RsDSpeng9TZ/cbTu3F8frNJMEF0MtOxJy
        rGh37juXoXzlDN1CcBDWyBA=
X-Google-Smtp-Source: APiQypIdfVM8Ohqo+FmD/zM+YA+XRK3MMfe4WRTwIojwI3dOLqqi2vSZ1GEHTaVF/ckE8eV4TVJ/tg==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr8883490wmb.127.1585928617818;
        Fri, 03 Apr 2020 08:43:37 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h2sm11701580wmb.16.2020.04.03.08.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:43:37 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ARM: dts: rockchip: remove include for irq.h
Date:   Fri,  3 Apr 2020 17:43:28 +0200
Message-Id: <20200403154329.11256-2-jbx6244@gmail.com>
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
 arch/arm/boot/dts/rk3036.dtsi | 3 +--
 arch/arm/boot/dts/rk322x.dtsi | 3 +--
 arch/arm/boot/dts/rk3288.dtsi | 5 ++---
 arch/arm/boot/dts/rk3xxx.dtsi | 1 -
 arch/arm/boot/dts/rv1108.dtsi | 4 ++--
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 781ac7583..55f3838b2 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3036-cru.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3036-cru.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
 / {
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index c14891fe8..d5a1aad17 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3228-cru.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3228-cru.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f102fec69..a56b4a58f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/power/rk3288-power.h>
-#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	#address-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index f9fcb7e96..c79d98edd 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -4,7 +4,6 @@
  * Author: Heiko Stuebner <heiko@sntech.de>
  */
 
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index b453f8d0f..06c46bed9 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/thermal/thermal.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
2.11.0

