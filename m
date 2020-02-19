Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6660C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87DC21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r88Wp/UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSJ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:59:43 -0500
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:9312
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbgBSJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViuTN4t1WoxGvObKyKJhfjtFfMyJPdMuTo7nCy3569jxX+FAAAXiujrUMsDYcDkoyWXt/e5AA6L2FZx0WvWQmJx6TvIhYviIYKzp4yKxuyXYmuesM6+dGkmdTK2YXdrXGtX6bSMssvOrURRNrektBFd1RuOEnAp3oLI9NeILwr3jH/RJgoS9PugKxFrH1MXAhOpEzvFwf93+4nrnuT0ZmOOnpX0M4EQM7MDiX2WFv9XKSdRJig6FZ6q3AvU/8hJXtJMRhs13mVsSkMNQGnPF9JqjrZWIaz+HSVV7jxX5AbQvDwbRfTFPpG9kCMqj31iQRyTTAEjN5ce8PBfz7n+Y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUs0+8jKfz67XE1EDU0COV3hY0F1wHrKeEL5stXCfh4=;
 b=XxlMOsN7nP+el48TesKRI2rE0wQrbs6lRnpTXOmXOR9Q7sSFxJr5F8fDSVWhXEvU9JQ/BvDhxJnfqcbb/eMbcWUPKszIgWYvCLsvXepjeGNWJUNMDbFpvetTqtg1FUNnTMOobi/E7W6PrxfybkdHZjBNieAu+PbJnXBB2eVyt773xN9eXXpcndtQrPuQuAOGAcCsVHt7ok/IxuH5Y61JeH1XzWv/Y8w1Lr2S+IJscMpq9dewnbChhbWeD3RvduZ2nmY9R+arC7CvC2h3b8WBysKGaEgSS+IGhdBattgdzxvGuCRqFHV5bu3zzECW8yglSSJTxNNnkm1ZGY1WnIFrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUs0+8jKfz67XE1EDU0COV3hY0F1wHrKeEL5stXCfh4=;
 b=r88Wp/UD1wO3x5Fvkeo/6slIVSZjoj3IXD2O9/DUIr1WBmUha4azIxAcqv+4uCOF5/I5mULg1uD6ktC/oLmewZxXKrWnaqso+2in0pbCBmcils6yO9irPFzQdl7OJ4m/U6Z3xT4E5g8rotxZxxG35hieuFkEhfK2Xd1wSp5hPFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6514.eurprd04.prod.outlook.com (20.179.254.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 09:59:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 09:59:39 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com, leonard.crestez@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anson.huang@nxp.com,
        ping.bai@nxp.com, l.stach@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/4] clk: imx: imx8m: fix a53 cpu clock
Date:   Wed, 19 Feb 2020 17:53:34 +0800
Message-Id: <1582106022-20926-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.8 via Frontend Transport; Wed, 19 Feb 2020 09:59:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8ac4cd8-a3a6-4213-b6ac-08d7b5226ef8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6514:|AM0PR04MB6514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB65143663F3703822FC5DB91488100@AM0PR04MB6514.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(4326008)(2616005)(956004)(6512007)(5660300002)(8936002)(9686003)(16526019)(186003)(478600001)(81166006)(81156014)(8676002)(36756003)(2906002)(6486002)(6506007)(86362001)(66946007)(52116002)(69590400006)(66556008)(66476007)(316002)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6514;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ld55/VfB6iZDzJk6QRMhxIWP0iuf5ZOZ7j0/5fTG89KKJnwAznHvIUTx1i3Pj75geHFMU5EXG0DrsmOsdlumcN6Gryr2syXs7zpzisOO5eG5ld5A3F6dG19zJ1P+HlyK+Dp0aMP3vc0oPdby8vgUtFYu0CihbgMr94Ob0rQ4qNKGDZFYzuNDI5TZ+jlVRnK4opt3DU2humIrP0HuD/s+AkfevDA6ZnfKWgzFbRChL3MF9UD+C1aCb/PDGi7KJSuX8A4sumjmcJu/DmWhxXDE0bUs7ryU9P4vMlHP5Or+vJPANi5iTp1X1vEq4xVtxn7GIHIpGvqDGpn5gaIcjLnM//iy6ukkrdqivs4LtsofVDGnm1dvyj9NG2+NdVK+iAOOZJZ8KnuPFZt3+4Zc9JvueziI8/0Xp+DRO10l/SHqrNtAYC2ygJsp2D/a/yOBVxXtd1g1PiEvln8uSdJ/w5u6b9edsuH8oUqxIMOIMumudKJiWO6fQZXy7aM2DjAYxNDJeoq4ueOgDHr3KHQGxEtJg8Gc76AggXkOGJgeuvcCAQ+LGgnmeSlMxW3NGfsQUQSL
X-MS-Exchange-AntiSpam-MessageData: BeOaCoLIFR3Yo5Uwgtu15rX48MC5jahHh7pVMR9NTedDcItHrerIRYAfDe451T0EqwSc9tW/pnmUqtYMjpBCF7rNyt4OGyM9LZ96/eUCNUYHvNdVOGfe5CqAlU886L2iEHKOrulA2bPriUxj92BO3A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac4cd8-a3a6-4213-b6ac-08d7b5226ef8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 09:59:39.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qewFcObmvNFQ15roaR/j3whPr1Zpm1dNTinsHS1652X/4xmotcU1tFkV3iVcHZ1Y/W4lh/pJc/UbfXXxEb12Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Rebased to Shawn's for-next branch
 Typo fix

V2:
 Fix i.MX8MP build
 Update cover letter, i.MX7D not have this issue 

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Peng Fan (4):
  clk: imx: imx8mq: fix a53 cpu clock
  clk: imx: imx8mm: fix a53 cpu clock
  clk: imx: imx8mn: fix a53 cpu clock
  clk: imx: imx8mp: fix a53 cpu clock

 drivers/clk/imx/clk-imx8mm.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mp.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mq.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mm-clock.h |  4 +++-
 include/dt-bindings/clock/imx8mn-clock.h |  4 +++-
 include/dt-bindings/clock/imx8mp-clock.h |  3 ++-
 include/dt-bindings/clock/imx8mq-clock.h |  4 +++-
 8 files changed, 59 insertions(+), 20 deletions(-)

-- 
2.16.4

