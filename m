Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F31C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4271820786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n5aSzQBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgG1Jfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:35:45 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:19904
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728130AbgG1Jfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:35:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbKOF96lEbto9MHxmKfxjHddB1Nh2icbeJgCFNeVMddcfJGbEbdeDAT3evsih902WqW/8MobLKBqMn7Ko4/weEEeqPolYE+GJYyQ1A7x+CFjDcVoQDdG9SoSj8s+1rw88urlcnJsmDGCyFKgaNbPmYV10Jmftaem+H2Uto6jed118SIL6PcTt6AiKgUYBPJU1oCSb8u/2S0NWnJiUNbDygQ0JQNc0u9uoC/EblkIeFneOt8W0wouc3DNFS2+YT+3puJ6nwBi6xdhi3eVUunr4qKlZDWfL/MMe6YAGtphLFfDCBK7VxXN9is1KFU88x+1BoYdHiTkR8e506ycv9n+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I28++d/kQ6HtgnqycqPFfPKEZZMNQRsSCBdMR+bXF/s=;
 b=TMx1X2VNRD8Z85Yh6pcRBcok/hY309BvHnNVWEFY+UcFR/L6h0CIdmN332Ya0fpQfgE+E81wMpFyiXnMuD1ZQHo/DeWPU++5u/GlFniDliHCMFfB9ksmb2nPrsTMSOdvX+AbzLmENpVKffplYXyjlK3nOeUIHMBH2Zrxfb89rGGTXKeNIeXtD92FbMhSRuEgrzw/t8KrpGFywHzcoqPRp3zx6ulaSj9VJIxaLBc3MtMENFfr8olBg8kCYYneNJY7fnETok99CH4q0MYCmHJfR8dJOKuVpCrK2bNJDcRYR/JQP6yrB+D0AmTiocrff61szMjT52XlHAC5MTP6QoMLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I28++d/kQ6HtgnqycqPFfPKEZZMNQRsSCBdMR+bXF/s=;
 b=n5aSzQBcOnljEaSj5fo/fuxjQmN58GZtk3Xv8RXPZt9rGbLDxkftNCICKSpY0zAxyYNzO4BVtdgqCGWEnvBYfVkLvXKFXl4uwXkoAPYedk2gZHnFMM0yjyogy+/1fLzC2hWd2xB4YeyMZzU5pMlVz+1v9MjxH6KIry0WpNMZo0s=
Authentication-Results: wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:35:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:35:41 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_rproc: add elf memory hooks
Date:   Tue, 28 Jul 2020 17:31:13 +0800
Message-Id: <1595928673-26306-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595928673-26306-1-git-send-email-peng.fan@nxp.com>
References: <1595928673-26306-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0101.apcprd06.prod.outlook.com
 (2603:1096:3:14::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0101.apcprd06.prod.outlook.com (2603:1096:3:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 09:35:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d18deb4-55f0-4b64-bb96-08d832d9979a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB44904241EAA8ACB618616A7E88730@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AACMjDK2BuVxR6fq67wedTWb5GOXmpUNrmuLDbvT3pixcztQEZDDJKtf+1Ue5fVUgokBrl/UvNrDGd1J19HUJE1FkBQIH0AlfwWnD+Kd+qmmDC/m1Y23scPN7dKBUX8LFsJfq2o2h390JPGP8/lfKYTDzMP5RNBIvar8Tu8YBloX6ALvjxO2GKXI51P2oF1/J9qOY16Tx6uEG0WUswNg/4+NSYC8Azd4iiRAQ2H2465iZB9yAtGdFLMnIx9OXfJYQxjaHLxSyVEDWCi+K5VhsxkrueI+JVrwrGAFlBfFVUNpj1Y/4yYuzwXzZvs9ptmEUPtL57pkd33+g76WHUfqjkqQBs9APx9HEJv9qUg3OhcHnPdPR4QABziBInvWNe9Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(186003)(956004)(478600001)(6666004)(16526019)(2616005)(36756003)(6486002)(5660300002)(4326008)(316002)(52116002)(6506007)(7416002)(26005)(8676002)(2906002)(86362001)(8936002)(69590400007)(9686003)(6512007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FKULCu848pTT5baHpB2XPZqkvloklp8SVBfObhvxbP1U+cSMwVWg/2LRj5Wfuiqey2kGBKKYEmp2cmnxfkmDKv7kHxQU3xdIm1fYMmO67AMTeFfBO3nAdqgLsI4B25QYqEbndG1PrcmIOd68VjjhvA6qPxsLFEhktgGa7BizoniQxOdHMshfWe7BnmeDIwxBY2OVfIYbCdg/HFgOHdWe+NhLcYKGObZSQjqYqfOlQIdt8C3CJO0OE5xa5pLJlhWRCbJQXe6/nx+jZKk2aCHEAhLzaVEsTISEsKK2PcXSvL6Mtdjt59RRqivaH1+4XhUuoih6pSrzlLoC50LBLm9V+CeqZ2aC1D6TU1YqqhXqNJCGoYYwrt3gkAj8568oSR13hPT/qkmF+DCrFwADTlsj89lnb6lYPB5iic/SsUrsUFTFB/9EhO2mHyhJGiPj4f9bES3VuTQ9Knv8MpwXUlHvD2rncEV/mATKJRjFyztB2DRhZNw6owTmpRxUAsgqcw5L
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d18deb4-55f0-4b64-bb96-08d832d9979a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:35:40.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvEzKLztdjVfqIbdON0tDAYwX/bHKb+1TYUywUjtB39JD6pi3QeYQFFtIq8yWei5Bd19Cra2t6/VChKxIXczWw==
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

