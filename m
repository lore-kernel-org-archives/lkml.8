Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3B92089D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="cuLMNGOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgGBOeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:34:11 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com ([40.107.6.129]:46462
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgGBOeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1EibdiKtsdvj/EZYeLMuMo2dOqQ9VffOsOGlLBQ3y9aiYrsRuKkuBHca0BwRLdrTdlUkcXnX/d4BFPqM2jW8K6Ar1YRZffmWst6r2JGpc6Lnn/bQP3Lryiv64XyS7SaHaBMIVt/CoPskwQnk8jy216ScT1RVx5gxiwtk1vwGpVkB4mvq3H1tDOytUG4T7ueAfuKDCw7PecKV+4mEvgWEck57G2OtQRimsr1z0OQBz7WbMVB8+Z6BBibsKbtjhfs9bl3LXmfFocaJuZjtYLF5HGFV92QeMCXCQEmc+IjaM8LJhhdr7Fom2w4L1RL7frtj5ebJHrzQhAZYb97o3SnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp2nJjYAbCYHEJGVjJyMGQx8xsfYd/HaWchn9hmlywE=;
 b=n55THrGvoMm/BlsyAfBj2k2DIYnuJeskUoMd/ziGpUUDkKOj+o2Y7/02x1XHpyevq4adHS0lUcKJ99uafb5iHM6JN3078S3Zc8ImDi6KNNMRZJ2tJ0MkWPe1GEOeCN6Mq74B3bd6jSimoqjFZgdk1cAHV/p1ZmtMvY6XLKlXMgYQcvt0QP/+TBWyv0MvRIWR5tNEGYfZJ5YWVpYZ/t0uLBsdpkRisgdqglsI3ynkZBkvwTAflrscDEBSAlw2jHpQYVK8NAgOob0eZEx76Z3Sv1q8tW+YuQf9g1p6HyHcH3T9NM5rStOz7RluxjoPNR9y4rGzmvd6uXTmXE/wC7/pQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp2nJjYAbCYHEJGVjJyMGQx8xsfYd/HaWchn9hmlywE=;
 b=cuLMNGOynb2u6r+ziEJy/7+KNZ9RbMe58N04IC4h76qzsihiy3D2SGyXr5ja5GHdlMoIutLHx00f/NELZZbfI83W1Aavo6XNKwnITMyCfH5FDdNlmAfBITc2iBZ7pEqANbon5YoJOhXhImzQ2hY3noIf0ZQ45evqyIgtZhRwXFo=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB6PR1001MB1159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:66::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Thu, 2 Jul
 2020 14:34:07 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:34:07 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Add support for Kontron i.MX8MM SoMs and boards
