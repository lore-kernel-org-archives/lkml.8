Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E9C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF0420702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wero8S33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgA2Ih5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:37:57 -0500
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:6071
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgA2Ih5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:37:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLZmrkyzwwkPQUOsy0l9MQsOD8GE7lJkeNmoIvuvXk8AVnr6QOPiXxUR6LJ9Q5btc8OQSXIQvCiVMz5t2uxNFEaWnd+/5ybF4wqq9vV0di3taXYYekOA3+d7tK1ZhvxaocJ0X6zybeKuTCCeEoUyKeJchCiEgSu1owOVwzgmAJv1cCxLkuh6qToFjyF9011Lgvjrj1oO8A8VP6pGBxeQEmkwO3Xh4xpUAo+wM3OPmE02SFyRtMU9jIERvVszAKZZoAysWx4kP1YMjPONvoCRF5Mna71Lr9tqU8XqAv7S/CI6TezCP3Hjtj22I5um/Z1fN1XvBP6TYcJlCxMTrUpcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64pEEJpN0uTgZXsX2mJFpFcKsARmJbSjCM6bE/FMmlM=;
 b=NwJAYEoOkXdUp2Ib76Cck5x/DjgaBnBhF1N/zcqtxwqqQED17huePpX4yCSRERAqugtJ1lIA2sZvhcPq43Oavpg6Y8M+4sqhJ7jEUEUkx4l58H3k+TCbpszcn7kPJyCCEvb7nfyLRIxRAcv3BwB8Ejz/Truj8mq5WCLEAAr/c/fLEDIRfFu4jiSI+lKfit5w8epRVfpuGykVA2iGc3e+EzeiG9oUsH1FT/N1TOpaItyzRfDEwi33iiVi7AC5ZF6mPGK3P1GS5XzrWpBTtwWO3vPsDbYQ++UeMGjZQqD/t8dO8iM65vawOtaLWQQGsYh1JUSt1MyhfwC6ew6Ql/aD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64pEEJpN0uTgZXsX2mJFpFcKsARmJbSjCM6bE/FMmlM=;
 b=Wero8S33NuLnfjbzrvWBkwzAzCcpy7jIWrTyS9uW9XqjtRuhcNigLQb0z11c5cEg9JpJg7eVN84q3nfIFrkDrBsgNDd37DGlE9u+daF5h45Ryh/lXM06+QtxlP79nJHs8twckYcvV+SN5AwFXUVrU89j4ugT757czPXa5cGYwdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3552.namprd12.prod.outlook.com (20.179.80.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 08:37:53 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::11fb:70af:b3dd:203d]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::11fb:70af:b3dd:203d%6]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 08:37:52 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: raven: Make the driver name consistent across files
Date:   Wed, 29 Jan 2020 14:07:15 +0530
Message-Id: <20200129083725.208166-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::19) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
Received: from ETHANOL2.amd.com (165.204.156.251) by MAXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 08:37:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8f717c6-aa4a-42e8-2f6a-08d7a4968793
X-MS-TrafficTypeDiagnostic: MN2PR12MB3552:|MN2PR12MB3552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB355241AB81BC9FB636506984F8050@MN2PR12MB3552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(109986005)(44832011)(66946007)(4326008)(2616005)(6666004)(956004)(81156014)(66476007)(8936002)(1076003)(66556008)(81166006)(36756003)(186003)(16526019)(52116002)(7696005)(2906002)(8676002)(86362001)(26005)(5660300002)(54906003)(6486002)(478600001)(316002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3552;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJHAQnF2ylDacybORhp+l1CunLlZfVmuYLMKRjwcz/gNrw9QciMJEVey5o57YEaFQwdKkdWCXPOwPkWG9eHR6Si00nPJg1dOt7VkEcYU+Zm8pZYT/xrGMntz3gUCD2wAF45G/vyG6xqASI9QGYatE8pLpYv8iPjbML3LHRIXP/sUOOm0NgyKI9TaZQQcIuIaAGj1oRk1NcF6EM1iOjFasnjxd3Hu+2p5q+LYRm4iApXXRgdmyPPROYdbMf7jaKlBMI04Jkx+B3AEcrEzPqM2cjZeTxZdmW8LKv6sF8QAiTeiK1sd6mzPLi12D/pefvoA4DVs5dc6P1HqW7REXbnemgfRDfyOEySKPvSf09idXTD5YIiRTaY2NiHDuIXSNGN2uIXoetPkWdmpb9BWbc1wcVXMdqqKVluWxmKEbMNy37V4gvMiUEa4sZiyeD9RBPI4otMnjBmfbqw68Xr0FQG+icen6bt8I1q39wyCVQBm3Tc=
X-MS-Exchange-AntiSpam-MessageData: 3KTNphqlJYoMMflYvvSbcpZTIAlsJ0Igzerk40hg3AWtViiyZo7KUpXfdSesOgIlBfaUX47HdI9KzvrilJ8Vmt5IdF4QWUcY1zygIgZrzd10lVHpxPFIDTSHuIgvsEjRE59BimIOsBRFi5a65rjPFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f717c6-aa4a-42e8-2f6a-08d7a4968793
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 08:37:52.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4/NarWDKEcfzQxURzwIkpIP6iuh1QaIFdAcq9OgC+ZpixdTA+0VtrMLawLJ8Mxs3/y2chqm8VrqTPXh4BvDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the issue of driver not getting auto loaded with
MODULE_ALIAS.

With this patch:
find /sys/devices -name modalias -print0 | xargs -0 grep -i acp3x
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.2/modalias:platform:acp3x_i2s_playcap
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.0/modalias:platform:acp3x_i2s_playcap
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_rv_i2s_dma.0/modalias:platform:acp3x_rv_i2s_dma
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.1/modalias:platform:acp3x_i2s_playcap

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c     | 6 +++---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index bf51cadf8682..8619ed5f08ef 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -15,7 +15,7 @@
 
 #include "acp3x.h"
 
-#define DRV_NAME "acp3x-i2s"
+#define DRV_NAME "acp3x_i2s_playcap"
 
 static int acp3x_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 					unsigned int fmt)
@@ -276,7 +276,7 @@ static struct snd_soc_dai_ops acp3x_i2s_dai_ops = {
 };
 
 static const struct snd_soc_component_driver acp3x_dai_component = {
-	.name           = "acp3x-i2s",
+	.name           = DRV_NAME,
 };
 
 static struct snd_soc_dai_driver acp3x_i2s_dai = {
@@ -355,4 +355,4 @@ module_platform_driver(acp3x_dai_driver);
 MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
 MODULE_DESCRIPTION("AMD ACP 3.x PCM Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index aecc3c061679..c865aeca6907 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -15,7 +15,7 @@
 
 #include "acp3x.h"
 
-#define DRV_NAME "acp3x-i2s-audio"
+#define DRV_NAME "acp3x_rv_i2s_dma"
 
 static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -534,4 +534,4 @@ MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_DESCRIPTION("AMD ACP 3.x PCM Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:"DRV_NAME);
-- 
2.17.1

