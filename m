Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB29C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DACC20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iqWKzCUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgH1Lci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:32:38 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:41602
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbgH1Lbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtNP0qae2U4lSlUsq+94g8iV2tkiI7jSbQUIjMWtPWRfyVnpDFV6CLgjbuToFoI/X6Id1yYKwbTXU3YYbq8vxtKT+KMkl2o2OFTe+BtK4CJEEX20H5hil0ccVQnrX0Nu5Pc2IwalRLBYeKoSBoqLOm/HHxpY0vFMknBNpewz3xQBKEsGkuPg9dzCBc4XxFZrK2Pn7kC2TTPPPIZGn+m4lDmiaGig32Anzcd6lg1uyvbK9DAWewSOU+CV+bI5066VIsaQjluV4ghBqgvGD9sG+CEd8rI5OD+oSAyW+ClQK4AzBvngVeUheGFMqBjN+p3gnzWCPwgVWTyz8KVCIjGiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyE00kQNXiIxREz+e+Xc4qA0kHJwdxlBf0U6bN3psDs=;
 b=U2f44k6Qz39sltzw4Mtlx+C8u1xdDK8P+P+Kn1tuvwBUsClmbGs12vfVyXn8+f5uymChmGVMOu4jofvRoRDwlkmhjIvcXF9ha2bqD3YFmPBLBToVALv9IsLd1mCjTp0iLvzEV5R0MeP9XsP2oPVzh6JjnpQIAc4Wx4CI5Z9+DO40CTyhstWo21EcBfq6hylL8zTeNCfBZBOUw/apSYWTo1NejfDbRR4ns5Kbe87Alrt+dCdyJWqQiJXjIAi4hqrH6ztkaDfx+/cBLaqSORIru5Y4k0fUrg+9oV5+/oB8cp797wkOJ9E/MMq27S/Cyg957EuSns7Id8PlFQX9davN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyE00kQNXiIxREz+e+Xc4qA0kHJwdxlBf0U6bN3psDs=;
 b=iqWKzCUZDxmGjHCTZaEONfB7QRMpRfxMfYq80zO6FpXDshoHVAYCgFcfQqOtglZyJsxOpA1m/bM2lRo+kvAwVVBoQAwcYZCQeWhinjsE9YlD3FEUOC8ilpRb92HlGNDa25n220LXyRN53BfZHzj3n+eRXsCUX/aMTYS6dPDb5EY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0401MB2598.eurprd04.prod.outlook.com (2603:10a6:4:39::7)
 by DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 11:13:41 +0000
