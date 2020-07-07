Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950D520720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bBApNwxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGGKIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:08:51 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:17552
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbgGGKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPTOyd8q10AnD3KY3OxnSTcSO2sDc6khNISfVTXz5pO5jNJVkadWFR9GPl6g6Hz15cxcodjWWM/X08oxicgyHzKMduvCDR0joywGI8sLzqoqVKt+5xB2VTberVGeQpe0h7bPWzNf/8A+BxS6bXfGJSaHVeL7ns6GaC3gpEBzYO5v5P4tREC4nTuYKs8BNcR0vwWhdzLji0vaFry/SShYMAbnhyR9byVc4Nkd1NCryCUClPkM80/cPletAI+9D0dRjc30T8ewtFdcUiytesmIlmOnqrXbpdrPIzfQS+hI+j3mDJGbIpX3pZJ1+wrA6XWZwZ78l1fhmKYJ2cYmSdoXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/PqrCgyn+Le9QHeazN69dgDNGE35u8F1594bSWbHwA=;
 b=fPw1OyZwQcrbNA0qqSAI0pDuXixHNz49/UurCefTqyrZU8CLJKlTdObuzN6i8VEuKGmG5P31rTtcrZkaCfyuPNRe1SV1oSj7idbsCtoD7WP60Brdk+NyTRPd+FJvfVvsLgkLtRz8quKqQs3WwSxFv3xF6oMRKQqLn6EWxeecXLbcERUpqGsThgozlG+HTzcjbJmwgMuz3D6PlXAnqYw3M3g9/qOE/h7fPEcVDniYiKN0UvyUpyiennbItMZq2MQLP7OrFLhQ4Hye4Q6PMqzgOgzGhdGMQwEgDqHplKTAvTwGOgRPIOU5Nat8oN1CPFPgLk++U9RrNgnSdmaD5vkS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/PqrCgyn+Le9QHeazN69dgDNGE35u8F1594bSWbHwA=;
 b=bBApNwxF+GvkE2RrsGyJSzCUs01HRyArhXFHYrxZz6G+syANGqJgnv4EgvYTWOwl4oUGpZuBhNTZIFQ7M8EbKIqEQig03gvithF0L/Kd2gtLYah/mLQchfVW8qzxEmck7q8rqJykyPduedKXFTYHDJiszjsDEbZJnqkjC3/FxfI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 10:08:48 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:08:48 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: rt5682: Add fmw property to get name of mclk
Date:   Tue,  7 Jul 2020 15:38:25 +0530
Message-Id: <20200707100825.24792-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G2.mshome.net (122.167.38.75) by MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 10:08:45 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4525934-05a2-4040-f7c6-08d8225dbd86
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB144003CD74383A78A6256683F8660@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSzT/a1okk5LyiQUgBpAIvYCl3ECD0euo9UYKwjlKxvVJwYFAmtyXJa9owmaWaKXQhnAghQ+Me4s+QEmUsfnqMKWBg2k1R6Ur5MVf585vELDhwbUok7/0mLfjTBNUuA2GZzzjBmx+fITR9/lz4JN1F0sk+MSeQ2mTcuVBIBkKu38jfhpFVBYXGBZdiscLe5toPLtR4ZQEiHRsZS/y9V2O7jR0E3zJQiLL7v1/9Ia5fH4h8OCLt7TE9dWKLBBW8uYhS0xnwZUXtUrSC3QckOiNuPPuL4ziqVmaH5OFpdlnF6OaoyidGbbgiJoW88ZnKx0uI/1abI+F3BylHfi1vnIgscT/Qy+JxDrkHg6ooNlNKvPtj2/GHgGCgtF+aUb9wvL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(83380400001)(66946007)(2906002)(8936002)(956004)(2616005)(109986005)(478600001)(6512007)(1076003)(16526019)(186003)(52116002)(44832011)(8676002)(6666004)(5660300002)(66476007)(66556008)(316002)(4326008)(54906003)(6506007)(6486002)(86362001)(26005)(36756003)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jS4MHA2JI7z2RiIyK6xX+kt7e0xUWdOzZJ52bZtmqU7wxVg5fdeGIcbKpi9BYYNlTBbIy94bXIqnFvJ0aNHc1TXiyAsyzxYUifhKo0HvxW7VYrvkT2rx4aLPDm33/CWeIuiR5QY9abwky8z/RpsYmhq5532SBVsvfW1rObxUY/ORGPV2HahpBIWAbBJhGxDE3kGJT7nMQiPC9Bsh7tT2MllRnjrUjiMvqfYCSWtJyumOSAQNERe9/4Vb/ogbMclgoUrHI+2A3r/u1NCYrnvUe5bDvM/RZgX0D98pld24VEI9TIpJC5y3nd9duy8brmt62jhV6ktcsxSde1lrto7jCxgegJmC0Bp1CZ5k368MdfL1fCxXkO+nlgGokVuDyQUg8+hs3xLLLbNcqVVtPM+361/Ejj6L8zzcauSqZAdfyv8NB3ufg9MReDEPkVhwmxHmMmKg+SNenmjMpMNIynVPDYcsrckSPYGpF7nXn4pdkjQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4525934-05a2-4040-f7c6-08d8225dbd86
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:08:48.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yYClgEJlSyBygXwjoWQKdWNPYQvZciWzLhobOMhBvTip5zsXhCfD+wQPAi77vGExhkrpvFyLGGTJBBn+V9Ymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-dts based systems can use ACPI DSDT to pass on the mclk.
Thus add fmw property mclk-name to get the name of the system clk
and link it to rt5682 mclk.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 include/sound/rt5682.h    | 1 +
 sound/soc/codecs/rt5682.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/rt5682.h b/include/sound/rt5682.h
index e1f790561ac1..8717c02f89b8 100644
--- a/include/sound/rt5682.h
+++ b/include/sound/rt5682.h
@@ -42,6 +42,7 @@ struct rt5682_platform_data {
 	unsigned int dmic_delay;
 
 	const char *dai_clk_names[RT5682_DAI_NUM_CLKS];
+	const char *mclk_name;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index de40b6cd16cf..8b223bd0929e 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2849,7 +2849,10 @@ static int rt5682_probe(struct snd_soc_component *component)
 	} else {
 #ifdef CONFIG_COMMON_CLK
 		/* Check if MCLK provided */
-		rt5682->mclk = devm_clk_get(component->dev, "mclk");
+		if (rt5682->pdata.mclk_name)
+			rt5682->mclk = clk_get(NULL, rt5682->pdata.mclk_name);
+		if (!rt5682->mclk)
+			rt5682->mclk = devm_clk_get(component->dev, "mclk");
 		if (IS_ERR(rt5682->mclk)) {
 			if (PTR_ERR(rt5682->mclk) != -ENOENT) {
 				ret = PTR_ERR(rt5682->mclk);
@@ -2976,6 +2979,8 @@ int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
 			 rt5682->pdata.dai_clk_names[RT5682_DAI_WCLK_IDX],
 			 rt5682->pdata.dai_clk_names[RT5682_DAI_BCLK_IDX]);
 
+	device_property_read_string(dev, "realtek,mclk-name", &rt5682->pdata.mclk_name);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt5682_parse_dt);
-- 
2.20.1

