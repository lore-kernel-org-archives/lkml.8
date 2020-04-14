Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A9E206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wOX70kOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439355AbgDNLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:36:31 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:29920
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439325AbgDNLgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:36:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCGgXOe87E2kUCNjWO+YLNQR5DJTDk1Q/YKo5R6LrJLsttzocIQRbhEhv5BEhxBDfK9JjCFXIIVG8ESXr1ubVG/cr4f8i0ITmi9Q2V/YLNgTZCyInEfni7Rp8SDVpsm5fSPWuz/GsnQYz9nvdoXAL/RfC+WW0w0pplUvnBkgusM/CHs4OEEFr+/IlEiMBSDV2KR+7TxEmXE3P5ptcAR9dWC4azjI4kWwVr3Txe6rqbmQ1ynEkjwpqmJl7/lVZAUvaE+PbJZTXJOty58sGk2aewgoFgnvNTYBsbUTJy0U/v2h3vT9yY8U+7PySDv+QjW358F52v06Vu6Q5RtxvkH4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDNclknnDiYNq9pNbVDnGjdBeziK88/V+YhOAgsBF3Y=;
 b=RQkNbJVifcKw72/0rWq1b3CuAYVKg4nc7uQqptRCcBev6x4z5HGAGA8l0eKpoPKQgrys2T5s1QPWIdfNP62ZenZttDsaC9kb+FL1Smx50+vHBswESbyWXsyFGyVXUJJnACRJERTopDVNAUUufuvhlTOIsx17imEj8IdtTsnIfFPQ4fbia0fCemrm5OLjaoRre99Ep4ecK0hrJe8LtvBDMrycj40CmMamPiKwfERd5m6Tw7rX2JIqPfZdPKi6Gein59wvjuNl7wioZoOQf7IjAHKqRZ4oPoVoZaJdRu+yQAP9+zmi06+eUUflBrNegd6bDkezX523s3SkwZVP6yjmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDNclknnDiYNq9pNbVDnGjdBeziK88/V+YhOAgsBF3Y=;
 b=wOX70kOfjaRabLqpllOBQjQejhTeQo3xtksycaE3XwoKy3X6Vq3BEbt+rqYX7mxe6O83k1Zg0C9G7N3qnRwhpyH2UbVqoUyq+XQHCv5fo8eVmdH3UnS1YVvjKxiDkvwxC2SJrW0MB8XXWgbsmxOsyvNqctnxGDGRDB+C3ueUQzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23)
 by MWHPR12MB1134.namprd12.prod.outlook.com (2603:10b6:300:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 11:36:09 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::c455:6257:3c8a:7010%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 11:36:08 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: Fix button configuration
Date:   Tue, 14 Apr 2020 05:35:23 -0600
Message-Id: <20200414113527.13532-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::34) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Elitebook.dlink.router (122.171.58.15) by MA1PR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 11:36:01 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.58.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb0ee293-5ddb-44b9-7022-08d7e0680633
X-MS-TrafficTypeDiagnostic: MWHPR12MB1134:|MWHPR12MB1134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB11341E5C8939D6208FB46BFFF8DA0@MWHPR12MB1134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:117;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(52116002)(54906003)(478600001)(2616005)(6506007)(44832011)(81156014)(6512007)(956004)(2906002)(5660300002)(6666004)(8676002)(186003)(8936002)(316002)(36756003)(6486002)(1076003)(66946007)(66556008)(109986005)(26005)(4326008)(66476007)(16526019)(86362001)(266003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHm4MQAGne6qEvFfRroPSLcNEcXMSEJvx9NKBeDSg+NDF4dZikMYIASV0XEPDRPj6+0ZkGvAc3GVIKmmgQEcPDdp6xTHUXxjjeIPRUPKK5eLJlEsdusSQ4HvOzalxOAuBh6YDK3EUa/yPMzyCewdROZLYYozwCQqLPB+57eyQzKsV8TO8szsk36CrMkUAJkbamxb8jKRF5nTwlgxECGxk32dcWLx8EPgrtdAYYTacbpOQcuNRhPWMHi2uTNO6Jso83B0IrlwdZ1vB3llaIiIFuFYCfOvR6F/NESfNmfCZ4XiQJypWBjxd2XmnpcDXfx7e8/PAcfn5kdD/1C2XaxMCd3nuH0vTX9YsCh7ha6GsWheuIbGj7aR3HdW+m7Kol8mwaJHql4RiWoiTU+YHPlw726MwSZXO8Rg7uptaV54W85ZjprS0iquX+GIQ8Y7wwkUF23J60XLj1b5/6M8S3sPIJpuWnliF873/cMUbp+ewxc=
X-MS-Exchange-AntiSpam-MessageData: B7X7EMzmP+DD/sDPTtyJ1QZDildQkrIsGwTep6ul4OfUTrtqpPH2oZ3u14dTUZ0X1olay/HNoXev3N7sd28CiOEl1uS8pWhX64WRWs7AfWRFjjHncsG/+O7+yEu/jqZvhxe8NFqikN3yTdlR+kPr6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0ee293-5ddb-44b9-7022-08d7e0680633
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 11:36:08.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdXo4NHp7VlgpOjx1F4Cp8uszzl30o3GlcsltyvMPPcQVd9TRv1FdEDYKsRq13ZiPIM0sD/4ee5sIqVz2p1N0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1134
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT5682 buttons were incorrectly mapped.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 024a7ee54cd5..e499c00e0c66 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -89,9 +89,9 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
 	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
 	if (ret) {
-- 
2.20.1

