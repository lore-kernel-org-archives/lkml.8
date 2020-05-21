Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A34C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ACD2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TM/QGDU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgEUDZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:25:59 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:31268
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbgEUDZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfM4vRSaqXWP7tJPCZ2OG6dbUzOW6oZnAlOFxG/148bRcRKVJdOMIRcYXHf9p2DstW7cEfmduHfW3j9GtR2xeQyXryYZj0ZghmY+XzDGL50dhRoQfTeG5rwjZ0ebWXM1T9z6e6c66tImAZkpEnGDzJTnWQd30K7xmbaUJw+0k4G+wyMv4K4A8BeDolNL8t98g3KbJuuLzR1fIe/C4f6zr6PrBCWDLunFevhfq58QhKkFeMhhSocpg7JzOSv+BmiFRIt5HxQPVbl9ST64EO7gvGO2krU8d/csmRBq2appCwT9wMM8S64uGNdWTQukBOVUzHAlPUguqpaQ6EDF0UjIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZyVXa6OVYjI56fPdSOlinHR0mhsfjQmzse91s3Pqt4=;
 b=MG3IS3tntzbYEGxaPUmqp9KlhffYlfD6RuKb3wJumlSQTzg74NCWkgamE2gUA62AtdbrGbhhRShOFF8eXv0DdblRPUTy4qOr4IaIre2OBMWEUP8/yAlHjNN54HcZjOJS/uJM/+X+2awAQaYRLFJ13KfTdFxiurYS3EKGzDKO1Okj6v15qnS47GddbazxKTjmXtyHTsdQk/9IoE4CFJ4B1P5UNFi4stt/z61oeus7GIxycx/4T4gvrW86noetK6PF27ASFTIRiCmop92aDOH4JCMo9EwPZ8mnIggddHZd+5Mg8yjXsD8kO2olUM2s8iOhlulYrovwsBU6PUdeTyOOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZyVXa6OVYjI56fPdSOlinHR0mhsfjQmzse91s3Pqt4=;
 b=TM/QGDU4DZxaNvyWhuygHr5zBYc9XZvRJz/ZMkFlIAbJ5U8YpOyS8pV+EXwqqmUc1gZ2YDpyTymMaP81tAKCKpcBQx8dsQbXpUbeGrA9A9u45mi8vOymmufIX4YoBGgsaOPiQH1QVVW2pdMoqwG8qy9SNl7ZzuNCyfj8B1fEopA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6383.eurprd04.prod.outlook.com (2603:10a6:803:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 21 May
 2020 03:25:53 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:25:53 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
Date:   Thu, 21 May 2020 19:26:07 +0800
Message-Id: <1590060368-2282-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0132.apcprd03.prod.outlook.com (2603:1096:4:91::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.11 via Frontend Transport; Thu, 21 May 2020 03:25:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9bdf494-e768-48c1-4efd-08d7fd36aaca
X-MS-TrafficTypeDiagnostic: VE1PR04MB6383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6383159C2201FC876DBF55E289B70@VE1PR04MB6383.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh2fJATLdTumekJ0qRqFl4Ep281vSggHG5gjjrDg5UciTMPT1HFdm55T4R75qlFMS32Hht1UycgomwZr3E9jrAYAn9Kfgyu4GQWBRRYEIhiq03WwBFqccTtb337QIs9nGEYBI8/dac65RtxP6yINVoikfeCkxjO6oET1xyJ5SXZB1o+Km2g+OC7pKA9xBD9X+VeloAaKWl+mQ4q7+1T/AMuI1DPzWZWXjElbNhBlSlvo0Ah1zWqNWbA8GLZ1VbGFrw/zfcci+3NX4saOZ2hcOg1lZJOgmBBXQskBJhfcoMxv8JUri6jHwHdesPEnJoME9X2Xs48WsX4Hdzzdk8C1hdAQ7px8heKv6kAn6uaju+KUlRevbXerdv/7DOKd9Ya9uEiCQNt1ZHcoDm7uVv1VM/gzZtPnoYfPXpErPJu+zxCAu5i6z7p0eKZHLU6AFc7nyQbL6z6ERU36qRUh9XNVCHCU/AJnafwJHOXiBMsRiaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(5660300002)(8676002)(186003)(16526019)(2906002)(86362001)(66476007)(956004)(6512007)(6486002)(6636002)(2616005)(66946007)(66556008)(6666004)(478600001)(316002)(52116002)(4326008)(36756003)(26005)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BA0dABnOqbusjlWb1MiHdXSek15OBU2qeAKa2eNPgkSm/5ByEKGDYEh0OS62hrDV+v/FitOADQSP51SkWmcgmx3Szwzv+1IDr9lAneSH5dyTdPkyiIdVDMVO1p63gwC4DjvbOSYkIWhqrOfan4uF42L7zpFn0ymSYbuubS489bNQaYP13jDd1w8SYn8e4JCKhfW9xaHVzwpMDss9+qQHSvo551VgjpGLvhqcLPVCqD2DhBvrkPgDQh4GryoaF/zWdizMd+G6IB26QHziM8PlKjBSY+qMPpP9d+BM+1BGRndu4U8GahLzMEhAuZHC+J0Mj4yUAugm8K+0MaZcvhuMuA63sa93DygCcPcyltf+qpaDmx6Rvtnv+vsvyJgCASy+KjJYIfAGNk0CpVFKyDW9STMjZ4Fer5rFdrcOsPe5jYl+CVJbTP3PAX21aUQwvkL0Km9WruWhEgGstJ10ARFKbYox+G7xJPG+PBPCkx4GZ06IyDdBTWyhIpX4d1Ol0O7Y
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bdf494-e768-48c1-4efd-08d7fd36aaca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:25:53.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fKDQw/OVTizwqHxRKinx8kcSJznOgNh7pWVHVBc8/Pq8HJ5YEbn7wJZartZctxVXEG0K0iIGKoRAN5LQCrSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct ldo1 voltage range from wrong high group(3.0v~3.3v) to low group
(1.6v~1.9v) because the ldo1 should be 1.8v. Actually, two voltage groups
have been supported at bd718x7-regulator driver, hence, just corrrect the
voltage range to 1.6v~3.3v. For ldo2@0.8v, correct voltage range too.
Otherwise, ldo1 would be kept @3.0v and ldo2@0.9v which violate i.mx8mm
datasheet as the below warning log in kernel:

[    0.995524] LDO1: Bringing 1800000uV into 3000000-3000000uV
[    0.999196] LDO2: Bringing 800000uV into 900000-900000uV

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index e5ec832..0f1d7f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -208,7 +208,7 @@
 
 			ldo1_reg: LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <3000000>;
+				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
@@ -216,7 +216,7 @@
 
 			ldo2_reg: LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
 				regulator-always-on;
-- 
2.7.4

