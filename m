Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA199C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1DF2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="mALVDJ6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGJJqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgGJJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DDC08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so2303208pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pDz2TpZy1zmfAx6/NkVRBj4zipinWZWDx5iDp7nNH0k=;
        b=mALVDJ6hW3iO+9paBDlxCPKPfTS1rs8Gew6dvpyxsjklewOSVK5rqn5uw5is0ojk0z
         SaRVpostKoq7BhRcb0q1J+IoxcRcEmmbtB05Jk3S9mq8hJ5V+WNBC9JTBpYsnwuz0ELp
         4jr4UY1p/g5N0n4SwT01zEer8rxcPTi6omYLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDz2TpZy1zmfAx6/NkVRBj4zipinWZWDx5iDp7nNH0k=;
        b=qIO3kPoGZttSd13BxdbvU96Wl14f74fRBhzd+cBqf17Se+TJvi2bsCTSD6WaQe5p7l
         RqXPuIVPjq8rNox3SjmxtMg76KN43aUkwMJi4lgB822jBp5jiI9XOt9eHYijeHux3EVn
         +siNlG0MpqJnpiekwwn1I3Fdxj3N8uUNN1xYk7u/Ys60aeK7s5uLLCU1UB6IHiNB55xG
         25IaSkwsQpOzjQViWvoRbYIdPKM3JxY+zPeGwvl4QOcJzqKrCHFTDJ+hMdGLqaQ2JWU+
         +G6ZrOrOvsYPTsjP6Arn56nuEDTUTTPc+iN56iskEsd/9Wz2kH8gW6CBbqXfRRaL9siH
         eh4w==
X-Gm-Message-State: AOAM533r4COYOxVcyYEeQIjgjDNCYPc6+PXyjzk5LuvCH0QInXEY6YA8
        0WQGS1my2e7077DxdMDM2wVorQ==
X-Google-Smtp-Source: ABdhPJzUaZWsRMUYEFVlrFXNNJm/xAZDsRja0JUv2X4wueXa06UaLK3zhTGDRo1r7cyPkH7uHJZWMw==
X-Received: by 2002:a63:e241:: with SMTP id y1mr36353854pgj.410.1594374389454;
        Fri, 10 Jul 2020 02:46:29 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:28 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v5 09/12] ARM: mstar: Add infinity/infinity3 family dtsis
Date:   Fri, 10 Jul 2020 18:45:41 +0900
Message-Id: <20200710094544.430258-10-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two family level dtsis for the infinity and infinity3
and then adds a chip level dtsi each for a chip in those families.

infinity3.dtsi includes infinity.dtsi as these SoCs share most of
their memory map and we would have a lot of duplication otherwise.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                              |  1 +
 arch/arm/boot/dts/infinity-msc313.dtsi   | 14 ++++++++++++++
 arch/arm/boot/dts/infinity.dtsi          |  7 +++++++
 arch/arm/boot/dts/infinity3-msc313e.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/infinity3.dtsi         |  7 +++++++
 5 files changed, 43 insertions(+)
 create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
 create mode 100644 arch/arm/boot/dts/infinity.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c277fa629fd..cb8a6b414312 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2123,6 +2123,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
+F:	arch/arm/boot/dts/infinity*.dtsi
 F:	arch/arm/boot/dts/mstar-v7.dtsi
 F:	arch/arm/mach-mstar/
 
diff --git a/arch/arm/boot/dts/infinity-msc313.dtsi b/arch/arm/boot/dts/infinity-msc313.dtsi
new file mode 100644
index 000000000000..42f2b5552c77
--- /dev/null
+++ b/arch/arm/boot/dts/infinity-msc313.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "infinity.dtsi"
+
+/ {
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infinity.dtsi
new file mode 100644
index 000000000000..f68e6d59c328
--- /dev/null
+++ b/arch/arm/boot/dts/infinity.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-v7.dtsi"
diff --git a/arch/arm/boot/dts/infinity3-msc313e.dtsi b/arch/arm/boot/dts/infinity3-msc313e.dtsi
new file mode 100644
index 000000000000..4e7239afd823
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3-msc313e.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "infinity3.dtsi"
+
+/ {
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/infinity3.dtsi b/arch/arm/boot/dts/infinity3.dtsi
new file mode 100644
index 000000000000..2830d064c07d
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "infinity.dtsi"
-- 
2.27.0

