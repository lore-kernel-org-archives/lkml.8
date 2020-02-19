Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA8C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0383F24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kTBKUSFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSHdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:33:55 -0500
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:59040
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgBSHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:33:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+1R8zP4ZeWRwjJYN4W0F+D4jWmJyznrNZATteGMdZPCiLPUpThexAo6W4AHUeK5oDS0Gdu0jBymWg3J+VH29I5DPHirEMWjoB4lkv7i0gjVqSKaniS8hzdtjyj/HtMq1xwKPMX6w3nb09ErF4vjaQqSTyxJbk6qeR6ymWoSNMbMRYa24mkaFqL/Bfg7bA/fbgAMxAq3/11a9JyXPtCFUrLMF5gZ/gBlvJI8F4reehzdjRQqk1vrqMRQwHWhFwtj8ZwxsmALWZ2M0Ffhczt9mK0RdiiYqxt4NFWx4TBxnFrZ15clOa3BuhvCk1CytG7tL6HUq3PiFb+xEYVamEbVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qCILug04ayhEfedFyILsM0cXXdxMb0n+5FQBhiCtvo=;
 b=kmQE6EGLhdgKcb+PlpgHB0+8cNeNYwcNAMM3MvtawHuR/zKP/wEKHRtlPi2bHqhH8RtD+X+S/R6OZMWtqCa+0jqMdQ5VLeN9kS+zey9sA9nUx5522uoadvCLZrKi9t0eeI5kpFItcmaOkIBZwjzHzBuL66AIjbIrWMvUYbH3+7SboGKea+6VhzrpSIqaNBNcnnsNIyYIbalydqOMV4c5D8ErRb/ZMMzFvvngQBIXqysCQhWc3zEWpQqUkA3yZXeDcHD/awwk8zEU66wu3fF/7fgAZyTBUQSf4Hm65ozd3Z8tmonviwrF0nkg0jRIrJeDO3FqzQxFEBuzV4mdT7pX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qCILug04ayhEfedFyILsM0cXXdxMb0n+5FQBhiCtvo=;
 b=kTBKUSFERZVNTrKCdzLjGmo+d+bFw+30BQJ6WugXtt4ujWB4wjmv+FXFCBjvRovnYwDBjtAh6sgYK4jSNUqBp6SloyZPUwpX+0GfwuV7wXGN3tNfByepeUBzqEmHzBJqitJfK37N5r2aKsldFe9eW/NQ6TYfGuxOI84Kf5Hq5tg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3969.eurprd04.prod.outlook.com (52.134.95.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 07:33:50 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 07:33:50 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/9] remoteproc: add support to skip firmware load when recovery
Date:   Wed, 19 Feb 2020 15:27:39 +0800
Message-Id: <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2729.23 via Frontend Transport; Wed, 19 Feb 2020 07:33:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13e3cbc9-b313-46e1-1dd1-08d7b50e1026
X-MS-TrafficTypeDiagnostic: AM0PR04MB3969:|AM0PR04MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB3969EDDE27632E931F1C72E488100@AM0PR04MB3969.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(66556008)(66476007)(8676002)(478600001)(186003)(52116002)(956004)(81166006)(81156014)(7416002)(5660300002)(4326008)(2616005)(66946007)(8936002)(16526019)(316002)(69590400006)(9686003)(6666004)(36756003)(2906002)(86362001)(6506007)(6512007)(26005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3969;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I6HbkX6Ll/Dm/0MgNppX+vD54De+DaHoCUDBj1OThOlti9GLYfXGGOUJPeOpDypnQSTxDRIYFKrPKwZyXV1WhGoorhwPOC5EESB+jSubFqVjLmeSQH5ziCiFrDMzL7se27BHKouJHCDZwIZvd0ES0GH2YpcG9Zhk+GYAbVzshwrZeycGxuYZUGJmnFOb21WGXmCff4FQL6GagfrP7Pvil2ks8mAEXBq+hrG9Y+QedZbc5lZS232fjVEQB8cOE0vUsXgxg/UZlbAKf8z3928oxQjDqE/hqp8LBEMRH5gqXkROQW8h0wZyz3kLQ4munSy/4eAaGTjUcJq1R6NnXMfKzNzwUEMDYe3KxyZIiFu5zpv0wtbc7sFh2KBnTpvj1K9L/JKhxnjHG/PHaf22EnjFPhE/kheyO+ZW2GoOT1okZL1g4C3+6//9tc+QyX4UAQL8mEg1w8oQepm+WCFLutgO4BZoVZjEnlW3u7I0ooNFO6KxuNT5TZvS6o5mdrkbSt2mOOSvmKY8lScFG8ii+VrMK1ldWBwuHDT7Dg3Ae4UnC0=
X-MS-Exchange-AntiSpam-MessageData: /SCSUIRJHQLQY6XpjGsXwoGiyDG2RzPGBBldfAnDb16BwMcyGxjDTN7jVn2hCUk12kuXoY+1YJTd2N616rcMhrbK6FI4lcHELBUF4WbU0lQUlvaOlIUf4bDpYu8dv2J+ms/8/K9/c+SSe4qCf9uJQQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e3cbc9-b313-46e1-1dd1-08d7b50e1026
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 07:33:50.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bskIFBC9QqxDLcNAOAz3VgsR2GPMhUAQwPsPWjCcJc/1Y+CbJ45EKQkVeh4ej6v/ImhTDNdzyCKdcwLgEPV1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Remote processor such as M4 inside i.MX8QXP is not handled by Linux
when it is configured to run inside its own hardware partition by
system control unit(SCU). So even remote processor crash reset, it is
handled by SCU, not linux. To such case, firmware load should be
ignored, So introduce skip_fw_load_recovery and platform driver
should set it if needed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_core.c | 19 +++++++++++--------
 include/linux/remoteproc.h           |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 876b5420a32b..ca310e3582bf 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1678,20 +1678,23 @@ int rproc_trigger_recovery(struct rproc *rproc)
 	if (ret)
 		goto unlock_mutex;
 
-	/* generate coredump */
-	rproc_coredump(rproc);
+	if (!rproc->skip_fw_load_recovery) {
+		/* generate coredump */
+		rproc_coredump(rproc);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto unlock_mutex;
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto unlock_mutex;
+		}
 	}
 
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
 
-	release_firmware(firmware_p);
+	if (!rproc->skip_fw_load_recovery)
+		release_firmware(firmware_p);
 
 unlock_mutex:
 	mutex_unlock(&rproc->lock);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 4fd5bedab4fa..fe6ee253b385 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -514,6 +514,7 @@ struct rproc {
 	bool has_iommu;
 	bool auto_boot;
 	bool skip_fw_load;
+	bool skip_fw_load_recovery;
 	struct list_head dump_segments;
 	int nb_vdev;
 };
-- 
2.16.4

