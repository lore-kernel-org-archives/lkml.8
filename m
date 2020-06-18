Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F977C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788932083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eHOmkiRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgFRN1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:27:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76372C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:27:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so6085567wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGuWagvHkR5CzPo1CRVJNp1xS36Ei3NsxHAn9Qc6w5w=;
        b=eHOmkiRHxbMLhRbAL0KHWuGUzadE+ZgogzWzMmhkx3LAIVM+AXis6XYnZre3Uf+LcZ
         QcWObIqEjvqx+6h83uCPq0nc79JdbpZgk0BHcDcpG+E3iKwwlH1lKCkh4AVAq5OX7ZJM
         8iD+ylvAc9hq2oAEXs/7ReqValj4Eln1UiErT4wuC0bHEWGlRs04Ikl13lbvbresYEts
         sKL+f4yHgN9AxRNv3fvPk1mnR5fNh9J20SxzOEXZSIZibA+ZNLSAponUFnymjtFdhwNb
         E6YZYUXWbu/YthMC0laqhe7S9VHJ8wZjpyfd6SICISVTMTvJ8F1lk5BP8uDbeR9peZQ9
         CFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xGuWagvHkR5CzPo1CRVJNp1xS36Ei3NsxHAn9Qc6w5w=;
        b=e7r+C2ST9nuMS6KSz70Miwdrg1ACJ0+th7hWbNcObQPpj9IGkEcKOBM/CK+wmgRlIm
         5SjO4lBW/itSsoGz6TnZcdxX3Vb3BIhjD2bNoOrSNRjryp6F1l2J70pYj9WHYW/6GwC0
         BlhoACuU7jqVymjIJASobi84Bq5R+VLaiK51rFeD36NElZjOt2PWiBmWM8QiO79Lvt6p
         NFu5Sv5sgARi6TQEKcfknxFDVfGpAvjAYGJGrFQ4jR7wGSe3n79QlgT9padVFTXGNCuO
         5zWkKRiTi3Gv191Vrh0yRdqHiPXgZg3r+XlYWplWizoslJ+smHVdiKLSlHzzKHkDKFO4
         CEAg==
X-Gm-Message-State: AOAM533B/uQ5kngU0ol6dETKMWggVX33DtVKcYC76M0pdWQ+rIC+MCp1
        ofG9U4M5WPZF+TCIZhpwsstebA==
X-Google-Smtp-Source: ABdhPJwppCorQbCpUQGKifbVA2gARZbO1wdWdyRTreqjCiFRT7SQ5iqEUtlUzbrx4RUAnkHkA5UfPA==
X-Received: by 2002:a5d:61c6:: with SMTP id q6mr4518545wrv.282.1592486864043;
        Thu, 18 Jun 2020 06:27:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id a16sm3562843wrx.8.2020.06.18.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:27:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-gxl-s805x: reduce initial Mali450 core frequency
Date:   Thu, 18 Jun 2020 15:27:37 +0200
Message-Id: <20200618132737.14243-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When starting at 744MHz, the Mali 450 core crashes on S805X based boards:
 lima d00c0000.gpu: IRQ ppmmu3 not found
 lima d00c0000.gpu: IRQ ppmmu4 not found
 lima d00c0000.gpu: IRQ ppmmu5 not found
 lima d00c0000.gpu: IRQ ppmmu6 not found
 lima d00c0000.gpu: IRQ ppmmu7 not found
 Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.2+ #492
 Hardware name: Libre Computer AML-S805X-AC (DT)
 pstate: 40000005 (nZcv daif -PAN -UAO)
 pc : lima_gp_init+0x28/0x188
 ...
 Call trace:
  lima_gp_init+0x28/0x188
  lima_device_init+0x334/0x534
  lima_pdev_probe+0xa4/0xe4
 ...
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Reverting to a safer 666Mhz frequency on the S805X that doesn't use the
GP0 PLL makes it more stable.

Fixes: fd47716479f5 ("ARM64: dts: add S805X based P241 board")
Fixes: 0449b8e371ac ("arm64: dts: meson: add libretech aml-s805x-ac board")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  |  2 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |  2 +-
 .../boot/dts/amlogic/meson-gxl-s805x.dtsi     | 24 +++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 6a226faab183..9e43f4dca90d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -10,7 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/meson-aiu.h>
 
-#include "meson-gxl-s905x.dtsi"
+#include "meson-gxl-s805x.dtsi"
 
 / {
 	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index 867e30f1d62b..eb7f5a3fefd4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -9,7 +9,7 @@
 
 #include <dt-bindings/input/input.h>
 
-#include "meson-gxl-s905x.dtsi"
+#include "meson-gxl-s805x.dtsi"
 
 / {
 	compatible = "amlogic,p241", "amlogic,s805x", "amlogic,meson-gxl";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi
new file mode 100644
index 000000000000..f9d705648426
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gxl-s905x.dtsi"
+
+/ {
+	compatible = "amlogic,s805x", "amlogic,meson-gxl";
+};
+
+/* The S805X Package doesn't seem to handle the 744MHz OPP correctly */
+&mali {
+	assigned-clocks = <&clkc CLKID_MALI_0_SEL>,
+			  <&clkc CLKID_MALI_0>,
+			  <&clkc CLKID_MALI>; /* Glitch free mux */
+	assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
+				 <0>, /* Do Nothing */
+				 <&clkc CLKID_MALI_0>;
+	assigned-clock-rates = <0>, /* Do Nothing */
+			       <666666666>,
+			       <0>; /* Do Nothing */
+};
-- 
2.22.0

