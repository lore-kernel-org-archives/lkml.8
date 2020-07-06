Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975872074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgGFL3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgGFL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:29:07 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96401C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 04:29:06 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:e012:1552:6e81:c371])
        by albert.telenet-ops.be with bizsmtp
        id znV32200Y0tDR5Q06nV3DW; Mon, 06 Jul 2020 13:29:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jsPJ1-0000Z1-AU; Mon, 06 Jul 2020 13:29:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jsPJ1-0001rC-87; Mon, 06 Jul 2020 13:29:03 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] lib/test_bitops: Do the full test during module init
Date:   Mon,  6 Jul 2020 13:29:00 +0200
Message-Id: <20200706112900.7097-1-geert@linux-m68k.org>
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
v2:
  - Keep a dummy module_exit() function to support module unloading.
---
 lib/test_bitops.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index ced25e3a779baf96..471141ddd6913724 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -52,9 +52,9 @@ static unsigned long order_comb_long[][2] = {
 
 static int __init test_bitops_startup(void)
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
@@ -98,7 +94,13 @@ static void __exit test_bitops_unstartup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
-	pr_warn("Unloaded test module\n");
+	pr_info("Completed bitops test\n");
+
+	return 0;
+}
+
+static void __exit test_bitops_unstartup(void)
+{
 }
 
 module_init(test_bitops_startup);
-- 
2.17.1

