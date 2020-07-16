Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C052071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="oFCTg4DU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGPQMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:12:33 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com ([40.107.22.121]:15712
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbgGPQMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2lIW+4jliBiFlBvlCvBJ2VEnPYYsivl4fTfahpcpzJbWh6CrGA8hSFVUi3o5TTMJv+85a4KexsrmKVAZGTpUiT0pvPLgh32OY8ybLBMLDW4x1j1Mmn0Pu1JygacDeDqvtvbtYMiDycZONnO2TWiCSoOPJ110tB+ymNQ7ASWxZn0WsuaNKRH0gCFCWS4DjLXsrmV5Ur7tuE2Cc7hYyKVsorQ1r5caiLDa6rdP+7HWBfUJVdlRyJluO1QTczKFmYAxcZXt3EZDL+WoNwqyXK056FxrYZtZ1RmLHcrEVEOZlEjP9DwdwldjECn7HUxry9skhPeiR/TBzl+unPfqHVgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PL0phlUnPQ0FdHdR9WVyYU9N1YaMsQbo606tHWKUUI=;
 b=hPSykzVOagQzgJqC/vFntlrLANn/iSwJkUC0zf1dOq2EkPv4qzi2fdSL10VQO/ungLUE+hOE8gL/t0nGCMEvqBK0ottqUOEbBIoigFWiAsNkVezJGAIdDpbaDkKtdKvLauhXwrBfJOfNkhbY9zXPLzPaUBClzZ8qdgXZNMgGo5ocm4GgQH0Oa8Zejw2NWMKSqOUeJMl9V7WeuTHEgKOzU/b2X/Xyrygq5OsLCvRSZBZMq15HAqSHJP8lGA46HIRMe4IpIeCKTuum9j1XgahvB83+wY5OOzJ2ss2KpTPaMSE7m/rHUxPyJdZa2ptxRw93pKbelkdSZxu5KtrFKzdefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PL0phlUnPQ0FdHdR9WVyYU9N1YaMsQbo606tHWKUUI=;
 b=oFCTg4DUDrxSAV+19pHJ7LIlDyWT3/cWuw3h95NAp7K2Vlw+ZKM08jTp/sGm70VTdo3YlF0gae8KnAYl/9ckMFajtNJlovU6kdaCNsey3XKCzxzWOAvCHIlI0QD0YLbMvjmjhPfl5cPDKJhGpJRo8XrKiQDyjqW/LRrZBK6EoXc=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 16:12:28 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3174.027; Thu, 16 Jul 2020
 16:12:28 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
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
Subject: [PATCH v2 0/2] Add support for Kontron i.MX8MM SoMs and boards
Date:   Thu, 16 Jul 2020 18:11:57 +0200
Message-Id: <20200716161216.15461-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:208:136::32) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (88.130.73.71) by AM0PR05CA0092.eurprd05.prod.outlook.com (2603:10a6:208:136::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 16:12:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [88.130.73.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc477780-e753-4c41-cfde-08d829a308e2
X-MS-TrafficTypeDiagnostic: DB8PR10MB3339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR10MB333949A8E2AE58A0C93E2B80E97F0@DB8PR10MB3339.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXeTimA+DcZ3BOuEw5bcsLRkkgWzcHTs7Zn0EJdNco2cuTXsOo6y+865puohn9Gwm0nD7scn5+crqeExFSUOGvdsb2k3KrTj92diDdSO9EqSZnTSLFEuV9Wp629KLMjT+XMdaIN4S0oskdFk2EaaXVVRHhu6t1IkzMRiqaj5SaiLknrAJaRTbdqfXELVZS0GoKv99taRYFmWFYmDcAEvZ20L7clcOhufe2Ja9O+d/ztBs0ZK0xEqLXEW3mUHOQ/IPwmfuJfYb+n/3vsjTcZ6ojFzeDc823dDPqxpWNf3BHHEhQdQpKxsIfq91t64J3WjUw/uUlrXn9SiAaLINpNeK2egh/O14giRHWMOyil7bUI7Cm+34X2Q/Yt/7dVWfOh/Q/TrfrNZYYn/mZEb0zc2qwO+jL3KuKYuV17vrHKPi57WWtPhPa3kCZlW7sc4hWCw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(52116002)(86362001)(6512007)(66946007)(956004)(4326008)(6506007)(110136005)(2616005)(8676002)(186003)(26005)(8936002)(16526019)(2906002)(6486002)(7416002)(36756003)(5660300002)(1076003)(66476007)(66556008)(316002)(6666004)(478600001)(966005)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r1YQ3OczkVDtRmZMPw3a6fgh+LIih4wW96Jlq6yiGyBrTvbYk1W1a+wvpcnmn9G4zCqfYgxCu6Bi/WK1mz+zu6vga9s6UXpIutb6VJFbyA4AliNIKMtn3S7i3Di26usSaQle9MIp8ejRaumgPa/l9m77mnyeJiATJuOA695LKLsB0UXDUEKYAAuJsgec1OG1k/Cm/U/m5MrZJHKaw3l3vU9deg71jGRm2Y+Q00QJ3dFcB5yQbqR/ihOxZgG5hWdVFQL6LxsYGOgXvCszvnkUU2TKmHnRFFCmS0xqoWggVQemj7PAO+jYnIqkKWjLWQbZkWChUNtfkN+EsJTmh5PR4Z934clqG3RTaSXYQUpu5vT9Fkx78GzSqn+oSllKhYdSaRyQ3QfnjDuZrqbLOKi/CqW2r/NC50F2m8BaTqRW52uCnGwb2a7Yt/xX3GLUM7Tci/ZLjsv3eGsztNn8zQF5cjnaj4or8Jou0YiK7tobdNw=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc477780-e753-4c41-cfde-08d829a308e2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:12:28.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uSXMUDcpzVHvF/6gtbyRC0WRudjWwH4PmsSKzjxnAsnJYRJxnIfyJu+eZbeGfvt6q1xgbcaz/ueL7e7tkaCA5z7Mk7bdEEaiYeJ2lBr4Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH offers small and powerful SoMs based on the
i.MX8M Mini SoC including PMIC, LPDDR4-RAM, eMMC and SPI NOR.

Currently there are two SoM models:
  * SL i.MX8MM N8010 with 1GB RAM and 8 GB eMMC
  * SL i.MX8MM N8011 with 2GB RAM and 8 GB eMMC

The matching baseboard has the same form factor and similar interfaces
as the other boards from the Kontron "Board-Line" family, including
SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
RS485, CAN, LVDS or HDMI, RTC and much more.

This adds the basic support for the SoMs and boards. Some things to note:
  * The SoMs use the PCA9450 PMIC. The driver support is queued: [1].
  * The support for the SPI NOR flash is queued: [2].
  * The graphics and display peripherals (DSI, LVDS, HDMI, GPU, etc.) are not
    supported upstream yet.
  * There seems to be an unresolved issue with the upstream SPI driver for
    i.MX8MM which breaks SPI devices: [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200716&id=0935ff5f1f0a44f66a13e075ed49f97ad99d2fdc
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?h=next-20200716&id=482dcb2a04fdf6d4306e40f2b0537a313a466558
[3] https://patchwork.kernel.org/patch/11037107/#23227681.

Frieder Schrempf (2):
  arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards
  dt-bindings: arm: fsl: Add Kontron i.MX8M Mini SoMs and boards

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 327 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 294 ++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi

-- 
2.17.1

