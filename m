Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB86C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FCD2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B3mG/0jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgG1QGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:06:55 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:46816
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730821AbgG1QGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:06:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbgFZUn2kkJt2hokIxtDfbE/x42G9EbY4GL6H4uILJiWwq2bqhnkkRzBhBVwaCZp08t6VLmkUVtbY1mt9ezeg3Tdk5l5egnrwDmiQlp/vBmViI6aU8hSp6iXwEJnv5AM9uuijn/18Zhhox6A8UZVKxNSbYFW+O90mcHPrU1V6/CP8TyymL6DoUgioYuSBskhIgaIfi1+/s1NbRE4lnYLensYaomUehmdFF6hCzefPa0NQv9SLhxbsJ/fTyIkT9g1Fy6OyzY5oQEkKbYD3kZDj8176V7/1th9RisoBmVumh+rYhIqiGVJ2WWuDiI5nxsvnRVH5gVAsQbEHdlKeA/siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCB1Vrsx+8WOuq91iNN5qiwdDikZp2WxyhLIUAVJ2Bs=;
 b=Y8gRcOo1QrC6wO5oo8mCBbzYzcBQVgCRPoqTtbSdN3eUEwOyHycr5+DTEgPgnISsjyspbri83TmLDlRZ8FWt4gUcjgD/Ph89pSPM14+RZZn7ozowXAz5+Aj6qVjYIVo7dZxa6/s82MAlLEHuaJlRNO7cO5n3y1Ht99KWgbhfiHF3ol0EuyiVK7iki3KthSYSe1K9rYZiEzUyqGd6sCKZdgxtPemb9DIjoD47xWnxGc3aKi+zYfjkYtc3fXueEuZCrLPpYKDeSh88sxb+dTd5z8dDBHWPnRtoTq4bsufV5gAcgDc97x4Yw3Nib/VKRW1ZhfkoAJzK5wG0aACopzzqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCB1Vrsx+8WOuq91iNN5qiwdDikZp2WxyhLIUAVJ2Bs=;
 b=B3mG/0jbROq1jfM7S+DRl6CE3DC036mDogAXEm93HkmBBNHporjnPbBrKFUmpF2AQtQhf4eTlcjl8XV94SfFVM1hzLNPoqTn2erMjMLDfFBzqgQL3Y8hqpXNvhBcy/cF8eoTj1EExLpM6Rvy3lGP4njCBf4KM16CaPXpObHLs50=
