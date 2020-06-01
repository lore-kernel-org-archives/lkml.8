Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035A82073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzjUoCfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFADxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:53:48 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:43968
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbgFADxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpihDk/Aqz6WFB/xVTsMJMpZB62clyHCT8owksUU8II0xhjXaJXajG84KmaoqZ74LR5Ar6XDv9LrQz568dWqbqPi2j8yMP4OpnZwqRNUlrTWnWBgK8tFNAx34UwlhsKjCsQuMc7xXhXRxeIdutjQERN88atugPYWOGlYkDsgANneu7gTQ1lIP48mdSyYLYHV4Igg/df2AYeq8uWlQEd6D97MHAn5fdQGAykQXXU7QmAuqQ0Bl0sP7xm5u/ydM2ajS+49AmEz6bUR0PWxAno5BCSqXP3yKwry43UqW0DEV7zdikAyXkkYDx/6FWpiSt7BYk+xPOeETjterCRPqzDHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwbhX2Idsrxieujj/Kq5c0pr0q2R66ph9RRONGZsnp4=;
 b=jpmKN0J4LBRIoqxh57kRzb7eSMD7up1+iotnfBRfATFckgmGIROkiM03OY9y6JGmNovkVvjdRaS6ZjV2AvZnwY1zvXoS5mB7Hv58NVzdtUqxpj7elEVIkd9RqOIYceGbhshhqlWJP0X8pox8pwGhzvKSSoNQlp1b7AT/gTN+arS8c912EAG4zAvV5uzQ5tyeQvjbdXvebU+70Q7AY3qzQ8g0/zxKJJQwMQlhivKVLaSNG3xrP+SlollvrxlmJWrmnd839KEPRCTCbQmOuhcscImsn5AIpc4Tyn+DUdm62rbcbIrXtoG/0XpYDPdaBCN6HbHLWRsgik0+DWPvnQAgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwbhX2Idsrxieujj/Kq5c0pr0q2R66ph9RRONGZsnp4=;
 b=UzjUoCfifcYznK6Frijky7bJ/Mcp8fClasTCYM2XE39IRMfaUc2Ms9Znjzn9iOBtDKwJDDTQZtSE/3eS3ouNVHeK70w/IfnS8h1Z1tdUBFw5Deb7SXu3sbytojBoRsTlyc/1HI651QfRWZRXExgmoEEmfCenay3uNxT9TGcWvhw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2920.eurprd04.prod.outlook.com (2603:10a6:4:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 03:53:43 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 03:53:43 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] imx8m: add mu support
Date:   Mon,  1 Jun 2020 11:43:16 +0800
Message-Id: <1590982999-7149-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0096.apcprd03.prod.outlook.com (2603:1096:4:7c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 03:53:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9b92cd3-023f-488c-b84a-08d805df607d
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB292040F4891454E055FC7272888A0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8tpC0YIBbSf6V1JDlPVJqQQ3hFyekuyRVA+/QDxU70+TH4U8tgsb0/zMMFriNlXxCniMNwAa71UqhN7go5k7tVup5tUKCzf+ivcakYWprCnCnXTneDoDpHtLq+5u32eI2dWjopb4WpXYWG4vpLBtHvqY6v+/yyYqD7OztMXT9w6JosuBd8mdHu0/cX5RlPof2sXzedOSu+Crr0wnDv4rQlFTfHb1f14DQFzqjUBE8poOs64VbloEYOLvedAT0VNFmVfXMebm98D+UrBwDFm2dXZBiq68au5/MAfWbu3UobN9oEhU72fmYFQ6ksRojQRrzD5vlLUnJi5n6OspUhhLJXJVwyEzg5uydWGyWQ1UqYnfNNUnkj/4Xq91gwvWjPtZtZq2d2FLACPDZ+KwGvNCKnYWX83kndru1yZuRirm3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(36756003)(4326008)(6486002)(8936002)(6666004)(8676002)(7416002)(6506007)(9686003)(6512007)(478600001)(69590400007)(16526019)(26005)(316002)(52116002)(5660300002)(66946007)(66476007)(4744005)(2906002)(66556008)(86362001)(186003)(956004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5mNPz3F7DR0BRWUy2y+SQaKni9+HgvqyFjDvKXGGGqRvKFOY8luTRUBXL/OMiUP33S0G2tGvJgks0NsK0oZqyzg2erxrMPUXhpJUphyTgdt5EwN198WikPEnoUVpvG7BPNPoUODr0z67IwQu73v6flFLiLLzkJfVRWNgkS8V0gwcAmMWEaNRcjYUTl5MwMzBjXw8Qd9W9Diy/XGkJCJehzcPjgPTEA5wZcFr+zAf9lqIJmj85fxiJUhIOIWsqyBNAqLZp5oIhtUQFQSxVO5vwkd3RTAx+11LdZ+YSrfW5Kh5P1vwOAUhHdbJ8AemEuDCJhRyqj95wtwn+xQelWKivPKifJ9x4zBvuAsK3U4YQNMo9MPeupHuF1m0z6X/Wm0S1/gBj/037L9MdM1coRLnJkZ23I0Qow96y7Jt88RtBy09BHzJlAiR3sBv4UipEJ/VDTS58M/m28+8AbH45nyDUHFzZZTW0unHvfZvnTK3OzY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b92cd3-023f-488c-b84a-08d805df607d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 03:53:43.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tI/ZZCmgvPkNbeEKSgIp3xaajsk/3dP+r3qA8fD5ejjVX8uUvvC9O4lxBErz4DWNVd3E8fvqOueOiBbTfhQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add dt-bindings
 Merge dts changes into one patch, since all is to add mu node

Add mu dt bindings
Add mu node
Add i.MX8MP mu root clk

Peng Fan (3):
  dt-bindings: mailbox: imx-mu: support i.MX8M
  arm64: dts: imx8m: add mu node
  clk: imx8mp: add mu root clk

 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi            | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi            | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi            | 9 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi            | 9 +++++++++
 drivers/clk/imx/clk-imx8mp.c                         | 1 +
 6 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.16.4

