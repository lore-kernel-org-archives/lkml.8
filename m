Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A74BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552892073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgC1Qpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:50 -0400
Received: from mx.sdf.org ([205.166.94.20]:50018 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgC1Qnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:32 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhJkQ015420
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:19 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhJI8005124;
        Sat, 28 Mar 2020 16:43:19 GMT
Message-Id: <202003281643.02SGhJI8005124@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 17:12:18 -0500
Subject: [RFC PATCH v1 32/50] lib/test*.c: Use prandom_u32_max()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/reed_solomon/test_rslib.c alreasy uses prandom_u32();
lib/test_hexdump.c and lib/test-string_helpers.c were using
get_random_int() % range, which is needlessly expensive for
test code.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 lib/reed_solomon/test_rslib.c |  4 ++--
 lib/test-string_helpers.c     |  2 +-
 lib/test_hexdump.c            | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 4eb29f365ece0..58e767c142ef8 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -183,7 +183,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 
 		do {
 			/* Must not choose the same location twice */
-			errloc = prandom_u32() % len;
+			errloc = prandom_u32_max(len);
 		} while (errlocs[errloc] != 0);
 
 		errlocs[errloc] = 1;
@@ -194,7 +194,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 	for (i = 0; i < eras; i++) {
 		do {
 			/* Must not choose the same location twice */
-			errloc = prandom_u32() % len;
+			errloc = prandom_u32_max(len);
 		} while (errlocs[errloc] != 0);
 
 		derrlocs[i] = errloc;
diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 25b5cbfb7615b..3349f3ddc528c 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -398,7 +398,7 @@ static int __init test_string_helpers_init(void)
 	for (i = 0; i < UNESCAPE_ANY + 1; i++)
 		test_string_unescape("unescape", i, false);
 	test_string_unescape("unescape inplace",
-			     get_random_int() % (UNESCAPE_ANY + 1), true);
+			     prandom_u32_max(UNESCAPE_ANY + 1), true);
 
 	/* Without dictionary */
 	for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 5144899d3c6b8..54e4efb28b974 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -149,7 +149,7 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 static void __init test_hexdump_set(int rowsize, bool ascii)
 {
 	size_t d = min_t(size_t, sizeof(data_b), rowsize);
-	size_t len = get_random_int() % d + 1;
+	size_t len = prandom_u32_max(d) + 1;
 
 	test_hexdump(len, rowsize, 4, ascii);
 	test_hexdump(len, rowsize, 2, ascii);
@@ -208,11 +208,11 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
-	int rs = (get_random_int() % 2 + 1) * 16;
+	int rs = (prandom_u32() % 2 + 1) * 16;
 
 	do {
 		int gs = 1 << i;
-		size_t len = get_random_int() % rs + gs;
+		size_t len = prandom_u32_max(rs) + gs;
 
 		test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
 	} while (i++ < 3);
@@ -223,11 +223,11 @@ static int __init test_hexdump_init(void)
 	unsigned int i;
 	int rowsize;
 
-	rowsize = (get_random_int() % 2 + 1) * 16;
+	rowsize = (prandom_u32() % 2 + 1) * 16;
 	for (i = 0; i < 16; i++)
 		test_hexdump_set(rowsize, false);
 
-	rowsize = (get_random_int() % 2 + 1) * 16;
+	rowsize = (prandom_u32() % 2 + 1) * 16;
 	for (i = 0; i < 16; i++)
 		test_hexdump_set(rowsize, true);
 
-- 
2.26.0

