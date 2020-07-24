Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF0C43458
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BC2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRL1ZkkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGXHng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:36 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:36007
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbgGXHnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4SiM0oNcDQ6Tnru5emckgGeRAVEYD9QUmrR7CUk0trlxc2LJz3gO253nuN+ILGc9qz/E9ELFdRmcKY9oYFfc5rJJGP1tlMLSpZeWFVx1Y3U4EX0GZ1+gR7FUdXc8wrRJK13RpaZS1CBGWNxzCRxvJKx2O+ebN/tSmRrFBBEYr75y36k54gC1GMyp4/zf/dPq52XEcubkrqgC24GNeXsGsYW0RTSrK5bCIJEd5t+vyQczmX5u3TM+UTvFUHBaNT5dSdvjoA4mWrPcuyOwzGPE6kxV4i+t0o57B3xELmRoOXJCa3hpQu/Vs3LwwPidwcBpCh/YICsg+JnjIAGVNymRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmGgTMIbllQUaEA8zmOQnT0s4TQFi5n7J8IqHXxHCJo=;
 b=KbeGzmKN+PpMylGI5JQy450VAXZoRfPCAc8jr8LrPusC1oHdEjQuWaQNVUT+Bq1YZ0Ot0hNvcmBLVsQAbzxYZTOJcfm3GW3B3rq5ilyoaSFO8uWMQ7C/TS6YJfBTf9/91uEK2uq8taQESpFklrlcefjfbthQxWKkyqTSsw4J9LfVSxN6RwpNOF+49HFTcpkxsUnXjrtTr0bUSf2jJ4y3alxbb6B0CACzD/Z04p2UOQT/aU5Qv1eiMLVlO0XogvWmeW1l3eLRS/yTXSuVn6TuH4pk0aHHjRQgZJi9Bn4AdiLbnvrbFTws4Psq1gOGM+52/EzbfKkP4DFIe6/ddGy0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmGgTMIbllQUaEA8zmOQnT0s4TQFi5n7J8IqHXxHCJo=;
 b=DRL1ZkkG0Df3WDQ26V7RiYpo6fDYS6FEicNqwdFwM36JE8zdznd9uBP+Jq1N/AdX7keb2y5IxeIAPnUzxEyppvln2bVovlWK1XEp6cJj6M3nBrxDqOhdeTbru7nkAJ8IS5rVA/HlEQ9CosvUc3L+FmkCidZw9tVeG+z1WF733yc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:43:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:43:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Date:   Fri, 24 Jul 2020 16:08:03 +0800
Message-Id: <20200724080813.24884-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 07:43:23 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d39b57dd-b7a8-45c3-b986-08d82fa540aa
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6857666065C706510ECD6A2988770@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wVGcDEgjQNoxjZAuonCt7RhyVZWB4rotR/CHrx0KZOFeMIrjzhD9RxQv2U5MwuzLAUCxSeOI0DSOrcmGNRay5hrrgu910OLUkwwjwh4yYYlDukfQfI0V93RhjxNec6PWlO+/Z7R9uDPo14Re1aHxISGOqDMp6LpT9c4zA6DWTmo7MyHGGSbi2HSRDnAIiwNr6XOZ6xY5p4zx3Lxc9XfQ41VI765VmGfdgnpc69kLr7tkXKG/zXY1kiQZnZHvKSpwTgDYq7HLzOToWvAIUXga38VptcTg1idwp5M6MZ6uyV4MR91tOX9M6pKwZvvxlYH2dSF/KwZfGPrGFAIS53wlQYP6RZ6ZV33bs+yRpLtJgja67Q3V+0fVAXjWxausXkO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6512007)(478600001)(8676002)(2616005)(7416002)(316002)(44832011)(956004)(66946007)(66476007)(66556008)(1076003)(5660300002)(6506007)(186003)(26005)(8936002)(6666004)(2906002)(6486002)(16526019)(86362001)(4326008)(36756003)(83380400001)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xRRoyv5cdfPQ3QzNcXRsI2sNH0+oON4rJU8Bfgfut3nVOCC4olqhnzK3XK6PiIVK3N0KD1owvgsWGiQDyNsipbMt+/hVzHbtTRdXqi7NDND9AOQCWrmEgLM2j7JbqdRvpaM6QIEBlCrFKejyei6lj6Uhns/GKy6+Q+TWgeq8P5abgJZoA+cgzZj39Sn5yY1WKsChAfFp+m0WiSflWRKI7b/ihFFYMnhAxo64kBB/ajPaVp8LJ8KKRCbOachUNDJvfQgFnvHgUw6QAkhJ9o4sEQDzOP5oDW0jmHxphJCfdLU91SIgG1zTbyMPc0iR8OYIEsVZHduhlM4xFbBCOF93OOaWk9rZUBQ/V3vcOAyKqMlleWsSXe7wBYqupOoiQDAxBjvI9w3eoVxpAWxAOaB9mWYn3ZCtdWWpt1MwPzynqjEvJAJGahKjaL4BEkAiUqkMM3p+uW+kAHW69AWMLJpaPQPNFsiPS/yo+bnLid4wCT/CDNZ3mZCwug7v1aW55c/l
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b57dd-b7a8-45c3-b986-08d82fa540aa
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:43:27.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCQSlNHM4BkQ9jdLtH+MeJVP36oUhaN/uFvgRCxeRwgUiOoJF1yXj3Dz4ewZh9b8pVkB3k8Gpb4tYYUfAIz6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to support i.MX8MQ/M coproc booted before linux.
Since i.MX8MQ/M was not supported, several patches are needed
to first support the platform, then support early boot case.

I intended to included i.MX8QM/QXP, but that would introduce a large
patchset, so not included. But the clk/syscon optional patch for
i.MX8QM/QXP was still kept here to avoid rebase error.

Peng Fan (10):
  dt-bindings: remoteproc: imx_rproc: add i.MX8MQ/M
  remoteproc: imx_rproc: correct err message
  remoteproc: imx: use devm_ioremap
  remoteproc: imx_rproc: make syscon optional
  remoteproc: imx_rproc: make clk optional
  remoteproc: imx_rproc: add load hook
  remoteproc: imx_rproc: add i.MX specific parse fw hook
  remoteproc: imx_rproc: support i.MX8MQ/M
  remoteproc: imx_proc: enable virtio/mailbox
  remoteproc: imx_rproc: support coproc booting before Linux

 .../devicetree/bindings/remoteproc/imx-rproc.txt   |   3 +
 drivers/remoteproc/imx_rproc.c                     | 409 ++++++++++++++++++++-
 2 files changed, 401 insertions(+), 11 deletions(-)

-- 
2.16.4

