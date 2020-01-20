Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD611C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EAD20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgATBY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 20:24:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56118 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbgATBY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:24:26 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B1DED1496066D6CEE24;
        Mon, 20 Jan 2020 09:24:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 09:24:17 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <perex@perex.cz>, <rafael.j.wysocki@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] PNP: isapnp: remove defined but not used function 'isapnp_checksum'
Date:   Mon, 20 Jan 2020 09:23:31 +0800
Message-ID: <20200120012331.34776-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc '-Wunused-function' warnning:

drivers/pnp/isapnp/core.c:752:29: warning: 'isapnp_checksum' defined but
not used [-Wunused-function]
752 | static unsigned char __init isapnp_checksum(unsigned char *data)

Commit 04c589f35bc5 ("PNP: isapnp: remove set but not used variable
'checksum'") removes the last caller of the function. It is never used
and so can be removed.

Fixes: 04c589f35bc5 ("PNP: isapnp: remove set but not used variable 'checksum'")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/pnp/isapnp/core.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 179b737280e1..6c457006e84b 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -746,28 +746,6 @@ static void __init isapnp_parse_resource_map(struct pnp_card *card)
 	}
 }
 
-/*
- *  Compute ISA PnP checksum for first eight bytes.
- */
-static unsigned char __init isapnp_checksum(unsigned char *data)
-{
-	int i, j;
-	unsigned char checksum = 0x6a, bit, b;
-
-	for (i = 0; i < 8; i++) {
-		b = data[i];
-		for (j = 0; j < 8; j++) {
-			bit = 0;
-			if (b & (1 << j))
-				bit = 1;
-			checksum =
-			    ((((checksum ^ (checksum >> 1)) & 0x01) ^ bit) << 7)
-			    | (checksum >> 1);
-		}
-	}
-	return checksum;
-}
-
 /*
  *  Build device list for all present ISA PnP devices.
  */
-- 
2.17.2

