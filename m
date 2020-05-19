Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B6DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA21207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+485zBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgESOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:04:46 -0400
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:30592
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbgESOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTh4PWcUa3pqzoh9fb3ug3BhfjZOLczceQyECkaVTbkEJPebl3w/C6dP+NVM0jf43w9KD60m4kuseH7YnRVDB3acsO3OFoElEeFrQjQX55FKQZ4UZ+AS9uaMpNuK/zfegDnU8mS44ALmNx8urBT+x5OcmUhE47r5O51GYRKhfqNPw8PEERJHtXQAFNSa0UwA5o8hkbC2zUhNY58Ct44ueulvj+5MaP5CNspuoykyljZoecNXT5tSvytBPfUlN+18r8qSaaFCZLk3jP1L7OZsLYfueuR+SPYNaaEFCIKW/P5vnR0aUoI8TIAovmroC6bLjuqB6J089cIaTRmEVzkk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvKADXgze9LQNvclFGZFl9Lh7DQ8boLySckeI/ZehzQ=;
 b=VP4SPeQLRHzS5HpbezIlyg2Bjoiatm+Igr+xQTOFpx/TCggQAtgq6NBfR/Vd2zhmcGbsf2vQaFwMjWjweJAT33vx38H1SSdM6oz/olkLx5Hc+xEBxJF06OsgXcEpGpcQH+4o1YyW+WlzXjq6vEfRW5b+MwdA+4W9365K9PhjpwlS35IdAJgHNzaQu8wDjfTDUKDsAv9VjGtraaI3uI/XRjdx3x6Wfvwg1ZE2poEwXGnbubMIVNtj5QAt7Mn91OFwUbcE+BFtw+jFOtHfWf9WdKDsXGfh8Vl/JKRPhGZe0+2sJqWQu66V3Z7HtxzRs7NvNPVUeTLxkI22dWEJyS5evA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvKADXgze9LQNvclFGZFl9Lh7DQ8boLySckeI/ZehzQ=;
 b=C+485zBHx08DIirZyecQXwjwZA4sSttPI/BfYvhjtN5T+UVupsPNm09zYp+3f68af3sgdGxR6wdwMZ44Vgg6E0irYS22Eib4wKCNyQ+fJNP+i0GfkFsfMc7ko/0fC+0bVn/kSwIDb6p0oqvKBPf3vLsI/6QXKN7CbLVU8QSA9Pc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6367.eurprd04.prod.outlook.com (2603:10a6:803:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 14:04:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:04:40 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        anson.huang@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        john.lee@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 0/4] Add pca9450 driver
Date:   Wed, 20 May 2020 06:05:03 +0800
Message-Id: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0128.apcprd03.prod.outlook.com (2603:1096:4:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Tue, 19 May 2020 14:04:35 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1815eb46-83e4-4b3c-bba7-08d7fbfd9272
X-MS-TrafficTypeDiagnostic: VE1PR04MB6367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6367FEA1966385C8DFD271E589B90@VE1PR04MB6367.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTtFK8/uPW9pfmDZ+W0gYodMIThrItzhB45uS9JanhBulVWOon3dY72qzGivVsQKX1j7hL8mVCrFvoaDi/ihZxTz6aqt2mX9hZXl5lWr3+pqGBnJOYwiRguPv6hEHxvIbLwwK/WgoCu6Ju6GMIyXG/IV8zg0MdBW3HwmRZZm4vBgp5jVlxJthjC7v6jTdLypWtk1REjjWTONt/d7O/j4ObsJxdm7KzpZET6E/RRHFMwRKMJAc93Sl8jzEMJ5D4Pe6mfxURU6r/nTl+iTNH4sV8zrnXnMGgjczTtI2Zr7+oeQVN7pMNMF7RjO23W0/hGb10rIwiSzfHo95STDc+OzEc9DN7Qzvs+UyRm0RpVU/R2M8S3qDa4CviLbpfB5Wb8+Je6fx2HhgtexjhNpbqH78RWwqvLWJP+6zb2sxBhd8w2SF3wo6O5C3Llc8r/6+CvT105ubREBJ7i2SLBNCSHwj9Wag0GhdqCKg9TyebG8KuF/nf0l8nT1sLayGDvUHfnc2pCXoSeg7M4rFIQjX1sqOzb3p6EFy5GEPXUjvxoThM7/dCaqnS3qtzLljOf5Rc8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(6636002)(6512007)(4326008)(2616005)(6506007)(6666004)(5660300002)(7416002)(26005)(186003)(16526019)(956004)(52116002)(8936002)(36756003)(66946007)(66556008)(2906002)(6486002)(66476007)(86362001)(8676002)(498600001)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bcwcDOSxv8k5Ftbi0SFldsTm/v8lb6sP9CjIitGTXkNLN8tLfODejmce4C5G4a4Fv9bnu5dKTTV/ay4013GpOlDUjF8/2xLmAy4Osh2BzTymvgkyzNKNTUWK5cMaf4qELkAbCsjebmxzWhX6nyx8PB2waMfINTmM/l4hYVHSSP/BxIFmyX3s3MSUIzsg9Sm2rApGlUZzfunB2K/WnZMSHdx7XXR70IoUTYOAHJ1kqzyzby3kMy2KmaQD3wRnWxueYVH9bXklGiXjrlkn4C9GLy5wWQ+GoSG2vX0+1t1ZniXL74h13li8MQ7HVREF/TC2nAZJcrX6QPo6uVRSOoZLhxw7gO9rTjCPY55ek7mADbiQKc8fIC5bhoAO4JbEyOllActcdM6h63zpFxDWDeY7S0i4qU5Vd8nRcIt9J99gydzSd0bzWomDgUu8hBMwKYcJ2vG7SonxzmIKHaMvOItWQ3z7KHeQLUVepuFhR67QQdA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1815eb46-83e4-4b3c-bba7-08d7fbfd9272
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:04:40.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTr4sugCeDy4syG3LNAetfBohVqDkeB0T2VszWytn3plFBvdC2sJHmPLmPHT74bL4TT3GeoOCK747a7SaYmxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pca9450 driver for i.mx8mn-evk board. PCA9450A/B/C supported now.
Please refer to below link for PCA9450 datasheet:
https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf

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

