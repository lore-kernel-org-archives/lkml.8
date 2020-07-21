Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F55120684
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="flDFcnY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgGUPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:42 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:15521
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgGUPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0ItYYmt1oAJ3WXhOilydApMp1EIcoRxLBUrlbTucOH+Vyh4sH5X1qnAryTDDs8dvMIfNetNEFpSUFIAe0MXdFBTcXhYIZkScVkRE8Lupws6yvUvihF+4GyNEL7JVAajrrNXvsLro4D+drwwPwAyb4qkXjtuFokV5tISLa2pHxiT2Ly+SZj8Ki7kwpkPyp0/3QHi4/2KW7kIv3NgfN208qKWwU6i/7Do61O9JpgAxmJCeSowEPdm7k9M6P1gLIJ4uAfeJ+8chB9ketrJhNHHoGoG8pDspk04dMmeMBPixs2bwpGZPzWesqjB/kvRnMlrIF98IGD8gqcvzMxXWWgUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn8uwiGgXFhwa0Cp9A+6EUkaKMM32q6XPLWd8fetmq0=;
 b=GYxiQ+ECiCSqUK73hIa9sWkhOlKEDweSQxTERgjTr2o28jyIybOu2Xy3ZyI7hSHAe9AO0SO4rWud+qLYw/KkH56x5E3SXmpO+NX74JL+5o6dLHEazakJEbMKlqpmhHcOiJrYb0r9rQYlDob30MX324jI7yUS5KgE5WdpBeNAZVWNGL+JH0RRiG280ZOLjtMV6x+RuVrV1YXX92xIQKbGRwVwErNojY0a2nCkOsliqTSMmDVoqP6O9ksmXUgRWPzNVqxD/HQDI1IXHqN2K5Q3FCut7Mhh69FSx1NRl/wV0OValI8kX2/jocyKzPwg6A9IN3B9d5dxGUjQ0Q8xQ19pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn8uwiGgXFhwa0Cp9A+6EUkaKMM32q6XPLWd8fetmq0=;
 b=flDFcnY2SdnayB5lAVg8mp25AgoahAG4EB7GVOQcvWEWrOCw1QBP/hICA46BS8G2oTQW2pwefzxTCgwvjq7URRusOUnnt1Biy48rbvt2zgvVdxeDo3I7w1e3fyGOulSYhbFZSqMWMiDWkd9Y6a0XYP/RptwEB3Bm4Oh1dlFShNU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4929.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 15:20:37 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::d0eb:f746:90e:44b3%12]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 15:20:37 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v2 0/5] Add support of SECVIO from SNVS on iMX8q/x
Date:   Tue, 21 Jul 2020 17:20:30 +0200
Message-Id: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.21 via Frontend Transport; Tue, 21 Jul 2020 15:20:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [81.1.10.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 043a7c6b-be71-4bdb-ac1e-08d82d899ea7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4929:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB49293A12597DF4C775B2FFEED3780@AM0PR04MB4929.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmvE7sU9/EH1DUQ1bOlXeBcpIeage6L14wbv3P9JGIcZfd+4/wjdBVPgklY4DPhTsEUtKiWxJmdumqBqhjU3E5qwtnWzwzu4pRsFkYZg6PKIPB/SBNOWyXV5b2Wp+ZcmvYZvjRIv+Eif/kSdo3JdZn8X0MqyMKB/WJ7MukWbljFx8Um7QIDPdryED3FphF6ilU4nDTDjm6p6imzbby5KFOx+faErv8CK35vbzhZ3RoxBwxUqUEzRHtmfjRYEOOMCDm1L0w6Pm3svJkf4xsOnMrzRDTDLSw9Q52IQ23wWB40SVqo0fasdSZy4xQ+otxR4rKCYQKvBC1CP1wfcGKVkeM5+Q65KJsE3uWNHtID6dDRysmF0m51iNOlKTQ45cYZs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39840400004)(396003)(366004)(346002)(66556008)(86362001)(66476007)(66946007)(8676002)(6506007)(478600001)(9686003)(8936002)(26005)(52116002)(6512007)(83380400001)(2616005)(4326008)(956004)(6486002)(186003)(316002)(5660300002)(2906002)(6666004)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k3mXz43/Sb4jIcKRMCoFNxE9qlnwJIEUP0MnHNaci6fuhRYoWZl6paRBGnpGzo9TI1a6oPCFmC6n7pG6aMo0lycTpUeGgycUEN3wVNPCvSB9pTGhhKDZFTUK969zDPtg3IqyT72PdBZz0iHczLXs0wD5gY1IUKlOFyLukPygIgUSLebhX52j9Oe+vodL8+6/GFlaE7clUSlkZxojuv8ttSrXj+WmOQOqt5XOg4MNDachTvaMJAf41gWEtSWsLt4k3pugPh1hc174B99vMwTzNNzhvoUSpCCQb/vYzAA5ZT116LVT+M0Ff++AKiTc95+z+eI39U6OTwG14ZIraCZns/229mfzhS+EEgcI2ZQfITIU4le4VZbIGrcdiXLvFVf7tVJzxusLn0OVF2dQ8D4fDdYx+7EwiJxPiVKp5eymCly+2VlGEqur8k6azMt9Q2Ga3I45B02/113WwyBa4pnE5Tt16GKZZTCv9GVXFXnb0BI=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043a7c6b-be71-4bdb-ac1e-08d82d899ea7
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 15:20:37.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CjHFVPyfoWzDiqQEpdNkOXrrMO5zZpwG/EDEFRQEDStGR0w6NMEDjDBq6DWBraqk1krK8wrX6btMw51EKwTH9Md+dzIKu2Ot4MrptzRH2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patchset aims to add support for the SECurity VIOlation (SECVIO) of the
SNVS. A secvio is a signal emitted by the SNVS when a hardware attack
is detected. On imx8x and imx8q SoC, the SNVS is controlled by the
SECO and it is possible to interact with it using the SCU using the SC APIs.

