Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B242084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k5KDp5Wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgE1GDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:03:11 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:6230
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgE1GDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h87IW0vNmPq8vEoCRRbb4IwgvW5C9A9ckmL4sT9481ymFSxB4eDBKouGd6BBb93Epkgmq7gHJGCkZkpd0eiiy+zhs9bWa6EvgGkwpwZ7Zjdj//Q/98lkid5F0pFYcXKD4uome9BYuD57p/IgieCHkgnlu7yIDNpj+ptnKHvhAxQ30A4bjifsBPpW5qFYEgky6xW/jjNOCDPkOdipmlZUDcg7Ai/W1Bfhf/UNK7BSnRKG7NbQD6OfDU9z23GbBrx0eCnUxM+l9McDMDmLNUyRzgAaFIaG0Aa+OAk9KaWanrM+6m6ziE5p6aqIt5nhiMw/9t7ZNI6hCQspuKxEfTH6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw6i22Q8V0iDYs5AkSCk2uIjCBoe/88SYmOlc6Uvcew=;
 b=Zxh7KJt98SF/wYTc7IrGqxpIYE0Bl4WBlepf9Fm0roNetVFiUKgYI4+d0d5F7HqGiBnQI5+4Rn2oK043YPe14BLRE5lAdsD4c+05SbLKB7rpj7sD9myRJRu4LZ78hacZ6SH0YYLTNfpjguPLvFOxM/z4CeCAryy9wq3Sjwu3P6AVaJgHCmfQ3CBGSD2UBbcMROIwicmceRi5jG/UsSwH/GNj7GJlabU+/oc9zG06NQvyS5FUoArGyAcmAgxtgonlcXYfaXs4oBvFx1ZYYCYX21Wod8deU/ZPye871g1Qn982/d9uUN7NKipjnZyTsGz0HBJ6OcJjfWaa6OtVmMSL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw6i22Q8V0iDYs5AkSCk2uIjCBoe/88SYmOlc6Uvcew=;
 b=k5KDp5WuJS5Boz8HBbRtFWnC/skXjExQODjB3Cz6jvcfOLS9HyWOYGtqL7oYJZLoB7rHCuAVvhXthaNTN5MpdS0c/sMitF1TlwGjRIWa5rdu6qKhW/oC91D5IuCHs+ZB/EPoUeAcAbvWqpY4Vjf3I4hKP313rUysb1C7nV/Oblk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 28 May
 2020 06:03:07 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::25ab:aac8:ecf3:59a0]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::25ab:aac8:ecf3:59a0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 06:03:07 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, yuhsuan@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [v2] ASoC: AMD: Use mixer control to switch between DMICs
