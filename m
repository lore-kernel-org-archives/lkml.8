Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347DC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CA9207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBRWLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:11:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33895 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:11:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id c20so21184081qkm.1;
        Tue, 18 Feb 2020 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SexCyhtG++Ew70oYHNDjxWHTtm2YNgcLBPVDPrQlosM=;
        b=M6WgOTSsB2eroVtH/gNW4Np4t84zmB52a5fVaCOmSnLGmkgoqlQUQmPn/mJnfXB7v+
         EPwEJHZBvPqa6i9u9VpItKK06JobPftiaVM4Kdrvrlup7tV2iJy78hen7Msb6c295mNc
         Skok3pKk1n8R3mUPYXW2L3NpmyfHoUgB2qN1gwhR7t2sSHnVxyC6GO+ofGYAKss/SXWh
         gUuKke+mMbfYYDIrxBI7ACN+cKWBVgsSo2eyhZzFsOurffhRw5VhW00p3vlZS4je2BZU
         kH80heuV3N5tobDmudFrcIieMj2d4BnWj2TpwEAU4aiW8JdEk2Qxttx2oGtY0CA1ydDu
         YOYQ==
X-Gm-Message-State: APjAAAXJIHeyechw2FWNLWCoRlLt2yc1DKUT+OoFtRJXU9t4G77KWP1L
        AWL8cmnjer1zx/UzeHQy8Bw=
X-Google-Smtp-Source: APXvYqxAuVhE9JWncGZiB96oj6NDqmFr+ATZc2mDIOV3mzx6dygSFAZoH1yla2lHQqbOeZ0xxJtJAQ==
X-Received: by 2002:a37:6197:: with SMTP id v145mr20336585qkb.443.1582063895017;
        Tue, 18 Feb 2020 14:11:35 -0800 (PST)
Received: from localhost.localdomain (189-18-27-64.dsl.telesp.net.br. [189.18.27.64])
        by smtp.googlemail.com with ESMTPSA id 85sm5415qko.49.2020.02.18.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 14:11:34 -0800 (PST)
From:   Carlos de Paula <me@carlosedp.com>
Cc:     papadakospan@gmail.com, jose.abreu@synopsys.com,
        Carlos de Paula <me@carlosedp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Peter Geis <pgwipeout@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add txpbl node for RK3399/RK3328
Date:   Tue, 18 Feb 2020 17:10:37 -0500
Message-Id: <20200218221040.10955-1-me@carlosedp.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some rockchip SoCs like the RK3399 and RK3328 exhibit an issue
where tx checksumming does not work with packets larger than 1498.

The default Programmable Buffer Length for TX in these GMAC's is
not suitable for MTUs higher than 1498. The workaround is to disable
TX offloading with 'ethtool -K eth0 tx off rx off' causing performance
impacts as it disables hardware checksumming.

This patch sets snps,txpbl to 0x4 which is a safe number tested ok for
the most popular MTU value of 1500.

For reference, see https://lkml.org/lkml/2019/4/1/1382.

Signed-off-by: Carlos de Paula <me@carlosedp.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 1f53ead52c7f..b7f1de4b7fd0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -906,6 +906,7 @@
 		resets = <&cru SRST_GMAC2IO_A>;
 		reset-names = "stmmaceth";
 		rockchip,grf = <&grf>;
+		snps,txpbl = <0x4>;
 		status = "disabled";
 	};
 
@@ -913,6 +914,7 @@
 		compatible = "rockchip,rk3328-gmac";
 		reg = <0x0 0xff550000 0x0 0x10000>;
 		rockchip,grf = <&grf>;
+		snps,txpbl = <0x4>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq";
 		clocks = <&cru SCLK_MAC2PHY_SRC>, <&cru SCLK_MAC2PHY_RXTX>,
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 33cc21fcf4c1..cd5415d7e559 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -288,6 +288,7 @@
 		resets = <&cru SRST_A_GMAC>;
 		reset-names = "stmmaceth";
 		rockchip,grf = <&grf>;
+		snps,txpbl = <0x4>;
 		status = "disabled";
 	};
 
-- 
2.20.1

