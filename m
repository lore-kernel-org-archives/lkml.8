Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735ABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABAD2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IhFtprQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgG1QHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:07:31 -0400
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:23393
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731214AbgG1QH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:07:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAoj85SkXzl3UCLX8B7sK5tF3XDTZUiXhzQzs47PotBeXnGlecmVEdM39UlAkzWEvAHWZkukeBC8XsfwgIaOfTRsjgWGEqWXqvxQWBVMhgcZzsiekGs5Z7a/Gm4Rgj3WLtnKOx7g+8Priw7ixpNgao8mZflqT6bo+TPn+nxu1hUoZMo3im3b+awr05H3TMZlFI3XH1pHH6Ka98KEp5JYb2IFG8+Yf2gQPhnROzgou+ja3GjUfKUSTujPDaA+e1+XwaU9LoQnzpaQf6rsFJyUDhaAT/Vnj2VR+tkTEkij5/F6y63qC/vr07Yzh+k+DcnkGOqd3rVoRYX+Awx9+CT6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEkczVNO0HrT0CFuTOKrW+xHvnxLTwPjo3atDKYT87o=;
 b=aQ/8+1KxXA35msC6GSmI2IAdt28z0ofAu3y+KrBZgx6NSbpBiKQi9h/2zi2KyE9ywWdgdH8bmteHDasvoIm69Duh+VEP02Ry1fTscjpDWNHiYlbwc9OCDEcagY0HpW6uZM1GQs/IA4G06cWhE8f/bF2cUoDpIPFV4KIXfvZq8ALNJhSwuEBcIODU7WawNCxvvEU7IvjQZp2XZwOmSFnfFunUN/qQ+rLJylwQ+97XYpqSGMWoy3YEiQd4OCNBtvsZNbN7w3GUQmFtvBX3D/cbKlLxhB/ZYGBIHQpNehygEsTUXN/yVqhhWsbsEDedd94ecPFLTF0iGgHrQkZFyUXiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEkczVNO0HrT0CFuTOKrW+xHvnxLTwPjo3atDKYT87o=;
 b=IhFtprQg6aEpH/suv21LIy/5H7vaRrhD3KWmlJHv5x0z8EHe+iye0mWdLBZrDXrA77F62CVybMGRCLoEL258pf6Nf2yVF8+8VCKrAAHHTAg7ztLa7O4jWLw0rsv45fqLtEQxplU0Hv5qlXPuZKnXFgf74KV5dvo5k0i6W+ZUCn8=
Received: from CO2PR18CA0064.namprd18.prod.outlook.com (2603:10b6:104:2::32)
 by BN8PR12MB3201.namprd12.prod.outlook.com (2603:10b6:408:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Tue, 28 Jul
 2020 16:07:09 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::63) by CO2PR18CA0064.outlook.office365.com
 (2603:10b6:104:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend
 Transport; Tue, 28 Jul 2020 16:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 16:07:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:43 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:42 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 11:06:38 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] ASoC: amd: Adding support for ALC1015 codec in machine driver
Date:   Tue, 28 Jul 2020 21:32:53 +0530
Message-ID: <20200728160255.31020-4-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbeeff1e-a729-4732-45cd-08d833104782
X-MS-TrafficTypeDiagnostic: BN8PR12MB3201:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3201BF00C79603652C25FF5CE7730@BN8PR12MB3201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed9T6JJiLlKG9v7tP57dIgqOLR3l3SeDPJW6zgccuKmYHC7gjPunN2QmIXjBfzULmRMfznNHux2UilMZTDWWjAI1xltXcLO+fE6YONQ7xQY+KbvZWJl2qoyCSsbtOonpS7fsI+M/Z7pZfT4rIannArDVEkR2OoLzYhGtqQwhc6oYR9TMUjzwN+yvtSashk/9jKA31mHGCtRGo1s6JTTNh1l05p8c/nzfMHHmZnrBAOjs0lgrgOF0NYV5xxPkUnZRBo9ggBiT2FN3GHAPXNVFoFZnVo9EdctzARggAxPhncpdiuixN7E6OeQE6nQuEuMelby87o4R4dvt0FeyFiPS3VKUlNm2KMrwoP6hERLu0neHtHxqom6spqyUgRy8SJnnXrgx1FS7WmT/F+YyhkLlhR4ry11S1fA/oKzOn4rZPO4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(5660300002)(4326008)(26005)(316002)(70206006)(186003)(70586007)(8936002)(54906003)(7416002)(8676002)(478600001)(7696005)(36756003)(47076004)(82740400003)(356005)(81166007)(83380400001)(426003)(336012)(6666004)(109986005)(2616005)(86362001)(1076003)(2906002)(82310400002)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 16:07:08.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeeff1e-a729-4732-45cd-08d833104782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3201
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for ALC1015 RTK codec in machine driver.
Passing specific card structure based on its ACPI ID.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/Kconfig                |  1 +
 sound/soc/amd/acp3x-rt5682-max9836.c | 63 ++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index e37cf72f2bab..a6ce000fac3f 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -33,6 +33,7 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
