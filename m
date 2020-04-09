Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E83BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2003420A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ho+Unou0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIIax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:30:53 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:15185
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgDIIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itgO6Yl2q9bzKzCoEOJnnhRpG85pF4sIkb+Xi0cIMhje3yYr0z/Bav4FZsdKE54cp2oBnMULtc2j/ScletKliht4Gy8XpdU0+d0eet09Kw0VbXbFKbFSqdu9/oCkuvWpVvxvd/Y1Jeu+2GJE4EZH406vkSybrjZy8vqjnHodEmpjph38EOnfN598ohHrT+uDn4iA5gPX+Se9qpNxL1SC4qD15crkFpoz1yzN6zH/pgi+UgJLc77j07PuGWq1phA0hOYdJO5uVskbB3F4ENIL1e/hjX0t/YCn40QfB25QEVo4RT8hxqxvuiOIRD2qwLvvHhx02FePBpmD2S9ipGcKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r62mWGqiCmsuodBLyS/TbQ8Z47ejeC7MuH4KnTENGoI=;
 b=lgXz9XQ5pYm5xDwzrRYllwPQPNoGxmbOz6E6pCH5RYknQdqkQwEI68I8HXf2w3yo3PR2SFiOj2kFpHcZD65Tk0logn9sQhI0s82LKPKyX7fMP+7kBAvJjQeWIzYiWRKctGRYbLPme24rnpRWtmKaRVKTfxr9bNonqpC9DXpwaf8Gpt0C/5u7GI+zybP1a4fO7mmNqPydFEK5zpr5FAIZ2YzS0ZmGC2MGk5y74rgrCk2rI0x+AWOOcnE0b0TBmL5Y5Wz0JWJ2EDYtPcuOhsYWStSwnnyxIATQCH4DxJK4bLuOcaSXlcvuYRZ5ZhiY/JUDNu/jYSoLH0GmUz8IPDIO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r62mWGqiCmsuodBLyS/TbQ8Z47ejeC7MuH4KnTENGoI=;
 b=Ho+Unou0DfnKD49EfHUfkNgPcdA+s8Jpam5iM1sA6/ZzURgeA6AjC0mMt2E7/ORY5L5WNBPhrYnt9+B9Cw5PW4KArZ4iQf1D1Aj8cbSk4EWDyDUEiPdUCNSLo2oLKyzHc//ji4jzqB5OQdB7v3d/lgqKPpRiErNWOSodXhF9Gp0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB6626.eurprd04.prod.outlook.com (2603:10a6:208:176::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 08:30:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 08:30:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Date:   Thu,  9 Apr 2020 16:22:51 +0800
Message-Id: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0133.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 08:30:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1a87978-b1a2-4e7f-ae33-08d7dc604e84
X-MS-TrafficTypeDiagnostic: AM0PR04MB6626:|AM0PR04MB6626:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB662635AC2EB4C4122C119B9788C10@AM0PR04MB6626.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(6486002)(86362001)(478600001)(44832011)(316002)(2906002)(6666004)(36756003)(6506007)(66946007)(66556008)(52116002)(66476007)(16526019)(81156014)(26005)(186003)(8936002)(8676002)(956004)(5660300002)(6512007)(81166007)(4326008)(2616005)(69590400007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIC8FVJKBh4jaBz4esdgjZbu/6tPeQU+9cJcRDMbEZ5czykDXglF1EJ6Tm7cmV0iD0dnWRK9k942AHQkAiEcG9mu9KSm1rzW+51SxLj7mIWc7K25XArue2tbV53hJKFukdmiX0uu67leQ9TW4j/JcZxSAPBvUqvudXz/ZVLwuYDBnZ/5zaTuiDf931Q3SEGgxmXpN1UH6zRr/L9zuPHb/MpD2OsyyNfpGX5mrqVqxq4xRtycbI7y+KclLcJ7YlUOjdDXdFvPzEEa/ymZFaHRDbUahO2pOWKnDYT/IfPx7Se/zN+ojyZjOOYpBpkLM69CDpX5OzQmNSQpw4e2ju3cwN/AAW1uBVE3xqYfWcdj17ZDbiX+HMp6GMMRQ+JVopc9HBiV1/MFXjjusA+ukv43K32h8EBYcu471aFLwEpfCp1LP95fcDKeOAsFlSYr3Vpr5ZAnoU140Zvbd5w/2osbF257m29O0tKXyioE2VqHFvzqfPeq/l7Bfs1ukYBCCrvA
X-MS-Exchange-AntiSpam-MessageData: C0fAcnpNh53lA2gx1OxrGFLMR4cAPLyL2Z5ktLlQd2db+6EpkEUCNTxqG65G6l5BJBYIHX9kjDLC88g0LnAHunNHphXBq64bKvNTPT3gwLiXeBM95ISf9mFojJlheMb/8Qw1T9Py62nPmbZBLZWxqg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a87978-b1a2-4e7f-ae33-08d7dc604e84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 08:30:49.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fu2aQLGtfypnF4wLZR5CcTX6hmrSsAza6vjdCXjj1nfIq7NXdeL2KCrIMNhmXSw10Kt+2NAc73gqpuQ6W064Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To arm64, "dc      zva, dst" is used in memset.
Per ARM DDI 0487A.j, chapter C5.3.8 DC ZVA, Data Cache Zero by VA,

"If the memory region being zeroed is any type of Device memory,
this instruction can give an alignment fault which is prioritized
in the same way as other alignment faults that are determined
by the memory type."

On i.MX platforms, when elf is loaded to onchip TCM area, the region
is ioremapped, so "dc zva, dst" will trigger abort.

Since memset is not strictly required, let's drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 16e2c496fd45..cc50fe70d50c 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -238,14 +238,11 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 			memcpy(ptr, elf_data + offset, filesz);
 
 		/*
-		 * Zero out remaining memory for this segment.
+		 * No need zero out remaining memory for this segment.
 		 *
 		 * This isn't strictly required since dma_alloc_coherent already
-		 * did this for us. albeit harmless, we may consider removing
-		 * this.
+		 * did this for us.
 		 */
-		if (memsz > filesz)
-			memset(ptr + filesz, 0, memsz - filesz);
 	}
 
 	if (ret == 0)
-- 
2.16.4

