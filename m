Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:22 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D7120735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DM3AkMK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgDMG5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgDMG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:57:20 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30070.outbound.protection.outlook.com [40.107.3.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A68C008651
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQbbYf7Yi/5RnYO02v+ETZ308iJY1S9zJwtuY7oLfbvHxaweu23kPtfh22m3sCQMas+4mEtCbz2NgNRx0Qhig7dgLu0EFsZr3VID76In+qnRNp8DXgIjkrp/puzKTMqJg2tam5VZWLynGaHpKRLAn3XjiRGpSsz2DiWMStUML6owvIAdrnk0j0rEw1SubtaGG3trfZ0WmNMMgXNxrgza3U0srItywHvuM9CJb0p6o11J3OBANuxEi27cD1XTw/eSvDfiQ1szou/1fdx0O9FtVTjSrfQ8lZKTaB/xArRv4162as5WuKevu04BnBCiwNp4McEdhF9trwEqqO86q/m5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09WZImW7F9OTt+B2YoruiXvoWL/Kck0AR+coDSsPfcU=;
 b=CjHCrkTN4zJzQEp/VScLUx9AerJuhieWPcmA1h3htX3voGI0voswS8DYNTCHKWasYdPnUcmEX1/rt6eTYU8qYT2D/GW5hLEANlEGjIruz3jIe8pLMtgmQD3qiAYBs5md/LjNpQkFDoUGM9bfPmOL28ePHVEiXtRAUYfOLrqBU5GYcaK5iyHYRIThgoHrnJG56a3B9qz+HaNkQFGfSg8R0/2QBgY9/o7XvPfx63gQdfwwtWFOr84pCGkF4oDNhxjn/lTH3RGS6ZAUrjxrXgE+KfB0k1gEi1ArUslSyrNgbEtTNDZtzdH6gDCVHNrStJzXmMqidnuReeQo1DjCYR6Xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09WZImW7F9OTt+B2YoruiXvoWL/Kck0AR+coDSsPfcU=;
 b=DM3AkMK5Tx1fFb1INlqhTpv8WBl0JHLL+irl5AhEEBLAl/38JZFsMx4SD1y90SfAoSwyxp5gpnNLYM4G0Bp86T0S5FrzJfs3PaNfvSxKjxbw01gOfb1+NpptSHS9T7/yHfwpBtDfu7AEz998C8ED6V+lIy7lZ4RuhcQo65QhL2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4708.eurprd04.prod.outlook.com (2603:10a6:208:cc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Mon, 13 Apr
 2020 06:57:17 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 06:57:17 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] ARM: imx7ulp: support HSRUN mode
Date:   Mon, 13 Apr 2020 14:49:04 +0800
Message-Id: <1586760548-23046-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 06:57:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98149ba4-7ad5-4fce-b404-08d7df77e75c
X-MS-TrafficTypeDiagnostic: AM0PR04MB4708:|AM0PR04MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4708314FE0D8F04EDC37050788DD0@AM0PR04MB4708.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(36756003)(8676002)(81156014)(8936002)(69590400007)(52116002)(16526019)(6666004)(26005)(2906002)(86362001)(6506007)(186003)(478600001)(4326008)(6486002)(66476007)(66556008)(5660300002)(66946007)(2616005)(956004)(9686003)(316002)(6512007)(4744005)(966005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+l2f3L4XTzSPd8/4TUuDh0hkbqA/QM09i3iwkd/ogcAlc6UrfxbH7iwkrddas1/2chQThIKwMExbC+Nza9r29/sJwYCSUpUok2Qpsf5OmpMVDC8pIee4S3gOY/kaDXN3qUicpY+cJgZwWnFSq9HPIVHVsHPTu533gnbrSFvgYXsklWB9i0YdsO8qB2LtnW4YL7p+fYNeT6Jhag8ZZ/IpUOybAAuTu+Lf2VlLIjPoa+gUxRbbmPBmyi1gscqTDdecHsakf7civ2W9fh/N4D8AqrCFwckgQoIh/rTeUiXytmS4PyDN7lZU+oFBADuL7NDRHjc4tqup6mcZ1fUpapoFHAnU9U+IVexQn9HqXvFPNsYDCJe0BB4GgsYCSeUe3quorBHF3AE0GNbc/z/nuQesg/Jyde7hqqtNH/Nnrjq3iMk5B9NpURbRyRE/G1RwjFye/fZ24morwBFCOO4t2gNAchr6mDgpqxtoibyeFjL5I9XoV/sCtFr2kDU4fIvyDgm63/DmVMv2K4jL/4fNvuxBwahppmCrnW0VLhS6i5nnQ03CPRGbJQOVyCLjutriieYsybTjrqw6EuVd5wZZf+FwA==
X-MS-Exchange-AntiSpam-MessageData: IjMjryRuqgdc/ODpPYPhetG07/fAFtrNKP8IyOLHdsxrZqGXZye/F3vhJr7k28EUAi47U/9j8EfuxC3hIiJ9QoI2/VBarjVN3CoSle+j2msOZ8WtUYi1tQcf02yWkLD2tZuLrVbpTcwyLMhoYUJNXQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98149ba4-7ad5-4fce-b404-08d7df77e75c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 06:57:17.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/kbEL03FihgcdmpZIDcGZkg3DXMAtCRjj49/DZA9BRlRazvIYpIalC/HzEChMMUOWcqlWWwQkMeSuf50Smvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Fix dt_bindings check

This is a splited part from V2:
ARM: imx7ulp: add cpufreq using cpufreq-dt
https://patchwork.kernel.org/cover/11390589/
Nothing changed


The original V2 patchset is to support i.MX7ULP cpufreq,
still waiting the virtual clk being accepted. so to decouple,
this patchset only takes the run mode part.

Peng Fan (4):
  dt-bindings: fsl: add i.MX7ULP PMC binding doc
  ARM: dts: imx7ulp: add pmc node
  ARM: imx: imx7ulp: support HSRUN mode
  ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 10 +++++++
 arch/arm/mach-imx/common.h                         |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 ++++++++--
 arch/arm/mach-imx/pm-imx7ulp.c                     | 25 +++++++++++++++++
 5 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

-- 
2.16.4