+	select SND_SOC_RT1015
 	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
 	help
 	 This option enables machine driver for RT5682 and MAX9835.
diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 2c672657d139..015b6a3312f5 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -21,6 +21,7 @@
 
 #include "raven/acp3x.h"
 #include "../codecs/rt5682.h"
+#include "../codecs/rt1015.h"
 
 #define PCO_PLAT_CLK 48000000
 #define RT5682_PLL_FREQ (48000 * 512)
@@ -247,7 +248,18 @@ SND_SOC_DAILINK_DEF(cros_ec,
 SND_SOC_DAILINK_DEF(platform,
 	DAILINK_COMP_ARRAY(COMP_PLATFORM("acp3x_rv_i2s_dma.0")));
 
-static struct snd_soc_dai_link acp3x_dai_5682_98357[] = {
+static struct snd_soc_codec_conf rt1015_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF("i2c-10EC1015:00"),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("i2c-10EC1015:01"),
+		.name_prefix = "Right",
+	},
+};
+
+static struct snd_soc_dai_link acp3x_dai[] = {
 	{
 		.name = "acp3x-5682-play",
 		.stream_name = "Playback",
@@ -317,8 +329,8 @@ static const struct snd_kcontrol_new acp3x_5682_mc_controls[] = {
 static struct snd_soc_card acp3x_5682 = {
 	.name = "acp3xalc5682m98357",
 	.owner = THIS_MODULE,
-	.dai_link = acp3x_dai_5682_98357,
-	.num_links = ARRAY_SIZE(acp3x_dai_5682_98357),
+	.dai_link = acp3x_dai,
+	.num_links = ARRAY_SIZE(acp3x_dai),
 	.dapm_widgets = acp3x_5682_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(acp3x_5682_widgets),
 	.dapm_routes = acp3x_5682_audio_route,
@@ -327,6 +339,47 @@ static struct snd_soc_card acp3x_5682 = {
 	.num_controls = ARRAY_SIZE(acp3x_5682_mc_controls),
 };
 
+static const struct snd_soc_dapm_widget acp3x_1015_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MUX("Dmic Mux", SND_SOC_NOPM, 0, 0,
+			 &acp3x_dmic_mux_control),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route acp3x_1015_route[] = {
+	{"Headphone Jack", NULL, "HPOL"},
+	{"Headphone Jack", NULL, "HPOR"},
+	{"IN1P", NULL, "Headset Mic"},
+	{"Dmic Mux", "Front Mic", "DMIC"},
+	{"Dmic Mux", "Rear Mic", "DMIC"},
+	{"Left Spk", NULL, "Left SPO"},
+	{"Right Spk", NULL, "Right SPO"},
+};
+
+static const struct snd_kcontrol_new acp3x_mc_1015_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
+static struct snd_soc_card acp3x_1015 = {
+	.name = "acp3xalc56821015",
+	.owner = THIS_MODULE,
+	.dai_link = acp3x_dai,
+	.num_links = ARRAY_SIZE(acp3x_dai),
+	.dapm_widgets = acp3x_1015_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp3x_1015_widgets),
+	.dapm_routes = acp3x_1015_route,
+	.num_dapm_routes = ARRAY_SIZE(acp3x_1015_route),
+	.codec_conf = rt1015_conf,
+	.num_configs = ARRAY_SIZE(rt1015_conf),
+	.controls = acp3x_mc_1015_controls,
+	.num_controls = ARRAY_SIZE(acp3x_mc_1015_controls),
+};
+
 void *soc_is_rltk_max(struct device *dev)
 {
 	const struct acpi_device_id *match;
@@ -375,6 +428,7 @@ static int acp3x_probe(struct platform_device *pdev)
 
 static const struct acpi_device_id acp3x_audio_acpi_match[] = {
 	{ "AMDI5682", (unsigned long)&acp3x_5682},
+	{ "AMDI1015", (unsigned long)&acp3x_1015},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
@@ -391,5 +445,6 @@ static struct platform_driver acp3x_audio = {
 module_platform_driver(acp3x_audio);
 
 MODULE_AUTHOR("akshu.agrawal@amd.com");
-MODULE_DESCRIPTION("ALC5682 & MAX98357 audio support");
+MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
+MODULE_DESCRIPTION("ALC5682 ALC1015 & MAX98357 audio support");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

