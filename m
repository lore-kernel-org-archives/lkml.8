Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21302C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12C42081A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 02:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdP2ucSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgETCNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 22:13:08 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:16771
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgETCNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMs9TcDch5zUsjyrecQU/cMQkuEZqQ2Twzg3yqAPnYGQrS1TBPh+FonKZ2BvjF4ydyJBBfLNh8legVTGJgJ05y2/9nm5YApK4WZsXB6HShO0OXbLLEXF9F+jRvQY/Evyhknwtcdr6fH5hNpz8rs8kRVzIAXgIFs8t824v3EB1G4YR9RHqhTHIi0ykXRPTYpRInwTcih+tzxcFuzQX/7JqIJ5QI2uHNO/NNgrJKSEi/C0sq5dBVzu8NmF/xdo2znc31ouFsuevZ7Z1btdvDFwpsVPgNhrmpB5GRrogKO9sJHcVkPAOlOVxBdk64DFg588WbAuWWrN+zeieSXimQsSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmMKD+Qy8SrdfhdbuX266VFkwuXgmo/2xd4zgunBX+Q=;
 b=LFnf0AEJCWKSVMwh/eXERnQ3OL8jCzHPgAFI5aIBwVeNnPbMpYfpyN898+n0ExrsMG/I6rmyIXhZEpiunt1QdQghAVFzVG9+uTLyoLN0lqzH3QORBtCF3rox4unyBGeBoc4TXtiPxLBM0N+k8+6wjULI6pWsUiJboeobaharjQeVG7W7lOZGY8Pv5GIGiGOB2mMkbADkYaTcdnRmOQPUTqaYxKqI3d07gDljsQcnHsbUvUPZomvGUL3epNHbcUkCT/xftZVAlpWE/wR3CwFKMPt/nNYzcWUvAFm9NxNEiydxKojbAJrjelCftuh3An0m/LaMElo8zJliVVLFVkQh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmMKD+Qy8SrdfhdbuX266VFkwuXgmo/2xd4zgunBX+Q=;
 b=ZdP2ucSL8Ebs1k6wr3rxHmajzGyYtRkWN7u+Qb8BOUoNPongR4h5O0QrG+4SgNnz8hbNjxdrmWL+q/Jsf5cNnPUT8Yl0kLVI2LSGju+FrFFnnfddhEK5j7iOtxd658y5/B0vicNbt4IhpKzmL+o/4+6ALm7outQ6zzl/j/7Or7k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2741.eurprd04.prod.outlook.com (2603:10a6:4:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 02:13:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 02:13:03 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] arm64: dts: imx8mp: add i2c aliases
Date:   Wed, 20 May 2020 10:02:46 +0800
Message-Id: <1589940166-736-5-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
References: <1589940166-736-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0099.apcprd01.prod.exchangelabs.com (2603:1096:3:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 02:12:59 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30305dc6-9cde-48fe-bdfd-08d7fc6353ca
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB274157D9D0F231C96FA6F25888B60@DB6PR0402MB2741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GKxHJfjd2f3KOzum2trQYJJLIxdTUqnQV0GuCwb6fOOOwVm8cPjUBBlt5gwqBBJp2r9WAJNbFZwvjyVnT+XSE8BoNGThRsciZHmIpIZvAjLGRwe5+Yuh4IbHZrd29HcBJeOld7b8qbqrKdKk30rttdyExUdK3O5URx+rKctQO9Y8kuHTnJyxldNe3jG6NDTRnHTn2YQCYTwuE0ta0H27bblUDsUZPm2dmrljQHFkC8dAsLepd9qmc/9v7/+swbHmf4wqoI441XtREANu8f8Tgil6dpQWT7OC10Wlp4ax9zTwds0K05EWbsHsV2nw6d9yioKTBHESqxJyzIvaTfKz+ZSQI5+nQDQ2b1secUkBQ4EZDOLt+0fziWp/LgPd5aoVB4qUIpoHnVmc8xQBXiycy6LKaADdGcllH6Xm1mw7bgkpMuWdzJ8rdsz7jk66KEmZm/qYcKOdlaUzLhVwRLs5v8jWRkNG6bKDy/fygNW2IiEfEqXaNQWDGVGSCcm4TMjMcVtQVly0jq/MKwH7ieIag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(36756003)(8676002)(6512007)(86362001)(6666004)(52116002)(9686003)(66946007)(66556008)(66476007)(8936002)(478600001)(316002)(5660300002)(4744005)(26005)(6486002)(69590400007)(6506007)(4326008)(2616005)(956004)(2906002)(186003)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1AeP4sRTae4849Gl9schmcEzolDQ8TJQdn63TB6Hl3Sclna8xIAl6hYYOuzQaCmhQOqg6zIeKP8ZFYY2Dk9dioUaTC3p+SyLP8MZ1wC9hDqhgibEX4ejz/UD0QXXZQTEMj533jKRFYshKkGH4pz3qaFXvP3UX8WGOO8hLQwaXg5cYUu6zItGEub0YMqNZ/2wumDQ8w/KpYQ9lFmk2lTLrYLhhuvZG5NgQAhmAOQ3SA0wjxz6El7yBAZgZVLDSWorY7FuAS+PHY2uPqwre/TGf8iNO/9eI0oL9+86/M7R7QA+za28VZzmUInlrw+pZ/4+EVWXq82bHY2yO4HVoXt4Vko4yssVAcd0A86nOqMlCZutICpi7s7r6jyEhppG2NNu0rKgg45HhCI9OVntjA76f+qVsRiO4CttSSPj1rN16Q5QwJ/Q5u55hUD0CCOXz0HIQoMMOtcj6Yfmhm0oyuWZOYMaYcIfN6gIjzHOgzM6bOIdrYrcDebh+0ud4l7iPVPX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30305dc6-9cde-48fe-bdfd-08d7fc6353ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 02:13:03.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /e6YXpvarcUKIAY4uLcMNRAnVmvtAYQqohwCp+OjPiSJ6a2Xlw6zG95HyRFsJ7ps3gRBeQTx35oSkkuavCprvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The devices could be enumerated properly with aliases.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 014205fc24f6..73535601261e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -23,6 +23,12 @@
 		gpio2 = &gpio3;
 		gpio3 = &gpio4;
 		gpio4 = &gpio5;
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		i2c2 = &i2c3;
+		i2c3 = &i2c4;
+		i2c4 = &i2c5;
+		i2c5 = &i2c6;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
-- 
2.16.4

