Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79767C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E53220730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgDHQFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:05:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbgDHQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:05:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MRTIx-1jgkLy459p-00NSSK; Wed, 08 Apr 2020 18:05:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mmp2: fix link error without mmp2
Date:   Wed,  8 Apr 2020 18:05:07 +0200
Message-Id: <20200408160518.2798571-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AuM2suQHykgHS5D/xLsz57DkmpokZxSKpa3CrAaWZr9hEAviZEX
 /1tHgL5uEfw1Kp5K4TxsivZZnogtp+GYLCzukoayaVGHZirX3YMvgTvKKt9QFt5bT7/C7Cm
 +awhXEIiQfoHopxWq42bVJwzeV1StBQr1XDKoSjwuDYX3jtVMWzyXwoVGqAL9Jfy5lhsjUT
 jOiwLE0XJYNHp3GIljNtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8dGqNu2G1I=:Y5quJ1/zpfJv2YFSKiJ7Rm
 ALVHEFbOz0jyNDFt+rmKyrWKoY+6ELtxXZssG+tPFfVn+zQ4GsaQLR3Vzwz2VPvv0yhEFpGor
 4UUpysNu0xdRvGZuylztWqAGpWLQuPQHt3EOCvuW/9CLcqkxvTk6q6rEN+E8co7fdMlrdeHyf
 q5iNTZZVJHSDI9lqGjDFYtsyGTK1nj/B0DRgbW14WTLMZnUhymXUdPQe+AhD3Glf5WCh2KtBo
 FqiUGkvQugYsLLgqY2oX02Ed+aUH06T71+j+htA0F8ELcvLieGkqvTLJWNNEkbaKrv4Dl++jk
 Qr5sWGm2XSOgUa5csEtsjbbp+Dl0dC8uXVoLz4Bz8oHpiIEQvegQAR8OxEAKDWDr+JxkUe0Js
 iFrxnxaAijUR9EnZhGzz98t980e0mRs1ZXIM7SkL5sl5fJ9inKo/eLvlOSX9yRQKUzVaFkZXm
 ToDde/uE9Zw1SqHh7sFZLNcn5oXKFJMurOQZzGdldngBGx6o8J65YHlBELRFpnnTypPOjni7y
 OOBxw9HW5z3Yfe5ge6vuqNbIU45YBnxQ4h0VJDIBduj3RH2MmAsmKlq3nrHvN+k/mWkmZzqNl
 c6TKQiTEDwcZiju74y1LAM0bdhJ/61PQcj2wI6ZvRJMNrdRgFE8+LekfdcxTlc8xyFOeaDhlo
 i+WHfRWxSm1Wd5UtbFH8Z/vNiPMK/vqYVc9RzDOWXLaIDpSv0Dcz77kiEg+gysK2WlIX/ZC2E
 05PtCMtf0Q8QH8Nbyuz48tw3hL3sDpl7iTzukCLUElulxzhE9DZn7ZeUghcxM76QmRlS5VeO2
 PpV8BNSATSrg4UrxYOIWN/oQUhQNeq/Q0yFahKFvhSYObV1FyU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added function is only built into the kernel if mmp2
is enabled, causing a link error otherwise.

arm-linux-gnueabi-ld: drivers/clk/mmp/clk.o: in function `mmp_register_pll_clks':
clk.c:(.text+0x6dc): undefined reference to `mmp_clk_register_pll'

Move it to a different file to get it to link.

Fixes: 5d34d0b32d6c ("clk: mmp2: Add support for PLL clock sources")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/mmp/clk-pll.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/clk/mmp/clk.c     | 31 -------------------------------
 drivers/clk/mmp/clk.h     |  7 -------
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/mmp/clk-pll.c b/drivers/clk/mmp/clk-pll.c
index 7077be293871..962014cfdc44 100644
--- a/drivers/clk/mmp/clk-pll.c
+++ b/drivers/clk/mmp/clk-pll.c
@@ -97,7 +97,7 @@ static const struct clk_ops mmp_clk_pll_ops = {
 	.recalc_rate = mmp_clk_pll_recalc_rate,
 };
 
-struct clk *mmp_clk_register_pll(char *name,
+static struct clk *mmp_clk_register_pll(char *name,
 			unsigned long default_rate,
 			void __iomem *enable_reg, u32 enable,
 			void __iomem *reg, u8 shift,
@@ -137,3 +137,34 @@ struct clk *mmp_clk_register_pll(char *name,
 
 	return clk;
 }
+
+void mmp_register_pll_clks(struct mmp_clk_unit *unit,
+			struct mmp_param_pll_clk *clks,
+			void __iomem *base, int size)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		void __iomem *reg = NULL;
+
+		if (clks[i].offset)
+			reg = base + clks[i].offset;
+
+		clk = mmp_clk_register_pll(clks[i].name,
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
+			unit->clk_table[clks[i].id] = clk;
+	}
+}
diff --git a/drivers/clk/mmp/clk.c b/drivers/clk/mmp/clk.c
index 317123641d1e..ca7d37e2c7be 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -176,37 +176,6 @@ void mmp_register_div_clks(struct mmp_clk_unit *unit,
 	}
 }
 
-void mmp_register_pll_clks(struct mmp_clk_unit *unit,
-			struct mmp_param_pll_clk *clks,
-			void __iomem *base, int size)
-{
-	struct clk *clk;
-	int i;
-
-	for (i = 0; i < size; i++) {
-		void __iomem *reg = NULL;
-
-		if (clks[i].offset)
-			reg = base + clks[i].offset;
-
-		clk = mmp_clk_register_pll(clks[i].name,
-					clks[i].default_rate,
-					base + clks[i].enable_offset,
-					clks[i].enable,
-					reg, clks[i].shift,
-					clks[i].input_rate,
-					base + clks[i].postdiv_offset,
-					clks[i].postdiv_shift);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			continue;
-		}
-		if (clks[i].id)
-			unit->clk_table[clks[i].id] = clk;
-	}
-}
-
 void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
 			struct clk *clk)
 {
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 971b4d6d992f..20dc1e5dd756 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -238,13 +238,6 @@ void mmp_register_pll_clks(struct mmp_clk_unit *unit,
 			struct mmp_param_pll_clk *clks,
 			void __iomem *base, int size);
 
-extern struct clk *mmp_clk_register_pll(char *name,
-			unsigned long default_rate,
-			void __iomem *enable_reg, u32 enable,
-			void __iomem *reg, u8 shift,
-			unsigned long input_rate,
-			void __iomem *postdiv_reg, u8 postdiv_shift);
-
 #define DEFINE_MIX_REG_INFO(w_d, s_d, w_m, s_m, fc)	\
 {							\
 	.width_div = (w_d),				\
-- 
2.26.0

