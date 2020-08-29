Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A21C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1DA206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Lj+3HmpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH2QA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgH2P7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:59:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FDFC0619C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:59:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g207so2218920pfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7Lva39pftBA6FEqjewb6eW+oOxMNUrFl3pdrz2HNEg=;
        b=Lj+3HmpEyxK4ys5SQafUdoDlyn05BgUs9LT198QYBWv66qQJuc9nUM/hZ1RjDEcsQN
         GeBUtxjbZpZ4lCuc2rHCY3ccleQ9JP2YJMCm3Igj5oGHVemhQfjADw3g3DJkwJqLbB2k
         gLeY7OaYguCEvySyiJJyc4PGcJ+yCFRWAt0gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7Lva39pftBA6FEqjewb6eW+oOxMNUrFl3pdrz2HNEg=;
        b=J061r5gzJBKOcTajKn//pytVnN+TZWt+KvdjnHXXDNuo4kGWfewYejqWIL9jJpS368
         UFnK4UygomQP1pe5CEojhRPIi1loSfX8Dp3OdfxYPQ0NKEReL2I+3DHrLMlS4IJtxRNN
         +YwyJdpbn6DCkVVa8NJu9YVsqiVZvtQYHvoXdyvdYLwDdYOcBjMxsz2ozRH0NNzdmZfM
         1m5dFd0zOtcVWcp71cmd982kgmL9Natt1FumoUi3ZRrshkZI6xXqMgVHbhqBrjhxiHHq
         +Xm0iKe63AR7kJd7cGEeWTl66ppO/wVUot1fxYj6r+To3CVBbU5kZCO/1+mhjqqJmncM
         qyIg==
X-Gm-Message-State: AOAM533wPYQ84rYcP6NFIAu0zsZVL1nXhi4h4MwT4MY6EbEHQWs/RhnW
        SeiB1PtuI/fbXxART1QFEHfRdQ==
X-Google-Smtp-Source: ABdhPJyd8r4VaGADPnKOn7M4yhYbeTP6dpEXeeSTpkNjRRZLUrB2zIAkjxL/cFsY6DjyI9ZZiyhwBA==
X-Received: by 2002:a63:4621:: with SMTP id t33mr2948882pga.32.1598716741018;
        Sat, 29 Aug 2020 08:59:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:59:00 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@libreplatforms.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 7/7] arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
Date:   Sat, 29 Aug 2020 21:28:23 +0530
Message-Id: <20200829155823.247360-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@libreplatforms.com>

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

PX30.Core needs to mount on top of this Carrier board for creating
complete PX30.Core C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/px30-px30-core-ctouch2.dts   | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 65116fcb7368..958eb57e403a 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts b/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
new file mode 100644
index 000000000000..dffc49348f28
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
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
+#include "px30-engicam-ctouch2.dtsi"
+#include "px30-px30-core.dtsi"
+
+/ {
+	model = "Engicam PX30.Core C.TOUCH 2.0";
+	compatible = "engicam,px30-core-ctouch2", "engicam,px30-px30-core",
+		     "rockchip,px30";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+};
-- 
2.25.1

