Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8D2206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bmeI5lYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGCIFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:05:39 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:41397
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgGCIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:05:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGsFNUq/hIU0eiN9DGGvFEpxz0V8vLkuI7oxPZ8lbPWBVovYh0CkPViklixFPlRxz+rjnGEJkhpMcoYGb0CY+J4D4gG7xpNsRAh7XeYlor1gqBjyXTHG38u/bOdfI7jUNnxJVHjPmUeWTLwakSkj8wtzYl/Yev/DZnYykhLsz4OANCIO52UFK67EXksCMKfAwpvejQckSRCinna+ZIABJBboE1wfj1A48ntEXTNsqcQ9qcD3n1lsqokhKex9WzlkwlM6Kg7CpqSVzFqIBX58wkh9QURjQvMjqR8CVz1qGhgit/qk97Y5vjsFg9jUKms8p0i7hwqER6fIWDC1mDiJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eKYCm3r0qd7bjdPJFFz0vFYhbjqrHJVjxi+QUp/GV8=;
 b=N0FT3bhlm9mSe3D54JivE2+SJDSjjvlU/d4PaBtTO+1egWiqdgw9m6GB+2fibaYrs7oM2bglgVbzzYMyfWgwdSjlpPcMgm91NZmN55QzAay4/JX+MmZpxsbkonJfth5gLZvz+9kM2pighhbjim9MkbdT0UaEdn61+kClqQCIoM/MfoVNU3YOBVPZhU2E7Yn7PFVYFnhy3sIBqPsbORfrRRUAIv1IUYqcNxOn6Z3Hbb2fSGeXoscTa/QDWX5NXDTOIxZgVaR27VyV4mOnHao9ed2kWs+I9FSjDsZZETEACvR9rIVTT37Z96vMqzbdklciHbloaCl5RXtFwuVjlxa/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eKYCm3r0qd7bjdPJFFz0vFYhbjqrHJVjxi+QUp/GV8=;
 b=bmeI5lYYw+xKczL6/57ujnZ/4/GUHrKv7APiSJ2HOcFkBpizzHl7215FsaKC0mDHrcLkjDochIxS+OWZFP8yStZRWFlbxIYo0eZteGeL5i0qypp0K804ARqUe8+Lmf+NDjUITvb4vla4AVLfP4BDH00OTgCW6TI1MgMQxYj3P5Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 08:05:34 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 08:05:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, anson.huang@nxp.com,
        festevam@gmail.com, s.hauer@pengutronix.de, john.lee@nxp.com
Cc:     kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v2 4/4] arm64: configs: add pca9450 pmic driver
Date:   Sat,  4 Jul 2020 00:19:38 +0800
Message-Id: <1593793178-9737-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 08:05:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6270e9a2-6649-440d-d83c-08d81f27dcc4
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB534456C08FA74F69C83D5A70896A0@VI1PR04MB5344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1q6Zh2b5PYc3s4oGE6LpvpUpj89oiZvHB/BHAKjhQSbWdejlw029E2HXspJlsbyUeFjPEZ4GTYY7G9mfMQFpQaOyO1R06Ez6BvvfvPKMe8BVl3m7XIkYXkaXqJAomN90sqaqf26JwTiLaHAgf4dnPQEBAbAh0xF2hiFIFL2aQU6BRyJNv21kL1Wv5/4Z5ohEFFMfh5nioKOJvCBdcl6VN3WazpbinCoumRHjjWXSODUlzDGuPHz/RmxHmBkRogIcAQFZzg1Z1KyEnVuTdAjIbvtXAAWY8D/Yoh6Uib0SuGxpIiZc/3yzQ/+khTQz+5iad04KQkmDhDgthj/6hDkfHC4qW7KWgZioNSdkq0EyXGG32MuoV8sAb31JNCcf5Yg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(8936002)(6666004)(4326008)(6512007)(7416002)(2906002)(86362001)(36756003)(6506007)(2616005)(66476007)(66556008)(66946007)(956004)(52116002)(26005)(8676002)(186003)(16526019)(6486002)(5660300002)(316002)(6636002)(478600001)(4744005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FoLFlGcHYO2JIQB47i29rN6HnnJEyiTiXnusBmQIcYbc5rfNGqyuYqanMIusKJP0w2tSjNm4L3tRiFZqjIzMKYT0tl1mGqHUYCIi4/yWuAfNnOdKcPdIPPRCSIB0aCfv3erRp0gV5ybjFO+J3L21pVVdHDpZRyiOkRxJXyXr4copMawiA0gf154f5tJw8CcGY6436pLYR3gwtmXHJ9MjKTguibk6lyg6oHRsUkh/t6wiS7QhOqsPmxm/hALwT6MMFkOGCqq1E77bcrDr1ROKrlxZgZQWmUFQcFUKEEc1DZa99UVKCXov9m+4d+t2lcw0F0c240mJUUmy62Ou5QAhIdATyyRx/fTpDhhg7oHiAZHI7ovO/7ObkH9AaBHvYxCxJZjeMble1Ni7lkL7nGZvui20TbAkDATvQ2+pcx0v+TY7wtu63DAFEj0NastikUWWf9cVZsYfdFdXNvbGflfwzC6GfTXwnk6okGmHBOBlUFk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6270e9a2-6649-440d-d83c-08d81f27dcc4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:05:34.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6SzLGBgn1eNVjpKAv5XY2UcPZO6l21Q9TZuV/J1Gna70Sr0xiWlTbxsrxa4P7O9jgT2BIpcd18Rfwomh2Ihkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pca9450 pmic driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d786bd9..abd0438 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -557,6 +557,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.7.4

