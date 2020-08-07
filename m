Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E0821744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sRw58YSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHGQQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:16:13 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:14336
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgHGQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:16:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAPWle5wVQuyhPUo58Te2azUKg87Dh+nH5usIp6tX5gGARt1F8CacAoIT+EK6x1uto8br138HY7+7arAfGKbRaYhxj0N8kYN3IefvLonPueS9o+0NsyQ/hxCGct0nIyLsd6WDgj6vJX/aarOYlnbFKguLg2/L7F6+UTdjJHtLH654Drn3mc5xK1OFEiwvTh3yUsLmHWcPblx6nANkvQ8mVbhiTAHh8Ct/RypTqq5wlwXoJEwgsFJ6dFC1XuRB4nFp+03TH8nzGJrut/WFPmDwQXkT7swzSGo1UKSjwPeS6U9maNrRdZr1lNmOCwkGK6A6WAOfjv4d7ELf4nv6bmpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx3wfKZBAkWa78NVMszSWAJ4jhBnGuqJxpn3pWbmn/o=;
 b=lzZjgI/OB2l3JhaLaruTkOEJdPmRKueEPAkJGpywF5qWT35u4VltkbALTaM8Xgoy+gpE7mtwveBARFjF42bHIWKK2eGi+3TMKjh6MoFJQyZGb7n8UBEsi8Cv+GhC4pttjBW9hk+5a7fLvnmbf/iz4Upsl/GRisbFeukf8iu0tFU+bXdHX0KRnJDg3niBF/BCvJg9EbkuCNr1WC3DMByqZkwk7eOikPyajXnmJZphgsqdId3FuhamHeDIDPXkLi5GPttwSHnBkTZoMGRuAsgD3t3DoLwEKqCiiYcEksjMkRw6GKdIdHW3PArSDeHtST4E/Us1eIrF2xSPkjyeGbgG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx3wfKZBAkWa78NVMszSWAJ4jhBnGuqJxpn3pWbmn/o=;
 b=sRw58YSpY1kDWwKsagJ3JjaQzbmn7JU76SO9OTjTFp+AGGIAt6GAJ67DqsUCJXXqW+3Bt1RdTmagl/yUqF3dwhzouPQJ11uBRxwkOsiIQY6RyFo/zej9xE6E6YxFGmAjsdZy9pkvr4KxKSf8geFojNmxxVAAriYdTjvieuXjyHw=
Received: from MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 7 Aug
 2020 16:16:09 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::e2) by MWHPR11CA0028.outlook.office365.com
 (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Fri, 7 Aug 2020 16:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Fri, 7 Aug 2020 16:16:08 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Aug 2020
 11:16:07 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 7 Aug 2020 11:16:04 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Replacing component->name with codec_dai->name.
Date:   Fri, 7 Aug 2020 21:40:17 +0530
Message-ID: <20200807161046.17932-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df3f196-e917-455f-d256-08d83aed31ce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1224:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12249C94E418325F929CA714E7490@CY4PR12MB1224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2dD8EVLQsLeu3iUjmqMYuy3XW6DkXuxMUh+QXNwi12VbhcHpxS0W7D3dnKY5T7in4F+/OJkv9BHDjYwmGiaZ1XMTHMQbrdB0YWZzBUPtJZ5h7WB9Ghw/wzwn3X90IUX3CtYW94WC5Ku9fWbXMHuwg8HiKqOYc9dTE149WSM4i6Cqk+HYtAHFE8FtlWvoG7ulAW3JQJSfDj/6ox4nRDptMF4G4D+r2hkcPlxXQG7PuFktASEQuNieGtetlTWSnVcwx65XAVQyuNOsZyjnhZOB2813oraDHmf3nZzm+W3umWNIW9zTEn8HbjtfkCeGIleKm3PeuoGtuBr6DKi5PRM3mQ1JUGj6oM0eUkPWUSGJRAHpB9Wde/QH8IvednQ/b5nxoScMf+Bc+MyRIQDrmMs1TdE4DnpIG+fhXKiU05JFdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(316002)(54906003)(109986005)(186003)(8676002)(26005)(8936002)(426003)(7696005)(36756003)(6666004)(82310400002)(70586007)(81166007)(70206006)(4326008)(336012)(1076003)(5660300002)(2906002)(47076004)(2616005)(86362001)(82740400003)(83380400001)(356005)(478600001)(266003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:16:08.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df3f196-e917-455f-d256-08d83aed31ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing string compare with "codec_dai->name" instead of comparing with
"codec_dai->component->name" in hw_params because,
Here the component name for codec RT1015 is "i2c-10EC5682:00"
and will never be "rt1015-aif1" as it is codec-dai->name.
So, strcmp() always compares and fails to set the
sysclk,pll,bratio for expected codec-dai="rt1015-aif1".

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 55815fdaa1aa..406526e79af3 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -138,7 +138,7 @@ static int acp3x_1015_hw_params(struct snd_pcm_substream *substream,
 	srate = params_rate(params);
 
 	for_each_rtd_codec_dais(rtd, i, codec_dai) {
-		if (strcmp(codec_dai->component->name, "rt1015-aif"))
+		if (strcmp(codec_dai->name, "rt1015-aif"))
 			continue;
 		ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
 		if (ret < 0)
-- 
2.17.1