Date:   Thu, 28 May 2020 11:32:30 +0530
Message-Id: <20200528060242.24945-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::31) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G4.dlink.router (122.171.58.15) by MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 06:03:03 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.58.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a576430-a470-4003-ca3d-08d802ccca7f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13900940AEC14665F745D7A4F88E0@MWHPR12MB1390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/ldLfle+NjgsSLAgvMKid8NxGe5ZsmErPLRkHs+GqxFmHvyK4w6NafJNdYl0LdtJvRBbC9StGYiZtjhmnDfVho5Tg5fyzB2tLKXm/Bvcdc1j9kW2hDCj7rAJX3A5NOi5hj13JbR8e4tDXZZjGonY5NfW7chle/+qr4iot3EEESmOnrvUCmpvH1HBDb662WOoEDy1Wih7WdC1HpWPYudxhCGVi9B/4tYSNQJhhpjLZgakEUx1Cn1VJ/z81v85cXCLQzrSrZmO+Q8L4U2jNwRROLavyYpNMMRYXan7ZhvFuYAFT1GpAr8hokPv6DsZbSG6Df76k+Z1qAqGnGV9HxUYpkjwVbjU3axy2agsy9bD4jJ3rzmHsy9YOpQGygAWpo5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(478600001)(6512007)(8936002)(6486002)(8676002)(2906002)(4326008)(83380400001)(36756003)(316002)(54906003)(5660300002)(52116002)(109986005)(26005)(1076003)(6666004)(44832011)(66946007)(956004)(66556008)(16526019)(6506007)(66476007)(2616005)(86362001)(186003)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hw+CaaPZW3hDOGCHkJzVsATUBqFaI30A8PMAlWQNk1FUMrHgVTDoSbncHofov4/E2WJJNuIRWXk0GiNn6s2B8tEbBLRalImnjyMAkUW9W11S/nlG3YwxE2dsbAH/meSsZigHbY75ZndTxBaWvNzrGNvDMCKJE3rcnUjiSU5eKBIKXxPy79QLxEXtpIReOc0k3l6jtbgjBNqgqVRGkoE8jC/KGAlZc1fv3A0y2gn9VkqvH4J+FuB5eb3tuVynqU7NulFiuabXSBZjpPQkGWyPDeV4696QNTQkVO0/Ilt+mrMHw08+qmtAK5KhBlx8Lp7+JiVvfCBUd5RbviopQ6M25S8mVOFuW7Eoz7+QvfohPl+rHdSbjZb/tSMA3pYknPHEtXzFnAv3ISdZZrcMdiw3ZJ4cdMNsM0NCKdLHrijC5Rwdpe0vLDA7jQSyt3KEtvxAzeKAStxlX35J2LcMa8OyUgVAtGYqChmx7Dim6fgB4xI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a576430-a470-4003-ca3d-08d802ccca7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 06:03:07.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LedesQiPG7fTbxNe7CL1DURujmaQOFYErjahkj7f9Yj0eC4DLqybT6aZWFURGik6u2deDrXoWqvwICO7TNP1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having mixer control to switch between DMICs prevents user to
initiate capture simultaneously on both the DMIcs.
Earlier 2 separate devices, one for each DMIC, gave an option of
using them simultaneously, which is not supported.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Modified "Front Mic" to "DMIC Switch"
 sound/soc/amd/acp3x-rt5682-max9836.c | 43 +++++++++++-----------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index e499c00e0c66..0d3422b5f1a9 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -188,25 +188,27 @@ static int acp3x_ec_dmic0_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
 	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
-	if (dmic_sel)
-		gpiod_set_value(dmic_sel, 0);
 
 	return rt5682_clk_enable(substream);
 }
 
-static int acp3x_ec_dmic1_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	struct acp3x_platform_info *machine = snd_soc_card_get_drvdata(card);
+static int dmic_switch;
 
-	machine->cap_i2s_instance = I2S_BT_INSTANCE;
-	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
-	if (dmic_sel)
-		gpiod_set_value(dmic_sel, 1);
+static int dmic_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = dmic_switch;
+	return 0;
+}
 
-	return rt5682_clk_enable(substream);
+static int dmic_set(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	if (dmic_sel) {
+		dmic_switch = ucontrol->value.integer.value[0];
+		gpiod_set_value(dmic_sel, !dmic_switch);
+	}
+	return 0;
 }
 
 static void rt5682_shutdown(struct snd_pcm_substream *substream)
@@ -229,11 +231,6 @@ static const struct snd_soc_ops acp3x_ec_cap0_ops = {
 	.shutdown = rt5682_shutdown,
 };
 
-static const struct snd_soc_ops acp3x_ec_cap1_ops = {
-	.startup = acp3x_ec_dmic1_startup,
-	.shutdown = rt5682_shutdown,
-};
-
 SND_SOC_DAILINK_DEF(acp3x_i2s,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp3x_i2s_playcap.0")));
 SND_SOC_DAILINK_DEF(acp3x_bt,
@@ -279,15 +276,6 @@ static struct snd_soc_dai_link acp3x_dai_5682_98357[] = {
 		.ops = &acp3x_ec_cap0_ops,
 		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
 	},
-	{
-		.name = "acp3x-ec-dmic1-capture",
-		.stream_name = "Capture DMIC1",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				| SND_SOC_DAIFMT_CBS_CFS,
-		.dpcm_capture = 1,
-		.ops = &acp3x_ec_cap1_ops,
-		SND_SOC_DAILINK_REG(acp3x_bt, cros_ec, platform),
-	},
 };
 
 static const struct snd_soc_dapm_widget acp3x_widgets[] = {
@@ -307,6 +295,7 @@ static const struct snd_kcontrol_new acp3x_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Spk"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_SINGLE_BOOL_EXT("DMIC Switch", 0, dmic_get, dmic_set),
 };
 
 static struct snd_soc_card acp3x_card = {
-- 
2.20.1

