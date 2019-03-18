Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FDC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20AD206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgC1Qn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:56 -0400
Received: from mx.sdf.org ([205.166.94.20]:49890 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgC1Qnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:53 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh8dN003041
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:08 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh8XV025558;
        Sat, 28 Mar 2020 16:43:08 GMT
Message-Id: <202003281643.02SGh8XV025558@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 04:22:17 -0400
Subject: [RFC PATCH v1 06/50] ubi/debug: Optimize computation of odds
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not only is "prandom_u32() % d" an inefficient way to obtain
a random number, but "prandom_u32_max(d) < n" is an inefficient
way to return true with probability n/d.

Where n and d are compile-time constants, the efficient way to
do this test is "prandom_u32() < ((u64)n << 32)/d.

If n == 1 and d is not a power of 2, then 0xffffffff/d == 0x100000000/d
works just as well and avoids some 64-bit arithmetic.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/ubi/debug.h | 6 +++---
 fs/ubifs/debug.c        | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index 118248a5d7d48..d19671c1a098c 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -73,7 +73,7 @@ static inline int ubi_dbg_is_bgt_disabled(const struct ubi_device *ubi)
 static inline int ubi_dbg_is_bitflip(const struct ubi_device *ubi)
 {
 	if (ubi->dbg.emulate_bitflips)
-		return !(prandom_u32() % 200);
+		return prandom_u32() < 0xffffffff/200;
 	return 0;
 }
 
@@ -87,7 +87,7 @@ static inline int ubi_dbg_is_bitflip(const struct ubi_device *ubi)
 static inline int ubi_dbg_is_write_failure(const struct ubi_device *ubi)
 {
 	if (ubi->dbg.emulate_io_failures)
-		return !(prandom_u32() % 500);
+		return prandom_u32() < 0xffffffff/500;
 	return 0;
 }
 
@@ -101,7 +101,7 @@ static inline int ubi_dbg_is_write_failure(const struct ubi_device *ubi)
 static inline int ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
 {
 	if (ubi->dbg.emulate_io_failures)
-		return !(prandom_u32() % 400);
+		return prandom_u32() < 0xffffffff/400;
 	return 0;
 }
 
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 0f5a480fe264f..3d8d8eaea6c66 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2444,9 +2444,10 @@ int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
 	return 0;
 }
 
-static inline int chance(unsigned int n, unsigned int out_of)
+static bool chance(unsigned int n, unsigned int out_of)
 {
-	return !!((prandom_u32() % out_of) + 1 <= n);
+	/* RHS is a constant expression */
+	return prandom_u32() < ((u64)n << 32) / out_of;
 
 }
 
-- 
2.26.0

