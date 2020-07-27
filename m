Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0505C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11FF20825
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="twrtw3gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgG0PBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:01:52 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:19472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbgG0PBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:01:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ5DrJE+FgebZ42XhzJbHHwzmI+UTINNLns2+vAn01Cz4EgeNJ3iDcLO5JrvKxe8q1Dv99WcqKa1kR0aGAFMM9Jxled6/uSAy7ULoD7mRGlV2Ae5Zo+5+iWdc4Net1dqMy7MC8buMQ5/30/pMdwbRvCdDCBu2Ss5ltcM4zHDk1MWO+YimMDMO3plGYnMS7FCS2dzhBxLJjC9d9xFdd/989+63S4kjcmJ0OhRhXpZkCOD+j3lEIRySqfrdXRAOy7N16cFXu7CtcCUtFyt2ZjyijkSqFF/277VpJXkk7MURWN6NgfaQVUlwGm+7WnkEdSPB96SYtCwE3sAs7sNO26FGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Bq6dBJaEwdEvTToJIyqtBNqxHpOJm5uLebIh7lLYw=;
 b=oUs5uZikQorcmAQLB382lxyknWlsxIAvrve/UgP2+ibG4alPgWPWiAq6D6oy9g67kJURkw2fRdMzkqD1zuRegDBRsMPcCWXHXhAAnlrSpeMGCpdp8tArCSAmK6Gf68NT6uoVDpulsnq55aj5IFCFXBGi6wiYkTxsqjl8in+pa2rD5j9jBbEDMPpeQIR5OMVTyzCreY0IwvJVaP7SMZfFkPd4CTTD092g8Vzz6eYebezmqK+Q+Of2i41b8ci62FLGw1n0jx92OdBsO7CXV7zkUO1H3yCAy5ENollagXDvrg8bnevltTBPA5OQt2vFaV6qtfynGc7VfDdc12scYeJqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Bq6dBJaEwdEvTToJIyqtBNqxHpOJm5uLebIh7lLYw=;
 b=twrtw3gieS1FXaQn6lGpZFr6SdMMcbQlvIa9L5SVo2AJbIRdbfjBzfwcH80bOhL5IgllNttE747939BYFQzZBbpoM/i7Pse1bzGAZGQz925RREt7prWL9F77c/SfhotmjSYZsGyaN1GHg7CcQ6UYbpYq88WiM4kCbybyaayqXzc=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 15:01:48 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::b4) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Mon, 27 Jul 2020 15:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 15:01:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:01:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:01:47 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 10:01:43 -0500
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
Subject: [PATCH 1/6] ASoC: amd: Renaming snd-soc-card structure and fields.
Date:   Mon, 27 Jul 2020 20:28:26 +0530
Message-ID: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a2f07a-d694-413a-e1e7-08d8323dfc71
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-Microsoft-Antispam-PRVS: <DM6PR12MB306657DF0D40E14AD5336AADE7720@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SdzO4hGrdc/6SiQCUgdj/nSJhTe3IIVmNb0fhK5isL/iSNg1gdrm3AdgI3HebgnpswBgvya0X+Zk5+QtDr/6APT78uevDZq3NP41dW/A+WRpBLc7sBZBWx1C5T0UfdNzOzSrw9Vx3Pbg2BxwYQwEo7lH9U6FFoAbpzjqsPhy024AEl3/rD/cx9+7Qm1wcDWwfBrK/sGhRuxsrIgZwgkMkHQf6I49dn8WGC6EG+AO4kLqbdQirLqm3nKDx9kmi4kcwFXVvgZ4YXyrXFtxZD1EpmYbIuXkatQnOgHwcnk5YLg7UCok9hCMjXqKlCMH1SNJrBnt27/5iofZ4Jt9cC/35bjpiAjokY66b8OxZqHJ+Qsn82CW1fd23SF5SK059nWp/GzU/v8y4zMXx2ycnHuKr6AFDJGAL63lGFkQ5gjfrA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(5660300002)(8936002)(478600001)(47076004)(1076003)(109986005)(186003)(6666004)(2616005)(26005)(336012)(8676002)(426003)(81166007)(82740400003)(2906002)(356005)(7696005)(36756003)(70586007)(82310400002)(316002)(86362001)(70206006)(83380400001)(4326008)(54906003)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:01:48.2221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a2f07a-d694-413a-e1e7-08d8323dfc71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in future our machine driver supports multiple codecs
So changing naming convention of snd_soc_card struct and its fields.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 6009e444b858..8b5af064864f 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -290,7 +290,7 @@ static const struct snd_kcontrol_new acp3x_dmic_mux_control =
 	SOC_DAPM_ENUM_EXT("DMIC Select Mux", acp3x_dmic_enum,
 			  dmic_get, dmic_set);
 
-static const struct snd_soc_dapm_widget acp3x_widgets[] = {
+static const struct snd_soc_dapm_widget acp3x_5682_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_SPK("Spk", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -298,7 +298,7 @@ static const struct snd_soc_dapm_widget acp3x_widgets[] = {
 			 &acp3x_dmic_mux_control),
 };
 
-static const struct snd_soc_dapm_route acp3x_audio_route[] = {
+static const struct snd_soc_dapm_route acp3x_5682_audio_route[] = {
 	{"Headphone Jack", NULL, "HPOL"},
 	{"Headphone Jack", NULL, "HPOR"},
 	{"IN1P", NULL, "Headset Mic"},
@@ -307,23 +307,23 @@ static const struct snd_soc_dapm_route acp3x_audio_route[] = {
 	{"Dmic Mux", "Rear Mic", "DMIC"},
 };
 
-static const struct snd_kcontrol_new acp3x_mc_controls[] = {
+static const struct snd_kcontrol_new acp3x_5682_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Spk"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
-static struct snd_soc_card acp3x_card = {
+static struct snd_soc_card acp3x_5682 = {
 	.name = "acp3xalc5682m98357",
 	.owner = THIS_MODULE,
 	.dai_link = acp3x_dai_5682_98357,
 	.num_links = ARRAY_SIZE(acp3x_dai_5682_98357),
-	.dapm_widgets = acp3x_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(acp3x_widgets),
-	.dapm_routes = acp3x_audio_route,
-	.num_dapm_routes = ARRAY_SIZE(acp3x_audio_route),
-	.controls = acp3x_mc_controls,
-	.num_controls = ARRAY_SIZE(acp3x_mc_controls),
+	.dapm_widgets = acp3x_5682_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp3x_5682_widgets),
+	.dapm_routes = acp3x_5682_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(acp3x_5682_audio_route),
+	.controls = acp3x_5682_mc_controls,
+	.num_controls = ARRAY_SIZE(acp3x_5682_mc_controls),
 };
 
 static int acp3x_probe(struct platform_device *pdev)
@@ -336,8 +336,8 @@ static int acp3x_probe(struct platform_device *pdev)
 	if (!machine)
 		return -ENOMEM;
 
-	card = &acp3x_card;
-	acp3x_card.dev = &pdev->dev;
+	card = &acp3x_5682;
+	acp3x_5682.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 
@@ -348,11 +348,11 @@ static int acp3x_probe(struct platform_device *pdev)
 		return PTR_ERR(dmic_sel);
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, &acp3x_card);
+	ret = devm_snd_soc_register_card(&pdev->dev, &acp3x_5682);
 	if (ret) {
 		dev_err(&pdev->dev,
 				"devm_snd_soc_register_card(%s) failed: %d\n",
-				acp3x_card.name, ret);
+				acp3x_5682.name, ret);
 		return ret;
 	}
 	return 0;
-- 
2.17.1

