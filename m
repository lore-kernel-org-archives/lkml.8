Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E193C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707A22068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W5hoVh7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgEFK0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:26:31 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:42529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbgEFK03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzTxYap61tEnq7okjIzBGGhapBVrT2/z+QZjhmOIjNs3XheXx3Ea+R6cZv43gTXqCkDm6NYXAuAB1FLK6Z6znwtZqDST9f0tbDIweSyDnYvuiBKhoL0W4rnS8ZvL8DhmWWRW9zhRqEfTmQ5XFTFwtggqT4dOgex5hpoOBE33XaYg/sLzjipOhojw/vLkGR8VAueK3SXvS/yzmvDxQKAVutnTDyHDoyJzg0CunloXGk9bI6l/ZrIQDVt/Tkl/vOZptRQ69Kf9s8BxXdhIlRXoEFejlXO44BBna6a5R+c1H2hPlQChTaUA8Jd4EF67ZaVK0YPnaRd1fGPAlgmqs/bIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9o8t3GPsbYt/5kfEfOTOYhEmo3EfQTV9qNjd7DrzZA=;
 b=oGEGIZ8nz9Ly8yIKmWXWQl8pETeEQLjBaCApmF2Zldp85FJX9RHx/atJH5PdF/nlCa3J+bloeZTP4r1TVHkqPqpMHoGf4LId8zDFTSRdsWuW4cvFZLQtFAyCZkwmD92mOb8R4IDHjoBkz/iYvRv4lKGmJvk86/LKZGvtmbnW83VA0aXqOqTNvl/hO1dxFkr1U5TSXoo7BDJpdkIApZtrSYvwS3mPDgSQLHPfsd9zh7xOdSLvTJpAV0h6TtItYEkzIBWyndECZD41kZPnNT9o5IHB9+Ig+dkWn5oq/buk7u1YPyClDy2+A+u7Iylq1SPH5aekxiT2S3dAilybnShkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9o8t3GPsbYt/5kfEfOTOYhEmo3EfQTV9qNjd7DrzZA=;
 b=W5hoVh7kHZXXNVii4is6aTfxq4sYk7V45oASGk7T16YqhABQEGZZ+bz/PIkR6MY65oZvwx3TEJVUHOfH7S1htDgR+yqSEDoCieJd5VQT9RFwJ69wmkkhu0AcR+XhG8SCFL4vpkFqaL86wIqG4OVqB1jAOt3YfiBeJxOsPF3r90s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 by MWHPR12MB1645.namprd12.prod.outlook.com (2603:10b6:301:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 10:26:24 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 10:26:24 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Date:   Wed,  6 May 2020 15:56:00 +0530
Message-Id: <20200506102602.140790-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL2.amd.com (165.204.156.251) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 10:26:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b01883b9-5a9a-4537-8328-08d7f1a7ed73
X-MS-TrafficTypeDiagnostic: MWHPR12MB1645:|MWHPR12MB1645:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16455F6B6CBA198445910028F8A40@MWHPR12MB1645.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SwVtxkAQE6cOb8g00eR3pkS6RNMdDOi8vrQASfltb+6Bs8pMLagYrv+m7ZaEvi+MSdz6gewmkPY1thr95uGo4hYWcohZ4QhQtGnpzju3DA/NzRpaKLLmBtNXwzxCeW6qSACLFrQmUUjkagWUk1NiSezOlr8u8AIgFyji9cf5kBJ1OYmAkSRpkIs3DloVN8dr8i6f1kbMl3VnxXPv0KfVdQsCLrJZd82dOId2ddB4TcZe7IzxFsgo+o7hlOvZYE5R2rsd5obHo1yNP4ADJvLkTWJwhp/E7a/UbvbMaqNZKXdZydw8pez/h6sGmTDy+tKJmsrnBHmaApyt8Fp0R8fqEaZmWJnOPRNO0k745W46gCFWtF4iETZgFx3G7zBcjnOdto6JGHJMBd5qKWZ906skwva0p4E2HuyyW6+PDG5DzwF8iknmKb0igIkFp70zUJcz/sXuD09wnBNKYCzluO5n9ro6vS4bhjlz6LWLqdKEVykqSsDvIb1eeXPXoKdqbc2PowMk+u0qbrMEV2qDRSWEmG+a0ZhTkUXEHb71xJY9G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(33430700001)(109986005)(26005)(2906002)(186003)(66476007)(66946007)(6486002)(16526019)(1076003)(66556008)(8676002)(8936002)(7696005)(33440700001)(36756003)(956004)(4326008)(54906003)(478600001)(5660300002)(316002)(86362001)(6666004)(52116002)(2616005)(44832011)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: duEI7h9+lnPudVBFi6xJoe2SbVmwY1Ca933LvkA2ifW91Vgb/CP04H7SUhz/orF9AXrBPS5y/i90BZnAn4RKhWqmUf7dPL8Lw2KRn4L1UUbmO/F+vEfBVOvIw5PXeNXZc4BqQxlYi5hbbirROoliybAZOV76bMRtxgk5e3Dm/rOFHu+t1OzfIYki6ztV9BMDl8F1vjI66F5ZpwjGkV5pvm2IxefjyKBNoAG/HhXTf+WMrEcLZZP6uFnyJr6CbYTJgyBIetWLQS6b/5/2Ohb6aU0+G5yi1LnS7tGTcPLc115/1G6N9kSCUqGB2RYrh/lt22jLWNt+1D2brCG4MIWrwH40+zWHlsSAOml1OA2Bd2AMa80RVgSm+37w5NqnE/cso9psh9f3FhqxdofBL+mlewTepGwnBWsGbm76lZKnFWxtGOOFAJM2F3yy41dATQP/DhFS5IzOGZo+gLp29p1f6rXv9Tt4bnuDRIg/bmDA9CkVDTd4G+2Ub3UwTDQA7+7b9h48juokpAvpc3J6edMV2udPGd2ib+oQCFZoVkIxmBk3x/tqYBX9fIPz5n0yN/FAqHD+wMnLyfpBL08gTNY4eUFvH9dVEWg8C6Jj6pmJnLPhRhXOE4hWDvZmOUvaJLERUvMlM+y5tfPPPHH0SjUTwk/qg/NoN+5ot5lEElQTXZ3rY9FCkUo921QHUI301MGR5Za0rUvtmYUc2sIIy+XJ2LnFA0v2KKt2SS1S0+vQijhpN0XAtyFvxeOzM63hHcVRrzXjauLzLiPGhcYkGlL5WNRKyhfDQxVabsyVeyHxDXk5IQdv0FHisxGF8VctcDSO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01883b9-5a9a-4537-8328-08d7f1a7ed73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 10:26:24.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2vs8ssMfHTDRX8BpZDYnQOw/zuXl+vvB3AervG60Y+2n/IFkbq4NPo+NhXxPujuHoKKskR0Xh8Grjkg4QABPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1645
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simultaneous capture on dmic and headset mic is having
issue with high hw_level being reported.

Issue Can be reproduced by:
arecord -D hw:2,0 -f dat -d 60 /tmp/test0 &
arecord -D hw:2,2 -f dat -d 60 /tmp/test1 &
cat /proc/asound/card2/pcm?c/sub0/status

Actual issue is :
When we open one capture stream on one instance lets say I2S_SP and then
once again if we open other capture on other instance lets say I2S_BT while
first capture is in progress and when we try to read the status of both
running instances by below command cat /proc/asound/card2/pcm?c/sub0/status
we observe that avail_max is being doubled on first opened
capture(I2S_SP in the example).

This is because our previous implementation was like when any instance is
opened it gets initialized in dma_open irrespective of on what instance it
called open.

For example:
First I2S_SP called opened it initializes both SP/BT capture streams
irrespective of on which instance the stream opened.next time I2S_BT
called opened and it initializes both SP/BT this corrupts the behaviour .

So with this patch the stream gets initialized only on specific instance
when ever it gets opened calls hw_params.

This rectifies the issue.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 37 +++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index e362f0bc9e46..a36c5cb848cd 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -241,14 +241,6 @@ static int acp3x_dma_open(struct snd_soc_component *component,
 		adata->i2ssp_play_stream && !adata->i2ssp_capture_stream)
 		rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_stream = substream;
-		adata->i2ssp_play_stream = substream;
-	} else {
-		adata->capture_stream = substream;
-		adata->i2ssp_capture_stream = substream;
-	}
-
 	i2s_data->acp3x_base = adata->acp3x_base;
 	runtime->private_data = i2s_data;
 	return ret;
@@ -263,23 +255,42 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *prtd;
 	struct snd_soc_card *card;
 	struct acp3x_platform_info *pinfo;
+	struct i2s_dev_data *adata;
 	u64 size;
 
 	prtd = substream->private_data;
 	card = prtd->card;
 	pinfo = snd_soc_card_get_drvdata(card);
+	adata = dev_get_drvdata(component->dev);
 	rtd = substream->runtime->private_data;
 	if (!rtd)
 		return -EINVAL;
 
-	if (pinfo)
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (pinfo) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			rtd->i2s_instance = pinfo->play_i2s_instance;
-		else
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				adata->play_stream = substream;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				adata->i2ssp_play_stream = substream;
+			}
+		} else {
 			rtd->i2s_instance = pinfo->cap_i2s_instance;
-	else
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				adata->capture_stream = substream;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				adata->i2ssp_capture_stream = substream;
+			}
+		}
+	} else {
 		pr_err("pinfo failed\n");
-
+	}
 	size = params_buffer_bytes(params);
 	rtd->dma_addr = substream->dma_buffer.addr;
 	rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
-- 
2.17.1

