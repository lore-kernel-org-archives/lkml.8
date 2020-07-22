Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E7520729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2EPB1hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgGVMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:51:06 -0400
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:1472
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730661AbgGVMvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEr3EeMa98HWOI41B/8fZu4ohrK2CEIFvwjUeGGq7vrzWXUtVJgoUymlt2SiNwyRF4zQyMJi+NmhakkLaQaOrBXoGIsXXB/Gg69IB27iPNlWBvUMVdOZtIItq+SBCmp2uTeXSPj1tqLsB9bYaDI2CcH0HjqYPkLOjvYMrEWAR/FzgH5KvapDVMb0S4PNXGZ2NSBGZSCmHG1blOyYB9mZYFY1LrsTKYAt0+cwY3kzwJGYTrSd1YIcDt7nBL7jzVYzFhKOx61FqGD4Q/J+JY/QJFJkHOUShV5+QuC0P+g9kfxaNuXzCBy/SaNIiUNQTcNlT2BXRByU/mPDUdue6jj+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3AMx1iO4hZ9tBYjp8j8aWdbWnINFXB9W92UEwxgxBg=;
 b=GRrcAEiHYn/8pVwb4VjnkmCo2k6EP9EtdgaPjPyUpkJAjvV6ybnnhQt28WxSgHox7b6k0OO0dUSyp3lpbwBzLKL47WakssfCDdotloCAw7+6wwdOtFXOoxBQdelheE5vcG22VPLITl5F0rPGzwDuEb85i4CzCtwwGt2Vm6VUyZhnVzWv9vswmauCH98YUjOIbmcIBxpWIMFaQty8ddoaPTBQTVTNi5BZY5IUSfYmc71uvZiPq5MvW4t5gOW08cpFmMyvDbj++SPW6/bNR6SO22qxSBcWyIgUUnE1pu9eIA2lv3HaCORP1CEO6MggdCnnUbmhTaPiZ+chPvaF0z1ubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3AMx1iO4hZ9tBYjp8j8aWdbWnINFXB9W92UEwxgxBg=;
 b=a2EPB1hgYfNXfeW5sPpdfQ1lDt1QFq1ZpaoSNNQ5zZaY8RU2OG+w0kg1DUXIGz3pu0lNGxKuZjsML6Jrph37zshN736tNxOY6t04bfpjwE8JAth+MlxRN36m4fX/LASBB+FAd2jm9up1CJonqdmbfdSwJeOvMSKChXNNsbjy6ZI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4763.eurprd04.prod.outlook.com (2603:10a6:10:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 12:51:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 12:51:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH] remoteproc: virtio: support sharing vdev buffer
Date:   Wed, 22 Jul 2020 21:15:43 +0800
Message-Id: <20200722131543.7024-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 12:50:57 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a13c939-16c2-420f-b370-08d82e3de228
X-MS-TrafficTypeDiagnostic: DB7PR04MB4763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4763EAEA41A8D8035273F6E688790@DB7PR04MB4763.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51uofUoVuVmEbSZ1UvXY38B92OX0i1Xh9hr5uTUAbm3wYT1bhHtEwNWQjZrnBFYoo8KrzzgDe0O6iVCVIs0G+ilog66RKKcV5pslPmEdu0KO4vARE+k36XCk9BdgWgdiZIYQidc6XQhzZoenHXQ0jZLBXO2ypE2q+jex0t6paqAw68avHoMNu0OJfq2XIDwRjE7VZkeoczUIGu0c4OQde7QvwISH1vHB021gmlSDnKPWDkOAAzoco5mcw4grQSeQAOFliqAsJsrK55si9eipam7u/WDJQsfNowGlUitvGNYmXqz2+YIA2Em7/gqLB93QGB+Kr+kyNkTiM6+q6sLSWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(6486002)(6512007)(2906002)(66556008)(66476007)(52116002)(6506007)(66946007)(26005)(316002)(4326008)(86362001)(44832011)(8936002)(36756003)(2616005)(5660300002)(4744005)(8676002)(16526019)(478600001)(6666004)(186003)(1076003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nvleWy+fXMNW9v3QCWGw4WTInMfiscWefGHPvBPoWMCS0a3rWfQT45xUwqkNZ5yNR+ga7fL0N4sRe2hZREQjNBq/696TSxvjwYWEgIzw8z/+CwYnq5+Vi9XUOvx5WRH93juyZH1/akiLSPw6BqES5+90WEaKV12yLLQ+Yu2B3RWdIRRqo2XqX/8DkVUU45MFX4hpNsdyqlBqVYJ+ih0g51IIHdtaPs3a9XRSnQjwjHClcxBIZA3MJ3N+9q1V+S+qGW676b1FreBJfnPbhSBYP02UcVwE2EPLsuUb2H8mccgjZ8pUj+eSvJVI6njNLdOsuKfi7FvxZY63r2l/7gMQjyc/nK7wVUNBECdGNJk9tnyutxE0JHo/AnP62HFhWhyFL2EmvnuBKhM2minQvVar0gki3g8thwDMugAl4Yr6PFj9anUwHXchnZ5yajcIkvyylnUqI508W8lH1izdNDYKdi5JJVFU++ZCw8JGcVMP3m7JszDHhr8WZDPIgy1QJX17
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a13c939-16c2-420f-b370-08d82e3de228
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 12:50:59.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6U9zPTPtNo+/yhQQ6+oBU9uri2KOcrIpjjsbScup2vSDEHX409HSCR0Lo8vfznfSB1+iOnJnmrtL4hKQdRBHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support sharing vdev buffer between multiple vdevs by using name
"vdevbuffer".

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index dfd3808c34fd..5d78ebea111e 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -343,6 +343,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 
 	/* Try to find dedicated vdev buffer carveout */
 	mem = rproc_find_carveout_by_name(rproc, "vdev%dbuffer", rvdev->index);
+	if (!mem)
+		mem = rproc_find_carveout_by_name(rproc, "vdevbuffer");
 	if (mem) {
 		phys_addr_t pa;
 
-- 
2.16.4

