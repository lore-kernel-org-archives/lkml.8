Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1372DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28B9207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FTX6IFuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgE0BlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:41:04 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:44353
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgE0BlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:41:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/XRNPGakuZvAFtDMLQAtP989RB8RljHUs5Cy3w+fQi835Y1yFfDY3CgBwPwRNbe7iMrIfHdUmaAoPqGZ4kfOM6vIVQ5WFzes+oF1j5H2IuJ8Rw4qL0YeXhoD0wqPT4WcUKQx3BkO4vTsmitJw6TNhBOsgdxt7WQBRKZSwKr2067bSG4PUQ8Ear/MjxZ8w9A4jP1ARbV+OgvytqWlpYdC+B95d5ZAj8aUTorcmAh9+KnbzEGX7Ao4MFm3yErcVpDDXCTPDOlhCbRxKuVr9xFAEc4Wh49QIHhL/9k90wgybZNxBJAjlnD9cYgJ9eotfHHCzvUHL+rWImB5hXwiAMu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnKRLyg1xhUuoBvUr7eu4tr4+uX0uKFemvAM9oMeQ4M=;
 b=gomUReAuhc9f1TpYzvzV9U1gRO+2sZy3u78z38EZvP4aQnYjFNlR6R9y0bepvX9/gfDGCqeov0iEGdYd+HgX7mKyR4UnnzAq0ycbMdIuAXw0RS4KaHDwJHNQXTIFzNyjVQ1rWI60bqWi2YYwYzbLlxi3gvpYryZyZNBXkzh+5FfTCfkSuRq5k09GFAxSAOgdvuCxKmIhoSZQttNFxWtvRywcmif3CynlQAwSh5f+FEZykJ/8IzhxzBc6IQ+H0NQQ38Ifjr4D101F1BAsby2rJV2OToC5LgaMwEDMSk/NdhAJmf6RcSm22VVe3NCcVWqIrSs/SxLSU9OZrR8CFGsnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnKRLyg1xhUuoBvUr7eu4tr4+uX0uKFemvAM9oMeQ4M=;
 b=FTX6IFuXdsZNazyP6QVb+uBfIT8Kq7zAXUn72VQk0ItJqjMSsPpDCOAfXpnIZZThchjo4iwqLdj6GYvw26iXYYqGez/crQ38OG1N6MQLi5DkD01VL1ZsaPe64TFiCAG8nrS+G4eSS5ORnfrKm6tan1C0FyX5sxQX3QV16HjWVYk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1849.namprd12.prod.outlook.com (2603:10b6:3:107::23)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 01:41:00 +0000
Received: from DM5PR12MB1849.namprd12.prod.outlook.com
 ([fe80::7d3e:85b9:e3cb:40a7]) by DM5PR12MB1849.namprd12.prod.outlook.com
 ([fe80::7d3e:85b9:e3cb:40a7%9]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 01:41:00 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, yuhsuan@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Use mixer control to switch between DMICs
Date:   Wed, 27 May 2020 07:10:16 +0530
Message-Id: <20200527014023.2781-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::16) To DM5PR12MB1849.namprd12.prod.outlook.com
 (2603:10b6:3:107::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G4.dlink.router (122.171.58.15) by MA1PR01CA0122.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 01:40:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.58.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1ce28d9-d455-4c33-dff9-08d801df01f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487E4722DFD45F888AAEF69F8B10@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj/5Ig80nmprOpqa9PRyR8C1ZxA7PWvGiUIRKe9VBQL3AniuAhz4LZpSK2WMEdBHVB73ZO/+CmiCeudMwEVDEdtlkI7fwgwu1oLF6dqjG3sEcDUMhTjbbk1lQCyIrWKxl3rE0aLOqkaHPSOq6goCEJQH9TXLT2yUvNaOFHyPbm0QARvjeZw4/a43pddS7g6L8jO41mt20NSjgllfLmqRo+KXsh8CmhpzRgn3hBoXLzNQnM5pbh8WsT4HNPKgQ/xPiTqzA9WIwYGf6MfxGcTJfKKdXYd1X5wAzq1joUKK2cMMlc2PF2wfK4ZJD17XDPc9cmvNYs4IzHTMXGnyAzU12s0j3cf4zdHZzoIjafoW4vH9Ju5hj3Lw2o1eRlpamldO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(8676002)(186003)(6512007)(4326008)(1076003)(8936002)(83380400001)(316002)(6666004)(36756003)(54906003)(6486002)(2906002)(478600001)(956004)(66556008)(26005)(5660300002)(44832011)(16526019)(2616005)(66476007)(66946007)(52116002)(109986005)(86362001)(6506007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RyZOqEZIRBIkI8nAQut5NaXGaxc+vIzZoyF5YHYoEeYdKMjJEldl+sAtCbyfrTVgjyz1/ikK6JgommKyiWWPMcRzpkKpPX2qu12dWzzVP6c2zMJb2xgYSOk2a9Ag6Oq++rQ9LPEbHUQE2aC3Ldk6hkph+Hr6YSmSkOskD3XcAvJK4y3gC+KggfNLP80TIqlmE+gYPgnCn7KO96I3m1dXZKfPKVDmO/Y/FvGlmhWkT5Hwg/6iDCa358uDQRDmabE1lS0ZvLl8bgyjOVUUaYLn5Zg59OzbpDbWMQehO6katflHVY9MWoOTadx664qGJ3i10jg1WzEq0bBHugmtdQ5yqZcIV5Gu4vE3udB5BNl0G5uF6JEc1bIkyoXjvVJQ4kH/Q07QA/+AJj//RFHq4GrIOce9QZU/GE/Up+wD5nvZEFjcD/hm+zy1Z3mUy51DQqBcF/Z8Quj253T7v5T9cKRkz0CmHV5F4oUhEtXojUcAaj8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ce28d9-d455-4c33-dff9-08d801df01f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 01:40:59.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMjDibMwlwAUA+4f99gy3r8wTSQEhbVk0PpjufyEXKCvGV80kEPqoDqkyUlO0klCPm7vHVFGEGHrRILU2cnfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
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
 sound/soc/amd/acp3x-rt5682-max9836.c | 43 +++++++++++-----------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index e499c00e0c66..19f55a814547 100644
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
+static int front_mic_enabled;
 
-	machine->cap_i2s_instance = I2S_BT_INSTANCE;
-	snd_soc_dai_set_bclk_ratio(codec_dai, 64);
-	if (dmic_sel)
-		gpiod_set_value(dmic_sel, 1);
+static int front_mic_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = front_mic_enabled;
+	return 0;
+}
 
-	return rt5682_clk_enable(substream);
+static int front_mic_set(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	if (dmic_sel) {
+		front_mic_enabled = ucontrol->value.integer.value[0];
+		gpiod_set_value(dmic_sel, !front_mic_enabled);
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
+	SOC_SINGLE_BOOL_EXT("Front Mic", 0, front_mic_get, front_mic_set),
 };
 
 static struct snd_soc_card acp3x_card = {
-- 
2.20.1

