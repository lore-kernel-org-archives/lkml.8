Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36469C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A53B207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ORIvvCQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgGTHVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:21:33 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:10157
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgGTHVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:21:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVBTnRtIBh4Uj1rR6jm9+1yYQYsjkwDUYAkABMcngH4RkEk1hwG+rFAVUbWx2RgxUNKX84BnsReLOlEo1iNw+DJN2AKciSm1mpCbCEAgPmvrRfcT9K9F2vWbpfAGwi3jWlBv0BarPmKb7AVOaNWDOZ54FAVpigECle+m0FFYxGqPRrgGqKkS/fkmphQLWWwld/5AkvCkcB8ERFwc5O+rRCfvYg73kzyNZCzMcGD3/2JwVMOoggvsU4gfUScuC1C0XQYWGCXSZTinEKoSzB37Fd2B+z8hBGojThLxoaEwVJx9ox/yeBxfs+p+UOfKGp0C78Jsx7KMDdIdnpPNVem53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jScGxkXwLTMvCxUuG308sljKFUZyywYxqVjjHX/wgck=;
 b=cV9NlJq9pJlT8S8XF3v06kSykt2gfsFNiQMXrbBvB/Iut7TAwZasVl60NpT7C/8Q+uJQu3L/JuWhYg+obTkZsVcyjQJygzmdP3fr6Ur+TPiOakh5XiEjqXpJ+3A4B3KyhF5SyeauikCNM1pE/lWIIPuuLoXfvzRe+UF0sBv4mgx9vDsPk1c+CoqiqRQu9eNK87Hn6+mxNSk9brT/PzX03ixknwgiu3WP7+8tqvJfqB3ukn8gYt0xzpyDPOtTfVf9Q7SmN90l686LvgtS9wpEFcYAqA+F85dOBrQCz+SpBo5aGABzUa42q2GvpqMi3FnsF6J310l0NII7QsdkPSsdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jScGxkXwLTMvCxUuG308sljKFUZyywYxqVjjHX/wgck=;
 b=ORIvvCQVgljxmyBpQ8nFKve7sEnfZiCm3fyHxOHoOhWZKH46h/DgI3Xt8tx8I9TJQM2weZL8AMDBAVr+u2wqdyPHC9YFCH9U+Uo4rgwfw5m184RzWNq5LsJtjKwYcbtj8dDlk3hgAQHeeFn+AZ2kSQO3CWb9zcabq9lvGCyu7X0=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0402MB3344.eurprd04.prod.outlook.com
 (2603:10a6:803:10::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 07:21:29 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::6888:5014:6c94:6711%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:21:29 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        festevam@gmail.com, shengjiu.wang@nxp.com
Subject: [PATCH 1/7] ASoC: SOF: define INFO_ flags in dsp_ops for imx8
Date:   Mon, 20 Jul 2020 10:20:40 +0300
Message-Id: <20200720072046.8152-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
References: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::36) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR07CA0023.eurprd07.prod.outlook.com (2603:10a6:208:ac::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 07:21:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fdcfd5c-1db2-4dcb-7b9b-08d82c7d8537
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33441783BF8D264B8988E8C9B87B0@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rElsfXvFnTVfsYcTBxJgNKv3HaH7R8bXwU0NoDLyYIV7X5Y1ncV2V9jG3fM18WDBq0Jtb7ppkfIQQdslTcnWCGjIjnOYCz3C9/vOySFmQDrjwmP8FEOKUGV1mYtHYZ6CYeA6EpBSWsQT7hOAhyiZyCHoHevdrWzZRoZ1825kpVlqzwSnojPpJusisbO8URV6ISVRtl4PbjhMwv+E8hvHZ/NzOvf+0OAqCBKo3RVnPelJBQYsBDwbQ+GQeh8nwTz0+AqE8vwTWkRfjrTk40e5kwMaFUy7Wa8mkt8QwMZA/iL5PqCNmWEoOEa0LaSIjaVvWBB4++KtNKGfq+BnEmRVyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(316002)(6512007)(66476007)(66946007)(4326008)(66556008)(6666004)(186003)(6486002)(2906002)(52116002)(86362001)(8936002)(44832011)(26005)(1076003)(956004)(478600001)(8676002)(16526019)(6506007)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zXcAWpArF20ylLTRd799DtIOf9QnJVL35D+wAwIyA8NX0fmnghVCuBZUv1tqDxOtnOho54HxxK6w933OztVReiyQkqYhJeGdcNVacNGiL/qCDoY5D1Q8454jCQ8DAZ9ZWQun9x5Vt4TzuCeow6p97uSMf7E0ku3a+9Fbl4z54amnWO53MVsUDETM4KzqsjA8B3i4gmU/GDPwFT4vqQECr8zii3uYeJJTdrooTq4KnF4/kB5FVaD+IkLN+NKhEgNrhqMaE8UYS+RlFdo1smzFGpUArdTABQx4gE0BL3KfRv0zWtMNzNhSQnYD2WqrltE2gCJIkMLnXEhcEmR2nL48L/6DiZmhwivx8O3MV1MlqNxdfW7a6JDMh54YL0yBrP8aMkgEo08sfqG7RzviNoBw/iQ1wECYHkXzFpGf1ErJZx3ljt09L4Vw2YwBJpFQ/98zJfhKSi7Ap9cpUH8tcDuDNG8ZjUfWPdx6p7VEy1XOrVI=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdcfd5c-1db2-4dcb-7b9b-08d82c7d8537
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 07:21:29.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAfVCu5QncvRm1xTe8ltHzycOcXr0SSdqTSHmYLsvEjFRBkKkdivw7ULQPJfpCGMsd5BkuwryP+xLIy1AHUKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

In the past, the INFO_ flags such as PAUSE/NO_PERIOD_WAKEUP were
defined in the SOF PCM core, but that was changed since
commit 27e322fabd50 ("ASoC: SOF: define INFO_ flags in dsp_ops")

Now these flags must be set in DSP ops.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/imx/imx8.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index a4fa8451d8cb..b558132bb609 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -416,6 +416,13 @@ struct snd_sof_dsp_ops sof_imx8_ops = {
 	/* DAI drivers */
 	.drv = imx8_dai,
 	.num_drv = 1, /* we have only 1 ESAI interface on i.MX8 */
+
+	/* ALSA HW info flags */
+	.hw_info =	SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_PAUSE |
+			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 EXPORT_SYMBOL(sof_imx8_ops);
 
-- 
2.17.1

