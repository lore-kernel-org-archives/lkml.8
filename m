Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D0920786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="RydD085p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGJJqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgGJJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45258C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2316983pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiSZdtFwKwHNBZOweoCEZNTpFyXOI2NF01y7ZbXZOTk=;
        b=RydD085pKT0b9+NpuJwO0tdgshoGEZNx/AhEt5n3kfl3cx2WJzywCcdnPTvGFULF72
         961lMEHFVczSkaV0F9k6rewCArn58gmhZKIdjKpVy75CqyS+U/B6LQ1Bcb/Tk4ryvAUi
         NxkiAOIALY02FUQJmiGhG3fmJ1IbCNgCNK3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiSZdtFwKwHNBZOweoCEZNTpFyXOI2NF01y7ZbXZOTk=;
        b=aHkYt5DY87Kf0uyN5zVCzVANPSNS3T++rxJG/k+OQmVtAyBufwE6D08wxHFKwdi8OM
         H6uiI0tH9nK8Kf/on6ikMb1jNP2ytIJT3qtnd4ErpZUnOCY1lqrmYstPyQ3htwYhjt1T
         vzHaVt1gWLi/0VQKI4OIWAKHiCRhbrAzgKXAnbSw/XZ419FqzBDcu2Wulev9hBC59sb2
         durJA5ajaP8qJ8ZH1GdvrMoLAYtK5uLttufpaVKjMa1CiPucWr+2KPPH9hFAi+3OQgKv
         sYVldJsAz2imHeF6oFKL1u/gw4yVhHF/LogwL9O4S25fTeUi27qj0bjMRvw27lFDOncQ
         lr2A==
X-Gm-Message-State: AOAM531SMn61GqKx3kim5hlOWIEvQYXiv93emOTbUXJmq85Dkd7ZcO3y
        drOVL3jImFqUAkXYx6FJgYj7yw==
X-Google-Smtp-Source: ABdhPJxRLK+HF3RoRsHoDJrpSwyCcu6NSk63Rd02qQcNLWwyf9MKQPlLn3+V8DlqwpidZkcVz/hs6w==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr59035011pgi.0.1594374398814;
        Fri, 10 Jul 2020 02:46:38 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:38 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v5 12/12] ARM: mstar: Add dts for 70mai midrive d08
Date:   Fri, 10 Jul 2020 18:45:44 +0900
Message-Id: <20200710094544.430258-13-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial support for the 70mai midrive d08 dash camera.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  3 ++-
 .../boot/dts/mercury5-ssc8336n-midrived08.dts | 25 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4a5f8075a4f6..35c7ecc52c60 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1344,7 +1344,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	infinity-msc313-breadbee_crust.dtb \
-	infinity3-msc313e-breadbee.dtb
+	infinity3-msc313e-breadbee.dtb \
+	mercury5-ssc8336n-midrive08.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts b/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
new file mode 100644
index 000000000000..f24bd8cb8e60
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mercury5-ssc8336n.dtsi"
+
+/ {
+	model = "70mai Midrive D08";
+	compatible = "70mai,midrived08", "mstar,mercury5";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.27.0

