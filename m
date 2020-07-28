Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31BE2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LGRQc5/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgG1QHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:07:09 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:24618
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731214AbgG1QHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPvGCRe5P9nBapf6806p1LQvS0U38F4aAZbSoHlHy48FV9uzyT+Jh2YFl4PLlvE98KTg+Wiw1Q0MKONxrbZ8T9ohcS4F0gYSZWQLHpHEgjIHm2drzy2qWMA+an/6VwW8KWd8MDVbxgKxKUlQ5HuxFEJHLlaz9oPu/WQq+hCYJRildgRz6YYXrdBckm3qJXwOafrlszTktTvv5404uVhI1DxbApa+HT9jB1Iy27JPStrFKVBrUmueMDEZqJQ2a7QeVvIlJ2zdjHl+Ov+VE70ttlmjMmhx4TMqIblE0sPhXqbdv16MQH1KFnSxR7ZjX+qA0nZM1qNEh4JcvjpI5HiBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY49mVqWzL7K+XU1k+rbMbfs53B5hKFiNB+VvldRQEM=;
 b=b8HtHHvxVJJOZbJPlBevvIYh6odv66CCzr4RNKp5LPbjFb4wbsdBy93/0j3a/SRqKhEoT/I97WnH1gBTvB4hFRc1wBGkWs0VspObP+AzWeV6J/dxgEUMebdz+xKfvURlf/Mpih1L68GLtCvfbXYD8zUkeyHZD5WnW7dbWzwwGxyGkCMUwwdWMB7OTnhCp07b0F+lZJywQ7Z3AAM47YGec4DnBoGVysVFe0dGnwU8r7XOSrrWEvWB8sVGQ/DERQSVNJOOU9ZcEoVi42GiOveEo9/A1xkyqDlRJE+ydhyYmoV4me0bupKkwK3zmCp4bMc1Dxqgzl/dejKIrKtBsEZpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY49mVqWzL7K+XU1k+rbMbfs53B5hKFiNB+VvldRQEM=;
 b=LGRQc5/I4pLTuVr65IjZXpx5Wv5TuiK1dJzpJ014C9Lu71/iBA0487h0Rk5sWKULo5lT1JLJ8iQ9dsSLWvYZ1V4R6MYRRcanmj8DcdU09VgdbE3pE5nsqdeJQempLIS/8pkb9cb7s5CL9+/gkmpBdVZKmWF79/aUIvhAvTatWDM=
Received: from MWHPR12CA0032.namprd12.prod.outlook.com (2603:10b6:301:2::18)
 by BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 16:07:04 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::93) by MWHPR12CA0032.outlook.office365.com
 (2603:10b6:301:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Tue, 28 Jul 2020 16:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 16:07:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:34 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:34 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 11:06:31 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] ASoC: amd: Passing card structure based on codec
Date:   Tue, 28 Jul 2020 21:32:52 +0530
Message-ID: <20200728160255.31020-3-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e29f64a-aafd-47d5-da56-08d8331044ba
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2481DBB8AF5880102705F3CFE7730@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vd8RA2Rzk5WZsa8NMBpH7qYxRHbvtEk3hamBMslUc0Njbs6eLE/4SHclknjTIlScVTFA2/bnRbKyMi6zaVt9Tayr3nR5OWCjY8XJF+2R0cXFatyq8TsN5vJnYGX6ByVIAZ38k75oeehQYXU2IClfKPQxfKkL5GkX3DDvCyl5QM6dnpyhNGHwOTD7aiVob07wUD2t7vGwNEzZyy2vBw8WAM6tLp9zlW5iz6d7jV4/QI6302JUWygGHmO6H5+Mw62fC4rCDCFI4QrJ9+EP2ze7KEz1uigQ5Fi1qEm8E25n5hHMV0/1TFpYI3BZyotpm78S7Hu8fuX63UWwkOpKg0uIo81q6MhiWEcEMP8u6CA0Ju9kLABzihlxpOpN84D/J8htz3u8e9Ixgljom/svp76Htcy23cpRsLhC5zxJA7Ou3Kg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(82740400003)(47076004)(316002)(1076003)(186003)(8936002)(336012)(356005)(81166007)(70586007)(70206006)(109986005)(7696005)(86362001)(54906003)(426003)(4326008)(8676002)(2616005)(478600001)(6666004)(26005)(83380400001)(5660300002)(82310400002)(2906002)(36756003)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 16:07:03.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e29f64a-aafd-47d5-da56-08d8331044ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing specific snd_soc_card structure depending on the ACPI ID.
In future we can add other IDs in the ACPI table and pass the structure.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 8b5af064864f..2c672657d139 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -30,6 +30,7 @@ static struct snd_soc_jack pco_jack;
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
 static struct gpio_desc *dmic_sel;
+void *soc_is_rltk_max(struct device *dev);
 
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -326,18 +327,32 @@ static struct snd_soc_card acp3x_5682 = {
 	.num_controls = ARRAY_SIZE(acp3x_5682_mc_controls),
 };
 
+void *soc_is_rltk_max(struct device *dev)
+{
+	const struct acpi_device_id *match;
+
+	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!match)
+		return NULL;
+	return (void *)match->driver_data;
+}
+
 static int acp3x_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
 	struct acp3x_platform_info *machine;
+	struct device *dev = &pdev->dev;
+
+	card = (struct snd_soc_card *)soc_is_rltk_max(dev);
+	if (!card)
+		return -ENODEV;
 
 	machine = devm_kzalloc(&pdev->dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
-	card = &acp3x_5682;
-	acp3x_5682.dev = &pdev->dev;
+	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
@@ -348,18 +363,18 @@ static int acp3x_probe(struct platform_device *pdev)
 		return PTR_ERR(dmic_sel);
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &acp3x_5682);
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
 				"devm_snd_soc_register_card(%s) failed: %d\n",
-				acp3x_5682.name, ret);
+				card->name, ret);
 		return ret;
 	}
 	return 0;
 }
 
 static const struct acpi_device_id acp3x_audio_acpi_match[] = {
-	{ "AMDI5682", 0 },
+	{ "AMDI5682", (unsigned long)&acp3x_5682},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
-- 
2.17.1

