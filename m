Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B488C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4557B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8mr45kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgBUCiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:38:24 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:58151
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729259AbgBUCiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:38:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyVTn6z+KqS2kM5cDbLfcsI22FK3zDCjeN55tD/lL//OL7xjF8orLUWeWbUPwCRFgluUUeHaDw2XyjfSkJc32V2KOAYSbduaEFo+ZD+KU3U4Q3rGeZSMMy1jsjITQoR2Bttxi6fUoBovhXwSIne09knLWT0YiAG2B9+buu6gaefmnr/ukwEwRmPI1zW3PxZmIMszUqplW7K5JDi0Dj/B75pvXyd7RU3gTgshobdbdIZeuvFWTqmf+LcoAe7bm2F/YxbujW3g83Ty+G5DiHp8auckvSEC2cvh5hMAndzdmXYLWX3lNDYX5Otfp7EzAVKFLySSkvfqHYRiRwW9oCtvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPM9H2X6jWFRlVlhCfS2tzaunv0fZ1C6GhScDwZiu4E=;
 b=Ms3tHV75ta9Z4XX+OewR35D4c2MziZt+/SahlECPhob98rIkpRxMZAzYA6wEl8AyC1DQvbYJyymekD4Bk0TfRqrMBsNjNeZovwoMkPiuH8CljyN4I18isZcztqbFdOz7vfZ4zbGwfy13R6+nKBg5o3FBQLbKkI8nSqi5GCt0I2jkg0Cvx7Q5s7QvcoobSK+feRd9n7c2No4uS+cQ93/CZ/5iM7N5WWPiC0HU4hndn5vaH5zKoaht9szomSxHAt51zt1idODvRW5FtxYhA56sk7D0jFfyM97oISiMAiy4zAQsbRVH3vYNPGSW4T9EsI7Mo/DKj3tMnmpSDJncphJ46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPM9H2X6jWFRlVlhCfS2tzaunv0fZ1C6GhScDwZiu4E=;
 b=F8mr45kOTdrYu0GOd+jBAg+ggl8MC/TWRO6gho3SdQyMF5ORjzMQ7fVCOpWw0+XhmTCXOu2RGdgGhlMWlOkGsoJHtnrHUEK9CGi4KxlBiM4FKfQtwEMwAwoo1vnU8RHPPaXhTYul7z5qEQzwU0GUatz7r3YffGFsQhRUWX8Mmog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (52.134.89.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 02:38:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 02:38:20 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/2] soc: imx: increase build coverage for imx8 soc driver
Date:   Fri, 21 Feb 2020 10:32:17 +0800
Message-Id: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 02:38:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d6759d9-1915-40ca-784e-08d7b6771cc7
X-MS-TrafficTypeDiagnostic: AM0PR04MB5281:|AM0PR04MB5281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5281B98CF93A3492F337C90088120@AM0PR04MB5281.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(2616005)(9686003)(26005)(4326008)(956004)(478600001)(6506007)(36756003)(5660300002)(6486002)(6512007)(16526019)(8676002)(86362001)(8936002)(52116002)(69590400006)(2906002)(186003)(66946007)(81166006)(66556008)(81156014)(316002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5281;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ca2z5nIaaAuNTU2ozlT6e9cpusPYNpSiTSjGdKzRHaVIIEiVkph4qDluClkQkGwqnMWKvNQgaPBG1PXG+ZgJJCMpf6OaCkxrAbbsBr41anN+VWcw1l0q/BcXjucw9DF/Vo4hlsUoOuRLPXxTrpYtHzyZCJ+y6QPMHCpc3mDBW24YjDsJNbUteULtA3iIj+OVQkMXHvfoqmcuW005lMI34YdWj5h4p4EDCUTiBOgIcyT+aSIkon1SC3jMnHgQuisH9SD5NF2LgT2oMXSB39SzXS+Ms2ZfmBzf2ICkJs7fjz+BCpSuJfZtocCcOu5mi/SqYpjux5CCCJ5TNt9WtxoF8lm1wjPnKqpyvKP3WCGYe0FdBDlhbRsatOlJRPDtdgYwlVMqt5RyBMLjoHqTNewIJa+xwbkjQBtvmhP8Tgye+jBtUDiN+f99nF9v/5XndS3MNoWl4Mu6P8P+kH18hUKoalo++WgwfGlBgchen215KO8VSGMeXgACSxyzDmWUXFNyBDXcChbvlRfgP2Sa8xkvx+ySldCef75dpRW4QUbhEH0=
X-MS-Exchange-AntiSpam-MessageData: NQar+/uk3ZNP806CJSGZ6HftseH6gM3JG9+tWOx0G+r3jfuMiGqWABt05C5YLF6nkM80H08TmqZyueCk2eqpa4wraIlSeXL2+fg0JZ75pLuoKzhxul6Zr+l+gEMkIAjGhJaqQSjhS/BrTU3vel6Ujw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6759d9-1915-40ca-784e-08d7b6771cc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 02:38:20.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m22t0Fmotlntvhv92IaZwryuofTYoOOfegKzHP7+EsCilLDUnluKFnoyO3VCgYyS0j/7E/C+cFxxVGRANjy6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Add missed "static inline" in misc.h

V4:
 Add dummy functions to fix build issue when soc-imx-scu.c built in,
 but drivers/firmware/imx/imx-scu.c not built in.
 No change to Patch 2/2.

V3:
 Per Arnd's suggestions, merged Patch 2/3/4/5 into one patch
 Dropped the defconfig change with a default Kconfig

 Leonard, I dropped you R-b in V3 since the change.

V2:
 Include Leonard's patch to fix build break after enable compile test
 Add Leonard's R-b tag

Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
Add SOC_IMX8M for build gate soc-imx8m.c
Increase build coverage for i.MX SoC driver

Peng Fan (2):
  firmware: imx: add dummy functions
  soc: imx: increase build coverage for imx8m soc driver

 drivers/soc/Makefile                        |  2 +-
 drivers/soc/imx/Kconfig                     |  9 +++++++++
 drivers/soc/imx/Makefile                    |  2 +-
 drivers/soc/imx/{soc-imx8.c => soc-imx8m.c} |  0
 include/linux/firmware/imx/ipc.h            | 13 +++++++++++++
 include/linux/firmware/imx/sci.h            | 22 ++++++++++++++++++++++
 include/linux/firmware/imx/svc/misc.h       | 19 +++++++++++++++++++
 7 files changed, 65 insertions(+), 2 deletions(-)
 rename drivers/soc/imx/{soc-imx8.c => soc-imx8m.c} (100%)

-- 
2.16.4

