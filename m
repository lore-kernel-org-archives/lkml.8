Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1924F206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4okQJuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFNNyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:54:04 -0400
Received: from mail-am6eur05on2065.outbound.protection.outlook.com ([40.107.22.65]:8032
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbgFNNyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 09:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7PSjuijY09sqbOcRS7LGLr9pdK02q0mLvlCjVcdzzwrpS2eFAf7BP5MRXTOoj3+nNPS+EUM/dCVddkK//aPmS7yn+kDzOOS9UJNSV7GM3gMhFXjbwZaM8lW9/0mey2LwKuVBSC4Uy8qVyaKjnfNgyZaI8IJAWLg5yY8763mKfN/spdG8+y4NAaXE3jcckNhse+SRd0IxZAoGr3SC7hzO4t19Zqjw0MkufC32yd169pfiAc3XJ9n9wU6U3Jf98cpOK7nDCMTzPBEjYQPxVFiZ+/rRddAWjtUfH5X2QpCEn/IxZGOxybEjKcyDZMVWzwsFFgiHhcbNUSaNRv6JmhT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pi5OD+ioDP0MYlLVSHq3TXC8ghcDC+NWzImWYS4Rwg=;
 b=IxR66sfvkEndnZaNVmNUFfxBmfIKBaujraPXQCQIj49R5bVX9KGaPneV/W86ksPL6Zgnol8Ikv4Eks8300hiqEXWLvhy/TM9v++r7TG3a+qFx+9FCOToknMsQxWCme7qZVsdQ15NhZY44Is4bZoJ7OvEXohxI9Raq5xOWBLgZqVc17KYs156OpULAsVkBzm/TgS9Wl7RK1WinSMuas8U9xxUe4uYape9IHf3junGfEelwlw4dcexN5O+YZY2Hz4avHdm+sZFGBp4dRcRrP6eM4lFDjskxaWmTVUkEbEOqV3JIMCQ5gYLholgq+Zqe45GAqf95BF7276WO2cpHcm+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pi5OD+ioDP0MYlLVSHq3TXC8ghcDC+NWzImWYS4Rwg=;
 b=g4okQJuGMcf98nODUPIiaXUrXhkfQtH1rZy7BqiA4oGaQun37LMXV9ntHGGUKZoYegqzuPGFwhz6MXYsc9GTNogovoWZBSg0Ttni5cJ7X6pFe482th2q4XOXBgnVsdCkTgcgtxyQaTt8G8Cdn4MgndN/XU1LPJIbFo2aABifFT8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6495.eurprd04.prod.outlook.com (2603:10a6:803:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Sun, 14 Jun
 2020 13:53:59 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 13:53:59 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, Anson.Huang@nxp.com,
        Christophe.Meynard@ign.fr
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1] regualtor: pfuze100: correct sw1a/sw2 on pfuze3000
Date:   Mon, 15 Jun 2020 05:54:08 +0800
Message-Id: <1592171648-8752-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0130.apcprd03.prod.outlook.com (2603:1096:4:91::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.10 via Frontend Transport; Sun, 14 Jun 2020 13:53:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 277c9bea-3e1e-455f-28dc-08d8106a631b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB649509B2529156236FB2E99B899F0@VE1PR04MB6495.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04347F8039
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lm6poZAvNxmIW7jeShMxR43V1kVhky+4KP4pUnYg1gmqIa8XAmAV6y4z63t9e47EudlCvs/6uZIZVdcjyo4BiqTKJLeu6lkkqTYeQtmp/5jWeYRFaUBrYiapW+9qgCxNxg2ETsxRbLhPYhESmhJ7hdvT67jMFgOWLFxVRMRKN++hGXSk8jzie3AeeFQqmJszj+NGJ73EtYEh/+HEPT8AmJS+ywaG7Qter0f2y5P2Je3mScr3D5lNiqVuX6ig79AjgQZYnF96Z1BMA5UCg5OtA0XfrnnKSfsAmvZ5oCOZml0AppN96NY6CQC3iYL5OLajmJ88Y296Nq9ETHpT6SE1hzw9Oby5zgE3rZLGBpMOctO2ajB1PqSsmU2yqX6tSBDS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(52116002)(6512007)(6506007)(2616005)(83380400001)(86362001)(956004)(26005)(6666004)(8676002)(36756003)(5660300002)(66946007)(186003)(66556008)(66476007)(8936002)(6486002)(16526019)(316002)(2906002)(4326008)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YCwW04775z73OLjkOXAShrosapOrvllK3xw2f1wp9FdayDMvtaHtJexFmzeyn7nHnpqAWhoNQDzhOxcEJYDkPvRLrXrkcUHNRPHRZTEhXbBnwqKyicrLlMMulC3WHrB9W+kD2b6JGrj9/4EF/WogyAvkq9p/10tOTgnq3TXlnyr1SAcJ40NHzTN3bpHs3s6d+iFckwRvG3PDqv7iW9Y5op1Pwl5yP9X9RiwbJFudHCKOoWRFocV27bYZlTAs3FB09ZIWViOTYRsyjx54pNeEA1zwSTRbrUdH36CqypSzVk2UnRDSRbtXlocHeGeXTiE+v6+NofpQtOjYXXuoPf60NjP+3zbtE/f5i3tY3npn6yGYasDAOud+9QIE3A6rkV+K9+uzXjoE/jB/+qVNfoYGx5mkhMJUciFdi6VV+hb33BoRstFB7m7pt4JbYg2TViw+jqjzvNTqfr/tU79ny7Mt9Rj7dd25ydxTDMCb4ZpvgzU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277c9bea-3e1e-455f-28dc-08d8106a631b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2020 13:53:59.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sqpr+GM47Afbxu+t9qbcO720okhn+Y7RIGIm2ftJuqaWNWeg+C2KrjRDEtG+wwKXM1LTpnkcjLrUFLABObKV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PFUZE100_SWB_REG is not proper for sw1a/sw2, because enable_mask/enable_reg
is not correct. On PFUZE3000, sw1a/sw2 should be the same as sw1a/sw2 on
pfuze100 except that voltages are not linear, so add new PFUZE3000_SW_REG
and pfuze3000_sw_regulator_ops which like the non-linear PFUZE100_SW_REG
and pfuze100_sw_regulator_ops.

Fixes: 1dced996ee70 ("regulator: pfuze100: update voltage setting for pfuze3000 sw1a")
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Christophe Meynard <Christophe.Meynard@ign.fr>

---
 drivers/regulator/pfuze100-regulator.c | 60 ++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index c34588d..0398b57 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -220,6 +220,19 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 
 };
 
+static const struct regulator_ops pfuze3000_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = pfuze100_set_ramp_delay,
+
+};
+
 #define PFUZE100_FIXED_REG(_chip, _name, base, voltage)	\
 	[_chip ## _ ## _name] = {	\
 		.desc = {	\
@@ -329,23 +342,28 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 	.stby_mask = 0x20,	\
 }
 
-
-#define PFUZE3000_SW2_REG(_chip, _name, base, min, max, step)	{	\
-	.desc = {	\
-		.name = #_name,\
-		.n_voltages = ((max) - (min)) / (step) + 1,	\
-		.ops = &pfuze100_sw_regulator_ops,	\
-		.type = REGULATOR_VOLTAGE,	\
-		.id = _chip ## _ ## _name,	\
-		.owner = THIS_MODULE,	\
-		.min_uV = (min),	\
-		.uV_step = (step),	\
-		.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
-		.vsel_mask = 0x7,	\
-	},	\
-	.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
-	.stby_mask = 0x7,	\
-}
+/* No linar case for the some switches of PFUZE3000 */
+#define PFUZE3000_SW_REG(_chip, _name, base, mask, voltages)	\
+	[_chip ## _ ##  _name] = {	\
+		.desc = {	\
+			.name = #_name,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pfuze3000_sw_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,	\
+			.id = _chip ## _ ## _name,	\
+			.owner = THIS_MODULE,	\
+			.volt_table = voltages,	\
+			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
+			.vsel_mask = (mask),	\
+			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
+			.enable_mask = 0xf,	\
+			.enable_val = 0x8,	\
+			.enable_time = 500,	\
+		},	\
+		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
+		.stby_mask = (mask),	\
+		.sw_reg = true,		\
+	}
 
 #define PFUZE3000_SW3_REG(_chip, _name, base, min, max, step)	{	\
 	.desc = {	\
@@ -402,9 +420,9 @@ static struct pfuze_regulator pfuze200_regulators[] = {
 };
 
 static struct pfuze_regulator pfuze3000_regulators[] = {
-	PFUZE100_SWB_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
+	PFUZE3000_SW_REG(PFUZE3000, SW1A, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
 	PFUZE100_SW_REG(PFUZE3000, SW1B, PFUZE100_SW1CVOL, 700000, 1475000, 25000),
-	PFUZE100_SWB_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
+	PFUZE3000_SW_REG(PFUZE3000, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
 	PFUZE3000_SW3_REG(PFUZE3000, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
 	PFUZE100_SWB_REG(PFUZE3000, SWBST, PFUZE100_SWBSTCON1, 0x3, pfuze100_swbst),
 	PFUZE100_SWB_REG(PFUZE3000, VSNVS, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
@@ -418,8 +436,8 @@ static struct pfuze_regulator pfuze3000_regulators[] = {
 };
 
 static struct pfuze_regulator pfuze3001_regulators[] = {
-	PFUZE100_SWB_REG(PFUZE3001, SW1, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
-	PFUZE100_SWB_REG(PFUZE3001, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
+	PFUZE3000_SW_REG(PFUZE3001, SW1, PFUZE100_SW1ABVOL, 0x1f, pfuze3000_sw1a),
+	PFUZE3000_SW_REG(PFUZE3001, SW2, PFUZE100_SW2VOL, 0x7, pfuze3000_sw2lo),
 	PFUZE3000_SW3_REG(PFUZE3001, SW3, PFUZE100_SW3AVOL, 900000, 1650000, 50000),
 	PFUZE100_SWB_REG(PFUZE3001, VSNVS, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_VGEN_REG(PFUZE3001, VLDO1, PFUZE100_VGEN1VOL, 1800000, 3300000, 100000),
-- 
2.7.4

