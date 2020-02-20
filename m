Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32EC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D824656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0w87aSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBTGaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:30:22 -0500
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:61774
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgBTGaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:30:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuttUpV/MDAJljgOVaq5u5TYICY7zMOdMMgRuKbJf/5zwUuCATqzwSzfYtVrtMlSqipuJ9/ZzynV0YggqLKQCFaSOMPzJn/754ujY9zDRwMfiLC/kzFhNff9n9UaQRjJ6G+aZKKwHzUWg3YRFOpFsls2iohwE50c/HcpfpbR6phuPZIUSppN6ZEmtg3qJTXC0FxlzeNNa7VoHMjrQsmvh7ByuwwXVpzjrjh/yGcLRuV9nyIY5FBIGIOYhqHcaL+KuV2cMeS0jQDnsxs0la+nLszuhgyeiclgwj8vGK9w7o9Anj/c8r0yh4jcy4RullBRHHsWVWw2xKNZ0/5A32KXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv/Cl6IAPZTxNQdDL67Xai+EznYnAbBpe0JWur6Ws3U=;
 b=dw+uUMdEACtTopY2lp5Zsa3ytGf9etswXdj267trpdnzAb7KvK+Su0BBMXjIB5/XbzmUZ0dge8ud5RDW+s/f4cb9nujP+417kQK4Y+jzQ46Ua7mIJQ7iASbMq8fRyTHoYaaPOe3ccSjBbqsHN0pZJpfo8kyvL40pfoaKoA1vobp2dyxRm9SUlm0bpyAAvRNoQgGZlGK8uj5DjNuxDcFBJ+q6UunGVvIFY3sNSYxCjbn6CHglSvbm5hufJbHnBBFcows+hwgfHa+q2reBmwKSoMmgnHi0AqlyBWQDPyLjtkXhY3IopybiaF/wP/MhZvlEBreVqfxnRpCmtKGVRbBoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv/Cl6IAPZTxNQdDL67Xai+EznYnAbBpe0JWur6Ws3U=;
 b=V0w87aSRb3H/diKIaXdcbrqz6RbWdscx/7UJRaLXZsg0hT7TBFh4O1W5ktvmM3PIRmVbYshsFnPW0xu/fPXGD/Wa8JZPsMn282VRKJYWFZIaGR0xQCcw4vJuKhqeFcz3TteK0ce6Rp+DDkwRyE0GYKsL3iIm9lvI17dBHRuIEHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4860.eurprd04.prod.outlook.com (20.176.233.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Thu, 20 Feb 2020 06:30:18 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::59e6:140:b2df:a5b0%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 06:30:18 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        olof@lixom.net, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/2] soc: imx: increase build coverage for imx8 soc driver
Date:   Thu, 20 Feb 2020 14:24:01 +0800
Message-Id: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 06:30:14 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44314b31-e790-4c94-469c-08d7b5ce5a72
X-MS-TrafficTypeDiagnostic: DB7PR04MB4860:|DB7PR04MB4860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB486022C3E6413A7940DE19EB88130@DB7PR04MB4860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(8936002)(6666004)(66946007)(66556008)(66476007)(81166006)(5660300002)(69590400006)(81156014)(8676002)(6486002)(9686003)(6512007)(4326008)(36756003)(478600001)(2906002)(86362001)(2616005)(16526019)(316002)(956004)(186003)(26005)(6506007)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4860;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UPQP5ZQnD66FemPX5flaKYizOihhWeYaVkhfTv2DhsM7unJDVNSP7vQSIiWqkeIEYxG+IL6tBVlrlqSy2dME2LSMLpjJVS92kP5tUzmfzrrvtBMGcSZ0hiCbKPgAlWlB3ShURAzECm/x9x5ED5ulZkJSAuVWKjkkyGiA8wN4XCs9J/Fl9BvzmymUJcgVCXtiHCRJTaWHiSUtLPlncDJnCmvKjg51sFxsUCVtEla5itgLsTBZ5kYGfJFZTnVohiLHwPX57mbOteY1q1pi1gRKlZQefLspQbUcY7jz2LSikNLXm2DnhIJRajqqLuF69cuKCkZouikKX3FQywRoSHuD6IjBQ8WMThoUOIp6RBRt9qdglEdjULwOcAPJ/s+UxvuqkrXLPFczGUZPJPhobYW7MALQzury2ucqGl6AqS3rVHkZoMOSTvI295r2cjEeVYNttau2wcY+8ZdlfC3mlGyqCFOFAG0Q1lEArPfKGuduhkMyQ9HdUola05iX7PUnjUTNJk6OAoTtNa11Cm1ZJc/LoumqVBb7+YOLXYZjlPQ7LQ=
X-MS-Exchange-AntiSpam-MessageData: sPJCH67ibtXrIRlZoQYG4Tn9hUJJFDEdVEYm0ai/JOCBPrJcxS7sw00UfIw1pLUQ4jfTUK1k6b+wuVFsqlETuLVFaf0T68HxY27eO9AInzHvrURR0JYTnXtsMcGu5edQc6unNPh36QM/ib9kXRak6g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44314b31-e790-4c94-469c-08d7b5ce5a72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 06:30:18.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwHNY9fHfFFGFDgNomLtrxzfT48V+7vxOQL4oImqWFYknpwgsYvKsSDu4ROJtY+GcRcgvFsHcCj6d+fGRztImw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

