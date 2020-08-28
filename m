Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D0C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DC62080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aSHLmvQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgH1BMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9885 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgH1BL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:11:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4859640001>; Thu, 27 Aug 2020 18:09:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 18:11:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 18:11:58 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 01:11:55 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 01:11:55 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4859d80000>; Thu, 27 Aug 2020 18:11:54 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 01/12] clk: tegra: Add PLLE HW power sequencer control
Date:   Fri, 28 Aug 2020 09:10:45 +0800
Message-ID: <20200828011056.1067559-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828011056.1067559-1-jckuo@nvidia.com>
References: <20200828011056.1067559-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598576996; bh=z9aKw1vyHrzjJiun8JEcoFXSJ50fQe9EfkdaKJIYd9U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=aSHLmvQRMK82RBen91xzSUpEy7rFZA38MPvC1aZnKNq9iXJQUtMjnRM42l5NpGIC4
         QOx5d6guECBSf8yB8eApZnQotsjFgI6Frk/zjNV2Sh14G67N0Wfy5w9nDR9PylcIvn
         8lusAPNOlP7P+lgmZaKMmMRiYuAAwjWh2AcplXDbkjy8buUzOS95JVJRhiWztXsNJG
         hl2j2EOvpnZpcljZlehejJpMKci4heNnQhpEwGxZwTVP1xnXskZgTQ6fSOPWBBYAwz
         DQOVHfDECKMQZwjs9mgJBC8aDaOOS6kSguEbW+/N7/I5uBcjHcpTt0R99+KVB5C+/Z
         sYSHYPQ6poyhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLLE has a hardware power sequencer logic which is a state machine
that can power on/off PLLE without any software intervention. The
sequencer has two inputs, one from XUSB UPHY PLL and the other from
SATA UPHY PLL. PLLE provides reference clock to XUSB and SATA UPHY
PLLs. When both of the downstream PLLs are powered-off, PLLE hardware
power sequencer will automatically power off PLLE for power saving.

XUSB and SATA UPHY PLLs also have their own hardware power sequencer
logic. XUSB UPHY PLL is shared between XUSB SuperSpeed ports and PCIE
controllers. The XUSB UPHY PLL hardware power sequencer has inputs
from XUSB and PCIE. When all of the XUSB SuperSpeed ports and PCIE
controllers are in low power state, XUSB UPHY PLL hardware power
sequencer automatically power off PLL and flags idle to PLLE hardware
power sequencer. Similar applies to SATA UPHY PLL.

PLLE hardware power sequencer has to be enabled after both downstream
sequencers are enabled.

This commit adds two helper functions:
1. tegra210_plle_hw_sequence_start() for XUSB PADCTL driver to enable
   PLLE hardware sequencer at proper time.

2. tegra210_plle_hw_sequence_is_enabled() for XUSB PADCTL driver to
   check whether PLLE hardware sequencer has been enabled or not.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/clk/tegra/clk-tegra210.c | 51 ++++++++++++++++++++++++++++++++
 include/linux/clk/tegra.h        |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra=
210.c
index 68cbb98af567..255de6c23c67 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -403,6 +403,14 @@ static unsigned long tegra210_input_freq[] =3D {
 #define PLLRE_BASE_DEFAULT_MASK		0x1c000000
 #define PLLRE_MISC0_WRITE_MASK		0x67ffffff
=20
+/* PLLE */
+#define PLLE_MISC_IDDQ_SW_CTRL		(1 << 14)
+#define PLLE_AUX_USE_LOCKDET		(1 << 3)
+#define PLLE_AUX_SS_SEQ_INCLUDE		(1 << 31)
+#define PLLE_AUX_ENABLE_SWCTL		(1 << 4)
+#define PLLE_AUX_SS_SWCTL		(1 << 6)
+#define PLLE_AUX_SEQ_ENABLE		(1 << 24)
+
 /* PLLX */
 #define PLLX_USE_DYN_RAMP		1
 #define PLLX_BASE_LOCK			(1 << 27)
@@ -489,6 +497,49 @@ static unsigned long tegra210_input_freq[] =3D {
 #define PLLU_MISC0_WRITE_MASK		0xbfffffff
 #define PLLU_MISC1_WRITE_MASK		0x00000007
=20
+bool tegra210_plle_hw_sequence_is_enabled(void)
+{
+	u32 val;
+
+	val =3D readl_relaxed(clk_base + PLLE_AUX);
+	if (val & PLLE_AUX_SEQ_ENABLE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tegra210_plle_hw_sequence_is_enabled);
+
+int tegra210_plle_hw_sequence_start(void)
+{
+	u32 val;
+
+	if (tegra210_plle_hw_sequence_is_enabled())
+		return 0;
+
+	/* skip if PLLE is not enabled yet */
+	val =3D readl_relaxed(clk_base + PLLE_MISC0);
+	if (!(val & PLLE_MISC_LOCK))
+		return -EIO;
+
+	val &=3D ~PLLE_MISC_IDDQ_SW_CTRL;
+	writel_relaxed(val, clk_base + PLLE_MISC0);
+
+	val =3D readl_relaxed(clk_base + PLLE_AUX);
+	val |=3D (PLLE_AUX_USE_LOCKDET | PLLE_AUX_SS_SEQ_INCLUDE);
+	val &=3D ~(PLLE_AUX_ENABLE_SWCTL | PLLE_AUX_SS_SWCTL);
+	writel_relaxed(val, clk_base + PLLE_AUX);
+
+	fence_udelay(1, clk_base);
+
+	val |=3D PLLE_AUX_SEQ_ENABLE;
+	writel_relaxed(val, clk_base + PLLE_AUX);
+
+	fence_udelay(1, clk_base);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tegra210_plle_hw_sequence_start);
+
 void tegra210_xusb_pll_hw_control_enable(void)
 {
 	u32 val;
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 3f01d43f0598..7a6b29ca3040 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -123,6 +123,8 @@ static inline void tegra_cpu_clock_resume(void)
 }
 #endif
=20
+extern int tegra210_plle_hw_sequence_start(void);
+extern bool tegra210_plle_hw_sequence_is_enabled(void);
 extern void tegra210_xusb_pll_hw_control_enable(void);
 extern void tegra210_xusb_pll_hw_sequence_start(void);
 extern void tegra210_sata_pll_hw_control_enable(void);
--=20
2.25.1

