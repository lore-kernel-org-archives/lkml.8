Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A48246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="12Iq2DK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCBIZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:25:12 -0500
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:35904
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbgCBIZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:25:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcoDUaAeg9VEBYQTXRIeEGa/cpFdYTtJ0SIKol4tv1PvEnjn48GCMTAydqmtRIQjworWy6g+uaepbdsIXOYGnOg2Vy9p8oWfR9DZWeRbC+5lgUT9LnzzCmVZyBEVxRjQaXrbKf1+tZ3qtTupTzDsRt7AbLh/ma/lDPrLpzzlnMpKf3DJe9R+hT1CJoFzC7GiWE8QM98znowDB8zbVFPdyGecsR/DNeVTvRyAcjR/tIQCBiL0KISrw1WVhnAkUOCOV0Gx+bsyfZtIFipUwUb2D3Vn0ieJLGrKBO+kbpaYkwMoOlW/tDFbo80qtoLVyHuefMqiusAyqwJWctDW+mvDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k4MeTQqSnuAL9OxSvKCcY7NndVY6mhe4iddeTQXzFk=;
 b=D+Z29B5uNvaopOPqOxpIAMnCVxzslVY2ENZp0my0iUToqMoL0MxPg4ORFTEOrwFBuQA5ZRkk6kITmKj3oRPBz0BrE9QfZGqSKxzCR9226eMHjIHUlRS6ZNDxxsZqub6H9wbdj7JwT0qrfH+ydOf0870f0377MdOel45uVghT+TRTiXp5s8tsZ1x9Zfyg/bnwI9OsPrblNBBp1CrDnCxOJn5//3n8fNFr6BnhxCkum4umkhgqeaQXPu2fEBSTiI3qQIse2qYn9Zq+lQKhBHQRjNxHckPQXMicdUvB3FsSLPPjPP+sQCF1HclzBgrH36favPDDZJAbGPuVn2pQJ9bNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k4MeTQqSnuAL9OxSvKCcY7NndVY6mhe4iddeTQXzFk=;
 b=12Iq2DK4p43IwNhwqXAn/fGZ+ipilgVTX/b+cpw/lS8D24kcSSTVH5xWE4itP07TQWEvIywWIJ7BuAxG7kA8BqBvhzFl3tMtJuxUPykVyz6VhKIlkkeV+foBC9InIsS5UIYm1NxeRkVS9U6+YN3aeE5Yt3SmWOY5wDH1hFhaDpo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 08:25:09 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c3:c235:f1b0:50cc]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::c3:c235:f1b0:50cc%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 08:25:09 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoc: amd: Add DMIC switch capability to machine driver
Date:   Mon,  2 Mar 2020 13:54:36 +0530
Message-Id: <20200302082443.51587-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::34) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Mon, 2 Mar 2020 08:25:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2529c90e-1b8b-461e-8723-08d7be833810
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:|MN2PR12MB4271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4271DFD9E819E2B7A6FC5AD9F8E70@MN2PR12MB4271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(44832011)(956004)(186003)(16526019)(26005)(2616005)(5660300002)(66556008)(66476007)(66946007)(6666004)(8936002)(8676002)(81166006)(1076003)(6486002)(36756003)(81156014)(2906002)(109986005)(478600001)(4326008)(316002)(54906003)(7696005)(52116002)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4271;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+E9/1sZ6RvU7N2k5O43twLDcAZmZOQ5MVx/V0CFjuB/7glXjeoNhp143wtZ13dqOO18VRQLE8eLMNKPqiO44HaLMz56CTLIcfJ5flLco1OY1lniyKZIGDHzEvQPj5bF+6DymuguhW7ZlHyLshLGy2E+6H6XaaOcr234Uuo1MiupOpap7w4pAvsg7CYOEgSzTKAeLLBTMg5OkbhDasJRlEQjrplNy6dxKH40vFKf9rimp4VGYN3XPXI7LvMJet2flRQt2EkjgLsP/uvbJ9RW/bWiwmEfW2AzkiAurwzMj+fepnRun3kUskdfb0J+U8dA816m0AVmgGA/QsoYkp+83KOlbS+OnVyeTo7cyj6hiFMU9qmcpSCnZzKZgI1VOBUEMKObNyyNypU9x1YNsix0xyWB/FqBpniWms3xAWuQmR0Gs0EX/jDyld+vd3rl0B7jSQGFVeakqcVefnOEl3X1dU82TJnv52O65tN6mwW60jg=
X-MS-Exchange-AntiSpam-MessageData: xEyJaOa2tBir4eLwS21vS98uQrRlU1vKTm7flxtDaXI2LYV8UkuI/wKfpG2WN4CcfAJAI0FVZe2bfmFd4fUNAk8zNB9EF1Num0GTHAlVyXZuIJHguYf/PHrOVddghydk7JB3PLDqadTntZ49gnXeBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2529c90e-1b8b-461e-8723-08d7be833810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 08:25:08.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxt+esqEfanyHHb1ZVTRT/VixV/dLvU66ooDrpyzantqFd9rhFsbngUbMeLanrd3Mb7HR1NPsstI6SbKBQg41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch between DMIC0 and DMIC1 based on recording device selected.
This is done by toggling the dmic select gpio.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 53 ++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 96fbcd29e3ed..511b8b1722aa 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -12,6 +12,7 @@
 #include <sound/jack.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -27,6 +28,7 @@
 static struct snd_soc_jack pco_jack;
 static struct clk *rt5682_dai_wclk;
 static struct clk *rt5682_dai_bclk;
