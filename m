Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F9B20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ALuNgxv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGAGRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgGAGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:17:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4DBC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c1so3322869pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2i13HrhbdyWBz2VSMHspL7oRwZeUoksbANwTdThdMao=;
        b=ALuNgxv+cQJPruxfz+cnpxT3S4RN+lkz0v4l0l/kc5hMgfXMduVxq5vqWrOKybDhYc
         WzOJ+GM4PvSOtph/5j2UtMEjccmRYrvQQ1TBd4CPGX7fqWUDo/679LX9u2v0eUv+xRjF
         AzaV1E+kkengcxnb+S60bSmF5OQbvuDTompnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2i13HrhbdyWBz2VSMHspL7oRwZeUoksbANwTdThdMao=;
        b=l7Dmd1Fblkexfuh6d6x95gfg0Pt1pAmPfgHwq4EoOckUYePXyXvgHM0Yf8XGmfskn1
         /5lQl55+eyWYKenvL3ERC2wRGzJdF3DCDq7YtoKuYgn8aluXpBgRm7Rb8WidLSgAaxhd
         5N9JLwbGtoP2ADvsyhGN7GCwoGnzxbASelAKX+gbBp6rf0kOT/kTMrCwFvyF6V2DeC6n
         sHiqG01jhWJcdMkWJtM3tGJQSNN5FkyAHje/j8s3ocqRSekfFw2xL8XFv1IrTx8J40gW
         6mA1nuQrBtU5lm/1tGHUIlY9gx37eAu3IKj6BtmCIf4AXcwyT4wzIGKynS9gb8y6UHLc
         75Bw==
X-Gm-Message-State: AOAM530XLPqGC0wn5UzaZRQ3ueVQCRgQBdihrfn7NNAg8EW/J7rLEQ6t
        qZvS3H5o8zzZDVJCcVbq8AuiEA==
X-Google-Smtp-Source: ABdhPJyfCGZNUCJlKo9e93Dg5bf+/kiOJfc3cIkuM8zAWpJwgVfgwOguM/twEgx6a+7cOiYlDlStWQ==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr21147547plt.101.1593584271768;
        Tue, 30 Jun 2020 23:17:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:356d:fc3d:92ff:192e])
        by smtp.gmail.com with ESMTPSA id n189sm4555744pfn.108.2020.06.30.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 23:17:51 -0700 (PDT)
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
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add Radxa Rock Pi N8 initial support
Date:   Wed,  1 Jul 2020 11:47:17 +0530
Message-Id: <20200701061717.143753-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701061717.143753-1-jagan@amarulasolutions.com>
References: <20200701061717.143753-1-jagan@amarulasolutions.com>
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

