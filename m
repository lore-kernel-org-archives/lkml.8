Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAA720C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="KzmWBsLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgFPMRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgFPMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACDC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so1358958pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJ9zmkSGiRc0Ox6+pRK/p41cAOxjrOMSE4GBWh4e2nA=;
        b=KzmWBsLyrtRflUXX/4QUXLtW0xoZRVMzE6WqoqeCj9rvHhboH4mpNqEUQwemXpfJ5P
         zRz8Hfy49epMaaPMcTSVb3nJ9COZbfAVgdnlkG2QzRTePs1Vu9SCCRXKCXJisCc23dIc
         4GDMDZJStGFgU+gQfYwLi34OmyOyA2gdby97o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJ9zmkSGiRc0Ox6+pRK/p41cAOxjrOMSE4GBWh4e2nA=;
        b=HjKo/iGYFXjWL/Xe8/XzYJGL+cB97W6wKQkDOv6jsnZvtxBw8HgABiXK9d5M1p/CSK
         h+zA8fZXcnj/CM+CsyVkyxHCnSbcDS5RiZzPtMENmUPWG4nMHvGoiBmKsNSG4dt1bToS
         WBczTb9CQXLN+ibkxQEr89cv7s3IxanvNwMy/TCQrO/F9j6vjAu2k1c+lEPSLIq8e5Qg
         +udZwpUekwVqH5aikW/eGLxMhjjKZjeAqkMLPII1Vb6fWjcSOSWbv9L/WWKK+WTPbhDG
         yajvMcix0maal4YMkls9gyEPnpQFhNGpaH345rSK6lWTwa72wbpUgeMrAVauNUKIksQP
         Ry2Q==
X-Gm-Message-State: AOAM530mAUL96J4tsruywnaM+Qg8+O5/1SeQEEmuyAXTf6ayIK1Ew0Cj
        D5T1vbhMmNWr5xeX1aPipKckmw==
X-Google-Smtp-Source: ABdhPJy9kQPlGP5pMTXQtzWTqqIdiaj6kCIdrlt0fhTqMmsXUccVucFaZuqu8O9Gc3DZ6FeV5o1ywQ==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr2520556pjb.121.1592309847849;
        Tue, 16 Jun 2020 05:17:27 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:27 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 08/12] ARM: mstar: Add Armv7 base dtsi
Date:   Tue, 16 Jun 2020 21:15:21 +0900
Message-Id: <20200616121525.1409790-9-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial dtsi for the base MStar/Sigmastar Armv7 SoCs.

These SoCs have very similar memory maps and this will avoid
duplicating nodes across multiple dtsis.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                     |  1 +
 arch/arm/boot/dts/mstar-v7.dtsi | 83 +++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d31bc749f6d..54a2fc60a1d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2123,6 +2123,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
+F:	arch/arm/boot/dts/mstar-v7.dtsi
 F:	arch/arm/mach-mstar/
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
new file mode 100644
index 000000000000..3b99bb435bb5
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+		};
+	};
+
+	arch_timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>;
+		/*
+		 * we shouldn't need this but the vendor
+		 * u-boot is broken
+		 */
+		clock-frequency = <6000000>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x16001000 0x16001000 0x00007000>,
+			 <0x1f000000 0x1f000000 0x00400000>;
+
+		gic: interrupt-controller@16001000 {
+			compatible = "arm,cortex-a7-gic";
+			reg = <0x16001000 0x1000>,
+			      <0x16002000 0x2000>,
+			      <0x16004000 0x2000>,
+			      <0x16006000 0x2000>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2)
+					| IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		riu: bus@1f000000 {
+			compatible = "simple-bus";
+			reg = <0x1f000000 0x00400000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x1f000000 0x00400000>;
+
+			l3bridge: l3bridge@204400 {
+				compatible = "mstar,l3bridge";
+				reg = <0x204400 0x200>;
+			};
+
+			pm_uart: uart@221000 {
+				compatible = "ns16550a";
+				reg = <0x221000 0x100>;
+				reg-shift = <3>;
+				clock-frequency = <172000000>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.27.0.rc0

