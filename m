Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68276C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB820809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XaEKRuRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgG1QH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:07:28 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:6382
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731182AbgG1QH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+ggUp3nQDWx5ejosCMEz43sYxpaPjUnmlJ0lYysNecPxAMuaGD6ZFQPcjVTb9PvJnSI1iiCwE+feOIMqOy2D9wLufSsz+sg2NRXukgQvaGLgjI78rqgsNA+udsI1enAbbqKTFKoH+Jm5P0MAH0NOIg7If4EPwODvu/Yr2zjcO1LO8C54Sg/lPOWwJuq6kSeFDJ2bsY7iAtCHhsqzf9ESxWaBbnWsV9EgBf81169o2a42k5OfNFapDPaklriPHNybfzMXnGAPw10612hldMQMs4Igyua5vULTGvnUa8gYRwx3di2PndbHXWOiW5x67lLNnst4F/KGDKyqleu13mDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNpz+z3esX/SgjiE1EFqtHCjhQAq/ZVf8laIuRzdBs0=;
 b=O++mVuZDaXTeTCBqH2+Al38xfvKxC5FDvM2J4D1c0WvxWpxVWBAsTiqdh32jQu/M3eCW2mWV0bM5sXPyW1e2MICk9iwqiNbFNn4mP9d08fK2hod1BvKtRSStN4AvGcctclUTg/0XJF12BjR/evHxRYCXFNzkkAizCpkuhSZvOHMebWsJfNk7wno+uUjhDMmw9FBakCi4OsAPDGw+99d8msGhFugr8i7a00PkzxIoEwCnEiCdx318oAkxogriF07lot5/IxOqUgpdxnzBGR4lHT2WWycebYkahthGH+AFH6LFigM5rtGSH55Gdg4pVJzoEDcpVXb8ffPSNSKLSizu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNpz+z3esX/SgjiE1EFqtHCjhQAq/ZVf8laIuRzdBs0=;
 b=XaEKRuRUTju41jcku1iBZgjL7lJ7zDLYWqXqO46twjGJwrCtfCW1t+rjYbX678s9YOQfFKXUX3N5Zjd8i8feCOSG55ZTIIsL/qPu6vopakpJa4UFdcnWhiJikqeISw1PNVj6OLMhydtpUQT/AKr9LWWQNCNr9g4a9kydTK93S4k=
Received: from CO2PR18CA0062.namprd18.prod.outlook.com (2603:10b6:104:2::30)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 16:07:24 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::ec) by CO2PR18CA0062.outlook.office365.com
 (2603:10b6:104:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Tue, 28 Jul 2020 16:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 16:07:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 11:06:56 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 11:06:52 -0500
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
Subject: [PATCH v2 5/5] ASoC: amd: Added hw_params support for ALC1015
Date:   Tue, 28 Jul 2020 21:32:55 +0530
Message-ID: <20200728160255.31020-6-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 455012e3-defe-4900-660c-08d833105107
X-MS-TrafficTypeDiagnostic: DM6PR12MB3658:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3658D8D0722939C189233F38E7730@DM6PR12MB3658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewi8U+P7GD+YnprYU3X2r1YdX0vir/qOCO4Vjq/tMNoG2k/QYP5url3MEJpLFPeUITEey8mL4yvsx6bHMnc3HLQ2vy70E3+J5SoW8/jPiK6sdsUR2K+NO913NOPiLZa7v5cqQ4U4tt2yXYHqeZXMma1OhJOHobdFXpV6ozydqWFiifRS/gQP7n2zOSGAFS3V0edfHNIK+HYV1LZQO4LCcWcrCokb00Ob08duPycwBWl8SA2wwLmos2LpwsylJcvWFVj1eh9juSibtFe0zcIw/bGvC/1USqPlivS0+fTaR3EMzHKZoRpfCxJruhnJooJie0c2PsUKXtWYcR3qTRQKu8sJknNgTdpNrj0XFe3Sq1hNsU4WhHXyfy6ilq3VoQGmsvlkCheGe/p0AttC6wzexbDe2mupIptwG0kDcDzWcfk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966005)(1076003)(356005)(2906002)(82310400002)(8936002)(109986005)(7696005)(81166007)(26005)(82740400003)(5660300002)(186003)(36756003)(4326008)(336012)(8676002)(83380400001)(70586007)(478600001)(86362001)(47076004)(54906003)(426003)(2616005)(316002)(70206006)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 16:07:24.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455012e3-defe-4900-660c-08d833105107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding rt1015 hw_params which set Bit-clock ratio,
PLL and appropriate sys clk specific with RTK1015.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index e0c767716b9a..55815fdaa1aa 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -127,6 +127,34 @@ static int rt5682_clk_enable(struct snd_pcm_substream *substream)
 	return ret;
 }
 
+static int acp3x_1015_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
+	int srate, i, ret;
+
+	ret = 0;
+	srate = params_rate(params);
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		if (strcmp(codec_dai->component->name, "rt1015-aif"))
+			continue;
+		ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+		if (ret < 0)
+			return ret;
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1015_PLL_S_BCLK,
+						64 * srate, 256 * srate);
+		if (ret < 0)
+			return ret;
+		ret = snd_soc_dai_set_sysclk(codec_dai, RT1015_SCLK_S_PLL,
+					256 * srate, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 static void rt5682_clk_disable(void)
 {
 	clk_disable_unprepare(rt5682_dai_wclk);
@@ -232,6 +260,7 @@ static const struct snd_soc_ops acp3x_5682_ops = {
 static const struct snd_soc_ops acp3x_max_play_ops = {
 	.startup = acp3x_max_startup,
 	.shutdown = rt5682_shutdown,
+	.hw_params = acp3x_1015_hw_params,
 };
 
 static const struct snd_soc_ops acp3x_ec_cap0_ops = {
-- 
2.17.1

