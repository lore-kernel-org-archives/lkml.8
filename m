Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6049AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E78C216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aCPQy7fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIHKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:14:08 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:22439
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728137AbgIHKNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:13:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/ePwKhOcxX8WAgymyfcRbiPQ+rqPCUVUxb+neHQ47SveD8ywLCn8njMyCsG/70hHtFUPpw97HpLz51SLwAsx2xNCK5n3AgZPy+cfWMvQr8cXoWjrmD8DRWw/Fr/5TO5t06zE2t9kyrNXgMEqnE9GGhfEWJIvz/n7zPmkcROiREtOGbUOB2WZ7JI2Ifye9IK4b7X6/QhpfnVsyRwL84g7DrJI9+Rwdwk4IM9kNTje+DR/beHgH6DLXTEZzl7zjWMzha/tC1i9FFbzvJfVT/vP3kX4WEFsNaKUmCwiVWOF7JIJML5p+ma9ZIhenIXcOMZ7GUHPopddSiUias9jOE32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCiT4REc0nG3TmvPSa+/XSIhaZHwKH+zkES3VWoXkug=;
 b=amAGgUXII50aG63/mEb4gA27xu2/rsCI+yEKjhgPtt2JF98wfmuUCS5vTJQ5Sz2abWyDBSaCSCs8hPPznLPy8YGyE3gmYdsapiuxpTAQCPv2WjiFVpFPbefP5I4T21+CPeVdgSLRRNSU9+a+9kebR4UGV5kxcXuu8lRdpwkOplGQdl6JVOgwhqThB4i5BKsS4l8S8EvStGeSs4O3WpIpcds8/V7UFICrPSROJmno4WvMWbgORB+STuJujp4gDJyztlyI0Mg3SE1g1m5P3WJVcaDIVOqZRsnXkFcnOnrZ3nyU+mNSDcMRlKHsPKl41HXIBne5VwiqthWIkGMphNW1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCiT4REc0nG3TmvPSa+/XSIhaZHwKH+zkES3VWoXkug=;
 b=aCPQy7fziEzobR2q17j2BxiPQO6jVtuUYbZKdlzgLI9bse9Z2u81ZS3k9WGBm9yxx3Xrk4Tq6NLcUGwa0fcBCN3SCsDmFIBLZictoPqX5r56/VfjNw4RKRxS8eM67zBTjP9W82CD3Toec0uwQDKBSXcGR6wajLg9ZOA9jv7hMQs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3659.eurprd04.prod.outlook.com (2603:10a6:8:5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 10:13:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 10:13:29 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: imx: scu-pd: ignore power domain not owned
Date:   Tue,  8 Sep 2020 18:07:01 +0800
Message-Id: <1599559621-1397-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 10:13:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c70527c-9b7e-4d48-edec-08d853dfd51d
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB36595C71688CBB060F9DCA9588290@DB3PR0402MB3659.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmC4smHnwBIEVNgnBd6nTEHnV2MivUC49jPOjhD3sgHXOiclRVWqk5eGIlSY8XvOOQHRceaqh/VDDNp2uK8Gz/4WM6tA4E3QSvUeNIYAHcC9Htu+SFcFXJEHuSHxL4VAhg9UsnkcUsYw662RTpruPfVvAGFPfekxey0hLEDYB1oi7oPIuedm7YEgWCEHaU3uk/PSo78xp/g2Nkx6HdTzPJKH+dMEV1/6d0UbF1uOMhI46vGmxEtlOn8kN76oQRfNuwmutmmo1cuMye1BSJ6ocv5y6ETFoMQoz/rJefRnION9sYkOU98imH6Ssmy0chcwX+Wrx9p4yxAdP0uJGNXPSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(52116002)(16576012)(36756003)(26005)(478600001)(6666004)(16526019)(186003)(5660300002)(8676002)(83380400001)(9686003)(956004)(4326008)(6486002)(66476007)(66556008)(8936002)(316002)(66946007)(2616005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bZj6Je1GfARe+kXL+bB9G0sLcawEEwHz/8ZY/6qNuteuUMeBqyyEBFEpXdOZYqM5LXIF63Eog1RwLiyubdHTpHJwvvytC4nhXFCDKa9jT60Jq6pZ08hsM7hGZu78Ar5gixApO8Qzmcz/3QREMAiV+Rv06sAW6hzlpY2KglqK6rVwJRmkKTjlxMth1sPFfpbBGr/i5Ftu5sa5XW5YVCzOJABGpMwoyGQ0flekNM+kYxO94Cahv6oU/SYjSE8qVGZLTRVw3jgdBZbk2L3uEe+mJtgLNsb9dOOvAEZkMKi+S7tN9WmUV9nFCokYkrE8SpSgEkCBw73k6RQmDxPZX+A46OZbOe1mZTVbVbZqgjiXF7skydOLvKrcZpQ5uMYMPvN7uzAeQzIf+9mPlYXtAmHP4RqCS/J7O2ccLw3jHZVJEckN+PEbVpFokB2ksclFBioGji1nHt3T7Mokkl0q4j157fNUh0wHuXh99hxrvpEjPaPtCi6zJ05MdRg7wZywM0vlyF3YIiwuYU/W6tgkU9aYIzhI1vY8Xr7GkAorjWNbdgBU984lobJmVqvOb4lIatYRGcgQy93Vcun1v5jtDq6tIUSsTo7T3JklEOO4vKhPoEKf2Rib5T1iGJLem84dYOfYQmn2gcinvBh8CBB9F0Ti5A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c70527c-9b7e-4d48-edec-08d853dfd51d
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 10:13:29.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVsL+yNTFHVUGDek8IIx1HCj3DRbxvWdKIp/Va1POS3DoRoLVWT3wWuYvrUP+B64zF93JypTTJcQFqZR/PQC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Should not register power domain that not owned by current
partition.

Alought power domains will not be registered when power on failure,
we have to let CPU waste more cycles.

Whether power on or owned check, both need communicate with SCU,
but with owned check, we no need to run more code path to save CPU
cycles.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index af3d6d9ead28..946eea292b52 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -46,6 +46,7 @@
 
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/rm.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -256,6 +257,9 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	struct imx_sc_pm_domain *sc_pd;
 	int ret;
 
+	if (!imx_sc_rm_is_resource_owned(pm_ipc_handle, pd_ranges->rsrc + idx))
+		return NULL;
+
 	sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
 	if (!sc_pd)
 		return ERR_PTR(-ENOMEM);
-- 
2.28.0

