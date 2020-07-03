Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C083C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A40207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qYGm9IIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGCIFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:05:12 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:14338
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbgGCIFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXL1Xlm1RCCUTayErmyu4PixQlHz+Ldm7Q6KIBqX8q28Gunlp8LXCcPhOC69thHAzexpp3IPZvz25hLC1VC0kVT4YUbMkvSuRK07DAOAa1R0Tmb4ravCbT8Oo+IxRvLK+NFJpNc9VlzmLkCPp5ks7WivimSYl6xAfzyamjqRN/012nT6/zt8cU+ex11twZ0w94ne7SrhhbWOsFUchgtTk7gnTTEhV4e451Y5KUm0zjP3hsZ5MyqvzOTB3IXD7G9gVC+YWl73yGZebmbJ3so28sggrw3PJzjQjfnVg9oXCgnMTFKkShP8lquN9xdBfhv7lf//b2bgJvCXw22xTR89ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hKDHVdEFh+XLT+WfauAQN6QP95BbRDFSK/AOpxxLEI=;
 b=kLYgZdEkReUo/GYB2WVJpkaB/Ad2zLOmECqp0htXee59VblVlgIiPxN98LarCK4CXhV2iUZ+ea2X0rw3a3CnZBzo2RN9AAm71Wx8P3WraBnqB8t4KzOJHrKVadtOD2BV4bWxmhSQvbjBdpQ42MHX4n6wNDLuh1K6UuOl9hhV2NnHxEWnUVlP/yZeTJ5OFdDiF0YK3r6oSGvsxbdbvw1ZVYVuLCYwJ7fIoJJmTNtWAa6CrR6ECdK2VOUMZIBKhUdOAqhSQdV+ehkCnwKSmIZ94ShnJDCK7Obvh3oc/anMG4uD47Olta8tk0Db138s8nuz5Sd6H9bonZkAGcZklCQ1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hKDHVdEFh+XLT+WfauAQN6QP95BbRDFSK/AOpxxLEI=;
 b=qYGm9IIYcPi/N+p9crsq0pkmHTHEz3zmemN8HK7HB2J5UFDwTfUsUNSEell5svlPIoLErT2G8K5fO3q/iNx1t5M4AD/T5uhbCDzaf1KnXZIb5Wpa2YIl9pyibwdQf8yTfHrZAA7EdIQZcYkAp+FOhCrRAUocIdY0irSKV5EikOk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 08:05:07 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:05:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v2 0/4] Add pca9450 driver
Date:   Sat,  4 Jul 2020 00:19:34 +0800
Message-Id: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 08:04:58 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60f9c235-1c5c-443d-73f5-08d81f27cc7e
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2302E18313A399103B5057ED896A0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KG1IOjRfIny4x482PXg7vGl46dKKjXSVR/4+1275OCE/l3JZ1XBShkzPUieprxvoeaPC0nveNBdWI6bg40Tq4ekAuToiJJAryWIMLKRa/OowczZfpk1o3tHRCdi1k3k3Il8ofz9OLk6hzu+uUa0vofVEKdCheAtZKp5sxD9iVwVX9mBj/1Skks1HKACbZnrWheG+ojAGG8B2PBMp07du+Gu+HRiILigoTgn6Mych/DpgRmV94SasjznNLZmy/dSZKofmgDuCO3ntDhfZrmWx64c6dqsBfOL24BS4uVQk9YiUwLynYC0vqYm8PSh8ELCSVmPb8cXSTOLXMtQMK/NaQcl7bFz1Shh5MkHLCMLzzCzKsX4dc0mCDeSJj8Klaam1YD5RArQmQ3loptc9hfEcDtx6hYrs3w6GOuTnjdTHiU3xRIHkqzUPTMcoIdCmJFMNTWfh6rAe4RF4Yi4FP38dvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(7416002)(6512007)(8676002)(6636002)(6666004)(8936002)(86362001)(52116002)(478600001)(5660300002)(16526019)(316002)(6506007)(2906002)(966005)(4326008)(2616005)(66556008)(26005)(186003)(66946007)(36756003)(956004)(6486002)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fRbal0zoQICB+Jc/AN1YZ7dtVtnjsTMgSNEZQuDkm1goqROH1k6xXQRYAqqMp14dT+kkQAz2Ti9BOGQsmRpY+EcPpEQ0CCcJMQsYw55g1IKbixBnfpHyjQzACPt8/ik9jap3Qth6UZGpdq205T4+9ReTeplOi80hly0IQ+GV0SRSmuLMJOdHjQmFcTwu32YCYNznLrexGnBVkzKbCF/Z7sJaLwPQBuh+M6hlV3OyoMdiQzuCpN9AcYZrUSYhrSWTJinoCmvHHxodQup1t8znVSLgQZVpr75xx17pKykNcOeq8JfbXd4JG++W/zLcPaxAg3HRYtj6muRbvw5Q2Knn3MbKdGEpGe2Sm3mvUaTSF5zQwFSNrZzOIUqCX+G4ZY0FxAbqt9JuRZP6Om75gATt3gevfpt+3/aH/H6oE3l18ufSvArvtX9+Hzb8vP/gmA6wkznZZyyTTBAv+Xsh8J60PL3Ccr5nx2U1XfR9JeJWvPk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f9c235-1c5c-443d-73f5-08d81f27cc7e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:05:07.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rDuiCVVVUxFoz+hBOrMGP8QzSYpDPYlWdB0Xy1aNw1jcz67e9WJMOKPpEJ8jXf09vP/fuVfX6HE+9v3GWVQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pca9450 driver for i.mx8mn-evk board. PCA9450A/B/C supported now.
Please refer to below link for PCA9450 datasheet:
https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf

v2:
  1. rebase with the latest code to use linear_ranges helper instead.
  2. address Frieder's comments, such as dulipcated buck4 description,
     debug info added etc.

Robin Gong (4):
  regulator: pca9450: add pca9450 pmic driver
  dt-bindings: regulator: add pca9450 regulator yaml
  arm64: dts: imx8mn-evk: add pca9450 for i.mx8mn-evk board
  arm64: configs: add pca9450 pmic driver

 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 190 +++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts       |  96 +++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      |   6 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pca9450-regulator.c              | 859 +++++++++++++++++++++
 include/linux/regulator/pca9450.h                  | 219 ++++++
 8 files changed, 1380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
 create mode 100644 drivers/regulator/pca9450-regulator.c
 create mode 100644 include/linux/regulator/pca9450.h

-- 
2.7.4

