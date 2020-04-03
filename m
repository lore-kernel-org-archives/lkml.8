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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890EEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555A8206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNSzBx3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbgDCSCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:02:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34704 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgDCSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:02:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so9604977wrl.1;
        Fri, 03 Apr 2020 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmSExbPcYsSLBGuvWWlddM3gtwpXwrgXWshNJkEoawc=;
        b=HNSzBx3vmm9ICSvF+V+FKfX4HydCxtwyiJ5H9kcsNR3jMarjQKjZt4ZZ8PmdBTwA/C
         SVlEHCG/8+6Rk2Z7t2qw8KNfPyJLGVnTP81H2mwdB2Qc5O6t1TlTPzYH4G502D1+xzHq
         f3aufq0lV3hmNVz+5ZpO/1zZhsulaCujzWCmO8U5XGgIOQF11aqYxt3Wy2wxw6/e28D4
         dBVdO9K9hu1uHJ1PEMAJMMW+/yHgHkyu04t9U6dmstavfayu2g5OOTs1vGJNoWB9LafO
         ZYPQryA17uqXi704N7Jxwh55Icqjz2yQVEgbiaThOHVBX3yCTAR7Fowqv1KD5T43DEFX
         zy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmSExbPcYsSLBGuvWWlddM3gtwpXwrgXWshNJkEoawc=;
        b=BArC7C97TdOP0PNqyz54K2L71pyYiMRpNrJRXF5XpvWH2mhP+h1UQYZ2TsvOqnTGSH
         HaufSzx9Tw32GwlwSm87rLvenexlrBhkVT7X1nFGAK/asw2ezR/JWcDQyJzWncczIRNP
         tzdtW/13Vn3to7100gCLON2qZ8gUcz6XWgLRn3AvTffTMw1Yy7u76W5m5r6EgCSE8tVt
         6glKeQypvlEYxciMCH8kLi4lq9EZbuYrfrT5p7bpQM3S+ydzl9m4puoeMoSznEZ/KP2I
         C9C5Eo9F8WenBvmbbAU4VogMoasYBtIwzGI4SL7MRTatVibJMNaaRUQZRLvEV5kOPkij
         HU7Q==
X-Gm-Message-State: AGi0PuZxBJYWgTbO5+t4FsTGRoBI8zkF8Pg3ufNQdQAFy4JPtVlpU3Ua
        4wkFfQjDVh40dd8dFcxsT8c=
X-Google-Smtp-Source: APiQypJIXvJp2Ky9wBX9h9hFu/x5hSk116TIOt+sFie8LhvXCTRdOUioItrnInQpyW3Iyj1g2uBNbw==
X-Received: by 2002:adf:c511:: with SMTP id q17mr10412087wrf.275.1585936931733;
        Fri, 03 Apr 2020 11:02:11 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j11sm13005492wrt.14.2020.04.03.11.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:02:11 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: rockchip: remove include for irq.h
Date:   Fri,  3 Apr 2020 20:01:57 +0200
Message-Id: <20200403180159.13387-2-jbx6244@gmail.com>
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
 arch/arm/boot/dts/rk3036.dtsi | 1 -
 arch/arm/boot/dts/rk322x.dtsi | 1 -
 arch/arm/boot/dts/rk3288.dtsi | 1 -
 arch/arm/boot/dts/rk3xxx.dtsi | 1 -
 arch/arm/boot/dts/rv1108.dtsi | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 781ac7583..8be47354d 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3036-cru.h>
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index c14891fe8..86c4d62fc 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3228-cru.h>
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index f102fec69..ace67aa7d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
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
index b453f8d0f..7d2ef39db 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/rv1108-cru.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-- 
2.11.0

