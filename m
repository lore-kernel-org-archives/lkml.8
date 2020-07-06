Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDFDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BC92074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgGFJvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgGFJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:51:04 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EEBC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 02:51:03 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:e012:1552:6e81:c371])
        by michel.telenet-ops.be with bizsmtp
        id zlr12200W0tDR5Q06lr1FG; Mon, 06 Jul 2020 11:51:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jsNm9-0005nL-Mn; Mon, 06 Jul 2020 11:51:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jsNm9-0004zu-Km; Mon, 06 Jul 2020 11:51:01 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lib/test_bitops: Do the full test during module init
Date:   Mon,  6 Jul 2020 11:51:00 +0200
Message-Id: <20200706095100.19157-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the bitops test consists of two parts: one part is executed
during module load, the second part during module unload. This is
cumbersome for the user, as he has to perform two steps to execute all
tests, and is different from most (all?) other tests.

Merge the two parts, so both are executed during module load.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/test_bitops.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index ced25e3a779baf96..810ae6bc72fac5c3 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,11 +50,11 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
-static int __init test_bitops_startup(void)
+static int __init test_bitops(void)
 {
-	int i;
+	int i, bit_set;
 
-	pr_warn("Loaded test module\n");
+	pr_info("Starting bitops test\n");
 	set_bit(BITOPS_4, g_bitmap);
 	set_bit(BITOPS_7, g_bitmap);
 	set_bit(BITOPS_11, g_bitmap);
@@ -81,12 +81,8 @@ static int __init test_bitops_startup(void)
 				       order_comb_long[i][0]);
 	}
 #endif
-	return 0;
-}
 
-static void __exit test_bitops_unstartup(void)
-{
-	int bit_set;
+	barrier();
 
 	clear_bit(BITOPS_4, g_bitmap);
 	clear_bit(BITOPS_7, g_bitmap);
@@ -98,11 +94,12 @@ static void __exit test_bitops_unstartup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
-	pr_warn("Unloaded test module\n");
+	pr_info("Completed bitops test\n");
+
+	return 0;
 }
 
-module_init(test_bitops_startup);
-module_exit(test_bitops_unstartup);
+module_init(test_bitops);
 
 MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>, Wei Yang <richard.weiyang@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.17.1

