Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C4D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OksZnCYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgG1JeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:34:14 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:60082
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbgG1JeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:34:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jirPceWluIC4Pv18YUnlYmIz8IE1I4mD0Nu3UkYZ+uy9kYObIGq7u7DM+agjV3u6Za8zGrz6/PTqLLXbGRiwNnKXwHAkA8HjRu0wJTnPggsxyqjQsnrnZ1ue3B53e97To6D8RsNI9bhZ4+4VSOb26MNNF8NByNzTNp8ZvO0eX9R5v9LVylO9FqITOd1ite7GRIMz1nkNcgyL1IfNsjXYoFlEq22M7Zr2nMhNV/g2WSY5OiR7XpkCsd81K+yAlb8gRfeiR+mrjJXQWqAGv00ArQJItb17oUPAubcbPC6R8bren+s+Gks1PbjGOBpY2QLP4cdtzgnhwVdgH8M/f2FGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I28++d/kQ6HtgnqycqPFfPKEZZMNQRsSCBdMR+bXF/s=;
 b=lQV1FLnW1RVbcO5IyWz+LPUQnt8h9q6Z7SVrGSf7jff4OQQ5UVrkAEBwdR+yPCN3NcKNP85gWz+nqXeQ4bFCaZPITNfKjly4Xf/S13j7oIzPwj2NWk0+lDB2aRUphDLpOtbMC4OwasW1/E5wA3GWPP444zwDyd64PvlVvGaKQmxJJjS4o5OKXY3ekyVwwap0/l+8vEUQpQv1bJ1RTCnDkUXpAZm4jM8ppDz0D56qzdoQn1pS6nlTNIyXA8eVqTR7/oR9We/LAV4k7LyeSd4m/NtpHMqHsJUJkbVv8kSZUpIHTtl442gRDS0DDUkv+T28mH7TPyb5oRMLKiMUNeSiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I28++d/kQ6HtgnqycqPFfPKEZZMNQRsSCBdMR+bXF/s=;
 b=OksZnCYxKTDJVHWA/iUhBRO70PKBEfQiEj1y7O7/4pMwXUsONrbbM47Z0aHAWo9Hu0EbniqunXb7/GT/g9rSDap74VebxvGeZ4lb/1CuIBtj7klUu0f3y8x38ylLy+1emCMXqIl8sKBcxocbdjp5lxU2MDsNoOVsPhwD/ucWqfo=
Authentication-Results: wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:34:08 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:34:08 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_rproc: add elf memory hooks
Date:   Tue, 28 Jul 2020 17:29:40 +0800
Message-Id: <1595928580-26199-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595928580-26199-1-git-send-email-peng.fan@nxp.com>
References: <1595928580-26199-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 09:34:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20c1ca2c-4761-4900-4363-08d832d960a2
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4490655404213A0877EA425088730@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/Dyr+//vyl5CZZhN4iPNFTTHs1zpvy4sqmhbEJrUYURow1As0/WfnVVo6bF4vvGdR42nyrp1gg+8szd+QFN/UyRk2zapi5vCIIBfJFFIUzdPwA5cnOXZ+2Zx+AkUmoEGYe5meyLW+xfwzKtdrL0SPJJv2PcsB2owF8aLDhtIE6+NF12wDBeEb5Vy6/jLA6gkx+uTXB8HwDJkfFGECOiRtTAk+0KzA8/XGUMXh+bVNfxWev4Htar9ZT6Idu54VlNrk2/NiD8kSn3M7Stg1D/DOQxZce3iY/DRFqBH2UKlRYOzNng2H3bHgl1PQwZ1pHT2T5Z+UH9cEwyi4rdaObMSKlSMcCPMBrd9y6R5s1v/BC3KKaVBGSM6EuWAA1HsfU3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(186003)(956004)(478600001)(6666004)(16526019)(2616005)(36756003)(6486002)(5660300002)(4326008)(316002)(52116002)(6506007)(7416002)(26005)(8676002)(2906002)(86362001)(8936002)(69590400007)(9686003)(6512007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CPg0CVnIyWU1fw6bt8IzM905aM82jBQNBrUJRjjqgsgawsuKMDPyEeR77fs0XQhlz/mHkpJr2ustuHnuqqkqYB9U5f+9c66OcUYcNnRIn2pZ5ZP/A7EZZo3g31IzEi1+xwYobSPHm2HdCasvf3nwOpu38DMRUsrmufvhRNtT+TKS/kCnI0tdmqTFUXtwHVJuaCSxsxf0WHstGvRInzf6kvDYoQvfu30Jtg18p357MC4EtLgaMoywbaGzlFDBZ2aY3vT45DkDsaSZTae03wO5VgoQm7Xa4hbDWPIEEI+awLVD1ViQ2ED2e92EnpMUP1TzFIlPhDvUSnVcYyAAk6pAiYw3yjMurb9iZP5cntHgkAYbHBveqqDTXzq7gam3xd8weTn3+7321vKbz2K+DwZkFOCFCMrESehXopgQ8+BeW1Rg3xtpU6E4DUtCzT2HyGo5CVRCzoIdKxws63QookmFtJ9OPH4BwKHJWbYFNYzj+sU3f5bYsjIfIpyMKOAej/wa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c1ca2c-4761-4900-4363-08d832d960a2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:34:08.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqKD2CiVqfI7RljaGojmaf2012upeEN1g/MU5Y7ebgQdQkD3mMdK02BIPVzY1lp9OiqQZJEi8NjkkBkflP/wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Please not apply 2/2 for now, this 2/2 has not gone through
test on all i.MX8 platforms.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8957ed271d20..8ad860c65256 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -241,10 +242,22 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 	return va;
 }
 
+static void *imx_rproc_memcpy(struct rproc *rproc, void *dest, const void *src, size_t count)
+{
+       memcpy_toio((void * __iomem)dest, src, count);
+}
+
+static void *imx_rproc_memset(struct rproc *rproc, void *s, int c, size_t count)
+{
+	memset_io((void * __iomem)s, c, count);
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.da_to_va       = imx_rproc_da_to_va,
+	.memset		= imx_rproc_memset,
+	.memcpy		= imx_rproc_memcpy,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
-- 
2.16.4

