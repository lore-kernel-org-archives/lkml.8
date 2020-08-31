Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA7C2BC11
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9402B2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KW9zZ/Tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaEkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:40:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1155 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7ec80000>; Sun, 30 Aug 2020 21:38:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 30 Aug 2020 21:40:38 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:34 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:34 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f400001>; Sun, 30 Aug 2020 21:40:33 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 01/12] clk: tegra: Add PLLE HW power sequencer control
Date:   Mon, 31 Aug 2020 12:40:32 +0800
Message-ID: <20200831044043.1561074-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848713; bh=z9aKw1vyHrzjJiun8JEcoFXSJ50fQe9EfkdaKJIYd9U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=KW9zZ/Twrtu0tbtiMZVDQNGbVdAGJ1jmLJi/h8GcR0QJR+UXm3jR9500X5KNY1Ksm
         0wIY9Dj50fr00INqviIcTng7mjqmga3jvmX/081ou2uM7Lg60OA76VuwqPeAezUElJ
         tawclycg0PyTOdjD7HmKBHVJYx0l47iZViJtd+VrUiuUd28EMru6ehxteMGzXV0Prg
         bYlsLot5zIyl76NoAOVGezA0g/A6y0lE2xm2BgwPncBaQOsEaDxwLroUZ6e5J3H1gX
         JLglAobbgSwNQSN07SJdMM0IKkRikJSZTusilROahGOpc/ZS3ONeAhwMGogUn3pxMP
         3xR5vFLk6wIhg==
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

