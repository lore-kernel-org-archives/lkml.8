Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3C20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gPW7gR4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgEREjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:39:53 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:63841
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgEREjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX9RVYim0/Elw+Ti+aZnUJ1VTmFIxQEAnG1dlCUk1pBxHsJCBDHkKhS3KjL1Zg0m1cpirG7uEXZvvLuuYRnH50yPXUgl15FVrlTLEMOPvi3Gb39EJ6pID/kXaXsDAov5UZ2Yl89vNHYHPOT46hAXTnJxvh6WCBJBq/LpPSXtrN14HiYvc4k46iJ2D3KOarTWGj/grFsXiUMTwvD5ZIjvA9VR7FTZuAtr3H0iRwK9fXqZvhVGwQBcKtaSoMMUzcYVWdnyIyY/qn1CnDLxtFOUYaKZ4Z64VDqHPJDVrvnVdnGZpbsI+lvqlbdt3sUcaDcr9Yeq6IMiorouabQwrhgo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg8GDeFfEbYSERAFDvY1JpG5UI5umKP9JtwNemG0RwQ=;
 b=Km37Lz6aEPzN6g5FQO1EQ9zr83LwFwuaHqxOTbkMNkEU3IKZQcGPDo8IMe1JeHJ5sIuqkcMNxJslYoX+Bh2I0dqpx/gWS5Z58XoL3yeuTPL80LVSSb29b51POxJepSd2l+S2/U8VNIA9MbQVPiq2v2gdM50iDGTkTEAvK64YocFh0Ho34w+wCI+6zTw/IDbDstkaqRnOsE/ZtdVf1UtoegRJXRZcuAPInhgyBOTlc6C867zKRvZEXgxP3ij2vBXldMI8utO2t7XQn4QdaEEmzaEzVnCAOcWScOt/9O1mvXBhQvPYrAySL32AAcEBtsbso8SnRGCa0Cy9gqianhEkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg8GDeFfEbYSERAFDvY1JpG5UI5umKP9JtwNemG0RwQ=;
 b=gPW7gR4VamNwIWoplZxnqbEn/5fom3qBdZwHNz5jN+oGDdQAenlbbGX6M1/GZu27TSryKQ8DpqBloQtBpNAdW6suKtjym3pVyBz8FkYfDcnS32APRD1cletJ9tnsZ0XSrKUBEzH9N2Hm2/YTd3I+hQI2+kw3Do0NTDERwVMMhpg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Mon, 18 May
 2020 04:39:43 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010%3]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 04:39:43 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: raven: Make the driver name consistent across files
