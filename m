Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B70C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F52070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4PIa6QGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCSL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:26:07 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:27207
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726188AbgCSL0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+ww+Cx8LqrCud4cmx3o3fg+KCowvThcKw9TRrGDMpMHW48Aid2Bug+y0O3l4OHFlhx/T4c1/HQwTulzbGLMdmUUedRv4RgbC5A4qVsBeujL9lJtT4lyFuEXHXfquIPsT5YA/n9FU72r/HK3/EZbfapXQcHU8daiNj+Tw7S3O2LBr5rdjapjTYo8VqmkPrSD7kjB3GrzA5t3umt72mRCkJ82fb0Bi9dkWepLRQw80vErE+iFLmQQD3VBny6L017d6/h0aXYl5MONl5daa5MYfaDuwUbK557vNotRdeEczPxtgfsqeoFYoT7ezrN6fRJwbdHihVp0beeY9Ng8T5S0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcvbhtgefw5WkAcVGVLk+MHzWiV4XqKtSnMk1kbumzs=;
 b=emU8PJcJMeswf1iB5S6Inl/95H+0K4IJQOiCw2Y8h2lAoYVi3N/fA9W8L5dkM7SZtf8cJc5VzWWYcgrOou4h+xm5DEsbikNHNEaKzyaCjhbybHcXed6igJsMEzRPG5jKOvKQTAKE1z8jUDGX5EO1/Jl0AxXLlLkKJhZuTlZ68P/FyDy5g9uEIYDTbWaWRFQJbflcKKsGdVtHDAa2vKuUsOQXx9ah6IPEhXdtO26ajQKlcndLPakUeYBmOsGA+4wA4ECu6wpDQFxkN1cjb9ygOuiXjLYKAQObrn7CEp5TId532r4/xcsaaw0lLerC3du43f2JgwTlZZHGjAi/v5chyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcvbhtgefw5WkAcVGVLk+MHzWiV4XqKtSnMk1kbumzs=;
 b=4PIa6QGkHtA416ifd5FgNITFZTOO4qCCD4r45/A7dsUVHRo6pYBJ16TB3vPBFTtxfPkjUS2FjpOvoshNygOUe64UWLUwwq+qjKz5Yg8mJSwT3R+1Sr3L3XWjv82mZXlqT5tfjtI6Y43LkcbGPmsreBjsrOKO35rqymutR69QCqU=
Received: from MWHPR19CA0096.namprd19.prod.outlook.com (2603:10b6:320:1f::34)
 by MWHPR1201MB0269.namprd12.prod.outlook.com (2603:10b6:301:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Thu, 19 Mar
 2020 11:26:04 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::97) by MWHPR19CA0096.outlook.office365.com
 (2603:10b6:320:1f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.17 via Frontend
 Transport; Thu, 19 Mar 2020 11:26:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 11:26:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Mar
 2020 06:26:02 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Mar
 2020 06:26:02 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 19 Mar 2020 06:25:59 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Changing Audio Format does not reflect.
Date:   Thu, 19 Mar 2020 16:52:53 +0530
Message-ID: <1584616991-27348-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(428003)(199004)(46966005)(2906002)(8676002)(4326008)(36756003)(109986005)(316002)(26005)(7696005)(2616005)(426003)(186003)(54906003)(47076004)(336012)(86362001)(5660300002)(70206006)(70586007)(478600001)(81156014)(356004)(81166006)(6666004)(8936002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0269;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e2d8c3-4cb4-48ed-4b97-08d7cbf84f48
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0269:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02697AA8C91ADC2AB150B31DE7F40@MWHPR1201MB0269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS1aBmGc5RIpC3OoMpcIaEY5NWRyP3cmT9rNBAtb3rDENMPol5YrbPgj98U2PL7YponaDc68rV4wkqEb4AtmvKu8d7THmeCqCICzz8UYuoZGF1mj3JNphfPojzxUisgzb08L3jYaInBmmwScwyWJ7t9lb0PsK69ACSoGK1cnfn6XBWN0V0hOyT7W+m1ZMD3bur4loKHA+4/N9HKkeltnU316j1/phfiN/QLxj8nYebJEMlBevt1jBZs+GedGKbn4RyW2Hoqq0hUGnPEEi/VmzYcFYtVAaHj/xFkJnRbtlFA498q9zCEP3pL567XSN8FNy7AI2pJfZZ7r+eS4pobKfJZTpCvIy7nikGccndHl4RD6noVZBZEzFjY4iJ3wf50lIHPuFxqLkKtaohamfSV5786yVVXZ5dHR5NvO8/i96xiH0u7lvelNtM+4rmMPwllOTmKoj8uSS/f5/4yB2LXWa0w429KZHdo2ymD6MG1paOgE6HT7ELTtI1CwL6bo5Nk6/fEdXOf54I4Lyo8o3vI7Jl02bb+Ec4tMzNz4Jp+zk2Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 11:26:03.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e2d8c3-4cb4-48ed-4b97-08d7cbf84f48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0269
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you run aplay subsequently as below by changing the stream format:

aplay -Dhw:2,0 -c2 -fS16_LE -r48000 /dev/zero -vv -d 5;aplay -Dhw:2,0
-c2 -fS24_LE -r48000 /dev/zero -vv
as a single command, the format gets corrupted and audio does not play.

So clear the ACP_(I2S/BT)TDM_ITER/IRER register when dma stops.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 3a3c47e..b07c50a 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -240,9 +240,7 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 				reg_val = mmACP_I2STDM_IRER;
 			}
 		}
-		val = rv_readl(rtd->acp3x_base + reg_val);
-		val = val & ~BIT(0);
-		rv_writel(val, rtd->acp3x_base + reg_val);
+		rv_writel(0, rtd->acp3x_base + reg_val);
 
 		if (!(rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER) & BIT(0)) &&
 		     !(rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER) & BIT(0)))
-- 
2.7.4