+static struct gpio_desc *dmic_sel;
 
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -176,7 +178,7 @@ static int acp3x_max_startup(struct snd_pcm_substream *substream)
 	return rt5682_clk_enable(substream);
 }
 
-static int acp3x_ec_startup(struct snd_pcm_substream *substream)
+static int acp3x_ec_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
@@ -185,6 +187,23 @@ static int acp3x_ec_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
 	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (dmic_sel)
+		gpiod_set_value(dmic_sel, 0);
+
+	return rt5682_clk_enable(substream);
+}
+
+static int acp3x_ec_dmic1_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct acp3x_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->cap_i2s_instance = I2S_BT_INSTANCE;
+	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (dmic_sel)
+		gpiod_set_value(dmic_sel, 1);
 
 	return rt5682_clk_enable(substream);
 }
@@ -204,8 +223,13 @@ static const struct snd_soc_ops acp3x_max_play_ops = {
 	.shutdown = rt5682_shutdown,
 };
 
-static const struct snd_soc_ops acp3x_ec_cap_ops = {
-	.startup = acp3x_ec_startup,
+static const struct snd_soc_ops acp3x_ec_cap0_ops = {
+	.startup = acp3x_ec_dmic0_startup,
+	.shutdown = rt5682_shutdown,
+};
+
+static const struct snd_soc_ops acp3x_ec_cap1_ops = {
+	.startup = acp3x_ec_dmic1_startup,
 	.shutdown = rt5682_shutdown,
 };
 
@@ -246,12 +270,21 @@ static struct snd_soc_dai_link acp3x_dai_5682_98357[] = {
 		SND_SOC_DAILINK_REG(acp3x_bt, max, platform),
 	},
 	{
-		.name = "acp3x-ec-capture",
-		.stream_name = "Capture",
+		.name = "acp3x-ec-dmic0-capture",
+		.stream_name = "Capture DMIC0",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBS_CFS,
+		.dpcm_capture = 1,
+		.ops = &acp3x_ec_cap0_ops,
+		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
+	},
+	{
+		.name = "acp3x-ec-dmic1-capture",
+		.stream_name = "Capture DMIC1",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBS_CFS,
 		.dpcm_capture = 1,
-		.ops = &acp3x_ec_cap_ops,
+		.ops = &acp3x_ec_cap1_ops,
 		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
 	},
 };
@@ -302,6 +335,14 @@ static int acp3x_probe(struct platform_device *pdev)
 	acp3x_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
+
+	dmic_sel = devm_gpiod_get(&pdev->dev, "dmic", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic_sel)) {
+		dev_err(&pdev->dev, "DMIC gpio failed err=%d\n",
+			PTR_ERR(dmic_sel));
+		return PTR_ERR(dmic_sel);
+	}
+
 	ret = devm_snd_soc_register_card(&pdev->dev, &acp3x_card);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.17.1

