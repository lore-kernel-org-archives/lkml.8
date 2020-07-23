Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF0C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47052086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eq+Z+3+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGWMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:40:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B4C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so3002197pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCYUJPGG+KbDLO7tFdQX9eEJsNaLnSLYaC221fvxdqE=;
        b=eq+Z+3+4XmTJNeY+PHfgySIRolND+ujLvw1k20p/z+ZjML2c14GwUvQrWhnzyUMoro
         8yQ96afPQO3ziw1ZGiMqK+4f9Cu2GVrbBFrw25ZepQU03rAc69qCNHEZEGicVa2iTrWb
         4O1yioKPgNGbIGhIvOk7eQNMsq5Weu6mlD5CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCYUJPGG+KbDLO7tFdQX9eEJsNaLnSLYaC221fvxdqE=;
        b=JBvfsPu5y+EFXBL2RDJhMBH5hl8f3i0JvSIxIMMGfM+REzUOvj/Zapt3y9dVy10VcS
         /0fRqbxG3h2YUf5yJJbxuuW3BbI7HSf0vmvZq7mfJsF154WougXnEO9FTQRxehDGqRZX
         04bBOtMzBufBo8EL/c00s6PTOc1DBoCDXp43EUaCj7wvTT74iuqN6nE1NiaXimM/O139
         PUHIrRnGcOiCVoeJRToM66uKW0TMY4npjwGdB3oInHBTC41Mn5b7StiVVDoONf5tYEcJ
         twGqMyDy+Q60rPqCAbTMQA8dPaf9L68qUtEKwR431bFi8CzP8kx6G2agLfdQRIvRVDfU
         jOJA==
X-Gm-Message-State: AOAM531n53OlWpYmyH/VU2gKY94twkKz5JuZVnmJ5q1rCR4/exNy0MAO
        UelrRaYJIWFlp6o/Pl0PsPnPpA==
X-Google-Smtp-Source: ABdhPJx3hkWlHqGMm0vTJejzvTFUJAa0u5XkNE9bZDhVFo9ZivILhe3SkDxBrWKJu5KXzh/02o4Y4A==
X-Received: by 2002:a17:902:7e8e:: with SMTP id z14mr3564576pla.52.1595508028443;
        Thu, 23 Jul 2020 05:40:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:cbf:ea0:8a30:a3af])
        by smtp.gmail.com with ESMTPSA id m26sm3051270pff.84.2020.07.23.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:40:27 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/7] arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Thu, 23 Jul 2020 18:09:48 +0530
Message-Id: <20200723123951.149497-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723123951.149497-1-jagan@amarulasolutions.com>
References: <20200723123951.149497-1-jagan@amarulasolutions.com>
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

