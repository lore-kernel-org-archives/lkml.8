Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C39C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704BC206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgD2GAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:00:23 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:40329 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgD2GAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:00:23 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 02:00:22 EDT
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 29 Apr 2020 14:30:20 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: ch0.han@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.221.57)
        by 156.147.1.126 with ESMTP; 29 Apr 2020 14:30:20 +0900
X-Original-SENDERIP: 10.177.221.57
X-Original-MAILFROM: ch0.han@lge.com
From:   Changhee Han <ch0.han@lge.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, ch0.han@lge.com
Subject: [PATCH] tools/vm/page_owner_sort: filter out unneeded line
Date:   Wed, 29 Apr 2020 14:29:40 +0900
Message-Id: <20200429052940.16968-1-ch0.han@lge.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To see a sorted result from page owner, it needs a tiresome
preprocessing work before running page_owner_sort. This patch simply
filters out a line which starts with "PFN" while reading page owner
report.

Signed-off-by: Changhee Han <ch0.han@lge.com>
---
 Documentation/vm/page_owner.rst | 3 +--
 tools/vm/page_owner_sort.c      | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 0ed5ab8c7ab4..079f3f8c4784 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -83,8 +83,7 @@ Usage
 4) Analyze information from page owner::
 
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
-	grep -v ^PFN page_owner_full.txt > page_owner.txt
-	./page_owner_sort page_owner.txt sorted_page_owner.txt
+	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
 
    See the result about who allocated each page
    in the ``sorted_page_owner.txt``.
diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index d3a8755c039c..85eb65ea16d3 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -4,8 +4,7 @@
  *
  * Example use:
  * cat /sys/kernel/debug/page_owner > page_owner_full.txt
- * grep -v ^PFN page_owner_full.txt > page_owner.txt
- * ./page_owner_sort page_owner.txt sorted_page_owner.txt
+ * ./page_owner_sort page_owner_full.txt sorted_page_owner.txt
  *
  * See Documentation/vm/page_owner.rst
 */
@@ -38,6 +37,8 @@ int read_block(char *buf, int buf_size, FILE *fin)
 	while (buf_end - curr > 1 && fgets(curr, buf_end - curr, fin)) {
 		if (*curr == '\n') /* empty line */
 			return curr - buf;
+		if (!strncmp(curr, "PFN", 3))
+			continue;
 		curr += strlen(curr);
 	}
 
-- 
2.17.1

