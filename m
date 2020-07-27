Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A0A206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yPbZWMuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgG0PB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:01:59 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:57569
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbgG0PB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETXPaEYKN6t9MF/O+HEWtfOGWCOFBvH+oCBsF/vPHYV89X99kdb1DL3WfYZP3zuDb8WiJvEnmOwsQII0qu9k9Ehvqrsbepn3NLkzgvlalEq6jhLd1AMyEb87UQr5mbgIE1Z7ZZ23U3Awm8j2EMogaiGmW5ywB4BNScbFyDVeIQ+1/XoRDjpJ/M0r3KNlg1w5VkcYcMh1SbHyyC1QpVpr5/N9daB8SCWbpwQEuRPL5OMXzK4a+hS+Bj8PsYVLM4Wl4HlFDBo6anMjB/ND3xdy62aJeMWvQ36Hg9X2b4w3ObjaEkl0p8CLA+Iu3RS7T+ek0u0wfVxIq+QoCQjKvNs9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZwsNUL5Rb+nSi3eiyrnNr7PnidSuPdIOwi32PL+Qjg=;
 b=QkpJHIZDgNz1DnpZAyrLbcZrqYloDI97yn+aeI78kwRu4R9fqGwSgsB2at4i+vCaLj9mSUgmvWqZvSCP9F8BgAlrsa1mci1sYgyUMFxfEGHjaO+dvpKIg/89Eo8NGVxc6HD4E4k9pHR9/t9NzhS3lfcd398Bw7L2YmHxZujKCpGACNMV0B0/NwWZK++rbebA6mkgLd8FkXtICuyqnyWoLySXi+vr+q354J4OXVr0Lek1S8gJtvziguA04dcTBWl7Dfvzgsffbmlg6S8O7sJ2ttClS0Yr9CkbJ4ls1VgnPQ/JC5sXgwyCZ7tCped+1/73e/5wirWl7xa5kgzFlCIE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZwsNUL5Rb+nSi3eiyrnNr7PnidSuPdIOwi32PL+Qjg=;
 b=yPbZWMuzSNOv9804qgZhbku58YBu+gC1MrwuQL3PBVIeEsPzpnlkZXPMTKHjHfk1rd6/4KPbnGs08EV8bNrstvO2Tq0RBL/Zrbue5n6OnqFbBWjH6UbNgskbKcm/kBJrw55uCr+qbpqscyDRcboUKXuRqXFiGRpAzX5zcWJoivc=
Received: from BN6PR14CA0025.namprd14.prod.outlook.com (2603:10b6:404:13f::11)
 by BN8PR12MB3074.namprd12.prod.outlook.com (2603:10b6:408:65::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 15:01:55 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::31) by BN6PR14CA0025.outlook.office365.com
 (2603:10b6:404:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 15:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 15:01:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:01:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:01:54 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 10:01:50 -0500
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
Subject: [PATCH 2/6] ASoC: amd: Passing card structure based on codec
Date:   Mon, 27 Jul 2020 20:28:27 +0530
Message-ID: <20200727145840.25142-2-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b97e88-4de1-4b0b-97f8-08d8323e0083
X-MS-TrafficTypeDiagnostic: BN8PR12MB3074:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3074516C13D61CA6DBC50CB9E7720@BN8PR12MB3074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3XUFxjw/D0yWLXPORYCy7S+/00b89jwKm3NsFcSXdtJXv5PM0sXfptri3gt8O+GmaJtXpPqSseAbrxY0PQcYSPsz5lambcjAAWy0tyfPVUABs5vwoCBxlCooQd7ebHZ7VxmQhaX7cO0RD1vcOnbO2k4ohNoRKXsF0HBU+reRAZxzzfJD5eW/UlBYQpgdsR//zWSzIvqjWaU9c8haN7nkKf5KvaJH9+5Rfp5DSjq3/Zn9RSoidJ+igfJ9eShpQlUgJVzdeC8hIWPQDjVS8VxrgLcG8r/U8rjeDYT2xHz3uwhcTqRpy922Sg5Pu+mMOu+a5tYgeZB2KFZ8iKN4vJRNHFmhMEE4ha45+UBkhDyNA5rnr6YZjKp9K9MGcjn5JURDG0VeuLcqVu2BVbvWZWxHgDR2NW6OVGtNHXm38TOE+E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(8676002)(4326008)(6666004)(5660300002)(7696005)(109986005)(36756003)(316002)(186003)(2616005)(54906003)(83380400001)(1076003)(70586007)(82310400002)(81166007)(356005)(8936002)(426003)(478600001)(82740400003)(70206006)(86362001)(336012)(2906002)(47076004)(26005)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:01:55.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b97e88-4de1-4b0b-97f8-08d8323e0083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3074
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing specific snd_soc_card structure depending on the ACPI ID.
In future we can add other IDs in the ACPI table and pass the structure.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 8b5af064864f..1e446e4bab25 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -326,18 +326,32 @@ static struct snd_soc_card acp3x_5682 = {
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
 
@@ -348,18 +362,18 @@ static int acp3x_probe(struct platform_device *pdev)
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

