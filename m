Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1063220731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgDMSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:04:37 -0400
Received: from mail-oln040092254020.outbound.protection.outlook.com ([40.92.254.20]:38784
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387498AbgDMSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i27PcqwQwo6ST88bBKBBCWjszPJ4+FcrrPjlUER95O3y6MVy2rN6oRVgkOsoMehjISuZwR0uchUIQLlipxz7Mm+XCIyw5lJr899k9C4OiKpopMY0CH7dbLPpdO9n7Nmw4AmKcqmRBe2E6nY60KtUgzPOdLi0BGPkQoGAHZDc3PsgBHdEo92LkLOViOLJUIaKjZSiExkiy10L6k9MNeAgYziRFgbD7jOY6UuNOMHa1CBTghAieSmvUKMAXrtXI3Ya7A7TJEhxSK1hzfdtUG4Zwz59Ci9MVYSCglqyTmxl9UydZA/Fos3olMLoTOvLy51ErC0H6Hq/DK8w/+C574hk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlfE4xARznZFmm0M0TpPvr1DCWp4D+qI4YHqZkGg+uY=;
 b=M7F6bf4jqP9JvR4k8AxdMvQgZltEYwStOnbpfXk6bIduxiK78shAowav/L/BXMiDzZErOJXMn8aN50rzIG2ZCaUwvik5zS6W9AR6OicZ6VLDFl/kaH3hqIwM2Aup6XzzRl3nH64ONXZrZNy7tsHiSJlqZcFIBaWgWYdOpttboXTAdeXi883JjpB7ZRy7tWjG60E1IA1E2EeNlhGVKzshAWZDD0fFQ/hjfMHT2cC3JDrnyW5SuwXEgQsOwqzmeeQQW8JzWCp1xvW4UEoG64gr+e5ooUW7x787rnV8aWW8ZHmvuIDRKB47y/FIzqcaN3BSL4sZAmR8f+ejRytK0INqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com.au; dmarc=pass action=none
 header.from=outlook.com.au; dkim=pass header.d=outlook.com.au; arc=none
Received: from SG2APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::43) by
 SG2APC01HT151.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::384)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Mon, 13 Apr
 2020 18:04:32 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT043.mail.protection.outlook.com (10.152.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 18:04:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B353F5DF6C22FFD5D8D6294B4AD2CDF6C17A36120202157386813D0421A08460;UpperCasedChecksum:6C7FAF9E459679F39061A713D85F60D67598732CF84D4564A4A8532D01664154;SizeAsReceived:7754;Count:47
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 18:04:31 +0000
Date:   Tue, 14 Apr 2020 02:04:25 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 1/1] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <PSXP216MB04389E900D109FC827A5752580DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043820634A932AF06774C0FC80DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
X-ClientProxiedBy: SYCPR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:e::14) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <20200413180425.GA3827@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:44b8:6065:1c:e5c1:ae4c:9b9a:39cd) by SYCPR01CA0026.ausprd01.prod.outlook.com (2603:10c6:10:e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 18:04:30 +0000
X-Microsoft-Original-Message-ID: <20200413180425.GA3827@nicholas-dell-linux>
X-TMN:  [yb96uwxJhJXy0T/MgvyOJWWBkaTR1zvKkI0oLkOR+GUq8ydkG3jEplA81DgjojU2]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: bffe1539-3ddd-44cf-5340-08d7dfd51d94
X-MS-Exchange-SLBlob-MailProps: mBy7Mai7yE6wDwT6hjU0HJYZjVe3E50DNbVAzgsbW0/PPnsN6xpZg0gY8KyxNrDUL92moUgLd3xrSncgfEeWl1e0AfM4EwBY8FmPr6xXhQDK3dhDJ/CKCtIVwMIAFKBQ1enrSGoh/yWTQYTwB9kf/V/bStInd2pt0SQGFa8U+SG13D4iF+8XGMFUkYgqc3sRIFz+b3ridzhEvcP1JWnay79v9ajOsfJdOCP5fzTPc5HySpYuhP1IAcn8vo4fFmDbUii7v/GzfylcgrTJvgDq7WRFjM00VG3BII7ItXC1RHGTCqsU5rV79RFntvunWxBQUkEbb8nTsknwB1k7pI97XnonPwx5XJiMGkcIf9yurejGDfYnnpiDlSXymcyVuOdvlE+um5MHPJJXMAx+VHjkxA+gTpr92/UbXSKgu/ddbqPfleYoJnBjokN9b7Wkk+EtD9wMaOFNxpCFAurKplKB73uxlSgdXvjY+nBAfdVyfPfm1rkhJwd9VxlmFcD/43RKLnfbmuOUPhowcwGh0PNVQ+WTYzUp+sV/VWfW9RQtoUV3ZVMpwwszF8KFq8+AW5qzzNv8Ks6ydEs7LR6XYXIcomxhC99FJBHi119EgnoVSj0G6tiIVqNZy9LHsjSJ7HXZFUBv4FNUSjrT81jmPVICIACfsZxFx0GEd/UfaRahP2tyqHPvvs3J/ZvaNTmiVImkBEE0JswX5YCwox5mNygnCeIlAj7P9dY0
X-MS-TrafficTypeDiagnostic: SG2APC01HT151:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POxUPgq5lToqimePJNf+ieCx/1LLxm6rsn7cRF6wFWjl70TJhfPg6PnHyI/mbsGnLdZEYE2A5y3h9EY3Ag2CfJ9VZxlPlTr6Xl9N/UjAfbIDn8ojyxSc0TpsRE2BIim21aMsiUfgmzriVsKOz9DNJall/WT+uMy+5UkzqS6whUuJCYIGK6l21VNaI08jAvWt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:PSXP216MB0438.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: cKc+ndr97j4xzSPBabN05C07QkdhHB+54r61andAWUOkbdhLhzc7rVlxN3DNdkSKRMlCMGGVs8LHy5g0Nxl7qAExzxePUUOnyNdMlWk2IyJoOy5s9bMwem9ves5H1YobK6LVH4KIrqB58mPw29m63i67Jx3l0zBlYcgFRn4kdt+nTvTr9UXKsWqn6GiylA+dSVCT/W0riwUIpXZxpq3QHA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffe1539-3ddd-44cf-5340-08d7dfd51d94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 18:04:31.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.

Commit 664f0549380c ("nvmem: core: use is_bin_visible for permissions")
incidentally adds support for write-only nvmem. Hence, this workaround
is no longer required, so drop it.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/thunderbolt/switch.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a2ce99051..1ba4050f6 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -348,12 +348,6 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
-static int tb_switch_nvm_no_read(void *priv, unsigned int offset, void *val,
-				 size_t bytes)
-{
-	return -EPERM;
-}
-
 static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 			       size_t bytes)
 {
@@ -399,7 +393,6 @@ static struct nvmem_device *register_nvmem(struct tb_switch *sw, int id,
 		config.read_only = true;
 	} else {
 		config.name = "nvm_non_active";
-		config.reg_read = tb_switch_nvm_no_read;
 		config.reg_write = tb_switch_nvm_write;
 		config.root_only = true;
 	}
-- 
2.26.0

