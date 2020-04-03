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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F19206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjLWh9fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbgDCSCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:02:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404454AbgDCSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:02:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id t8so8041213wmi.2;
        Fri, 03 Apr 2020 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxdQKl8R6YdM8K12dz41P09Nrimll4Ax/Xh/6JqmhUQ=;
        b=pjLWh9fa3JaWmB//DkucFHLeWDoeVKvvYt/9ZAeV1bXCC2v/ae77zMcaue3hrhw380
         Fhga1BX1j2XkVpnwXxuqT8gKFpDRXI44u4cpXQIca59sz9Biiv8imONtXD1bDCpo59Za
         7rpMPLzna4YJ5J8xCVTnlHSsoOCrraK0/NkQ/KBorBYOPunpWcz/91cwj34Z6HFN7G33
         L/wmEryLTVgdQUHxWemyJjdP8XQUNSD/saVs4rAfNXjSOsGDZ8u1rAcfqwA6VYxKcjMp
         Rih0XpHt8Uau6PVh6MadenOVaNWSDXpLGsHy2qR1IXtRlmR/WeUGBPdfQACs1Slb5cBK
         7NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxdQKl8R6YdM8K12dz41P09Nrimll4Ax/Xh/6JqmhUQ=;
        b=FmEjQMjubTlmf7l6WmmlHks9+HdrmKX5W+2kIdJ5Xxwa1Q32T+AbMqAUEoIPpyf0OH
         U6v+tKJvGpb3m9DW/46OS3m2U7QAa05dIDIhAHtz/Y46E/ScQ/XWO2WTB6YCawqA4a73
         98Nt5Bkj4jbbt6Jh/VLn2MtXLcdlUcS53ktbirewQ7xlWbtJm6H+5IWnF02RWVL2aoLf
         BCO30gfLD/EJJBdqoEDWa0beEV+Yx9+UobdXU8YQ6p2lvI24NAdXXYP4EyBW0kK8ZAgf
         9DCS9GDkyMrpFy3QlncT1+Hp4/uReQR9LHERTzWWM8zAz+LHUBddh0g6WihxJKEre47B
         d+sw==
X-Gm-Message-State: AGi0PubxmHXB+6XmiMrKiySDTCue5bXCBrPIYNLf1uhzC5bg5w6cJcwd
        Ee3kgwWSt7AnNEm4cbMyjG9roCc8
X-Google-Smtp-Source: APiQypImoK5ioimPgpiENe2Nn/IzH6MBtR5XoFVNl4JhD2f5ZPCGGVK9AMP9nAW1l7dTWem02KHOJw==
X-Received: by 2002:a1c:3943:: with SMTP id g64mr9784987wma.9.1585936934139;
        Fri, 03 Apr 2020 11:02:14 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j11sm13005492wrt.14.2020.04.03.11.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:02:13 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: rockchip: sort includes of dtsi files
Date:   Fri,  3 Apr 2020 20:01:59 +0200
Message-Id: <20200403180159.13387-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403180159.13387-1-jbx6244@gmail.com>
References: <20200403180159.13387-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The includes of Rockchip dtsi files have been subject of
several patch styles, so give them a little alphabetical sort.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi        | 2 +-
 arch/arm/boot/dts/rk3066a.dtsi       | 2 +-
 arch/arm/boot/dts/rk3188.dtsi        | 2 +-
 arch/arm/boot/dts/rk322x.dtsi        | 2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi | 4 ++--
 arch/arm/boot/dts/rk3288.dtsi        | 4 ++--
 arch/arm/boot/dts/rv1108.dtsi        | 3 ++-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 8be47354d..55f3838b2 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3036-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3036-cru.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
 / {
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 1cf7e1b38..9924def56 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -4,9 +4,9 @@
  * Author: Heiko Stuebner <heiko@sntech.de>
  */
 
+#include <dt-bindings/clock/rk3066a-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3066a-cru.h>
 #include <dt-bindings/power/rk3066-power.h>
 #include "rk3xxx.dtsi"
 
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 2298a8d84..e22bfc612 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -4,9 +4,9 @@
  * Author: Heiko Stuebner <heiko@sntech.de>
  */
 
+#include <dt-bindings/clock/rk3188-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3188-cru.h>
 #include <dt-bindings/power/rk3188-power.h>
 #include "rk3xxx.dtsi"
 
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 86c4d62fc..d5a1aad17 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3228-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3228-cru.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 77ae303b0..60259d9eb 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -3,9 +3,9 @@
  * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
  */
 
-#include "rk3288.dtsi"
-#include <dt-bindings/input/input.h>
 #include <dt-bindings/clock/rockchip,rk808.h>
+#include <dt-bindings/input/input.h>
+#include "rk3288.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ace67aa7d..a56b4a58f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/power/rk3288-power.h>
-#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	#address-cells = <2>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7d2ef39db..06c46bed9 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
+#include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/gpio/gpio.h>
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

