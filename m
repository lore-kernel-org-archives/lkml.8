Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583712087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yjfJizql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgAUKpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:45:46 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:16768
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729384AbgAUKpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:45:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKEW2BLo3FqupHoGsrViGZ7m5OBazr2+4CotKRXkazitkoDP02fsm+woVyFUOSTX1egtS3zEATqvA5BmSeVxAgOeBH1pwKw45w5d4X87c6aMWBK/iLxh0pE7gP30u5yEIKKqulD8m5JLhBIkt89soBjvWdckflxsqHhC+M2ikQ04zw6X/F0R+9iWhUmAZ2Z5qfYEqPlpzYhI/deH8rsTfADCCtbo945J0AWze+3Fv+O493JhSyKxltfNZomq/q72ncwRRBc3b5B0lGSJPlKzPTr2MV35RpBHAtaaxRzNO/Reyi/9Tg9rremxXmvbpCPBRY5f0it6AIg6Z//XI4iNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsxLewS2dixLfjG50YVYM/MuaQAk7d0HQnNIliQqXg0=;
 b=iIwIUBYvbNAv9WivVP2DgcHIpHKwLuMmD5hPNx5POBPPRP/rjbe28TIsANU1tV/3Vp80zsCYF7qKkkxDs3c8i1MG64WVZKuC0CT+8WKksc9oTevLS4MvkRQsjtYM4FsHONffEN0EYUgxOqDEGdctX7hXgijCeXiprf2RMyCUp5jfRrb4vFSHfcxdH9vbeKth58PmxyhooE25ymPv1G/0OdWyPG7gI9JDuxD5o5/WipbFRLEnp4IZ33GkZkSodDT0sHMwbKL2loAtEWb1ti4Ee0AwI5sPH+CAW5qp2ayK49HEv1dlWtSQyPKdB2AqM0zzPVnN2liVgDuKyNQx8mr5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsxLewS2dixLfjG50YVYM/MuaQAk7d0HQnNIliQqXg0=;
 b=yjfJizqlLk9240sV8PAoTN6hZgdGXRntScmVkdDfeBRPGL9am5FNw4aaE77enASqk1utPbeAi10D/LrS9VzDrWFQKJ4IBtJCP8Tr/w8bSWM3FoLupIKqUYNHXKwGfOmbTWqtuCxG0Ig1whC0K4ejzY9sk4gWaNsQR+60Be6+PZA=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by MN2PR12MB3277.namprd12.prod.outlook.com
 (2603:10b6:208:103::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Tue, 21 Jan
 2020 10:45:40 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::206) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 10:45:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 10:45:39 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jan
 2020 04:45:37 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 21 Jan 2020 04:45:33 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Fix for Subsequent Playback issue.
Date:   Tue, 21 Jan 2020 16:13:35 +0530
Message-ID: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(428003)(199004)(189003)(426003)(26005)(316002)(54906003)(2906002)(86362001)(7696005)(8936002)(81156014)(81166006)(36756003)(186003)(8676002)(5660300002)(70586007)(70206006)(2616005)(4326008)(109986005)(478600001)(336012)(356004)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3277;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe5831a-755b-46b9-457b-08d79e5f0e59
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3277025A325CBC020C7DAB32E70D0@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckclESf3GrC4g5SiRonl4XQl90JDNW5BqPh6w3YsHLizPkgTuV8ih3o7YVDiJ+Bri0mqAAJuQWyeqMgGmaicrq/uFJ/h31QD1HKGm9ayYPN9m45+vgrR8STyTUVcat2Dvo9HFHznt6qTRkWocdYx3iafqI5GmbbGMPTPRNw2EtaYYdsnHhZoqtpCNvP7DC1qCSBbVonvpL3o+JkSWpL7B+2Nvm5WaI5SAVVuB59nWOrrsLuB2It4qx6xGbSVNIoZfkcXI8RouBEa/RjFer2R25SVZeDWrblvK1lmHCxO10vGQ99xWg5Lo9AO+Yno6Rl4fwCLj3jdJO4s5clFem3on3HKDfDz43Dli3Pg93DYqRfBsIsEe1KW+HvIyItmBZtWWidZ366I7SHPF6flcjJWWam6fK0ZAuZtLP6XV+YWDB2uzRWN/UaBCyGqmJMXaoQVFwAx2dzS1rC3ZA9GyvzBRGnkWduNqCTfa38L06xjkb8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:45:39.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe5831a-755b-46b9-457b-08d79e5f0e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we play audio back to back, which kills one playback
and immediately start another, we can hear clicks.
This patch fixes the issue.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 5c3ec3c..916649a 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -344,25 +344,28 @@ static int acp3x_dma_close(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *prtd;
 	struct i2s_dev_data *adata;
+	struct i2s_stream_instance *rtd;
 
 	prtd = substream->private_data;
 	component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
 	adata = dev_get_drvdata(component->dev);
+	rtd = substream->runtime->private_data;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_stream = NULL;
-		adata->i2ssp_play_stream = NULL;
-	} else {
-		adata->capture_stream = NULL;
-		adata->i2ssp_capture_stream = NULL;
-	}
 
 	/* Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
+	kfree(rtd);
 	if (!adata->play_stream && !adata->capture_stream &&
 		!adata->i2ssp_play_stream && !adata->i2ssp_capture_stream)
 		rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		adata->play_stream = NULL;
+		adata->i2ssp_play_stream = NULL;
+	} else {
+		adata->capture_stream = NULL;
+		adata->i2ssp_capture_stream = NULL;
+	}
 	return 0;
 }
 
-- 
2.7.4

