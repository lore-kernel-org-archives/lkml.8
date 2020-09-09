Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6DC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11F021D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XhuVPjNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIIILA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:11:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11975 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgIIIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:10:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588dfd0000>; Wed, 09 Sep 2020 01:10:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:10:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 01:10:50 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:10:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:10:47 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e050000>; Wed, 09 Sep 2020 01:10:47 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 01/15] clk: tegra: Add PLLE HW power sequencer control
Date:   Wed, 9 Sep 2020 16:10:27 +0800
Message-ID: <20200909081041.3190157-2-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599639037; bh=IAEzbl+SzvO/z/0Woj6WCtxnqj0JWqFlSliqV8z6ucM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=XhuVPjNQrGuhfDRLwGlKo7g/gAbi0rt4lcMOBKC3Peh+mzh0EuMAcm9n08C45j9yx
         xx50twvIOIOCkEkwp9DdiLr/JkxIjdNPcD7CAy4GpjzKfeQ6xMMpUvOlEEW4EQY2yY
         RzECSedd2N1nR329eV/MaBJzjSm49XiEEuvCf4saML7c/rNbsTCg1phcsEYvoC5/wh
         jjW6vTCN2DJsgQj8JA3Z+oF37hWiXCVpaTIrh96LqKBJs5s0fkg2fMrPSNzoA1RItd
         A3uz+beIsAt6u/fVEjM7orZ04VZvPFH4LVEa6Aw+C+a6ruVEZ0ZVc0MTHeRoCS7OKf
         SFX+1h78oSbjA==
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
v3:
   rename 'val' with 'value

 drivers/clk/tegra/clk-tegra210.c | 51 ++++++++++++++++++++++++++++++++
 include/linux/clk/tegra.h        |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra=
210.c
index 68cbb98af567..a91bf9b9be7a 100644
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
+	u32 value;
+
+	value =3D readl_relaxed(clk_base + PLLE_AUX);
+	if (value & PLLE_AUX_SEQ_ENABLE)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tegra210_plle_hw_sequence_is_enabled);
+
+int tegra210_plle_hw_sequence_start(void)
+{
+	u32 value;
+
+	if (tegra210_plle_hw_sequence_is_enabled())
+		return 0;
+
+	/* skip if PLLE is not enabled yet */
+	value =3D readl_relaxed(clk_base + PLLE_MISC0);
+	if (!(value & PLLE_MISC_LOCK))
+		return -EIO;
+
+	value &=3D ~PLLE_MISC_IDDQ_SW_CTRL;
+	writel_relaxed(value, clk_base + PLLE_MISC0);
+
+	value =3D readl_relaxed(clk_base + PLLE_AUX);
+	value |=3D (PLLE_AUX_USE_LOCKDET | PLLE_AUX_SS_SEQ_INCLUDE);
+	value &=3D ~(PLLE_AUX_ENABLE_SWCTL | PLLE_AUX_SS_SWCTL);
+	writel_relaxed(value, clk_base + PLLE_AUX);
+
+	fence_udelay(1, clk_base);
+
+	value |=3D PLLE_AUX_SEQ_ENABLE;
+	writel_relaxed(value, clk_base + PLLE_AUX);
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

