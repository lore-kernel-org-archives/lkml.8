Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CCC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EAF21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBSHex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:53 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35118 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgBSHeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 375D1E005C;
        Wed, 19 Feb 2020 07:34:19 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ytSnHxQJ2Uja; Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 04B20E006F;
        Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VudPmGfcJW79; Wed, 19 Feb 2020 07:34:13 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 64067DFCA2;
        Wed, 19 Feb 2020 07:34:13 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 02/10] clk: mmp2: Constify some strings
Date:   Wed, 19 Feb 2020 08:33:45 +0100
Message-Id: <20200219073353.184336-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219073353.184336-1-lkundrak@v3.sk>
References: <20200219073353.184336-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the parent clock names for the muxes are constant. Add const.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-mix.c     |  2 +-
 drivers/clk/mmp/clk-of-mmp2.c | 13 +++++++------
 drivers/clk/mmp/clk.h         |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index d2cd36c54474f..7a351ec65564e 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -441,7 +441,7 @@ const struct clk_ops mmp_clk_mix_ops =3D {
=20
 struct clk *mmp_clk_register_mix(struct device *dev,
 					const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					u8 num_parents,
 					unsigned long flags,
 					struct mmp_clk_mix_config *config,
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 6e71591e63a00..ee086d9714160 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -127,16 +127,16 @@ static void mmp2_pll_init(struct mmp2_clk_unit *pxa=
_unit)
 static DEFINE_SPINLOCK(uart0_lock);
 static DEFINE_SPINLOCK(uart1_lock);
 static DEFINE_SPINLOCK(uart2_lock);
-static const char *uart_parent_names[] =3D {"uart_pll", "vctcxo"};
+static const char * const uart_parent_names[] =3D {"uart_pll", "vctcxo"}=
;
=20
 static DEFINE_SPINLOCK(ssp0_lock);
 static DEFINE_SPINLOCK(ssp1_lock);
 static DEFINE_SPINLOCK(ssp2_lock);
 static DEFINE_SPINLOCK(ssp3_lock);
-static const char *ssp_parent_names[] =3D {"vctcxo_4", "vctcxo_2", "vctc=
xo", "pll1_16"};
+static const char * const ssp_parent_names[] =3D {"vctcxo_4", "vctcxo_2"=
, "vctcxo", "pll1_16"};
=20
 static DEFINE_SPINLOCK(timer_lock);
-static const char *timer_parent_names[] =3D {"clk32", "vctcxo_4", "vctcx=
o_2", "vctcxo"};
+static const char * const timer_parent_names[] =3D {"clk32", "vctcxo_4",=
 "vctcxo_2", "vctcxo"};
=20
 static DEFINE_SPINLOCK(reset_lock);
=20
@@ -190,7 +190,7 @@ static void mmp2_apb_periph_clk_init(struct mmp2_clk_=
unit *pxa_unit)
 }
=20
 static DEFINE_SPINLOCK(sdh_lock);
-static const char *sdh_parent_names[] =3D {"pll1_4", "pll2", "usb_pll", =
"pll1"};
+static const char * const sdh_parent_names[] =3D {"pll1_4", "pll2", "usb=
_pll", "pll1"};
 static struct mmp_clk_mix_config sdh_mix_config =3D {
 	.reg_info =3D DEFINE_MIX_REG_INFO(4, 10, 2, 8, 32),
 };
@@ -201,11 +201,12 @@ static DEFINE_SPINLOCK(usbhsic1_lock);
=20
 static DEFINE_SPINLOCK(disp0_lock);
 static DEFINE_SPINLOCK(disp1_lock);
-static const char *disp_parent_names[] =3D {"pll1", "pll1_16", "pll2", "=
vctcxo"};
+static const char * const disp_parent_names[] =3D {"pll1", "pll1_16", "p=
ll2", "vctcxo"};
=20
 static DEFINE_SPINLOCK(ccic0_lock);
 static DEFINE_SPINLOCK(ccic1_lock);
-static const char *ccic_parent_names[] =3D {"pll1_2", "pll1_16", "vctcxo=
"};
+static const char * const ccic_parent_names[] =3D {"pll1_2", "pll1_16", =
"vctcxo"};
+
 static struct mmp_clk_mix_config ccic0_mix_config =3D {
 	.reg_info =3D DEFINE_MIX_REG_INFO(4, 17, 2, 6, 32),
 };
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 5bcbced3f458e..37d1e1d7b664c 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -97,7 +97,7 @@ struct mmp_clk_mix {
 extern const struct clk_ops mmp_clk_mix_ops;
 extern struct clk *mmp_clk_register_mix(struct device *dev,
 					const char *name,
-					const char **parent_names,
+					const char * const *parent_names,
 					u8 num_parents,
 					unsigned long flags,
 					struct mmp_clk_mix_config *config,
@@ -193,7 +193,7 @@ void mmp_register_gate_clks(struct mmp_clk_unit *unit=
,
 struct mmp_param_mux_clk {
 	unsigned int id;
 	char *name;
-	const char **parent_name;
+	const char * const *parent_name;
 	u8 num_parents;
 	unsigned long flags;
 	unsigned long offset;
--=20
2.24.1

