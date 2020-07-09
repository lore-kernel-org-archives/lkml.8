Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DB320663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WbXnCsJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGIKJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:09:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9663C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:09:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so655594pll.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76l8qPKsbcZxqhpyjedMoRnwYdl4LVn9sy/6xNrRrrU=;
        b=WbXnCsJa1ka6PH6CfdDjTVuqByC+UzWjszjU+Idcv/JK7yz/NP3lIkuU8hYVlyaxRl
         DrdSG31UM0F49GmgjSn2SJQ8pHDu7YCgS71wbcLf6g1M7AvjxL6KLqQMIas8LXeHww0/
         at0XdMEvfeIqclNagcu7IbnozCnzb3eWx3ji4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76l8qPKsbcZxqhpyjedMoRnwYdl4LVn9sy/6xNrRrrU=;
        b=IAxGp6LAy19AdG4jUDjnkRIdydacuHnakS8YzxzFl9S6isr+Xtsp4PFVoJGE1mtzdp
         MaV3FV8f4GUrXPjtGdVIeGkCtDYL+t1LYqB4kxybmabIUf/s4Km8oJjIa9OcFOhQ/jnu
         8WmdveJRD80dA9C0zsa6gw4jTlBhQvaxuWoazCydjUcXhYrmYt2jvTdn2oFIrH1p4+yf
         lYNEhuTrZzTIVkjKlzD0z+q1aicNE3cfRKzjanLPfopZ1XO/uMJoU7wZsxORL83vTnJ6
         IFXztJUEmBTLsNgMNpyZqDREAc3iDWaqxnRsnHwG5EIM5N6UwqVWuByLDkScEv5IZJv6
         0FXw==
X-Gm-Message-State: AOAM533ahFUp4/Ekq69vQ8kPxFIW1lyezktlrTM6YO7eAvrUpJHnPmi5
        fGEigzo9HAFyHKFdgE0hIixiVA==
X-Google-Smtp-Source: ABdhPJwjbGs5toMFCehlDdTP7g7sB4jU8QEfsIKM6Pai0ZGMN7QTYg3cUzf5HMRNF53SMb6yYx65Tw==
X-Received: by 2002:a17:90a:a60a:: with SMTP id c10mr14992743pjq.117.1594289386275;
        Thu, 09 Jul 2020 03:09:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:24b9:69b0:e917:1d11])
        by smtp.gmail.com with ESMTPSA id ji2sm2076527pjb.1.2020.07.09.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:09:45 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 4/4] ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support
Date:   Thu,  9 Jul 2020 15:37:56 +0530
Message-Id: <20200709100756.42384-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709100756.42384-1-jagan@amarulasolutions.com>
References: <20200709100756.42384-1-jagan@amarulasolutions.com>
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
Changes for v5, v4, v3:
- none
Changes for v2:
- reorder dtsi include so-that common properties will
  visible to main dts.

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
index 000000000000..b19593021713
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
+#include <arm/rockchip-radxa-dalang-carrier.dtsi>
+#include "rk3288-vmarc-som.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi N8";
+	compatible = "radxa,rockpi-n8", "vamrs,rk3288-vmarc-som",
+		     "rockchip,rk3288";
+};
-- 
2.25.1

