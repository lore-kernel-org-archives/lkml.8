Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C52C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A926F20737
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHYE5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:42 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:59264 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728908AbgHYE53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 69C0F12C8;
        Tue, 25 Aug 2020 04:57:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: book86_4a00e1427059
X-Filterd-Recvd-Size: 4582
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:27 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 25/29] lib/zlib: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:22 -0700
Message-Id: <26b46a75251b8889a3c857461771f9a4115220e3.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 lib/zlib_deflate/deftree.c | 49 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/lib/zlib_deflate/deftree.c b/lib/zlib_deflate/deftree.c
index a4a34da512fe..e358053bdb15 100644
--- a/lib/zlib_deflate/deftree.c
+++ b/lib/zlib_deflate/deftree.c
@@ -217,10 +217,22 @@ static void tr_static_init(void)
     /* Construct the codes of the static literal tree */
     for (bits = 0; bits <= MAX_BITS; bits++) bl_count[bits] = 0;
     n = 0;
-    while (n <= 143) static_ltree[n++].Len = 8, bl_count[8]++;
-    while (n <= 255) static_ltree[n++].Len = 9, bl_count[9]++;
-    while (n <= 279) static_ltree[n++].Len = 7, bl_count[7]++;
-    while (n <= 287) static_ltree[n++].Len = 8, bl_count[8]++;
+    while (n <= 143) {
+        static_ltree[n++].Len = 8;
+	bl_count[8]++;
+    }
+    while (n <= 255) {
+        static_ltree[n++].Len = 9;
+	bl_count[9]++;
+    }
+    while (n <= 279) {
+        static_ltree[n++].Len = 7;
+	bl_count[7]++;
+    }
+    while (n <= 287) {
+        static_ltree[n++].Len = 8;
+	bl_count[8]++;
+    }
     /* Codes 286 and 287 do not exist, but we must include them in the
      * tree construction to get a canonical Huffman tree (longest code
      * all ones)
@@ -378,7 +390,10 @@ static void gen_bitlen(
     for (h = s->heap_max+1; h < HEAP_SIZE; h++) {
         n = s->heap[h];
         bits = tree[tree[n].Dad].Len + 1;
-        if (bits > max_length) bits = max_length, overflow++;
+        if (bits > max_length) {
+            bits = max_length;
+	    overflow++;
+        }
         tree[n].Len = (ush)bits;
         /* We overwrite tree[n].Dad which is no longer needed */
 
@@ -497,7 +512,7 @@ static void build_tree(
      * heap[SMALLEST]. The sons of heap[n] are heap[2*n] and heap[2*n+1].
      * heap[0] is not used.
      */
-    s->heap_len = 0, s->heap_max = HEAP_SIZE;
+    s->heap_len = 0; s->heap_max = HEAP_SIZE;
 
     for (n = 0; n < elems; n++) {
         if (tree[n].Freq != 0) {
@@ -583,7 +598,10 @@ static void scan_tree(
     int max_count = 7;         /* max repeat count */
     int min_count = 4;         /* min repeat count */
 
-    if (nextlen == 0) max_count = 138, min_count = 3;
+    if (nextlen == 0) {
+        max_count = 138;
+	min_count = 3;
+    }
     tree[max_code+1].Len = (ush)0xffff; /* guard */
 
     for (n = 0; n <= max_code; n++) {
@@ -602,11 +620,11 @@ static void scan_tree(
         }
         count = 0; prevlen = curlen;
         if (nextlen == 0) {
-            max_count = 138, min_count = 3;
+            max_count = 138; min_count = 3;
         } else if (curlen == nextlen) {
-            max_count = 6, min_count = 3;
+            max_count = 6; min_count = 3;
         } else {
-            max_count = 7, min_count = 4;
+            max_count = 7; min_count = 4;
         }
     }
 }
@@ -630,7 +648,10 @@ static void send_tree(
     int min_count = 4;         /* min repeat count */
 
     /* tree[max_code+1].Len = -1; */  /* guard already set */
-    if (nextlen == 0) max_count = 138, min_count = 3;
+    if (nextlen == 0) {
+        max_count = 138;
+	min_count = 3;
+    }
 
     for (n = 0; n <= max_code; n++) {
         curlen = nextlen; nextlen = tree[n+1].Len;
@@ -654,11 +675,11 @@ static void send_tree(
         }
         count = 0; prevlen = curlen;
         if (nextlen == 0) {
-            max_count = 138, min_count = 3;
+            max_count = 138; min_count = 3;
         } else if (curlen == nextlen) {
-            max_count = 6, min_count = 3;
+            max_count = 6; min_count = 3;
         } else {
-            max_count = 7, min_count = 4;
+            max_count = 7; min_count = 4;
         }
     }
 }
-- 
2.26.0