Received: from DB6PR0401MB2598.eurprd04.prod.outlook.com
 ([fe80::19ed:520c:8c98:e334]) by DB6PR0401MB2598.eurprd04.prod.outlook.com
 ([fe80::19ed:520c:8c98:e334%4]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 11:13:41 +0000
From:   "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/5] Add new features to nwl-dsi driver
Date:   Fri, 28 Aug 2020 14:13:27 +0300
Message-Id: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0114.eurprd07.prod.outlook.com
 (2603:10a6:207:7::24) To DB6PR0401MB2598.eurprd04.prod.outlook.com
 (2603:10a6:4:39::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1664-120.ea.freescale.net (83.217.231.2) by AM3PR07CA0114.eurprd07.prod.outlook.com (2603:10a6:207:7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.7 via Frontend Transport; Fri, 28 Aug 2020 11:13:39 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2944dc5-1007-468b-e177-08d84b436b50
X-MS-TrafficTypeDiagnostic: DBAPR04MB7413:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7413760D877F262316946E35A2520@DBAPR04MB7413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FB/2yxdrPU6oQwbctooBH2cHCt/cH5x8WYjOGeMd85/5H6of3beEga37Ph+oRexjH5g7x7u321RHoyHrvahxA0XtAAD/yJNlcYYAAotaMml4tEWa/HZEx3xb31eKJHcgGqI7wwYy3GOqoAeZO7xzStV0fHy5Et6EZf+EaVest5Gqycg0kveniRjkHp7Dz8qCVIvjmKw+dqI3mNN7nWU7WyBblaX6AWCRh/XumLaJeywSbgnt5sg3aNEGX/IMIY6zsat5o9Z6xRxwY4NWlCoyylS810OO9QOQSogE0GrXq+y/78bHktivXCjMg7XVGmdDivvGHgwq5nOO3XQWCG+jfT7YRQxtYX3mqie8Pur4sMwoxijdwb+UcwDYPcFf7SQX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2598.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(16526019)(52116002)(86362001)(26005)(316002)(8676002)(6486002)(66556008)(8936002)(2616005)(54906003)(66946007)(6512007)(6506007)(186003)(478600001)(66476007)(7416002)(110136005)(2906002)(83380400001)(6666004)(5660300002)(956004)(4326008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZGSOZez02lTg28dGurWy7DIsgvpIcQq+Z5zWs0B/X8ED8RTkrWs8V9ePD+tn9k+NBZZjVM49YEOcl4Ar25aLOx4MQDbqbIxr5nFxCf+aTA/XRTAEo+l1xhoLcQSlC/7v6/7dw5ag6uwPqw7t9LK0GYb5Qmib4Az31xeDswwEJApgZTZsHohyP8eNeqd8iI8+Xd8eJTGd/QsgWPJU4j1v0l0xz2e5m0TcoJpkMc9Lp1mTa6eRs+7DHGdbbSHLVIkgwTsFhqtaMZyPAwAbfprC72vWvvWPNHJpMkAWXrGFsVSdrlAOioKpYRgmd+/znY6cP68fIzMjtbCxvqSF+ayeMLsygHjVTYbL5tZkm0mmjMipLrXcQrG5MoqQX/w1f/E9KJoF5LeRMabwx7zQ2dWLRc8/RzFghUSDW4fFul/K3txSB+lvoOKbdXY2QBADzmmeGrOL1TfgA4n2DT7BUmHtpUnYNQxpJzNoSiJS+Emie2m9SefvygktAT7N1n3tXW+upoz6+ZLkJHCeNJU4qCf5+ShCndlBqOFMzdkxjPZtmob9uCYC8fQ0Tz6tgFz0xdhZaLu8unSReTBf9gOfLA6HRGC8s1K05AT4yg2zdOvMer7x/0oibaFTdFMVLlmfdMrWS31zoA5gC+4zA8uiZJlr1g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2944dc5-1007-468b-e177-08d84b436b50
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2598.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 11:13:41.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9krY5WFpudZXnApwiigAZwlRTeeE+OqS7HCgi/r9M9RPMO3PNGUGsRHC/gmTE+sjkKAU4wuo1c6RXYKqJQ1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Chiras <robert.chiras@nxp.com>

This patch-set adds the new following features to the nwl-dsi bridge driver:

1. Control Video PLL from nwl-dsi driver

Add support for the Video PLL into the nwl-dsi driver, in order
to better control it's rate, depending on the requested video mode.
Controlling the Video PLL from nwl-dsi is usefull, since it both drives the DC
pixel-clock and DPHY phy_ref clock.
On i.MX8MQ, the DC can be either DCSS or LCDIF.

2. Add new property to nwl-dsi: clock-drop-level

This new property is usefull in order to use DSI panels with the nwl-dsi
driver which require a higher overhead to the pixel-clock.
For example, the Raydium RM67191 DSI Panel works with 132M pixel-clock,
but it needs an overhead in order to work properly. So, the actual pixel-clock
fed into the DSI DPI interface needs to be lower than the one used ad DSI output.
This new property addresses this matter.

3. Add support to handle both inputs for nwl-dsi: DCSS and LCDIF

Laurentiu Palcu (1):
  drm/bridge: nwl-dsi: add support for DCSS

Robert Chiras (4):
  drm/bridge: nwl-dsi: Add support for video_pll
  dt-bindings: display/bridge: nwl-dsi: Document video_pll clock
  drm/bridge: nwl-dsi: Add support for clock-drop-level
  dt-bindings: display/bridge: nwl-dsi: Document fsl,clock-drop-level
    property

 .../bindings/display/bridge/nwl-dsi.yaml           |   7 +
 drivers/gpu/drm/bridge/nwl-dsi.c                   | 338 ++++++++++++++++++++-
 2 files changed, 336 insertions(+), 9 deletions(-)

-- 
2.7.4