For the driver to communicate with the SNVS via the SCU and the SECO, I had to:
 - Add support for exchange of big message with the SCU (needed for
imx_scu_irq_get_status)
 - Add API to check linux can control the SECVIO (imx_sc_rm_is_resource_owned)
 - Add APIs for the driver to read the state of the SECVIO registers of the
SNVS and DGO (imx_sc_seco_secvio_enable and imx_sc_seco_secvio_enable).

To check the state of the SECVIO IRQ in the SCU, I added the
imx_scu_irq_get_status API.

The secvio driver is designed to receive the IRQ produced by the
SNVS in case of hardware attack and notify the status to the
audit framework which can be used by the user.

The goal of the driver is to be self suficient but can be extended by the
user to perform custom operations on values read (imx_sc_seco_secvio_enable)

v2:
 - Removed (firmware: imx: scu-rm: Add Resource Management APIs)
	-> Code required is already present
 - Removed (firmware: imx: scu: Support reception of messages of any size)
	-> The imx-scu is already working in fast-ipc mode
 - (soc: imx8: Add the SC SECVIO driver):
	- Fixed the warnings reported by kernel test robot

Franck LENORMAND (5):
  firmware: imx: scu-seco: Add SEcure Controller APIS
  firmware: imx: scu-irq: Add API to retrieve status of IRQ
  dt-bindings: firmware: imx-scu: Add SECVIO resource
  dt-bindings: arm: imx: Documentation of the SC secvio driver
  soc: imx8: Add the SC SECVIO driver

 .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  |  34 +
 drivers/firmware/imx/Makefile                      |   2 +-
 drivers/firmware/imx/imx-scu-irq.c                 |  37 +-
 drivers/firmware/imx/imx-scu.c                     |   3 +
 drivers/firmware/imx/seco.c                        | 275 +++++++
 drivers/soc/imx/Kconfig                            |  10 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/secvio/Kconfig                     |  10 +
 drivers/soc/imx/secvio/Makefile                    |   3 +
 drivers/soc/imx/secvio/imx-secvio-audit.c          |  39 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
 drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  84 ++
 drivers/soc/imx/secvio/imx-secvio-sc.c             | 858 +++++++++++++++++++++
 include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   5 +
 include/linux/firmware/imx/svc/seco.h              |  73 ++
 include/soc/imx/imx-secvio-sc.h                    | 177 +++++
 18 files changed, 1991 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 drivers/soc/imx/secvio/Kconfig
 create mode 100644 drivers/soc/imx/secvio/Makefile
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h
 create mode 100644 include/soc/imx/imx-secvio-sc.h

-- 
2.7.4

