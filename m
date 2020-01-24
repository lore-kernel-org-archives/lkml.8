Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E39C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5B6214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYSolAY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbgAXQac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgAXQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2724357wru.3;
        Fri, 24 Jan 2020 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7CT1HFdVWS9Kqks9wgmn9tKbM4f7DejmQgot2NDLU84=;
        b=WYSolAY6S4WbAez6asDGNrvm9HWgMKgD/rmvi4wHu+pRvN1EmwWnClM+acTJRDPSbr
         uC/nEOUK2eOmah6Q5Ax3HR6Z0vD8Z/MJK6ZIarCt8SJ21BYk3xMJQVol58N2H9M4yYWV
         ZYSxlCb6uygXUNcrZ1Hq/Dn40sXJIqtKJva4FYKm+WGae/dwIQmXBCLu6EdNlhfYGHiC
         axm5UX7P47U0IMyBEXovcN+BcrqbQTMY4gucmaWYL+XtOdp3Vvyans5wjgCljtyqrWfs
         snRj2BRdfiAQ/jyXUtZ64s9+pcu3Od76Dr8JFuGpYquqPWvD9Z71cxV47zHjijNejWdy
         iyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7CT1HFdVWS9Kqks9wgmn9tKbM4f7DejmQgot2NDLU84=;
        b=gnUFVZIowmcSdKV4qlNAgarTfIQWeyEi8HahoAEC66/IfC3CD7eb9I9xU8C9i0fRbz
         0asS9hpMD3D8vm6QT/sPscF2ohfnDwrO6ihFUUDN5kj5WPeoHj+vpWqPYcvaLU7iShEM
         bZa/ttuiAkpZYPNjEmZiXhnUNUlXqGwj0+ExnNiSuqWB+scw+zBKBWsOzwGz6l4rZAvV
         OrL0Pt2LGdLF6VsQ4e5m9cHermc+s5xIoo2vYBzGBfsLo27v74xi96fOvPKzLLI4rJAV
         oKudf7euR9gep43tQy5t2BRvcTibgerBEjPauPZxDMaL/SPGymzT3PzNxJcDGxkUXeoI
         j59g==
X-Gm-Message-State: APjAAAWXn9frtQTW5gTHNL1UfnMdwNCqRyzGX6ORU8Ft9SJH2xZVxvJq
        8khqvVMwg1I+gAap6kTAivTTiQgN
X-Google-Smtp-Source: APXvYqyReDgSFOPL1dqk0NxO2V+Xd5blLAgfHdZ6znaq9ryVBBfkZGn9OJywGm8Dwc8e09qhMr7jZQ==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr4951928wrs.376.1579883421174;
        Fri, 24 Jan 2020 08:30:21 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 09/10] arm64: dts: rockchip: add nandc node for rk3368
Date:   Fri, 24 Jan 2020 17:30:00 +0100
Message-Id: <20200124163001.28910-10-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyifeng <zyf@rock-chips.com>

Add nandc node for rk3368.

Signed-off-by: Zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index fd8618801..22a1feed5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -508,6 +508,15 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@ff400000 {
+		compatible = "rockchip,rk3368-nand-controller";
+		reg = <0x0 0xff400000 0x0 0x4000>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC0>, <&cru SCLK_NANDC0>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff500000 0x0 0x100>;
-- 
2.11.0

