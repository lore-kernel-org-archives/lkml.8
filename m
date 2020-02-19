Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846CC3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28FB222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBSHeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:11 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35204 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgBSHeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 83E06E0052;
        Wed, 19 Feb 2020 07:34:23 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZuSmbimCh_wH; Wed, 19 Feb 2020 07:34:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 42E7CE0078;
        Wed, 19 Feb 2020 07:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O_pnKxru6GZZ; Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 22A6DDFCA2;
        Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 04/10] clk: mmp2: Add support for PLL clock sources
Date:   Wed, 19 Feb 2020 08:33:47 +0100
Message-Id: <20200219073353.184336-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219073353.184336-1-lkundrak@v3.sk>
References: <20200219073353.184336-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk-of-mmp2 driver pretends that the clock outputs from the PLLs are
constant, but in fact they are configurable.

Add logic for obtaining the actual clock rates on MMP2 as well as MMP3.
There is no documentation for either SoC, but the "systemsetting" drivers
from Marvell GPL code dump provide some clue as far as MPMU registers on
MMP2 [1] and MMP3 [2] go.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-d=
ell-ariel.git/tree/drivers/char/mmp2_systemsetting.c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-d=
ell-ariel.git/tree/drivers/char/mmp3_systemsetting.c

A separate commit will adjust the clk-of-mmp2 driver.

Tested on a MMP3-based Dell Wyse 3020 as well as MMP2-based OLPC
XO-1.75 laptop.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/Makefile  |   2 +-
 drivers/clk/mmp/clk-pll.c | 139 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/mmp/clk.c     |  31 +++++++++
 drivers/clk/mmp/clk.h     |  24 +++++++
 4 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mmp/clk-pll.c

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index acc141adf087c..14dc8a8a9d087 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -8,7 +8,7 @@ obj-y +=3D clk-apbc.o clk-apmu.o clk-frac.o clk-mix.o clk=
-gate.o clk.o
 obj-$(CONFIG_RESET_CONTROLLER) +=3D reset.o
=20
 obj-$(CONFIG_MACH_MMP_DT) +=3D clk-of-pxa168.o clk-of-pxa910.o
-obj-$(CONFIG_COMMON_CLK_MMP2) +=3D clk-of-mmp2.o
+obj-$(CONFIG_COMMON_CLK_MMP2) +=3D clk-of-mmp2.o clk-pll.o
=20
 obj-$(CONFIG_CPU_PXA168) +=3D clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) +=3D clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-pll.c b/drivers/clk/mmp/clk-pll.c
