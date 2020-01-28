Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A6C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA3121739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aBSnkLmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgA1KbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:31:20 -0500
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:47187
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgA1KbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:31:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYjnNRaACK1L3M1fmNqDiIEogVv402YS9ZlzSOduFoBN/Db32vyRndQNbE3XhIGZZepPV7aJmiiaVxWu0GYbHWLP0XeKIazR6bfpcbbaC/0BPQB07yDteyQXfwts/NItX3FQ6KOG2Psh24Yk+TCtL5kVhymjrfhjEy0VCzpO6WE7+Ir+cMP2MepCwAjrlSvMsqag5BO648SJtsepXMACDVmC467Jg7Cc3UnQnMWUYVkucVcNp8Xovva9O5vSnI7ed02Rm2SFoSFUkV/Toi0RNcl9j8ORZef5bLNyyftsAiiIthB2uwM3Yww3SS0t12Z5ctRaykWXyACEa/jCo+9rVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wes4GstEkN4BG89qDquJ3sSTKuepb7JkrL7xd9wU9QY=;
 b=jeeze0TCpwYdLJrzg1JR7ezifwQY0AvkHsFTimu5CT/h/I0JfHDYjbCCq0EyCQ2W0ZJYZtCvRxVnSKkEklv4zCIygDmah1G9bZa2lK4npvnMbecOE1N+wS2XspxxCjeDOAcgbR5iFwYo7JGKbnA6nQo3eomI6Fm/cz5NakBGH+cUmfFo6ppuveaaiO5nHWRrU8YZ8Mi6K5an76kOlohDFvFifWmn7eMbQmExBIL0CTKvK0nc2vAFb9su1i425TibtXT994URyAXhL0lb6Wou5wGQBJxXLCHdmvAAyxK+bedIEMBmpCtY1xmgT2Gsr6nZLiPpESFNTC0E4Z8T2h5HZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wes4GstEkN4BG89qDquJ3sSTKuepb7JkrL7xd9wU9QY=;
 b=aBSnkLmbB7Vban1JaIBd4REHYcBZ5RiYUwyJ3Pu09I1Szlut+O8p41q86mDfLx8yC039pR27jCS0kR/FAYXZ+ktWbYlKpsQM/t/azJelR7db6nzri1LZRhmtbd9nVIL+ACGeyR03vZcW7LzPc39toTxJmiar8pJhETICVYnS8NA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) by
 MN2PR12MB3280.namprd12.prod.outlook.com (20.179.81.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 10:31:16 +0000
Received: from MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::11fb:70af:b3dd:203d]) by MN2PR12MB2878.namprd12.prod.outlook.com
 ([fe80::11fb:70af:b3dd:203d%6]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 10:31:16 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: amd: Fix simultaneous playback and capture
Date:   Tue, 28 Jan 2020 16:00:22 +0530
Message-Id: <20200128103029.128841-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To MN2PR12MB2878.namprd12.prod.outlook.com
 (2603:10b6:208:aa::15)
MIME-Version: 1.0
Received: from ETHANOL2.amd.com (165.204.156.251) by MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 10:31:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d4eb267-18eb-4240-07c8-08d7a3dd34ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:|MN2PR12MB3280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32807AD0D5F05BBF95E6C23CF80A0@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(2616005)(956004)(86362001)(52116002)(8936002)(81156014)(81166006)(8676002)(109986005)(36756003)(66476007)(66556008)(2906002)(5660300002)(16526019)(44832011)(66946007)(478600001)(1076003)(6486002)(7696005)(54906003)(26005)(316002)(6666004)(186003)(4326008)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3280;H:MN2PR12MB2878.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZLOglkzMHBgfH9bAjaBVMy2z+6gWf91cpZyV0IIIJg+9T7Vidz2EDEyNfXYLR9zy5si9+lB5j8eGn/Bh5+2qsR2WxDwSB7BNk5aKZsqeDAg3mT59QogdGCN6DFBY4XcAeLqpKJorwb4bBIL+J2rYLNp/SgPU5DgBxmGkFSwjkvpTqe18oGqa5q8P1GUH2GSvxi7lXlF7lnt88LwVnHE0NxZdBOchvCdtVuYZ/TcEzfL11+xu19wz+RDRaJ5abXWP2gkunEemK5l1kUojFTutmLcceyy+Hx4kDDbU6LWMszof7cKsX8x9SAnEHDes4ebZZC04L/ojwl1GPJ3KsoYDIE8YmWPF9/WSJhBIxjFkTitmIxyLaKLCgXl5dO6Ggm0a/FYswlxF5X748nEPKXlqrl5IZqq+4FsIjUfuiiwIEwnkwjjgdV0q81J/pUiPrSRaBlupY7TgpqRHsihVs78kyzPlpdeSs0OAaOvtaO0q+w=
X-MS-Exchange-AntiSpam-MessageData: AtZ6/GP7fmc/zo7HPp9aAzchgMolh+mM9fn2+YS5hETLiyJHyLPe56jENdO9+C7N0U8x5uBgASVEVUJMzc1dRP8L4bH6+jHGsS5Xu280Fi0ESkQdJ4vJJW5tU9WKcnpHCSqbdSS+LV3nZFMc4c/vXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4eb267-18eb-4240-07c8-08d7a3dd34ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 10:31:16.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB9vfZKK3KJv7Bl3Qdmsf56xAb8zizhJkbxIo5AyHrIAD04zaYo5wRy8icWHrNOkFOoN4rsINdLAKQkof21FnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stopping of one stream is killing the other stream when they
are running simultaneously. This is because, IER register is
cleared which disables I2S and overrides any other block enables.

Clearing IER register only when all streams on a channel are disabled,
fixes the issue.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 8619ed5f08ef..c40422fe0001 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -234,30 +234,32 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
 				reg_val = mmACP_BTTDM_ITER;
-				ier_val = mmACP_BTTDM_IER;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
 				reg_val = mmACP_I2STDM_ITER;
-				ier_val = mmACP_I2STDM_IER;
 			}
 
 		} else {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
 				reg_val = mmACP_BTTDM_IRER;
-				ier_val = mmACP_BTTDM_IER;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
 				reg_val = mmACP_I2STDM_IRER;
-				ier_val = mmACP_I2STDM_IER;
 			}
 		}
 		val = rv_readl(rtd->acp3x_base + reg_val);
 		val = val & ~BIT(0);
 		rv_writel(val, rtd->acp3x_base + reg_val);
-		rv_writel(0, rtd->acp3x_base + ier_val);
+
+		if (!(rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER) & BIT(0)) &&
+		     !(rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER) & BIT(0)))
+			rv_writel(0, rtd->acp3x_base + mmACP_BTTDM_IER);
+		if (!(rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER) & BIT(0)) &&
+		     !(rv_readl(rtd->acp3x_base + mmACP_I2STDM_IRER) & BIT(0)))
+			rv_writel(0, rtd->acp3x_base + mmACP_I2STDM_IER);
 		ret = 0;
 		break;
 	default:
-- 
2.21.0

