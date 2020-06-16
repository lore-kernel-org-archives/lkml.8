Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7D220B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="sqZtwnwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgFPMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgFPMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DDC08C5C7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so1362841pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QNIUikvD5iyxTHk1gYVBrR3ob0+R8+y+UhbZ9LC4HI=;
        b=sqZtwnwS2+hl5HB/Mtw0ss6MLDu3pD5SAEXhwXuKc6aC9vARfDQdEN0CUoXI/7yvYD
         Ccb0NnHubg8xNdj0m7nhkSA4x/3EgrgoCWpfekQUS0sNLEMmxLroGM85ztzkKVaNV0TX
         sV+C8/Ce5iG2ZZOTrWkG5T7/QVFkFT/0xetmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QNIUikvD5iyxTHk1gYVBrR3ob0+R8+y+UhbZ9LC4HI=;
        b=UqnGqdJw6BdCZj6g2KZIbaYgwnytnas1P8jBecvg4dC2vVeE4es+EjBS1n7yoYSxih
         JwnjotANURXjjqb2En7bkHQppNKO34uyroKXve6sEsqY9QOOyF3Tk8rOCg77/q8lKTMG
         mv9jj69bW7+r8S4izdwslLXmgsphuPds85XZ+RBltLnLi9tuBitk7TAqFE85h32xUE1t
         lO0ipIBKBsjsNfp+PPgD85gEl5RW+nBQgDFTmiVfmOj+Z9fem9Kf960byJUjYn9av7sQ
         dHxJeL4gu3T+g816+80Y4ey1yXG80Ta5tcl4mSjGH6+/q1+In/Jfd97mLIKJvs6jAnt2
         VzoA==
X-Gm-Message-State: AOAM530A2Uj1ln0tMNUjW/ad2+P2JT/rNzXGAUnZeByDr1TXd01lVhGp
        n4lmWnnYU5boHDRV4ATmJRg+cw==
X-Google-Smtp-Source: ABdhPJxkj1vvamQcbIq+GbZ7IKqORIqDltS0mXIbcsskYSDbh4JsuwGjaXSV6NAfNX1aQkC3UrPE8w==
X-Received: by 2002:a17:90a:bf14:: with SMTP id c20mr2584276pjs.228.1592309852364;
        Tue, 16 Jun 2020 05:17:32 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:31 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 10/12] ARM: mstar: Add mercury5 series dtsis
Date:   Tue, 16 Jun 2020 21:15:23 +0900
Message-Id: <20200616121525.1409790-11-daniel@0x0f.com>
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

This adds a family level dtsi for the mercury5 and then a
chip level dtsi for the ssc8336n chip.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                              |  1 +
 arch/arm/boot/dts/mercury5-ssc8336n.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/mercury5.dtsi          |  7 +++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c152e29877d..f0a2b7b3c0b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2124,6 +2124,7 @@ S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
 F:	arch/arm/boot/dts/infinity*.dtsi
+F:	arch/arm/boot/dts/mercury*.dtsi
 F:	arch/arm/boot/dts/mstar-v7.dtsi
 F:	arch/arm/mach-mstar/
 
diff --git a/arch/arm/boot/dts/mercury5-ssc8336n.dtsi b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
new file mode 100644
index 000000000000..7d4a4630c25c
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mercury5.dtsi"
+
+/ {
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercury5.dtsi
new file mode 100644
index 000000000000..f68e6d59c328
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-v7.dtsi"
-- 
2.27.0.rc0

