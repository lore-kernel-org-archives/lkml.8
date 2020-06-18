Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87152212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mEYHPESw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFRHbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:31:17 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:45089
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbgFRHbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbgq8wKz8CQxrR2lhjzA0B/kHmCcD41F2ysvLHmyvThtLUndB6rKqzsdh26gIzQUqI7azrKbeUemCwew3h9+8JXFLNztTtYwNoRj+8GEins1XkKDe+WT7IfR7irXFdCUskDxCT6gVpupHFk0RJVWDROSZhAT7ICIiv0n0kgCBMY8M8yDarPphiLmV6a923h4sOQrcNISEJQcm/WFHNeH4+2RR3MCyeEI15OcxkJ12FpGSnhBRTCYQ543KPcW8P4DpM8VbDhjlbH0NusU++GCmzegwFKFb3Z/jmz0EndUa7MlkAwt8UNx+G/P336PJFoz8mTG2+sp3Wp2EFrd20+qWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3IzppjHtZhIaL0eju8N+YX5Er/KubiX9LfvLhG2LHY=;
 b=KihlTY5abE6wE+vfgsgdyH3Rx3l4L1W52tG979hVVIVsYOn4zSl4MdR1tnx1EalyMKSSvCerAFpfbD0vjZ5aYkmqcryw5E8iOaOZdQkLwdfj6ZTzTUyUv2aB41N0YC1aeMKaDFW1DG76JFSXa1jPOk8oapS4BkkPowfTC+QjCwwY6KYivD8pOZkvPUy+ZfSDfWQ+U225xz7gazU510e2qHizHgwB3p8eBOREJoBSXLKk9AaLVUoi3BHd+0seHQd6SfcLJHHRkk387FdJzAesyjijv863s+QEZCHpEUctEtRFusJwiMFoVOG39TH0UYmPBJmAf0XQmnTVCKehv41ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3IzppjHtZhIaL0eju8N+YX5Er/KubiX9LfvLhG2LHY=;
 b=mEYHPESwJm7FeJZ5fducXKj2eKQ1m5k67dOsn962aURLwGH2hsrgNn9a33Kc/os8aRYXQkJLlgVIVwxRMcVQ4vm1aam8VaEmhBemhNHZXGg0oNv/OuJulrgwCrsERtWJZD3/25L66mDnfhbS2sGfPtM4ce/NrlrpU8xFFzpYT0Y=
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 CY4PR1201MB0085.namprd12.prod.outlook.com (2603:10b6:910:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 07:31:09 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::90) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 18 Jun 2020 07:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 07:31:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 18 Jun
 2020 02:31:07 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 18 Jun
 2020 02:31:06 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jun 2020 02:31:01 -0500
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
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: closing specific instance.
Date:   Thu, 18 Jun 2020 12:56:52 +0530
Message-ID: <20200618072653.27103-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(83380400001)(2616005)(336012)(26005)(8676002)(4326008)(356005)(426003)(316002)(2906002)(478600001)(54906003)(7696005)(82310400002)(8936002)(81166007)(82740400003)(47076004)(186003)(109986005)(70586007)(5660300002)(70206006)(6666004)(36756003)(1076003)(86362001)(266003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f9d64e-b0f0-4796-13d0-08d8135991c1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0085:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0085E87341132B667356C30AE79B0@CY4PR1201MB0085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhoYJkyf3rRBlSnwkNhXVeS6BJZAzOguAnL7kyy3zyKFdZukkeVpHvYwdgyIlpV5CcSZLZ/mQ0/Ooc5UuQ5MnFBwHndUJ+OZe1iiwq1Y5Yz8Gl5dHBWqpXkTvF/UK7GRIyc7IPa5yJ9A5rcvBECpOcvfPi1AcvjiGnG8//TFxeIHloDsQdYLxd+ppzc0HXT36zxoPrv9ubWI0dZLR4AnVFBwHUXzu/lVzsW9wldJy+qtg0PldiSduPwmwhzm8B9hdDnEJgZuxomdo44iDljs7oHb46KTVEO/CG7zQUbOiaoBD7Eh5ftN5VnxWSZA4sJmirPq2+04mrPa56hzmw3yX4S7jNjPSyAYN89qC9WqaowWPK2DtVBoWMl7hE3Xs5RmmafCJAhAChcIwVbGzoJ3LyfVpdBfe75+VEQhvf+qzy8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 07:31:08.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f9d64e-b0f0-4796-13d0-08d8135991c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0085
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The steps to reproduce:

Record from the internal mic :
(arecord -D hw:1,2 -f dat /dev/null -V stereos)

Record from the headphone mic:
(arecord -D hw:1,0 -f dat /dev/null -V stereos)

Kill the recording from internal mic.
We can see the recording from the headphone mic is broken.

This patch rectifies the issue reported.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 30 ++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index d8f554f369a8..e6386de20ac7 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -342,11 +342,34 @@ static int acp3x_dma_close(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *prtd;
 	struct i2s_dev_data *adata;
+	struct i2s_stream_instance *ins;
 
 	prtd = substream->private_data;
 	component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
 	adata = dev_get_drvdata(component->dev);
+	ins = substream->runtime->private_data;
+	if (!ins)
+		return -EINVAL;
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (ins->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->i2ssp_play_stream = NULL;
+		}
+	} else {
+		switch (ins->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->capture_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->i2ssp_capture_stream = NULL;
+		}
+	}
 
 	/* Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
@@ -354,13 +377,6 @@ static int acp3x_dma_close(struct snd_soc_component *component,
 	if (!adata->play_stream && !adata->capture_stream &&
 		!adata->i2ssp_play_stream && !adata->i2ssp_capture_stream)
 		rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_stream = NULL;
-		adata->i2ssp_play_stream = NULL;
-	} else {
-		adata->capture_stream = NULL;
-		adata->i2ssp_capture_stream = NULL;
-	}
 	return 0;
 }
 
-- 
2.17.1

