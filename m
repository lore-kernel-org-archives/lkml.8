Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332CA21548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Xjk4lMJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgFRKJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgFRKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:09:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496BC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:09:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so2234908pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0tx33LB4XJjdQBQtJdq8pHurr/XG5qcfV4Bojc0lI48=;
        b=Xjk4lMJzfKrnO0dJ7ag4s5wJ293r8pN6aY06e7dmdJJAdcWKbyXrT4Lrd0ctnmWbZy
         lDoSJPn4Mko3dbuiyumEg9xMiq9cbJM4Z/sxbZIMgQjxIpNigP9LDe2e7gjtnpx0USNq
         0Q1/Q7hodWx40U/KW/hIyUDq9BoujcY3vIhBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0tx33LB4XJjdQBQtJdq8pHurr/XG5qcfV4Bojc0lI48=;
        b=dM7VwGtoeUC5VObmZMAW9yR9HYp/2tV7rx7JlAZRopUR5E8eaW5BVO3TAEI4pL0bkb
         M2WhydcWPRM2jOnaHuOMq8jNnWoaHUt5yDOpkKSVhWeD0606zNlCHh3vfGdatbkTigUK
         pTLRBENuIc2T/RjjZhVDFqjdZT7dlSKPhgqKhgrgfBBxcNtP48iI7gU9AMPetotJTZVK
         PUnxOtsuPKyBDJCuDTu58xp7NPYMrDDBWzaSqrCINaqkMm82BsPemYjgXOqN1WlKLzzT
         xhSfi+qWkLrwVGqFIhogjuAixmeicbHMNzpt9I/uznZo7ZAXVt0dCsTdWtYZAiSU7Fw3
         Nagg==
X-Gm-Message-State: AOAM533Zp7mvvDcPuWNhJGnk207ksYFFMHqRoEBkVrv4mfKwkdwdWdkY
        +C4daKT2Gh+1YROjsuN9qzTQlQ==
X-Google-Smtp-Source: ABdhPJyQtBMBw9LrfkiQ5o078z+MCo/lVLK2v8zmEGv9YGdhytmSTD/XuQ7v2f2i0mL/BOi1ny7s8w==
X-Received: by 2002:a17:90b:4c4b:: with SMTP id np11mr3550785pjb.58.1592474947624;
        Thu, 18 Jun 2020 03:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b0c7:f192:869b:df87])
        by smtp.gmail.com with ESMTPSA id o16sm2190793pgg.57.2020.06.18.03.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:09:06 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/4] ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support
Date:   Thu, 18 Jun 2020 15:38:32 +0530
Message-Id: <20200618100832.94202-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618100832.94202-1-jagan@amarulasolutions.com>
References: <20200618100832.94202-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Pi N8 is a Rockchip RK3288 based SBC, which has
- VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

VAMRC RK3288 SOM need to mount on top of radxa dalang
carrier board for making Rock Pi N8 SBC.

So, add initial support for Rock Pi N8 by including rk3288,
rk3288 vamrc-som and raxda dalang carrier board dtsi files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/rk3288-rock-pi-n8.dts | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-rock-pi-n8.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e8dd99201397..1d1b6ac26394 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -964,6 +964,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-popmetal.dtb \
 	rk3288-r89.dtb \
 	rk3288-rock2-square.dtb \
+	rk3288-rock-pi-n8.dtb \
 	rk3288-tinker.dtb \
 	rk3288-tinker-s.dtb \
 	rk3288-veyron-brain.dtb \
diff --git a/arch/arm/boot/dts/rk3288-rock-pi-n8.dts b/arch/arm/boot/dts/rk3288-rock-pi-n8.dts
new file mode 100644
index 000000000000..ffec77f0a1b6
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-rock-pi-n8.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2019 Vamrs Limited
+ * Copyright (c) 2019 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "rk3288.dtsi"
+#include "rk3288-vmarc-som.dtsi"
+#include <arm/rockchip-radxa-dalang-carrier.dtsi>
+
+/ {
+	model = "Radxa ROCK Pi N8";
+	compatible = "radxa,rockpi-n8", "vamrs,rk3288-vmarc-som",
+		     "rockchip,rk3288";
+};
-- 
2.25.1

