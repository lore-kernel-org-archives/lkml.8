Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C97C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5583206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FPJvvm45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCSTvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:51:46 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:28703
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgCSTvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4zofgkZ7zP6Gw5Te1xkIS+tjd1YGkHLrhfPGnfOiRvErYMAgViuVPaTQrEMDWEtRISSCAIel84/8LCKJwC0/fbdD5Eo4R89msT6/BLqsBs5u4TeWK5HiMLN7UuxS+lqCjQUGKMjZZKTdLdILDRVvf9D3G+wL34JgtVyAxZ/opHL9xaXb9Qn0k1uyB0Ypl0M08kQzj0TRBTEvDmkCaOEfpiQXeIXGLGbvbQjigeKqpvqnOg1hLEiGS7xSxykxtkhslw7b85SEr3c/OICfJAUm3XCh75S7ZfozVHCyhAapypdugcR+mdmJciFSIkI7/1N12nk//PqlbZdJPiiWR51ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33Y+k5XVFn4hawpiqiZ0JEg5M5ZSQ1Lh1jAjmWH3bMM=;
 b=Ybd27aeWUUnUhk2QjfLJm2sknDmYXiz1xNGOQNbhjlX8bLEhHwWwyC6IYqdJs+KaB9Fi/Pp+SvELGwODESU2fwpAefb1QZKVBKLSUDnrDSRvsQfPxQNAuQF57qboYMunyXPOWrfx16S0felcIA3MUqe9prO57Aj8R5mbzwVHTnmEPpMYp0T/T6sjJAg8dB+T+7GfM1fxmgFxAffNzl0Fdwp9ia3SeR+OVyJ1FcM9NlAWDKXy/9Lj9J+8e8xDR1GVnhC13nBUZT47LbIzG36XpDYz40KTB6RX1x8D0EnEzAb+P6LMvHww6hgS8+MdUV/PlUFbw6s5OnBHOKCviRGoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33Y+k5XVFn4hawpiqiZ0JEg5M5ZSQ1Lh1jAjmWH3bMM=;
 b=FPJvvm45tYSLWmK1t3fz230Rah/0tsGBqJGsEFXNeCkaM4QBSrRsKEmbN9bTP7+KawAeah1Byc/x5XADhdyhN1f2JjQctdMPqKhka2xErmIFCVvRyRqy8dXtiDZGX0vTy0rx+1Slt+LgTsjXK0grapLURuYDWlIlfFGeSSGc3lA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3486.eurprd04.prod.outlook.com (52.134.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Thu, 19 Mar 2020 19:51:41 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 19:51:41 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@gmail.com, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        yuehaibing@huawei.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/5] Add support for SOF on i.MX8M 
Date:   Thu, 19 Mar 2020 21:49:52 +0200
Message-Id: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::44) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM0PR07CA0031.eurprd07.prod.outlook.com (2603:10a6:208:ac::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Thu, 19 Mar 2020 19:51:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7eaeb31-5b4e-4855-98a2-08d7cc3ef1a9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3486:|VI1PR0402MB3486:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3486E70DDEC1DB7B40580ECAB8F40@VI1PR0402MB3486.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(81156014)(4744005)(8676002)(8936002)(1076003)(81166006)(186003)(26005)(956004)(4326008)(16526019)(2616005)(478600001)(4743002)(6506007)(316002)(6666004)(2906002)(44832011)(86362001)(66946007)(7416002)(66476007)(6486002)(52116002)(66556008)(6512007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGxMB3yr3NIjHkL71VSOamB8pUYzRhtj+Y69FHeMnXpqosZCzEsvF4WZykGvw/aShyOMo+/h3UTCJozdkub208TvYO1NUc74WYu9Wkql8DeAFF8w1yNcjnGxHrUkIT4lDFxSZ8eqAZ7gT7cV/+g+OOSixF5aGAgkH4dcd3YXM+49CzjxJ7aTwgXCxyqZxqY7mEe8R0oVwBE5OE4AaXXLzvYUerICiqiVE4Y+uQS4VXsETM20BUME3VxEcsgMapJcsij1m/Rxzrk57ndIRakEizf5DGaYV0qO47bC0gOY4An3ck6JdChXM92+oWvs7kh7hym3TKtdz6y4PC1Omk3vXCGm4Lud8UmJJx6J9wHRrLaQO/ICyzGzccx31M5afE7X2F8+7DGhB41avpt1ooD4b532lTeck8GDweJ3RSrZmc169vGuaIpgjESJ3UJHVYCJ
X-MS-Exchange-AntiSpam-MessageData: FicdRk1BQFUw6771FAeXE17a6AScZSlpPKbpH8y5VRYwX4HeiKfVnybF1LT8QOobjmMYop3956oSdqSkDQEhg2fXvwcFu8otfQMdLyZfpJbqmmzPusx/aKlei5T28dmstalS8ILDiC7OiiXuqcQhQA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eaeb31-5b4e-4855-98a2-08d7cc3ef1a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 19:51:41.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUxIjWvQbxuE+3Gt3pxQ00551TH/bQ1atvALi2LoP9OCkPfgBWLINSwVfh4lZgdPoSh0IVs+ADv4EZJUhI62+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds support for SOF on i.MX8M family. First board
from this family that has a DSP is i.MX8MP.

First 2 patches are trying to fix some compilation issues, the next two
are adding the imx8m support and the last one adds the devicetree
binding.

Daniel Baluta (4):
  ASoC: SOF: imx: fix undefined reference issue
  ASoC: SOF: imx: Add i.MX8M HW support
  ASoC: SOF: Add i.MX8MP device descriptor
  dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry

YueHaibing (1):
  ASoC: SOF: imx8: Fix randbuild error

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |   2 +
 sound/soc/sof/imx/Kconfig                     |  32 +-
 sound/soc/sof/imx/Makefile                    |   2 +
 sound/soc/sof/imx/imx8m.c                     | 279 ++++++++++++++++++
 sound/soc/sof/sof-of-dev.c                    |  14 +
 5 files changed, 325 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/imx/imx8m.c

-- 
2.17.1

