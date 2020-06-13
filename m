Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4CC2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFMNbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:31:50 -0400
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Jun 2020 06:31:49 PDT
Received: from hera.iit.uni-miskolc.hu (hera.iit.uni-miskolc.hu [IPv6:2001:738:6001:500::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6EBC03E96F;
        Sat, 13 Jun 2020 06:31:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 3F250E31;
        Sat, 13 Jun 2020 15:23:53 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K4Kwa-7tD-1y; Sat, 13 Jun 2020 15:23:45 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:2114:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id C3265E32;
        Sat, 13 Jun 2020 15:23:31 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        JC Kuo <jckuo@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH 3/4] arm64: tegra: Configure SDIO cards on Jetson Xavier SDMMC1
Date:   Sat, 13 Jun 2020 15:22:11 +0200
Message-Id: <20200613132212.8538-4-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613132212.8538-1-tszucs@protonmail.ch>
References: <20200613132212.8538-1-tszucs@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserve SDIO card power during a suspend/resume cycle and enable wake up of
host system on SDIO IRQ assertion.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 5c40e5c7ee9c..4cf3830e37c3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -59,6 +59,8 @@
 		/* SDMMC1 (SD/MMC) */
 		sdhci@3400000 {
 			cd-gpios = <&gpio TEGRA194_MAIN_GPIO(G, 7) GPIO_ACTIVE_LOW>;
+			keep-power-in-suspend;
+			wakeup-source;
 		};
 
 		/* SDMMC4 (eMMC) */
-- 
2.20.1

