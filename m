Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9551C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6AA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lr2wbsA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgG1Jfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:35:40 -0400
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:62191
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728130AbgG1Jfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:35:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3FbfMmrlwIPe+O7PUwgrCKFGicyQdGG0Eaz5EHHDqTEjsaNvbhX1uR2iNNN3YRJHeB09WV7FZuqu/yUTVbiC8x3cr2sWwst/BeVJb3JSH5q4zR5odfUDHAVX1DSxV9mRLLSmBJCKHEAJw0qIMpBZpcRnA79yTG5yIIYAc2WAVAX+ku7BtEd8Nkek5LsYVXB9g9ptEbQpE+4VrOZHuNTRh5SX3c2ULDPYaV/XGtOsJ6zSkumSkE1L2FRBkaq1oeZ0YishIwxPM6f7HCA9HKe74xGcuApJ5nK0v0OjHHHiHUCEjPS7boW8rvHX9g6DdxCgcQngl7jOhQnxPMJnftHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfRm6nqee1zmGaYQWM9juc8qUzO05Kv9PEjJTwzzaOI=;
 b=UsmPSvwi+09IHZ0C3JrwvwEwr9yslA9HTrlLNUNqJJ8PUZe/16l7KLhqSKhEYk7gVjRAhpn6ioub5iSkFCAgcgEdUci70V7SpqzYLlUigtMFEGEH1SYAZ45ha71OhkAs3BIXqh7yuuUrsl4b4jcAKFE5fJJhQVGURtW7uyaKu0bx3kJ0z4aaOzLfGyB5lziQMmU4Z38WKysjxLsHd8ZtOPQaJ05HRwqrP7p9fcfdGTz4I54XhFS6bUb8uXRtoYAwHSm0cbf6SE7BxiOWRZUZIFuhyDtSyzU4oAN9gY9ai/ZVej0RrJiqwDWZwFoJykOGL9uctaGPaSb3/kvPNxClhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfRm6nqee1zmGaYQWM9juc8qUzO05Kv9PEjJTwzzaOI=;
 b=Lr2wbsA5mJR8WUQOWnWbP4L/LpypmgIpHhDS0Dc3YZbxrKwHo5w1lJ4C/lTy+9hBIyAtTl+SKNjSsD9EX1ibPUUW4kpHYgLWcBd/FH3sGEMoxmfaQ9NE+8XhprMGufIJDrf7W2MlhWL6LEA+/A/4Hu3Cj5LO8PMN/6dhPSRxIdk=
