Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E420823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bx+4ntuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgESOFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:05:10 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:8160
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728982AbgESOFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul+a2wJQjs1huUyq8QeSm6PCGgmN2Q4HqkJGJnS44pAi4MI011J+fO5sy0PE2kYTUew6mlhxboy4iN48XuqkIowITK2YUfND5Q2g+BkJKNB9PJcel8iiyvtojSxmdEAbOQmv4aJnZ8MxQ+z+x7ZS2DkgYCriIn4Osb7mUcTiHRig2meZpZI0mRffsn5c1ehsWkhU6MxIJigqCW/f/zZnjul6A5y0cgYuhi+/iyNF/Z5aUqL+ZgwCH/61HhQCAPBwutpc/k2q/wA8XYj/Ng2MlDRyeFRRrqpfbSl2IFN3zKpUMHMu2xN9bH4p+kt+Q4WNPS4tHKQ2BOMdHltkeZ6PnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTLiHa2vMVTb/qu7hQYVMHmXWHuN/6xwzyfcbluYw/Q=;
 b=GOHQn6BO+MI7LddjO1/wpFW8bFfsY64psR5Z0hh6cOHN6ILo1b6g94XjJ4N333qE2azdfKbuTw1IVPZ8okt/1NX5yOwdjj9Uw3Q/zz9NR8mhKGvlh9qPrGpY53AcZASQ/s8Xz2MiQqT5rIK1EDzc9+7nxOB6gbJJgXQJFpjIYP7zqghxT++9Bk9hM+0o1MDI3Rio6aG1RF49KkfCdYQ3TSnAyzP7OWwlMD0qqpVNvdGJ9vEEMLf+qUKGv00mD1+FaXvZGWm2u38naRwwvSKHCnQMBskwcOLTXIDNNa8XJehTnGKD4SfnLLOHTM8dv6SOFCa1pi/1Nee6LhdJMmmK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTLiHa2vMVTb/qu7hQYVMHmXWHuN/6xwzyfcbluYw/Q=;
 b=bx+4ntuQxJqKq9zoOiD3dzmQ5xpTeBC6IaclQrTOrMZ0/+0c4T/MZBOoh87FPvq9BkVBp+c8gS7e7LTfMbsm1aiwLkYs0p1+gk62D5cj6Q/mdHUTfDhgs027Q0OkmNeaVBmvYhPs93M8+ghkKqjK+aw0WmjXpRPzxPawvVZQy5c=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 14:04:59 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 14:04:59 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        anson.huang@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        john.lee@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 4/4] arm64: configs: add pca9450 pmic driver
Date:   Wed, 20 May 2020 06:05:07 +0800
Message-Id: <1589925907-9195-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
References: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0128.apcprd03.prod.outlook.com (2603:1096:4:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Tue, 19 May 2020 14:04:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec1a46fa-74fb-4825-ec20-08d7fbfd9dd3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB642956E2FDD11A73D35FCE8189B90@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+uPU6balgi4KTp5wLvcK4VeXM3BWV7va8HrFwKWCj1hZND4o9H3Zg80z04gc/eJPST7U2gMsToPMowd49lJuLNFPoEKTd9RlEjTKrxS/JIDG5MopJiV9bDgSOT7+t88UntqpNbOIbAFp/GPkVWiHJZ5UQ3Bgxb2JnrVNaN12BDKwiJOXxw7U9oQO9KA4X+W5LHKJHfFk5uKX7F+1adBn5oQ1d+bbdlblAZjy9BdDzk+jyswCRQ729Spvb0cdZ3FatzsUidurVi0fPtU5fx2VZ77fcU4u3i9GIV7FytdsR00Lbt+tDzBOYB4cJ4KriqVyiQeJ1Bc7YPdgodfDQEgjxL6WECDcut7c1UAnM2ijIFvA4aVOl+YwK3pao9fcHQbHxb+NdmU84+BIHrNzrhsahG8qiaUOiHjcyZqJXHQQ6Q9BVPAXXinJs/fDiiCwWj96HuwjmAKyFYVvJ86i+BQlOXFayxOmkKqQJ+e55RZTKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(498600001)(6506007)(6486002)(5660300002)(4744005)(4326008)(186003)(2906002)(2616005)(6636002)(956004)(16526019)(86362001)(52116002)(6512007)(26005)(8676002)(36756003)(6666004)(7416002)(8936002)(66476007)(66556008)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dLVKBYovJwrz7ulJcEfTBhh4xKUxHa7lTNXeLvGP9wSfK0AtHw9UWpk9A+Wpx5zytzMmacbUl0Cvqzb4r/vYUd5dXB8dt6myyQiE8h2E+hUl4HU0zF6O71yrFllE46JUM9ibVZ8f0LRovc6atU6Q89GQcHQzVMnwCTtk7ZB+TfQxu+x+N6IjLABWqu57iqaMjKmzBDkuQwA0C4vnz8RTeMg8IP6vf3DylwE+WOXEkvGQZVHUq3HE6mfz6bP08yVyonyJPvg8AafeZBioCNnPpXE5qPMqbJb3JdYTjHQlX8bfcu2lJVWdHlGiAbCYBlywY11spoVNne3mSsEmeL0OHHg7mpRQ8FCcdG9TNHShk3/Aq2Mj+3I80T2+kPPV8idmNjyw2pmpqBlE+8yKm26hX1nOV4C76788/i39Tm0UBxlGyNyccpnLsZZyTcStxiCoX/1mmGeYsLwTp4XmjeqZP27tTzztpixBcTllIQRFaRU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1a46fa-74fb-4825-ec20-08d7fbfd9dd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 14:04:59.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbxdSs37euDMVpqhRkIt6rRt+tJT44/dDKHJfg/pPqdpqDARQWDeVq9+gryVcqV9/zlfSiRqWvxbNtSJP94izA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
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
index c6c7e7e..36fcfd8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -550,6 +550,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.7.4

