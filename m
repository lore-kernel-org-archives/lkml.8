Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC3CC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD87207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SciYgYrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGTHVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:21:44 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:10157
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727837AbgGTHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:21:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxB2t7DmxC21AKIDXwcTg5MnR2n7Pg1TmcthsZWE4T9ozjeCURR4bxmUG6MAf0MCMuMCS2ByEEMLTit7I0XYaFoHFrg3nmA00b5fyqSokK9l9imK0DWACw4R8aqli2EaRtrSpUgT/SHw0NShPoaIOpk2Tl9aqFPD4dAl6z7y/OW7GV6VJxSw5AObUcjmtOUceHttPJR9rrZGMW4tinOVPFfMRXBcasT9xO+TGigtsMh3lGCD1hU9PykjRAmbVBnrIMxv+LVv+N0svUab3/9boVQ+xqTcYFot6uT3UPEc9A6t1vMTVC628AzuEF/k6Nvkhzsr6LMQ79OO6xN9vgz+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPerqZdB8ZRuhINmAG0H9T5I4wQjHd9CoVe4inm//8g=;
 b=Ql4spEkCNbMp3NTJaT7L03RuI6xVXoi85ffRxfIl192U55fD7pn37dVIbXJE1LZYqoO9ClZP6yzAmTFNrtK7HGflhncHmExev8o21Sf/JV1FjZIaFL3myLkVVzPxrBl8zyAHzMx0Vmadpu07Q0bWTNnQAUkz3nPVeMFjrWJAhuQso7DHriyN6896TVZ3tHUzYMq9jRdn5EZFdpfNgsdb0r70PEYVci4BEsO6Pon2CCJl8UTJ8k5govmY7HRFpVSeh+gNxsBHj9+CCU2DdpAV3l+u3nJXQFH0UeLuMWMlP77fsYwfyljtZJi1l+kcHqJB//rNxabujoyHJTs2/pTaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPerqZdB8ZRuhINmAG0H9T5I4wQjHd9CoVe4inm//8g=;
 b=SciYgYrVUWFk/j03+UTIygotmQB7DPsajLkS/CROVEuT3OUTFaEp1abY2R1IBSBvsV3lB5q9Op6xIyJMDQwX4FwJF/T3kk6rvmy50RXf09ymw78s9i1Fs32UG8uibJtBBuGDa81TX1IFqzPzfjiWRoz6OfWTBvYnwgCj+Yd8jL4=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0402MB3344.eurprd04.prod.outlook.com
 (2603:10a6:803:10::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 07:21:33 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:21:33 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, shengjiu.wang@nxp.com
Subject: [PATCH 5/7] ASoC: SOF: imx8: Add SAI dai driver for i.MX/i.MX8X
Date:   Mon, 20 Jul 2020 10:20:44 +0300
Message-Id: <20200720072046.8152-6-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
References: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::36) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:208:ac::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 07:21:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4fb3213-d776-466b-0f84-08d82c7d87dc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33441DEF5E26CA4FB2BCF386B87B0@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgWlLOiB50g2t2y8GoJYEaMK1DBJj2GLPnY0F2FUjxoa3G23YveZhyl63ShFbLNR0b7t8W6K/lKlPy4TtdGLG+cPvDDYs6Vo0hM2IP80yCV/hctc2suhcC7ymlBDyN8gB0zqYYPLqSosXQDN8iW+z87ypZAdsIEATv+bcMj7b4TtkxpOysYLNnTXGG1Zrs93A+NM0EFJxoM87CIWHAMrfPAPRUjnmeuz26tydtXMoJBlpHpL9qD5VGd2RnIlc3IdVtXSSquf+1HiLZUWGkGO5+MC1ALona1S2LoPx2l0WeB8HxoaUvB3tZNdEWo9Kz+VH5MZHes0GZctPB3QDlLV+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(316002)(6512007)(66476007)(66946007)(4326008)(66556008)(6666004)(186003)(6486002)(2906002)(52116002)(86362001)(8936002)(44832011)(26005)(1076003)(956004)(478600001)(8676002)(16526019)(6506007)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AqC10o12gx6AWPdRsBUG0uBFAM/dz4VH9n/V/JZMI5S4Xlkdu46X2Q1r9QqRmF22PJ2ZltDJsQkSsX1KUfFqflBfruaVUMzaoi0zS1jBxq6hc5P957czLv6fa2hjBLQA5eQgG1iFAU62/Mirxvkp1xRb1txmr0kZN2Z7NGwaSAXTl6f3S9tTkZlyW1RFrMh/SorXI9FWbMxcRmEDuK3UFAlvkP/ObJMiEcYtTbi67qYQ10Y2Yj6Vim99KqMkVD2fvYwLj2EUow40PNsqtJbZiSJ/PC1Fw37Uv4nEkg9jucEYH3GYi21QgjytvdsgL81S+FJGtY5McUgSyX0Dlv1pQ/XsnJKZCk5gxKMJeLu1Z1ogcYv0aj0C26RaaqjpkLccraEvQMWNkPvZgO1YWRexlgtretJKz1vewUO1Ngjeb+8u/q608lNbIuz8nsb7C+hkOV4Os9Q9Tkt/lhX8/ZuEMdgjMfmfbmTsJdz3D0fxeos=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fb3213-d776-466b-0f84-08d82c7d87dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 07:21:33.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+wfLscFPdLsFeckGpRjynMTqe6Gk+mrwa3xPFtAHdDvIGQXhccVkdfa0HdFb0MuY3UTms6oXdizpuZwJYCV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

With SOF we support 1 ESAI interface and 1 SAI interface.
This patch adds SAI1 interface support existing on i.MX8/i.MX8X
boards.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/imx/imx8.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index f1308824e2cd..bc0628c7b88c 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -384,6 +384,17 @@ static struct snd_soc_dai_driver imx8_dai[] = {
 		.channels_max = 8,
 	},
 },
+{
+	.name = "sai1",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 32,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 32,
+	},
+},
 };
 
 /* i.MX8 ops */
-- 
2.17.1

