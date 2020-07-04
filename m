Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C606C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C63520890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l3pUPpqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgGDUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgGDUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:16:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B142C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:16:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so13820176pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iz5gEZOmf2Z/DfumNACLyBntux+apLMSkaM/2QmivIQ=;
        b=l3pUPpqXCI03dmEQJfW35iL4jMa//iGQBB84kYksPRrxFCmiHPimEKIbtqbwTqw16M
         jElCkJzMSBO8NVG4yjKFsdpJXnFGjnH7U49d21tR1MYnQoES3TdRmz3aMvBtAjBYhRgB
         y/u7EACI4PgFy+H6go32aYnAlw2qkfjaSXvdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iz5gEZOmf2Z/DfumNACLyBntux+apLMSkaM/2QmivIQ=;
        b=LfgyTQKklured8HvnykjUuzJM/IOvCSRWb4lUQEH9FJbBcFCY/DDYdbTrCoehjUX9P
         8Uj0MF9CnJAwUx2UK7z+Bvmk0/fWk1UK6ErRxoq4tINlrq1emIksB4k9Lu8z1YYiXrTm
         FBpShDlN+L/A8gU8V6Ss2cTSqmPpJ3ln+gHO1USdTP1+iFuf1AhXucYZ5O62RcHW3eW0
         Xu7CyjlgsVbEO9fTqqLnlqIjBFdfV9IXb9qh1ahDIsrxJ/lJrsCYsnR4HvDCLHzct1ye
         6FUu9YFtmq/UGO4A8WlumyvoL81JjkqAyhZNyStcmpzITTF1G+1Zr/Mxnwa4TGzPC4A9
         /ISw==
X-Gm-Message-State: AOAM532ffcvAFbf5/Zw/R5H8D1o+7xXXTiG63ISFqGJV+2s0MHQqIkD8
        n1LRFs5apKb6okbUdFS0sV48lA==
X-Google-Smtp-Source: ABdhPJwULH9OMGmTgOjbY27fxla5NURsUEqaYcSpJL5O4IORiADYdLI78b+FOSkLlKmmvE75n/ChdQ==
X-Received: by 2002:a17:90a:930b:: with SMTP id p11mr44102304pjo.230.1593893793769;
        Sat, 04 Jul 2020 13:16:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:bdf4:3289:4b66:dcc0])
        by smtp.gmail.com with ESMTPSA id d16sm14960791pfo.156.2020.07.04.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 13:16:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Tom Cubie <tom@radxa.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/4] ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support
Date:   Sun,  5 Jul 2020 01:46:04 +0530
Message-Id: <20200704201604.85343-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704201604.85343-1-jagan@amarulasolutions.com>
References: <20200704201604.85343-1-jagan@amarulasolutions.com>
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
Changes for v3:
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

