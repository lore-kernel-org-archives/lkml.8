Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B61C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB321532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFQNMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:12:00 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54283 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgFQNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:11:58 -0400
Received: from [5.157.120.79] (port=34860 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jlXr9-000Frj-FR; Wed, 17 Jun 2020 15:11:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2 1/4] regulator: lp87565: enable voltage regardless of ENx pin
Date:   Wed, 17 Jun 2020 15:11:42 +0200
Message-Id: <20200617131145.15696-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617131145.15696-1-luca@lucaceresoli.net>
References: <20200617131145.15696-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver enables outputs by setting bit EN_BUCKn in the BUCKn_CTRL1
register. However, if bit EN_PIN_CTRLn in the same register is set, the
output is actually enabled only if EN_BUCKn is set AND an enable pin is
active. Since the driver does not touch EN_PIN_CTRLn, the choice is left to
the hardware, which in turn gets this bit from OTP memory, and in absence
of OTP data it uses a default value that is documented in the datasheet for
LP8752x, but not for LP8756x.

Thus the driver doesn't really "know" whether it is actually enabling the
output or not.

In order to make sure activation is always driver-controlled, just clear
the EN_PIN_CTRLn bit. Now all activation solely depend on the EN_BUCKn bit.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

As discussed in RFC,v1 [0] there is a potential regression on existing
hardware, see the discussion for more details. So far Mark Brown kind of
approved the idea behind this patch, but more discussion about the correct
way to handle this situation would be greatly appreciated.

[0] https://lkml.org/lkml/2020/6/3/907
---
 drivers/regulator/lp87565-regulator.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 5d525dacf959..fbed6bc80c1a 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -11,8 +11,8 @@
 
 #include <linux/mfd/lp87565.h>
 
-#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm, _er, _em, \
-			 _delay, _lr, _cr)				\
+#define LP87565_REGULATOR(_name, _id, _of, _ops, _n, _vr, _vm,		\
+			  _er, _em, _ev, _delay, _lr, _cr)		\
 	[_id] = {							\
 		.desc = {						\
 			.name			= _name,		\
@@ -28,6 +28,7 @@
 			.vsel_mask		= _vm,			\
 			.enable_reg		= _er,			\
 			.enable_mask		= _em,			\
+			.enable_val		= _ev,			\
 			.ramp_delay		= _delay,		\
 			.linear_ranges		= _lr,			\
 			.n_linear_ranges	= ARRAY_SIZE(_lr),	\
@@ -121,38 +122,54 @@ static const struct lp87565_regulator regulators[] = {
 	LP87565_REGULATOR("BUCK0", LP87565_BUCK_0, "buck0", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK1", LP87565_BUCK_1, "buck1", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK1_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK1_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK1_CTRL_2),
 	LP87565_REGULATOR("BUCK2", LP87565_BUCK_2, "buck2", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 	LP87565_REGULATOR("BUCK3", LP87565_BUCK_3, "buck3", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK3_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK3_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK3_CTRL_2),
 	LP87565_REGULATOR("BUCK10", LP87565_BUCK_10, "buck10", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK0_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK0_CTRL_1,
 			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2,
+			  LP87565_BUCK_CTRL_1_EN |
 			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 	LP87565_REGULATOR("BUCK23", LP87565_BUCK_23, "buck23", lp87565_buck_ops,
 			  256, LP87565_REG_BUCK2_VOUT, LP87565_BUCK_VSET,
 			  LP87565_REG_BUCK2_CTRL_1,
+			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL,
 			  LP87565_BUCK_CTRL_1_EN, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK2_CTRL_2),
 	LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
 			  lp87565_buck_ops, 256, LP87565_REG_BUCK0_VOUT,
 			  LP87565_BUCK_VSET, LP87565_REG_BUCK0_CTRL_1,
 			  LP87565_BUCK_CTRL_1_EN |
+			  LP87565_BUCK_CTRL_1_EN_PIN_CTRL |
+			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2,
+			  LP87565_BUCK_CTRL_1_EN |
 			  LP87565_BUCK_CTRL_1_FPWM_MP_0_2, 3230,
 			  buck0_1_2_3_ranges, LP87565_REG_BUCK0_CTRL_2),
 };
-- 
2.27.0

