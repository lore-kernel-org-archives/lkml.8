Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A2C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4214221F7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doXg7c2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSFxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:53:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD28C061A0C;
        Sat, 18 Apr 2020 22:53:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so6381402ljg.5;
        Sat, 18 Apr 2020 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETRJ8mYOQ9yujZCmmqXpwwej2/FIPoryFM9Z1P/Qlt4=;
        b=doXg7c2ioYYkK4WQWUgxwqfnC7y2oLopTk782suwNGNXZ0e7YECuLuH2BXq+6ZPgii
         S6cwZkCRxikfxD7Xqvv8gidbuAvo0P4hWDBIPYgJhqmFpOYlo+HtrOhrFCtoirYr59FT
         KWAErbGNxbllP5le9+rfK/vIHOhTjG0FEs2g3D3PIadq7Dl+3ywFMt5JDKt07zhqODJb
         VPxDq2Gz1RetdyOB7gG/aoR9ARiVrg6PkCL398UN57t/fFLknoQt8gY2mYR7qCKYk/hE
         PfoDt2bl2yJs2RrFXXNFeqLdVKOGa8PYT7aREueGPMA0xePcoCuEWLRiGuQRcGlDn0ZG
         JBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ETRJ8mYOQ9yujZCmmqXpwwej2/FIPoryFM9Z1P/Qlt4=;
        b=grFUTjgvqCtlIkVR1UaDbPiVBXbJmB9BgC4R+Y4ORiVg7WtzXCieQVNNDA1BPqAjJw
         sXONciVi5WYLmc6THlBRHg7HmW95MLu1DbdCDzyekaazZxVRPp/5nkU1X3jVvenCLUen
         zFo9/CKaAsbq7rUvLpPlbweWdlpqD0igUBp/XJB3GXQrip3UJ9W5qab8zFl8idDatlR5
         RLwAmdw8WIX/bc+iGiVX/kxAikbDKp5lA9mKn3Ug5I27IP9L2HIoVmrpIPYAv+XmXeYe
         dgu4xFm3LSn76b4tiZfTfMopR0mVyVE48RtMn2P3ncmwGlMT5oVWb5858LhrzUZHR9Y3
         c3KA==
X-Gm-Message-State: AGi0PuYAAF+h4+4ctOHmvZv8H/nk6Xp17z87f+lc2lGAc9tJGJI8dTBx
        +aRUwV33qCOu1WNVWIvMrOg=
X-Google-Smtp-Source: APiQypIpk5R47A7gcnVm6RNFywZg4lAADQNzbBgdyL8UkwtSc5G/cscsnrcEghuNWSwMncxxIZzIBQ==
X-Received: by 2002:a2e:b889:: with SMTP id r9mr2631829ljp.203.1587275611832;
        Sat, 18 Apr 2020 22:53:31 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h7sm3366247ljg.37.2020.04.18.22.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:53:31 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/4] arm64: dts: meson-g12b-gtking: add initial device-tree
Date:   Sun, 19 Apr 2020 05:53:20 +0000
Message-Id: <20200419055322.16138-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419055322.16138-1-christianshewitt@gmail.com>
References: <20200419055322.16138-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

- 4GB LPDDR4 RAM
- 64GB eMMC storage
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- HDMI 2.1 video
- S/PDIF optical output
- Analogue audio output
- 1x USB 2.0 port
- 2x USB 3.0 ports
- IR receiver
- 1x micro SD card slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile             |  1 +
 .../arm64/boot/dts/amlogic/meson-g12b-gtking.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index eef0045320f2..1fd28e84e808 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
new file mode 100644
index 000000000000..461da47ed463
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (c) 2019 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-w400.dtsi"
+#include "meson-g12-audio-hdmi-spdif.dtsi"
+
+/ {
+	compatible = "azw,gtking", "amlogic,g12b";
+	model = "Beelink GT-King";
+};
-- 
2.17.1

