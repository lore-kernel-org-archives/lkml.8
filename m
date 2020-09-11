Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A8C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F08A21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="seclKN+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgIKDih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:38:37 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:51841
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgIKDiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9eBdoILkqjzksadjQ8g6/NeHU8BB9duYdNQcA47++18xFN2vUOGiJi4k15x/+f5rwhyIpxV54CQdrE9oZBVj3B7PrCu+o5lD+2J8F3tCeGPYKTNwNYAkLJ/DL4zIR4KArqMuBujgVFmCR6azjXrTu1Ys4K5jjl0lQitvt8XhgN9AolLBEd1I0uZMfdXT3SZcoaxgkN/7M+EGzLkkQV8mOTDTAmvn9VcXvKrkJeXF4XiHdfixvhQLzdiV1hh+8YHWSM6TedfHTs7OG3NwYKK0S0CC5hPxwOsU5CdwIzlsQdqIxugv/cS4DDblA0D9n35rMnOZzE9azZApUCzmlhSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHK6L2elfkKsJH8vNgUGijKaz22d5anduyA45WjKPLE=;
 b=CeLFYa5vQ2NqSxQsnpVkgxQOgn7VsMM9PVgx9b91xhZtKK383MD8CEStMJVMXQ1YOCwNX/VBNTCMAFfWj5FKelYXIEfotklQMOBsrSW+ruBVjlNBesg3el2cdxTt/IsgHb4E9KaWw/UxOWP6H3rwpQ75a0OqUXzOUvWU+2gZ9qgc1tFtAo25uHCGKmxVUlcrpchmlh6c4bB82ne5ccL5mfSc2PmKKcSQ0/Eys6ad9tmAnh4FFmefCA6JMMWptyMsNAKIi7KRwpON+uO2UFftgMdgADx6/AemMEbGxDrMUu6IwYjLiwdjbvMmPYW/4I6t3YvsE55+cPoY2SuklC5IVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHK6L2elfkKsJH8vNgUGijKaz22d5anduyA45WjKPLE=;
 b=seclKN+xaPFme7SvDgq9aPHxSv/ZN4lUuiWvmAjVqFArPX6JDLouyQkRuSN8nweQQKsuzv4Vr+CI9PzhAaaLOl2aCQ0WouK6WFBpGmEZzPFa4BgPTvY5+xMHf3A4ODQw1kNh+WVgnugn1qcALkTAFUYkb2IFCFfHshiX36uzXow=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:38:19 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:38:19 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: imx7ulp: enable cpufreq
Date:   Fri, 11 Sep 2020 11:31:44 +0800
Message-Id: <1599795104-7016-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.66) by SG2PR02CA0031.apcprd02.prod.outlook.com (2603:1096:3:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:38:15 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b61ecb0-316b-4122-02dd-08d856041ffe
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5084ABF6E4497A78DE4AA2BF88240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQaqQgLrOoxvVFhqgjGfHlbY2xCtnCaBFkAiX8q6KqLK6zdZxz8HKjYY7idaKldYLMoO9onJlrY4qHMJTyylqg5RYlU3T3fDADzWejICWemepXJ3rIaHQt77y+GjblZzFxNXaC37bmaxmXAlzsl93EphuwNgtu/SCHu3pcLTS9UtledeICRZwMBYSQT/B89ZuIa0zrWmN674VESt+zLGHbtsMhujRg+Z/9Uvfzpw2j+V8TZVxd5nfRXCa/MYmIpiQL5gbwdvdaIrF4dXaGSCCW61bf4uKbyC1aappfdwuCFZYq88pBKLrn92S0uW04vBvLVKU4gkHYgTXHHn1IVbQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(956004)(2616005)(478600001)(86362001)(36756003)(66556008)(66476007)(9686003)(16526019)(186003)(26005)(6666004)(52116002)(8676002)(5660300002)(4744005)(4326008)(8936002)(2906002)(66946007)(16576012)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B0uK1bhLZQwiVHraLsoW+b+fC84yMd6j0YqxRuK+j3sN8nO7P5wat/Q64J34LlZ5bbBpps9l0kPl9VESetMrYg4eOzq8rLsXaUg5mz4Ftl0LEuleSh0iitgX7Fe56Y3fuQbxi+jgiBHiRy7cTeBIx508ETBWX3dQ8n8jLU/mVrNvxnvvVldAB7DbnQIWzM3hCAB/UbPYErvaagX8fEhCWSbopuWQPegN4kDEJ7CFwAyJcfubdAiUCxp8Jq8vI1uvzktbnlG8AfiE6wZsXdDvbGiHmdirtVgVFmHd+HZn8Q750vZAEcURWN2kFN4AF40YWIlAF697NP3DrCiypWBtxckloum5ayt/F+c3ptL7UWM6KPUFZkpshZ8VEmnstb15jFS/msGKsTm1KV4cQ5cj7UdHtma/BcBsPHY2PhzrG6Sc6PHlRvzA5bcCiabq28exhzACnNZ/8J/Eiim78SZU1PgQstPex8STth9/6UfhNCFe1NrXkquCQ3+n9zz3jrl8AVc14LS7EN5VPjN7QJFO5vx1Er9LDyaktDdhg81pQYmiA1LWG/qDdvBQ5VMRiBdamXlUUyhmj9kiFwMkn9joR2w7IFO2TCof7PP2FxbuIRwryCgpHauIFFwBI6k8jqF6eT+iz+p7gr97xuzZM3XyvQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b61ecb0-316b-4122-02dd-08d856041ffe
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:38:19.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueIX/J0P9NlAKkpfuBA+U+2bD+ebX6QZyYtXD5dxK/b/d6kDcJ0Bce43YtRHfgQJeYJILpmKDDH4Jn3ko8+/0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable cpufreq for i.MX7ULP when imx cpufreq dt driver enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mach-imx7ulp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx7ulp.c b/arch/arm/mach-imx/mach-imx7ulp.c
index 128cf4c92aab..445256e6a4a0 100644
--- a/arch/arm/mach-imx/mach-imx7ulp.c
+++ b/arch/arm/mach-imx/mach-imx7ulp.c
@@ -67,6 +67,9 @@ static const char *const imx7ulp_dt_compat[] __initconst = {
 
 static void __init imx7ulp_init_late(void)
 {
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
+		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+
 	imx7ulp_cpuidle_init();
 }
 
-- 
2.28.0