Received: from BN6PR04CA0101.namprd04.prod.outlook.com (2603:10b6:404:c9::27)
 by MN2PR12MB3005.namprd12.prod.outlook.com (2603:10b6:208:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 16:06:51 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::7c) by BN6PR04CA0101.outlook.office365.com
 (2603:10b6:404:c9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 16:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 16:06:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:50 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:49 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 11:06:46 -0500
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
Subject: [PATCH v2 4/5] ASoC: amd: Adding DAI LINK for rt1015 codec
Date:   Tue, 28 Jul 2020 21:32:54 +0530
Message-ID: <20200728160255.31020-5-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90de723-b87d-477d-ed45-08d833103d8c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3005:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3005B8C61381E85F8930580EE7730@MN2PR12MB3005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nl4p0J/TdIQKwhJioUgSqRBHiDNcsXKutt8BoUc4c+mUrj/qHdYMrgDdlxImaPgULXMZlbL8m7HaZ67NKXX+rrbsSoPtMDxblOvbmJmetuXzrskwWbGgiMNoxwcRpIbjWSSCyKeR/Li7m5yjcg5nUbfbGIsdi5DJBFK9AHCvYBf0jC1uJsOoCnEk4Po4oBtv62xXJ2VxT9Nx+y+VEDxKpvZ83wOYX5do4UY6tHvJevnfngMYzFa1qXprE6+pKmIV4QwNmZ1fGdw9ieq5E7LorVLirqZtWMMCIovgdZQcc6f/88lxfo8JDHi9cqQ4SUg36Dn4wkrAryU7cmygsb9amGaV7otY1Xx0qw0ZQ+nkVg0o7hSJPxw9dJ+w+ZCnrdvtfzVihQplzuIfi/gedj4wo/g+QxXrU2Ebky9C38+9bLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(82310400002)(86362001)(83380400001)(82740400003)(47076004)(336012)(2616005)(5660300002)(81166007)(426003)(356005)(70206006)(36756003)(70586007)(1076003)(109986005)(54906003)(4326008)(8936002)(478600001)(8676002)(186003)(6666004)(26005)(7696005)(316002)(2906002)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 16:06:51.7614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90de723-b87d-477d-ed45-08d833103d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAI link support for RTK 1015 and providing the codec details
depending on the snd_soc_card selected by ACPI ID.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 35 ++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 015b6a3312f5..e0c767716b9a 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -33,6 +33,12 @@ static struct clk *rt5682_dai_bclk;
 static struct gpio_desc *dmic_sel;
 void *soc_is_rltk_max(struct device *dev);
 
+enum {
+	RT5682 = 0,
+	MAX,
+	EC,
+};
+
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
@@ -242,6 +248,9 @@ SND_SOC_DAILINK_DEF(rt5682,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00", "rt5682-aif1")));
 SND_SOC_DAILINK_DEF(max,
 	DAILINK_COMP_ARRAY(COMP_CODEC("MX98357A:00", "HiFi")));
+SND_SOC_DAILINK_DEF(rt1015,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1015:00", "rt1015-aif"),
+			COMP_CODEC("i2c-10EC1015:01", "rt1015-aif")));
 SND_SOC_DAILINK_DEF(cros_ec,
 	DAILINK_COMP_ARRAY(COMP_CODEC("GOOG0013:00", "EC Codec I2S RX")));
 
@@ -260,7 +269,7 @@ static struct snd_soc_codec_conf rt1015_conf[] = {
 };
 
 static struct snd_soc_dai_link acp3x_dai[] = {
-	{
+	[RT5682] = {
 		.name = "acp3x-5682-play",
 		.stream_name = "Playback",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -271,16 +280,19 @@ static struct snd_soc_dai_link acp3x_dai[] = {
 		.ops = &acp3x_5682_ops,
 		SND_SOC_DAILINK_REG(acp3x_i2s, rt5682, platform),
 	},
-	{
+	[MAX] = {
 		.name = "acp3x-max98357-play",
 		.stream_name = "HiFi Playback",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				| SND_SOC_DAIFMT_CBM_CFM,
+				| SND_SOC_DAIFMT_CBS_CFS,
 		.dpcm_playback = 1,
 		.ops = &acp3x_max_play_ops,
-		SND_SOC_DAILINK_REG(acp3x_bt, max, platform),
+		.cpus = acp3x_bt,
+		.num_cpus = ARRAY_SIZE(acp3x_bt),
+		.platforms = platform,
+		.num_platforms = ARRAY_SIZE(platform),
 	},
-	{
+	[EC] = {
 		.name = "acp3x-ec-dmic0-capture",
 		.stream_name = "Capture DMIC0",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -390,6 +402,18 @@ void *soc_is_rltk_max(struct device *dev)
 	return (void *)match->driver_data;
 }
 
+static void card_spk_dai_link_present(struct snd_soc_dai_link *links,
+						const char *card_name)
+{
+	if (!strcmp(card_name, "acp3xalc56821015")) {
+		links[1].codecs = rt1015;
+		links[1].num_codecs = ARRAY_SIZE(rt1015);
+	} else {
+		links[1].codecs = max;
+		links[1].num_codecs = ARRAY_SIZE(max);
+	}
+}
+
 static int acp3x_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -405,6 +429,7 @@ static int acp3x_probe(struct platform_device *pdev)
 	if (!machine)
 		return -ENOMEM;
 
+	card_spk_dai_link_present(card->dai_link, card->name);
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
-- 
2.17.1