Date:   Thu,  2 Jul 2020 16:33:05 +0200
Message-Id: <20200702143337.8590-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (46.142.79.231) by FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Thu, 2 Jul 2020 14:34:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.142.79.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a91918a-cabe-4edc-4036-08d81e94fa31
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1159F6CC09789FC98EA47204E96D0@DB6PR1001MB1159.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyaLlbHK/kQQTodnCif5SO/bVzHHDwZGmHynINDHGeGcPoh7L4vClNjZWj7MHKFwqCX2ut7nbSGhS/cBsgG/o8dEI4uYqtiADi8fIq/GKn+CS3JGMjEgZiyDnRLbi1L9mE7ocLgSEgkBtYpKOvKySAkZ3/9Wn4y3CUcY+rYAdFpUEIpU35L1E0v6i1UxJCLKqqLddoDfkghRZGfj0Tauy+bA3W7nSJXvvlxokn07QmJELblvZ5OUlQxwMKo4g+g8xcKfWGBfmEfjoUB24SgugUrcSnMpd0vCxPtkk3EteBvDtQk3WhzhkOADjTPngk5SOnrk3h2wQaE7E7FbWCvklc3Z5IT24o3qSn8hyhdcZFZORGBTPQx5RFyE4h/9JCf8w/Y3EKlKE9a5RdmBVq8EzbPSH1mOcvNbaebTy1/nmLjAtX6iG6Lwqamttz9Km8w8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(5660300002)(66476007)(66556008)(7416002)(1076003)(6486002)(36756003)(956004)(66946007)(110136005)(26005)(2616005)(86362001)(186003)(8936002)(8676002)(16526019)(6512007)(6506007)(966005)(4326008)(498600001)(52116002)(2906002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KFUDomLl7GpReHtgkWR/rcy8FIWzN1EW0ZEQEJjczL9BKVjh+x41sjkeFNV8XbY3jp7Iz+mj4MlD+mVoZrafEze9fwB08F5bihJYMi2+mV19zHV7OX4TTjyza0NRzQXokBEwC1a7GKI2H1hkvjEo2nmzs+9p+qYv1J2AmFms8dJ8D71PRs9nskXhZ4fH0Pl44Y/ddSrV14jg/d/OaJnLB3ssrmzskzrtiSkTc/LLjaSebsnDfvlF1xYmPlPqWqco+4caXVId9uUenBSfXdkfEtyde8cyZTWnyMCzeryaH+xUabfYUXfuoe8YiqdF/DHEpYZyGvKmJYgVDbe7AcI94JsKzXzODk7nxMnDtN5gf7NNynTeZ+bgWIOOOreBId0JB+Ab/rlK+pQa1MOhBPSErJT/2Z2ElTF65T21LGwdMqDyV5Fih2NPfTyfYlqmecbgripJv1UDBHxrKQxpVBiaZvG6nQ8TXunGDhx7FWO795Y=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a91918a-cabe-4edc-4036-08d81e94fa31
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:34:07.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FthTZFTgjhEk0wN6QJ9sHl2BT2OQQPUFi9aBKNRLQywYg6UoR4QRfIAyY1cgG5/0qKmz0FHWaGYq7ut3memwaFtUnkhFH2aDta245db0xTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH offers small and powerful SoMs based on the
i.MX8MM including PMIC, LPDDR4-RAM, eMMC and SPI NOR.

Currently there are two SoM models:
  * SL i.MX8MM N8010 with 1GB RAM and 8 GB eMMC
  * SL i.MX8MM N8011 with 2GB RAM and 8 GB eMMC

The matching baseboard has the same form factor and similar interfaces
as the other boards from the Kontron "Board-Line" family, including
SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
RS485, CAN, LVDS or HDMI, RTC and much more.

This adds the basic support for the SoMs and boards. Some things to note:
  * The SoMs use the PCA9450 PMIC. The driver support is pending: [1].
  * Two other patches for the external SPI's spidev compatible and the SPI
    NOR support are pending: [2][3].
  * The graphics and display peripherals (DSI, LVDS, HDMI, GPU, etc.) are not
    supported upstream yet.
  * There seems to be an unresolved issue with the upstream SPI driver for
    i.MX8MM which breaks SPI devices: [4].

[1] https://patchwork.kernel.org/cover/11557753/
[2] https://patchwork.kernel.org/patch/11639027/
[3] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200702140523.6811-1-frieder.schrempf@kontron.de/
[4] https://patchwork.kernel.org/patch/11037107/#23227681.

Frieder Schrempf (2):
  arm64: dts: Add the Kontron i.MX8M-Mini SoMs and baseboards
  dt-bindings: arm: fsl: Add Kontron i.MX8MM SoMs and boards

 .../devicetree/bindings/arm/fsl.yaml          |  14 +
 .../dts/freescale/imx8mm-kontron-n8010-s.dts  |  15 +
 .../freescale/imx8mm-kontron-n8010-som.dtsi   |  16 +
 .../dts/freescale/imx8mm-kontron-n8011-s.dts  |  15 +
 .../freescale/imx8mm-kontron-n8011-som.dtsi   |  16 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dtsi | 326 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 281 +++++++++++++++
 7 files changed, 683 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

-- 
2.17.1

