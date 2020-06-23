Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7358820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CFl1GHAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgFWHBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:01:40 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:13065
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731169AbgFWHBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYUbvexroIfP25D3RfIcn+mNAELzjJwb6O5p4iPadJl8DzOk7DhXbjxkOOzuCqR//P2upQhzkZtRzWUn8taCQf3QWtQdHP1tp9L6uta6rqKO5INNWo+uaZqiLJyHNH4OY19O8O6e/9rcv7KgJJRN9zAmEI5253PQ9Kw7sp7ShYW2x7/L+FPxxWxVjf7SVeT5ASTIEe59ybo+xr+gYR1q0lyWM51koOkvYY9sfwdUYDmvz/MoUkxjmS1RvogIkhLzHd/UEmuOk1zhjAZ4/mzqHUbbFLxBMzLhY7Xor+ltetaS8JO2DSX8+3/gvGVDYTfYJPlGlqlH0P8IbjDKZ/+DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5HldMRvGSzj1kyooQ5o8KzxbNGGC0dAW4b2If/BQCI=;
 b=mS4SQdN7LVKjqfFkiJkKdLY/gTtTprCr66JJirHTtsITi1rs513QdORbvmUcmkdV5xeiCHmGc38tL0w2EzMTOJR2iRJH8fLI3+5YcgK6LNVdOx9mXvLX+QvQUpbkdX2jsHHAydmuyeYQLYSKWjv3c8ZPQf6z3BHXor9v2MkkUJn9c9ErQD3+iASC+a2XQkjYVbUtwmt11TuoPh8pX2WwM+4/ppKtOVKtM8mwVXR9JNzb3qUa2Pgjhq+98mdP5pGFPlHVr4Mpkbh1USJDTzsrEGW8+Mpuy6iVfZW/GYQnllC9vmqKpMJJPgrE0s56EaBhtsbpN725IyUSU+Q/cn4t8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5HldMRvGSzj1kyooQ5o8KzxbNGGC0dAW4b2If/BQCI=;
 b=CFl1GHADRpN7VZi7Vxr+Q0GTJpWYz5oVPwwS58p3+HrWMlD2quOewES9nWkszhbOQBlgC6DKeCnOJ2G7P5N3WtINh6lavcf9JcSJmfiZOEjAdUacmkBQiB90/uxVhd0GfuJ/x1M/wgKRabElvr3EYSM9RQ7ZSzq+ftbq2vjE79o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:01:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:01:33 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/3] arm64: dts: imx8qxp: add i2c aliases
Date:   Tue, 23 Jun 2020 14:49:53 +0800
Message-Id: <1592894994-30015-3-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
References: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0101.apcprd01.prod.exchangelabs.com (2603:1096:3:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 07:01:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed2e94a7-310a-4aed-b48d-08d8174342f9
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB27117C00DD2653640FAEF22488940@DB6PR0402MB2711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8p4pKZ3MxyN6zBStwGR6JZ6qmWLmjgSINpzPXccr6F3jq0gE+lfWepOZww+VbrQHmEjIfyczniBpwD4p4AFI5Ve4eQacxc3NZK6f2SDKTSrvHAly4YheBoyq97SHYMMT25fhRyinZtk3vgDg74KsSPmCzGcOGewgzpuLY0IvapdmPxviL2fMHG0fhCqvplU2oP7p3TiJkVXf6laMOdsO+iQIdGHHbxfqaKUFDhmR73PhRTmmIZIbkP+vF6Gq4XMqtvA66sySjIPPsmM4kSluOn4fUpEyj89cLATLgpysKexLYoB9MJ0MqD+P7PQo43QbMZmIdr8pkdP2WgVR/isyLI3ezcERH0asfSyRC2ayUtFg1ZgTKT3sY8qdB98/wMyKBBhm/g/VBe6t0yZK0vABddfTHD0sN1JxvGy7WLct1uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(4744005)(478600001)(6486002)(6666004)(5660300002)(2906002)(186003)(316002)(8936002)(16526019)(66476007)(66556008)(956004)(2616005)(4326008)(66946007)(8676002)(52116002)(86362001)(36756003)(6506007)(6512007)(69590400007)(9686003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fleqBRuNmnqkzF3blWPzSbIYZeO285L1Djs38O9AP0LWacVB2s3lsWzCIslGS+nfTyMfA4NdHcnuRE2FdgjueUNWiWlNFMrpEnDhdYZ1M601d900ouclbTJtZS+KXLfE/jGMQonZDJ0ypKqcBxLv7b/54ntaTdSNG/Tf34abiD2mJtpopuTVGia5G8srFUC/LsSYZaU6g2lxNK2j6NKsUOQUSEJoc0o0rc2ih03D89IbfA5JJkfZpaj7VsUpj5sEJYQfQHKxuZrvWN0c23hw1WMPcxPrfT7uljnajDNcdRKwbP2mCHVq0C3witbUqRFJ4eAnlXQOcGeV9LHIxLBwC1KC8Ds1a6rfsuZ2ZLBPbSGcXBNzhFUA95zrfdRrU70+n6/ihnbwFy8l3JCmZ04Y0bfN0o6Mn1uFDYPReK8nM7DOm08yebyJACUKTUkZIv8bxOzLvQsdNcRAbEhdXjjCHI1SqNLN3fU+m7SR3cD88MKa7az9tG+0aGw4Ugt3qcmF
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2e94a7-310a-4aed-b48d-08d8174342f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:01:33.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eis//YVsxgn/bEFGpW+IyTMmxiwUjxkHL+wIyjmmGgmw5OAdN/UJ4r/UYyjHAtBh9Md+o/ulWjbQ7Jm1y17/mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The devices could be enumerated properly with aliases.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 33363c127478..3b2fada99c09 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -27,6 +27,10 @@
 		gpio5 = &lsio_gpio5;
 		gpio6 = &lsio_gpio6;
 		gpio7 = &lsio_gpio7;
+		i2c0 = &adma_i2c0;
+		i2c1 = &adma_i2c1;
+		i2c2 = &adma_i2c2;
+		i2c3 = &adma_i2c3;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
-- 
2.16.4

