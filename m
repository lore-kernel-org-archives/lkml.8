Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B402C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4C92073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IQpA6Xgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHaIaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgHaI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:29:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EA8C061236
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a8so2693908plm.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBHJr1Okg/7cjUJusx0Y2Ejv4RKVEX9vsUPY+T721kc=;
        b=IQpA6XgbebTvewaAc85D6XPtEHWVEiGmqkYWMzOGpvHPwU6rU3HhBna8fg23ldWOM+
         nVMlkrq9HzCDm//XykDTD9LUjxHCDDS1FwAWSZb+dDOjX+cEp9jtRmDnZwax9Tv21G+v
         AVJ+LvPfg090Y48btqSpg14fWdNg+J59cC85c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBHJr1Okg/7cjUJusx0Y2Ejv4RKVEX9vsUPY+T721kc=;
        b=pHEd1F+N/6Nt6hYHQR68Wy63ZW6z46bMAaQO84eU5KV9SZjZg0I1ZhpCH7jiuhYeTm
         H/YlF+BHK3QZk3HKxb8nyr6VOh6dQQzBEvKDVFm8QM761E2iWmb5tDxWwViXlxd1iXsn
         SVLyszBQQ8mqcrWz0A6E46NEb7SFi4iEHa12QTZwvTkf/epE79Znx8eYhKhNuUtuI0z6
         jgj796mqI5lHQmPfDilvJMV7gbMnUFxB88L5m3h3m/B0IzQA1gcyNtl6aw8XcyzAe0OL
         b8m43/YQM1ILSmEDYJOpArzDGuWhpe76G2peuEDM7kFB/rVclU6kn2kT9OYh9QS8nelc
         6WUA==
X-Gm-Message-State: AOAM531hCNR06+3azPcU0gAcKb0QFhUCZNnJcBKHR1BWyUVHvMBGt7Es
        pmp2LcL+ougrqKP94j+Wi9CYkrobTmQFXg==
X-Google-Smtp-Source: ABdhPJxgjziD2tuA2kVV0dZZb4M8gPNqYekdzI1yHazKUQ5scOXSTXVO7V9ko8vChmF9EEt79LGq5g==
X-Received: by 2002:a17:90a:120f:: with SMTP id f15mr411985pja.120.1598862585815;
        Mon, 31 Aug 2020 01:29:45 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d50:45fe:aaf3:66ee])
        by smtp.gmail.com with ESMTPSA id b5sm6411335pgi.83.2020.08.31.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 01:29:45 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/7] arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Mon, 31 Aug 2020 13:59:14 +0530
Message-Id: <20200831082917.17117-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831082917.17117-1-jagan@amarulasolutions.com>
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

PX30.Core needs to mount on top of this Evaluation board for
creating complete PX30.Core EDIMM2.2 Starter Kit.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- none

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/px30-px30-core-edimm2.2.dts  | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 02cdb3c4a6c1..65116fcb7368 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts b/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
new file mode 100644
index 000000000000..c36280ce7fc7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+/dts-v1/;
+#include "px30.dtsi"
+#include "px30-engicam-edimm2.2.dtsi"
+#include "px30-px30-core.dtsi"
+
+/ {
+	model = "Engicam PX30.Core EDIMM2.2 Starter Kit";
+	compatible = "engicam,px30-core-edimm2.2", "engicam,px30-px30-core",
+		     "rockchip,px30";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+};
-- 
2.25.1