Authentication-Results: wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 09:35:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 09:35:35 +0000
From:   peng.fan@nxp.com
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, mathieu.poirier@linaro.org,
        o.rempel@pengutronix.de
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] remoteproc: elf: support platform specific memory hook
Date:   Tue, 28 Jul 2020 17:31:12 +0800
Message-Id: <1595928673-26306-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0101.apcprd06.prod.outlook.com
 (2603:1096:3:14::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR06CA0101.apcprd06.prod.outlook.com (2603:1096:3:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 09:35:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2776d49a-1e91-41b2-de18-08d832d9949b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4490D0DD141B51E2BA21CF3288730@DB7PR04MB4490.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zdRTzd7IglJQ4JbGK9wQbPZItBu/NG7gXi3CUAuv1rAmp6+cEnpL1+zTbyHsLz5IgB604mp/riCw7DNgAajufzTBfoVFXVHO/Q3LfMCHr/bs7r3tjDhtHVTCaFsf7KvHnFhsJtOc3Aa/9PtipY+yPfn+gtT1aP9hy7T/VUwruS8uM+6EYAVoyVE9y6JkTYu7w5v+de6NGH8wx75WGrSY75wFqFuvZBfNKqUSlbAl9UOTUKHg4QD4MZtcU10ctuM2gbtywm3ag0wH6qilgTSBDudJl17TL5d3gsCv4VPMyhUm55H4ZgUl6R171F6aptzWRX8BxfMvAiOJkSKaNmvEjd5robgN/jkaVEXqgEoeeB38c4y1bIlwG7iGBt+8EI+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(186003)(956004)(478600001)(6666004)(16526019)(2616005)(36756003)(6486002)(5660300002)(4326008)(316002)(52116002)(6506007)(7416002)(26005)(8676002)(2906002)(86362001)(8936002)(69590400007)(9686003)(6512007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PlwMI6gbTcuYwA7fUFmrElSuN/A77UXphxaXzuJVNRqNg0dd2FYwI2sm7n8EATwqAVoL7mCgR3b5HI/ulHm30TEq9nPoPrDgqPLAEOIMzesCnMyyPSm7naE5FSNKHrVzlk3DwoC6qeU9NK+X620TvAgveys5zw1k/ciA/UKM2OR9A7OhffMIUa94XEkvFAzZ0JswEwUqtpNqZv4XpanRanmnfDbZauSDQvzkuWZqNqNBDqBBbCyY238WrwWehr+SMwhW7l5e3wNW7kMh0e/iIMZfHpDpXrrsNDU4eaVYc1j12S6MZv3RFgm1S8YE8mCaYjO5Dr00Iaq1gv6sE8WBoIYe/AoTumHzd7veqWzQ6p+bDXqe3AzNqL9i3PMqonFqaLBX4Iaq4p5Wbn0mKyhWEkL8g8MV5XIlC+hGzBImMH8F8OlGXxVUMTyoqI5bTnlQFnCEFuknY0OGwHnF4HgLw1h5Kzy5vuM+0653m/QdpS/PbMs8Rb4ptiD70HYuzab4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776d49a-1e91-41b2-de18-08d832d9949b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 09:35:35.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zACKdwNM1dfvdkVsAlNc4N5kb4oDUJkUzc6uPQXLd1VT2gNZL1iALyO1+k6YxwWfYN8bksTDGrx4nbaZRMWAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To arm64, "dc      zva, dst" is used in memset.
Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,

"If the memory region being zeroed is any type of Device memory,
this instruction can give an alignment fault which is prioritized
in the same way as other alignment faults that are determined
by the memory type."

On i.MX platforms, when elf is loaded to onchip TCM area, the region
is ioremapped, so "dc zva, dst" will trigger abort. And ioremap_wc()
on i.MX not able to write correct data to TCM area.

So we need to use io helpers, and extend the elf loader to support
platform specific memory functions.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 20 ++++++++++++++++++--
 include/linux/remoteproc.h                 |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index df68d87752e4..f442bac64432 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -129,6 +129,22 @@ u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
 }
 EXPORT_SYMBOL(rproc_elf_get_boot_addr);
 
+static void *rproc_elf_memcpy(struct rproc *rproc, void *dest, const void *src, size_t count)
+{
+	if (!rproc->ops->memcpy)
+		return memcpy(dest, src, count);
+
+	return rproc->ops->memcpy(rproc, dest, src, count);
+}
+
+static void *rproc_elf_memset(struct rproc *rproc, void *s, int c, size_t count)
+{
+	if (!rproc->ops->memset)
+		return memset(s, c, count);
+
+	return rproc->ops->memset(rproc, s, c, count);
+}
+
 /**
  * rproc_elf_load_segments() - load firmware segments to memory
  * @rproc: remote processor which will be booted using these fw segments
@@ -214,7 +230,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 
 		/* put the segment where the remote processor expects it */
 		if (filesz)
-			memcpy(ptr, elf_data + offset, filesz);
+			rproc_elf_memcpy(rproc, ptr, elf_data + offset, filesz);
 
 		/*
 		 * Zero out remaining memory for this segment.
@@ -224,7 +240,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		 * this.
 		 */
 		if (memsz > filesz)
-			memset(ptr + filesz, 0, memsz - filesz);
+			rproc_elf_memset(rproc, ptr + filesz, 0, memsz - filesz);
 	}
 
 	return ret;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0e8d2ff575b4..88fc9643c1a8 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -391,6 +391,8 @@ struct rproc_ops {
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	void *(*memcpy)(struct rproc *rproc, void *dest, const void *src, size_t count);
+	void *(*memset)(struct rproc *rproc, void *s, int c, size_t count);
 	unsigned long (*panic)(struct rproc *rproc);
 };
 
-- 
2.16.4

