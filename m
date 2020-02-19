Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BDC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C532E2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxBJL65X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBSIHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:07:04 -0500
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:6167
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbgBSIHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldKmhj5Nu65F0BFaud+Zngm528krUY/XEvjLamy4NARZimgDjqF0AJqZDvk7fjixFIkWT+CSovL5KwyNVP2b0BjmHC8tnjNJz7u+qIbw7BmOKjdDFdMVrzVozdk+3qe55P5JlJILhCaCztmMtqgpYUn5A3ta+p5kAr7/xUTGzWofbNc8eyaZA4/S/Ep6gsMNCk6G39MF6aL2NOY50ZHzqUi4YzfihW4+rbEPSTNnyEASy0LmM2ChtWcPqyO6x0tUnCrm0+yn6KI8UCeAKGUZ3+bTMPsaEWU1D+2l0p2yKZEqaNR3gQKwg7NXbC9V8STbCgi+HFh8V0aa65MOAFDV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW8D9PKYgZw/xogPl/HvMYj8YaeyZ8IBW32RXchewUY=;
 b=KVs7RlBOqcDQm5zB4Izcpghz3ifbKG887F7dTuV1AvKj3yKwGsw5tyE4WTyKAzRdp93aWxvPFqHAeRYkdVULitlYjppIJWZpg/wMAKa1lWVVwYKiPEQCVVgTWhnWd/0SeLvEeWUcrZ5aESny0+KA9rk4YgzWLCq6hKAPJv4SkhaLIktPesu91vpeGMT1BfFHNr/++JXxfVxmMXM/GCxjMxY96P/BDm3tjSAdDXXChyiqNIsuIl7zcxPjSmS3UkuCz/OYHJNQauIWAuenxT3U/W12hfNoFvBWpkYxcILSbK3rMT0P6D7Kad61kP9+R7aMcozyeCYaEnuqc//W5teDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW8D9PKYgZw/xogPl/HvMYj8YaeyZ8IBW32RXchewUY=;
 b=TxBJL65Xgs1q9O3RTwf4oLkWCGgtMiAfe8PmOP8uuokZdn620o5ivx40TdQhv0dyRFEmyC9YkRZBnP/8lBY9ALxoYgsBaQjpphjsh3gEvDVpgu6XIo2C6TCaSSOEIcGB+LajifnZFcJw0l4h8Rs1w36kGNj9a9c0mjQ++HBLty8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4132.eurprd04.prod.outlook.com (52.134.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 08:06:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 08:06:59 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 13/14] ARM: imx7ulp: enable cpufreq
Date:   Wed, 19 Feb 2020 15:59:56 +0800
Message-Id: <1582099197-20327-14-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 08:06:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 334570a6-d0e4-4e26-5e5f-08d7b512b163
X-MS-TrafficTypeDiagnostic: AM0PR04MB4132:|AM0PR04MB4132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4132CCBE106BC2C0ADD8349288100@AM0PR04MB4132.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(4744005)(9686003)(2906002)(6486002)(6512007)(316002)(478600001)(69590400006)(2616005)(66476007)(8936002)(86362001)(8676002)(36756003)(81156014)(186003)(7416002)(81166006)(52116002)(5660300002)(66946007)(4326008)(6506007)(16526019)(26005)(956004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4132;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDF6/2qyHYHnKGnXaM/QVbhsHpJq1RnBgWb1Whqtd+si1kBteuIKg9/tHRCPxFnuvmXb+MHiRMoov9EXV4lWpaGnTB4YuHza1vKWhHnYckIwR8dBHwdG7WQtJkUV/KHJ8QYxltfpGj1YCYZdCWbIMwnGRuy/AoFlI565wm+nZkDMh+LMckky0vsLRfy59VPGrFQE2Wv1LJ/IcX8tHFLTOtchM2DABqSnLIHb7GEyueCJAgJwCRjDMycWcU9hdXenH131AtXJ/TPiEG2v+AVWIFllSlZ/z3wQXQdXCOu88BZOKVm/LlDS1TzK62iW27P57cP5Y/ksifgTjQPVLeZ6x1kDjoKWK1zrtxgTK9zH/Zp/ERTZBJwCA/tlCxAHFDJLNVVs6GuAx934JzoQb0yQ/b82qvquBNRPcg0dKSk0rzlMVMbxSUJJkJOuss7TqaYqKW7hjAM9nfe2CkEG4ZC5oYiiuuu3XEYhI1yBjjhMCA7bhBZrXS5BDIiH32LK7RzqCsNaNA5+oeOOIMK18icVcCbu/3XA1ccc2fJjeeNrUd8=
X-MS-Exchange-AntiSpam-MessageData: k8peW0sLtwZynP4IWICymOWtabZLzajWi6SNMdSPxqMc12F7USA7UfFmnDc2b6Buna4mooyqunY3toTWScX7PPfORnTeGCRA+1BfZ8oklG1uGmDp59hcKS437jto/xYZSwkaZJuvKX4+EN4wcHX3XA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334570a6-d0e4-4e26-5e5f-08d7b512b163
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:06:58.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5fyFdFtNnOGTMiSpSoEgOxD2OljAu0xah5GkV8Zq+2taddQ4DFRbgMYP6yduvo69Qo0+VhdYPqQNJc/Tsdapg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4132
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
index 11ac71aaf965..bf22d19e02f6 100644
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
2.16.4

