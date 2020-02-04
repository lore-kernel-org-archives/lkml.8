Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4DAC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C33222C2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="U6GC4mSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBDLMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:12:12 -0500
Received: from mail-db8eur05hn2224.outbound.protection.outlook.com ([52.101.150.224]:29465
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbgBDLMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vrd0k9gX7W0DdX8NeTCZCVmL4Q68TxrDFuVKMFtSzUVzSyIfLRciy6g/4b9xHLfQTeF26mexxaOCMXAxg168HebzMI9DeAQi/e4YhZfPg/TTRlsVSr4hVAQOTh3P/u9Ht94PTSx3B4eBEIENdB4xGQCfVPpfJH3qPSQbtotNXKVjIMjC0ocY1wndepZv8iyNp6FYWWChfZ63JK+LOArALeV04yF8da+b5L7K/hs4TJDwPlh4VjkfcJGpkeAw7ZeUvP1x53Fa4OI5AMsToBenm/bmXdWgR81kUKxSug7+tU7AUy0a8zRHcVGYadHrk3VCUfpVNAF8EVGNE9k+ixPBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkjPjzfDMgMB3/na1YLTKsGY9i8jue32k9z/pee5+lo=;
 b=kns7ubWaCWrjVGpQoX1u5gtjQPhYBH0suqCPrOCjVoSkDp0bFMfKgx2HCRSOZvihEArK+Htlz9QUQutqfjxLDgyqma61nHPeNUzutvOO2MfJJBq0IvD5c3XwC/3oZZrhtazmlLbfFSBlgPvu6wIzziBte26qb4Om164dCzuP4+iPyQ8jS/Vs+Xy6B7LHIO5y9RYlms/qlFrVMnFof1qS1b2CEf1IWV/ekpg8OsqJkSr5q7P9n8kGapV99/vVqB7NjO6nuLdxJRp7flzJ/7Zd1Pb+ouo2uOuP0XXMgqpzTRP3qVza+ww5Mm4WkWUKbADpqFkwhOD6p6Em2YImmV9/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkjPjzfDMgMB3/na1YLTKsGY9i8jue32k9z/pee5+lo=;
 b=U6GC4mSi6GqE7iYMFirjNNZXtz0ceTo/4K60QobErI/VJbfcCg8Xj5fqKhF4pDsbQj3drnXCZ0/R8+aywclTqkfz6zeAm6s9TrGL8BEvxlR2iejp++1mDNAOSGCMouW9JJzwQqiG/TFPS/O1gqH5IoXBprREOC5NNkGVoS1a464=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB7039.eurprd05.prod.outlook.com (20.181.33.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 11:11:58 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 11:11:58 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Adam Ford <aford173@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add Aster carrier board support for Colibri iMX7 CoM
Date:   Tue,  4 Feb 2020 13:11:45 +0200
Message-Id: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::21)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from localhost (194.105.145.90) by PR2P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend Transport; Tue, 4 Feb 2020 11:11:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [194.105.145.90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23c72aa3-c4d7-4618-8340-08d7a9630d2d
X-MS-TrafficTypeDiagnostic: VI1PR05MB7039:|VI1PR05MB7039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB70392196B666E697F7BF0C13F9030@VI1PR05MB7039.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(346002)(136003)(39840400004)(366004)(376002)(396003)(189003)(199004)(186003)(66946007)(36756003)(478600001)(8676002)(81156014)(2906002)(81166006)(66476007)(6486002)(8936002)(5660300002)(66556008)(16526019)(1076003)(6666004)(956004)(44832011)(7416002)(4326008)(2616005)(54906003)(86362001)(6916009)(316002)(26005)(6496006)(52116002)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB7039;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgfMpO488fAngJz0IEUQ0ut22t30KmvHzGbe7xpxx81kpOFPrmyBwE4vvvv4gJ6m39IWT4QZ4B+C/Ebnoo/37ybIzzCF/yvGlzWAkKl//lp3dHfinXr5mDXiX8uPIkv5C2SsVeFsibUOYfzHcvQkfcP3qeCV+72nVoWGitqmFlNOQ0Dx87RPj1NJXza/7v0iAHFvy33uBSuSEUAhTzzvcKs9CGSv6bvlAC8mIYOPOViNGF2YHQ7EXN6g0783K99JSlNEbUjiP6gKVUcK5RMX7bWQUfsYBJcdp7YKrgzw/TnP6aC6tGyyrmrRvEW1YJIY8ir6RRY4KVv2OSLhmHd0rvAB4KjjRZVVcjviO10iJS365wvQfyLNgjpYkGAHzBzjIeh/W6StCC8P7ZKgXCEBMMvhrll+oPxOkAtmkxzWzAXhX/6G91La25jvc/4iGX45lcv1A3B3xpMg6QpmhlKtnpYBOHQzQHfKW12a4k38FGlFTkyqd832wyFcBK89aOcALgLTLOSPMRUFP+MFJQmlogWuPuf+x0ZkxuJWcPcRI/yKBvjVrw9IasddHS9rVG/fjgIS4bhiBz5HMqlbPW2W1Hhyy5J/QHurikyl74a6Rn7jK1YyxJp7G8V+3m2O0y4MtfV0tCwWHOzfcn5t6ukUgPdDq5kkwT9gRpSjbOFcfwl5zXO242FRHve2ptP/ux590WmmJMHCzUihgx1Q0iiULMCOV4s2jYj8F5RnbpPEZnnQwUAgUoqdjGs2l898xzOCamp2WBE3kQZYarjOkENy2A==
X-MS-Exchange-AntiSpam-MessageData: FN80g9++rnwkfOkTrqwwH9/lePvBdfuRv4gmur4VWTjuzsbjmd2kD5FsQ3NaaK8ib8q1+KitYP7el6CdBD97s466x7gR6Hi4VHogzhHtTk1SISViPEUA9Rfxy7qz/7PMGNWBh12IFOz9gWEih9Qdeg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c72aa3-c4d7-4618-8340-08d7a9630d2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:11:58.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 107KJoy3vARzFekdd9/dbrzpBl5w1Tyr28VaclgapbdGTFhnaLSLD95pPDCC8c+iAr1zVvHvB8fIYLieW6yrOCPwyLJ8MDc1mIkXOmRgbiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds devicetree for the Toradex Aster board along with
Toradex Computer on Module Colibri iMX7S/iMX7D.


Oleksandr Suvorov (6):
  ARM: dts: imx7-colibri: add alias for RTC
  ARM: dts: imx7-colibri: fix muxing of usbc_det pin
  ARM: dts: imx7-colibri: Convert to SPDX license tags for Colibri iMX7
  ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_ATMEL_MXT
  ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_AD7879
  ARM: dts: imx7-colibri: add support for Toradex Aster carrier board

 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx7-colibri-aster.dtsi     | 191 ++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   |  45 +----
 arch/arm/boot/dts/imx7-colibri.dtsi           |  51 +----
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |  20 ++
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |  20 ++
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   |  40 +---
 arch/arm/boot/dts/imx7s-colibri-aster.dts     |  15 ++
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts   |  40 +---
 arch/arm/configs/imx_v6_v7_defconfig          |   3 +
 10 files changed, 272 insertions(+), 156 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts

-- 
2.24.1