new file mode 100644
index 0000000000000..7077be2938711
--- /dev/null
+++ b/drivers/clk/mmp/clk-pll.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MMP PLL clock rate calculation
+ *
+ * Copyright (C) 2020 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+
+#include "clk.h"
+
+#define to_clk_mmp_pll(hw)	container_of(hw, struct mmp_clk_pll, hw)
+
+struct mmp_clk_pll {
+	struct clk_hw hw;
+	unsigned long default_rate;
+	void __iomem *enable_reg;
+	u32 enable;
+	void __iomem *reg;
+	u8 shift;
+
+	unsigned long input_rate;
+	void __iomem *postdiv_reg;
+	u8 postdiv_shift;
+};
+
+static int mmp_clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct mmp_clk_pll *pll =3D to_clk_mmp_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->enable_reg);
+	if ((val & pll->enable) =3D=3D pll->enable)
+		return 1;
+
+	/* Some PLLs, if not software controlled, output default clock. */
+	if (pll->default_rate > 0)
+		return 1;
+
+	return 0;
+}
+
+static unsigned long mmp_clk_pll_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct mmp_clk_pll *pll =3D to_clk_mmp_pll(hw);
+	u32 fbdiv, refdiv, postdiv;
+	u64 rate;
+	u32 val;
+
+	val =3D readl_relaxed(pll->enable_reg);
+	if ((val & pll->enable) !=3D pll->enable)
+		return pll->default_rate;
+
+	if (pll->reg) {
+		val =3D readl_relaxed(pll->reg);
+		fbdiv =3D (val >> pll->shift) & 0x1ff;
+		refdiv =3D (val >> (pll->shift + 9)) & 0x1f;
+	} else {
+		fbdiv =3D 2;
+		refdiv =3D 1;
+	}
+
+	if (pll->postdiv_reg) {
+		/* MMP3 clock rate calculation */
+		static const u8 postdivs[] =3D {2, 3, 4, 5, 6, 8, 10, 12, 16};
+
+		val =3D readl_relaxed(pll->postdiv_reg);
+		postdiv =3D (val >> pll->postdiv_shift) & 0x7;
+
+		rate =3D pll->input_rate;
+		rate *=3D 2 * fbdiv;
+		do_div(rate, refdiv);
+		do_div(rate, postdivs[postdiv]);
+	} else {
+		/* MMP2 clock rate calculation */
+		if (refdiv =3D=3D 3) {
+			rate =3D 19200000;
+		} else if (refdiv =3D=3D 4) {
+			rate =3D 26000000;
+		} else {
+			pr_err("bad refdiv: %d (0x%08x)\n", refdiv, val);
+			return 0;
+		}
+
+		rate *=3D fbdiv + 2;
+		do_div(rate, refdiv + 2);
+	}
+
+	return (unsigned long)rate;
+}
+
+static const struct clk_ops mmp_clk_pll_ops =3D {
+	.is_enabled =3D mmp_clk_pll_is_enabled,
+	.recalc_rate =3D mmp_clk_pll_recalc_rate,
+};
+
+struct clk *mmp_clk_register_pll(char *name,
+			unsigned long default_rate,
+			void __iomem *enable_reg, u32 enable,
+			void __iomem *reg, u8 shift,
+			unsigned long input_rate,
+			void __iomem *postdiv_reg, u8 postdiv_shift)
+{
+	struct mmp_clk_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =3D name;
+	init.ops =3D &mmp_clk_pll_ops;
+	init.flags =3D 0;
+	init.parent_names =3D NULL;
+	init.num_parents =3D 0;
+
+	pll->default_rate =3D default_rate;
+	pll->enable_reg =3D enable_reg;
+	pll->enable =3D enable;
+	pll->reg =3D reg;
+	pll->shift =3D shift;
+
+	pll->input_rate =3D input_rate;
+	pll->postdiv_reg =3D postdiv_reg;
+	pll->postdiv_shift =3D postdiv_shift;
+
+	pll->hw.init =3D &init;
+
+	clk =3D clk_register(NULL, &pll->hw);
+
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/mmp/clk.c b/drivers/clk/mmp/clk.c
index ca7d37e2c7be6..317123641d1ed 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -176,6 +176,37 @@ void mmp_register_div_clks(struct mmp_clk_unit *unit=
,
 	}
 }
=20
+void mmp_register_pll_clks(struct mmp_clk_unit *unit,
+			struct mmp_param_pll_clk *clks,
+			void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i =3D 0; i < size; i++) {
+		void __iomem *reg =3D NULL;
+
+		if (clks[i].offset)
+			reg =3D base + clks[i].offset;
+
+		clk =3D mmp_clk_register_pll(clks[i].name,
+					clks[i].default_rate,
+					base + clks[i].enable_offset,
+					clks[i].enable,
+					reg, clks[i].shift,
+					clks[i].input_rate,
+					base + clks[i].postdiv_offset,
+					clks[i].postdiv_shift);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		if (clks[i].id)
+			unit->clk_table[clks[i].id] =3D clk;
+	}
+}
+
 void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
 			struct clk *clk)
 {
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 37d1e1d7b664c..971b4d6d992fb 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -221,6 +221,30 @@ void mmp_register_div_clks(struct mmp_clk_unit *unit=
,
 			struct mmp_param_div_clk *clks,
 			void __iomem *base, int size);
=20
+struct mmp_param_pll_clk {
+	unsigned int id;
+	char *name;
+	unsigned long default_rate;
+	unsigned long enable_offset;
+	u32 enable;
+	unsigned long offset;
+	u8 shift;
+	/* MMP3 specific: */
+	unsigned long input_rate;
+	unsigned long postdiv_offset;
+	unsigned long postdiv_shift;
+};
+void mmp_register_pll_clks(struct mmp_clk_unit *unit,
+			struct mmp_param_pll_clk *clks,
+			void __iomem *base, int size);
+
+extern struct clk *mmp_clk_register_pll(char *name,
+			unsigned long default_rate,
+			void __iomem *enable_reg, u32 enable,
+			void __iomem *reg, u8 shift,
+			unsigned long input_rate,
+			void __iomem *postdiv_reg, u8 postdiv_shift);
+
 #define DEFINE_MIX_REG_INFO(w_d, s_d, w_m, s_m, fc)	\
 {							\
 	.width_div =3D (w_d),				\
--=20
2.24.1

