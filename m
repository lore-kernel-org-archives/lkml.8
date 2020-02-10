Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8ECC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2621775
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PrLJrquw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:58:40 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:26564
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbgBJJ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:58:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiVw3Q7aFLyi8L+1u/VS+katfYs6Qd9exOVyM5Jmnvvp6JCIOSE/IIMQg4vIYd8M9AuTohXXDns1DPBMb+hWNSv6FalsCcNJwg0AKawrI/Ag5Et9zCnqNwfGWJzI2Uc8O66RzAjtOavzGyG0yia5K6bA+vZ4T1E2pGDTCE0oYYMTnsNOpMfyY9Pwgrw+/l5c5NALH1rsNsz08f7Jd9C1iODrSW/GUQspNa4jspk4nTjaG0iKvSOm7Mv3RibLBgrP4gVxV3JKqdoChHhpO1uIZEFMezPWZjBbjQW/TklAWvs4Daaa1ixhVCkdTDxIc1Swpwi5ZzqDPc7ExtpIsUPXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4xkXgOTXEDGM4vG9pjFIajOXLwO+HSfi52xcgH5L4o=;
 b=IsAyO75Xs2nhnd9B/BwrMko+ESUv/9B+JoCnDMtN2BknY++q2yDAUq16Gur2WgGOcButrESLBLZjlvwOcgMoNsmpYsI4NOFAjB9KmqangiQ/tPUvLxDxFCs/F06iEaAtxT3T2oqjqtBsPE8qVGzk6Kyjz+RoUVm4pGu7z7ZfoUsDHr7YkbYlu3l91bN8lUJTwioIpvl5PLJYIUIY9HeH1VqBWyzYqo/nNDo/nobLjgsJ1zvIuSS1jVIA/uxMPEHdMMvdxfMiTYF0MJQNRZy4ul1GfKjll1I2i7LsGmX3yjJ/rNvBg/Rlmw+IYhaok6hlpZpefmSp2iC8HwbLrkN9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4xkXgOTXEDGM4vG9pjFIajOXLwO+HSfi52xcgH5L4o=;
 b=PrLJrquw68SAY5f/FDCxNSXrnMEo7rKNrEWyDY2pALqXddi2VptvYdvJCWPYu5uspJPgPB1IZSV+G60lI28+EJFkmFfJ/cgJBw3GRqnCBviJUvWPSnlMCzMreaX38yhBm9QbMSMM3MikMVjek/0YCIikIhePpnK6r4cynAKTGgU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3423.eurprd04.prod.outlook.com (52.134.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 09:58:34 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 09:58:34 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     festevam@gmail.com, alsa-devel@alsa-project.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND 1/4] ASoC: SOF: Rename i.MX8 platform to i.MX8X
Date:   Mon, 10 Feb 2020 11:58:14 +0200
Message-Id: <20200210095817.13226-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
References: <20200210095817.13226-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Mon, 10 Feb 2020 09:58:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79d65ab5-1c4b-4856-5f9c-08d7ae0fca84
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3423:|VI1PR0402MB3423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB34233BBE544F4D0F98E67803B8190@VI1PR0402MB3423.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(66556008)(66946007)(66476007)(1076003)(5660300002)(6666004)(44832011)(2616005)(956004)(8936002)(6512007)(6486002)(81166006)(81156014)(54906003)(6506007)(316002)(16526019)(186003)(8676002)(4326008)(26005)(2906002)(478600001)(86362001)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3423;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsQBzE3fFM/IvOWLdcp6tmlEYN0NvpwHWFzIMNiTDkElkxr2TGXIxb6cPButTx4W/OyESD+QV/GV3V73ys/z8iu5+bGiMSuPwb8eTNC6tguDE4f2arcO8VcHTYcApGd8YoIs2/zI1KjyufV7gEgME7N4z4u7kwQAxUCbFfsNcdEVhXapUT+OfnpuPrkmjHriXpiec1FIDImcEDN9REofLmYzSkA69gAWtMa9/zWb9RDFqrxdfM+FRC//hwqQc0TQ8qsbnvolF3aM+0ySGdaL2H8W1oQY/GRBzgCl7TxXqfObUQ2b7us5n3tTOgPwyeK6ECtLhRJ593vIbNKpBBFp+WbRqn/f4yJpChcS7cZXvJuAh5kUEXbildWvWlmhoxKW+lZnUxdR6nCCtMepEaeE1+dnPHUHucET3EefYSfP4FuUcZT/gQEq6gHNZDgx06w3
X-MS-Exchange-AntiSpam-MessageData: j7Ey8aafduSTYeeaBVepEdk+E1LAuE2FPC49tCCajeBx8rOhOWiNTFkZvDuL+LKMsCfgKlGZ5SY+q1+jG/OsYgnYbF9rwIJTtOhGsm3a6r9fLnhJpCGg9tMTstLZI8ttPyc04b1uI9ToZXTz0SV4Sw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d65ab5-1c4b-4856-5f9c-08d7ae0fca84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:58:34.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtfErVf1WekAeYvnoMK/4gowTnY5iNj/v0iVzSiT7zm3rIO2bmzXSZuR2zEAFRj3O0BVGgcoIo20qTRfH1scgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Olaru <paul.olaru@nxp.com>

i.MX8 and i.MX8X platforms are very similar and were treated the same.
Anyhow, we need to account for the differences somehow.

Current supported platform is i.MX8QXP which is from i.MX8X family.
Rename i.MX8 platform to i.MX8X to prepare for future i.MX8 platforms.

Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/imx/imx8.c   | 10 +++++-----
 sound/soc/sof/sof-of-dev.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index b2556f5e2871..9ffc2a955e4f 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -138,7 +138,7 @@ static int imx8_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 /*
  * DSP control.
  */
-static int imx8_run(struct snd_sof_dev *sdev)
+static int imx8x_run(struct snd_sof_dev *sdev)
 {
 	struct imx8_priv *dsp_priv = (struct imx8_priv *)sdev->private;
 	int ret;
@@ -360,13 +360,13 @@ static struct snd_soc_dai_driver imx8_dai[] = {
 },
 };
 
-/* i.MX8  ops */
-struct snd_sof_dsp_ops sof_imx8_ops = {
+/* i.MX8X ops */
+struct snd_sof_dsp_ops sof_imx8x_ops = {
 	/* probe and remove */
 	.probe		= imx8_probe,
 	.remove		= imx8_remove,
 	/* DSP core boot */
-	.run		= imx8_run,
+	.run		= imx8x_run,
 
 	/* Block IO */
 	.block_read	= sof_block_read,
@@ -398,6 +398,6 @@ struct snd_sof_dsp_ops sof_imx8_ops = {
 			SNDRV_PCM_INFO_PAUSE |
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
 };
-EXPORT_SYMBOL(sof_imx8_ops);
+EXPORT_SYMBOL(sof_imx8x_ops);
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 39ea8af6213f..2da1bd859d98 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -19,9 +19,9 @@ extern struct snd_sof_dsp_ops sof_imx8_ops;
 static struct sof_dev_desc sof_of_imx8qxp_desc = {
 	.default_fw_path = "imx/sof",
 	.default_tplg_path = "imx/sof-tplg",
-	.default_fw_filename = "sof-imx8.ri",
+	.default_fw_filename = "sof-imx8x.ri",
 	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
-	.ops = &sof_imx8_ops,
+	.ops = &sof_imx8x_ops,
 };
 #endif
 
-- 
2.17.1

