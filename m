Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B4C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB222D00
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HU0nk8lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGWJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:02:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:02:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so2868616pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJCSwxnGk2Ssl9aVpet8CDGQoGguzrl/jiXKGzvc19M=;
        b=HU0nk8lzy9019SP8Nxp4115Sx1aNoaLg7bRyELTqpLgKO/pV9TxmtAm5IgVHYcToee
         M4TUnVcoOS1FyxpKfsASbNHoRnc3bKZRwF6MR+1RbKIcfEqoitN/qCiT9Gkqv0nT5NKG
         vo09E9SBG8LJbV9ZT0t8tKQ345PACJtc8w4t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJCSwxnGk2Ssl9aVpet8CDGQoGguzrl/jiXKGzvc19M=;
        b=OG0+/r3/vRkezWNTvZhh0UDF6nruaMjijVDYRr4CHxmp2f3zVOH8p4APwtkHpnzMCg
         l6Mhp8SlZJ/uCvNlLGjeth3knLS3ZZ+VlbRumbWxozYKN6XJncz9whiy/9RkKzJlzZjT
         O/UzDq8HHoqQTyqHABZryl2tlUGD4mkNaalM8oGLl/OoQ4kwueX5UwZfF9I0MDO05TLC
         HoTwQmChaH+PvHGnoPWKilVE8RTJOEMXeVx+98koWYiyYplpTIg87BFikQUDcpmWw75V
         TTO8gPyQJOhfznpYErOvPST2bP7m/r/72qK3rajDxK8YcXB0jq3pfLsToIJCjPH9XJkc
         mLwQ==
X-Gm-Message-State: AOAM533pkRuCg4J18/YwYm/Sl8M1hoMq6usipr8oO/24fzxho6DF19c0
        xYZPjEecB8cbzz3GsZq4rR1iGA==
X-Google-Smtp-Source: ABdhPJwL9kQ/eB8mfbD0qNXkzpBox+40LlM209FHnzSpjMSGLSH4ebLDS5lP8Jf4/LPAn4lBptNzzg==
X-Received: by 2002:a17:90a:784b:: with SMTP id y11mr161257pjl.51.1595494947770;
        Thu, 23 Jul 2020 02:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:cbf:ea0:8a30:a3af])
        by smtp.gmail.com with ESMTPSA id k23sm2319383pgb.92.2020.07.23.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 02:02:26 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/4] arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts
Date:   Thu, 23 Jul 2020 14:32:08 +0530
Message-Id: <20200723090210.41201-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723090210.41201-1-jagan@amarulasolutions.com>
References: <20200723090210.41201-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCKPi 4 has 3 variants of hardware platforms called
RockPI 4A, 4B, and 4C.

- ROCKPi 4A has no Wif/BT.
- ROCKPi 4B has AP6256 Wifi/BT, PoE.
- ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
  GPIO pin change compared to 4B, 4C

So move common nodes, properties into dtsi file and include
on respective variant dts files.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- update commit message
- add radxa,rockpi4a

 arch/arm64/boot/dts/rockchip/Makefile               |  2 +-
 .../{rk3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} |  3 ---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts  | 13 +++++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)
 rename arch/arm64/boot/dts/rockchip/{rk3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} (99%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b87b1f773083..42f9e1861461 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -33,7 +33,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
rename to arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 60f98a3e19d8..e163f438f836 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -11,9 +11,6 @@
 #include "rk3399-opp.dtsi"
 
 / {
-	model = "Radxa ROCK Pi 4";
-	compatible = "radxa,rockpi4", "rockchip,rk3399";
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
new file mode 100644
index 000000000000..89f2af5e111d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
+ */
+
+/dts-v1/;
+#include "rk3399-rock-pi-4.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi 4A";
+	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
+};
-- 
2.25.1

