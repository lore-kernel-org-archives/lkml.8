Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA8FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483E720656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y25LbSlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGHHgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:36:37 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:42049
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbgGHHgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF3jYgLK5Sywyd04cuZ3KYd6HWNPpPIL0VAN1SpsFBpak8jHaeBCHv5Yz5PXrCl6/48iuDvB5MQuQLS9icn7QW/fC5SkU8q0SWDAfgi9VXNBAJ1S13NqZ4VsLFwQ8lsee+uWp3X6QEdK7wmAglcnv403FWCzBME2+t5sIgyC5GDu7NekM+KdyWg5jMldWDglOS6rNA8pkFND84uIG9JqQHt4Twvg5TIE35HdEKlqTNWYcIPZ0EgNvmseV1NYB/Q9RvTvy+HZUrn7Pd5Mpb2LCzEu6okDRVuVMuGCO+kciOa7Vur+OyJiSHPIcqDeN018d66FR8J2MyI4f4pWpASOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/tYqyR7AHVcgpgMKDqvpjZ5oCafQgTOGvuoxdkO7XA=;
 b=nq/X69GH0Fms8f7vCfv1GG9XjTQRVuzzImXHXk5W+H0n/jlAsJZA118Ljn4Jk+vuMPm53iveBkxutzuPXN0K4LTV3ClDe0YcpanN2zYoUC007EbJylv+f+J3hKBxlARHZCrbNsdUdSAQIhgSV2Xc6p37jHc6M+/L7+nCOJxDCvywoAjuzILRblOG1X3GunA5iYmCECeHOHWjp6qQWrhXi9aGISB7Ti2GgucWdTxAA7bYCWrwLSjeUBiDCw0zcStX+u18Zx+plUx2IaiZBeMw7y3s4YPTpsu52zQngdK3hzW0oJaEdSLJSUyNrXOutaF8Yn/kDFOPvuhexhlDflnVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/tYqyR7AHVcgpgMKDqvpjZ5oCafQgTOGvuoxdkO7XA=;
 b=Y25LbSlwO6+MKdTUtjUtdR85T0wqcu2qLVkp3QrL0JF5YnQ5lF2/dBi2dNr/qJOAk5VmISs+S2q0PQDtJkyWTzA35IdafdeutoJiNT/pkIVOCjn+yrP584TGHwRlYRqicTU38aBEgfrNc3pL8SdzufxlLSG8EFLU/btGLxrF8P4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6734.eurprd04.prod.outlook.com
 (2603:10a6:803:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 07:36:29 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 07:36:29 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux@rempel-privat.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firmware: imx: Save channel name for further use
Date:   Wed,  8 Jul 2020 10:35:55 +0300
Message-Id: <20200708073556.19188-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
References: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 07:36:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 871cff37-bc8b-4ef7-ec31-08d82311a106
X-MS-TrafficTypeDiagnostic: VE1PR04MB6734:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6734B43BD16EA4CAF95825A9B8670@VE1PR04MB6734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEN2nt9UmYTUj3adBm1jWoX02Tq//Vvd7s7iOMRyhHa9GBVerkBHBS+8Wx/Hfyfws8FPDWVXl68i4ifFxqpOjiG6xfXd/GeAgnViazDML7XnnKXBmSOXVSoyiQxZfZ/Uvz2cWg8PgljtRXvVl6/qV+g2q7Y1kR9kozu9TV8Ae8J1d5aBpAm7ub0tPWxATNKR0x3mO3cPcn7BSkmV/DR+5u55BanFzHfhqxX1Zyw93Ga770qdOR9w3IXcY2LQTHKA15gbtT8qq7o3Eq/rMHc3jHJX12RI9D7rGL6a0PT45ArLrprgV1dqyXTrUW6atSwYtLq+8JSVGlNumDteJBLULA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(26005)(8936002)(4326008)(186003)(6512007)(16526019)(86362001)(8676002)(66476007)(66556008)(6506007)(6486002)(52116002)(478600001)(316002)(66946007)(1076003)(6666004)(44832011)(956004)(2616005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qXymWbUgZyVX+tlI6x1t2mruIbEM9jm87eEkrAT2txSqa24QKA9lBlYz004q6E4SIpzF4DwX9NpuSdGkrHQSUen/ZfARsg5I5KOpPSXo38DpHRuUjK4tUXrsAFjyVnZXQ5mMrPqkk7N0IMqkLqSI5u8rApiSc2avh/w4WfSVFIaNU080NUQSD4nUeEZ9CRgYcqbtTBQSLWZo4/MUMLi98i7JDGz/tJRFZhHUtj3wuLkXA5j5AOB98xEXTOSsaIPLMwN6Uc8JAfZxbp9IF/GHFrxFnTd7FhBCB+wyARUMcUwftUe+95yi+SligK7E7z2of51BvPrT2lrG5Qgmol8Qe4AZ496XeMELHpLFmv1gHZwCLh8l/n+sFqqg85gmuJdaxkouxHaem53ScoScpF8QoythRZ4qnEwUPeZyspTMzmxZIwrXkrOWdfoL69Nq6RWiN5hza4FmNcH5swH1xe2+v8hZTx3FgJ8g3RLgkve+/GM=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871cff37-bc8b-4ef7-ec31-08d82311a106
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 07:36:29.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M6oOps3JgVy70qNaV9QH1oVRgkT4tBlBRe2VgadFyS6UF97vJ7ILqhK2SLa6OZwnJoqQqiczUQ1zgi8ctlBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We want to request / free channels on demand later in order
to save power.

For this for each channel we save the name and use it to
reference the channel later.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a3a018c87b52..b6e95d6d34c0 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -79,6 +79,7 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 			return -ENOMEM;
 
 		dsp_chan = &dsp_ipc->chans[i];
+		dsp_chan->name = chan_name;
 		cl = &dsp_chan->cl;
 		cl->dev = dev;
 		cl->tx_block = false;
@@ -97,16 +98,14 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		}
 
 		dev_dbg(dev, "request mbox chan %s\n", chan_name);
-		/* chan_name is not used anymore by framework */
-		kfree(chan_name);
 	}
 
 	return 0;
 out:
-	kfree(chan_name);
 	for (j = 0; j < i; j++) {
 		dsp_chan = &dsp_ipc->chans[j];
 		mbox_free_channel(dsp_chan->ch);
+		kfree(dsp_chan->name);
 	}
 
 	return ret;
@@ -147,6 +146,7 @@ static int imx_dsp_remove(struct platform_device *pdev)
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
 		dsp_chan = &dsp_ipc->chans[i];
 		mbox_free_channel(dsp_chan->ch);
+		kfree(dsp_chan->name);
 	}
 
 	return 0;
-- 
2.17.1