Date:   Mon, 18 May 2020 10:09:05 +0530
Message-Id: <20200518043913.40646-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Mon, 18 May 2020 04:39:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2a9dc2a-1235-457f-eb0b-08d7fae57c12
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341783DA3677436C5A02416F8B80@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3p3WkL2KP8+uQxhkb3vcM0Fpdzf1dNJbKeJ1bpkQBlnimUgesXMH+DAwhqlMojtCH8mcqsdoVoLhbyC0UDTsb49dDyLxVRql9TPEv/ipeHUxI+5hmDdCaRsya0apLJTUTWkaVdcsCCHNkMsMXuVmMjnBj5feVMY8UAy7L7DI52M9ojHpqCkxEJHnaYm5v4jRPAo5exJpzlztjuDzE6NVtosik0O7d3lrLl6EVb86l0KpOMsxnksP4XSlVGaxbM7vPfGgnp/2s7C//6wDaQp3Zea70941d9nDm+scYeNXsVLNnV26Fgz8PzMEkhB42LbM0GLWpj51H4FPuJjL2m8EQNOjxogsWGChGqMVicvxeSuV0Kn0LT+UHpFty3CkujaZbOtvMisj2p8pYXLNtG6kf2p5WrHEeC4Qvov6exSeCAChQFXAyBY0KIrGZmeY6fKOMGSvWle503zbkBCO5EP9HZxOMf8P59rJBhTqHgP48E1i06/Vj5LGoZcsccvwgfg1GLCO/ZBF6MeefEPQIZYgy3nvnwSbVg8CQvlPqfelWHH/HoWkt8u4dOQBpWxAi5x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(52116002)(44832011)(7696005)(6486002)(54906003)(316002)(5660300002)(8676002)(4326008)(109986005)(6666004)(86362001)(478600001)(36756003)(966005)(8936002)(2906002)(1076003)(66946007)(66476007)(66556008)(956004)(2616005)(26005)(16526019)(186003)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: avMxVCR7O0IAoENTeo7uvyKNWZhXYLZUk4t33/UyyyEB5DOKfY+1Qy52W8VtbOAfZy/VNiuTm87K4geNks+CB1fRrAzVIPSmxR5acq0L77IVV7TQvp/EQZs2u4osJX39hcVRYfiYZlUMYm+K8EY9s0hgvm9h15lyjpIuZRb9TmdeRO8Mt71tMUvMOS8vFTJ2AGGMhvygInwsTJHmQbjFKyABPJLma8HUN1qb23N4AmG9LUbaVT5snragqgmfixVzlhExXFlxJzv75qfrgdo8WInQEyCKRmHCOY9RPNkJWkKJEMO9S2+xfzCAHhWjxyu5zaO9oKqrnU6ap5fXe8UyFhY7WGmcg0ZEETaVZhSx6JgP++cx8hv4rmmwmLhcuSrLfvfuOw/9aPJIaIPA/uHj5oazb/+JyDvRTwH+TRpaqwBqh+Rbapr21Ax5UITOADtu0NLFxn9pzxUHii5HhCGYjcr1Yd22x78lUpky8HzApKArOwhiFvy9A9NxVLH2Hwd9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a9dc2a-1235-457f-eb0b-08d7fae57c12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 04:39:43.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Oz5VvsCFhiUOspm44npKSnk1KmOoRuS3QodXJuRW43nJlYk/fuGzRmk9rZYI9jfrwDh9aPsF4/nF7QIX2uvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the issue of driver not getting auto loaded with
MODULE_ALIAS.

With this patch:
$find /sys/devices -name modalias -print0 | xargs -0 grep -i acp3x
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.2/
modalias:platform:acp3x_i2s_playcap
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.0/
modalias:platform:acp3x_i2s_playcap
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_rv_i2s_dma.0/
modalias:platform:acp3x_rv_i2s_dma
/sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.1/
modalias:platform:acp3x_i2s_playcap

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
Resending the patch https://patchwork.kernel.org/patch/11355713/

 sound/soc/amd/raven/acp3x-i2s.c     | 6 +++---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index f160d35a6832..a532e01a2622 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -15,7 +15,7 @@
 
 #include "acp3x.h"
 
-#define DRV_NAME "acp3x-i2s"
+#define DRV_NAME "acp3x_i2s_playcap"
 
 static int acp3x_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 					unsigned int fmt)
@@ -269,7 +269,7 @@ static struct snd_soc_dai_ops acp3x_i2s_dai_ops = {
 };
 
 static const struct snd_soc_component_driver acp3x_dai_component = {
-	.name           = "acp3x-i2s",
+	.name           = DRV_NAME,
 };
 
 static struct snd_soc_dai_driver acp3x_i2s_dai = {
@@ -348,4 +348,4 @@ module_platform_driver(acp3x_dai_driver);
 MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
 MODULE_DESCRIPTION("AMD ACP 3.x PCM Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a36c5cb848cd..620b568bc414 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -15,7 +15,7 @@
 
 #include "acp3x.h"
 
-#define DRV_NAME "acp3x-i2s-audio"
+#define DRV_NAME "acp3x_rv_i2s_dma"
 
 static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -542,4 +542,4 @@ MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
 MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
 MODULE_DESCRIPTION("AMD ACP 3.x PCM Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_ALIAS("platform:"DRV_NAME);
-- 
2.17.1

