Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626172065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 12:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGZMIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:08:06 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:58388 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 08:08:04 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 180C86F62F;
        Sun, 26 Jul 2020 12:07:58 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, walken@google.com,
        akpm@linux-foundation.org, chenqiwu@xiaomi.com,
        rostedt@goodmis.org, acme@redhat.com, tstoyanov@vmware.com,
        tz.stoyanov@gmail.com, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] tools: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 14:07:52 +0200
Message-Id: <20200726120752.16768-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 tools/include/linux/jhash.h                  | 2 +-
 tools/lib/rbtree.c                           | 2 +-
 tools/lib/traceevent/event-parse.h           | 2 +-
 tools/testing/ktest/examples/README          | 2 +-
 tools/testing/ktest/examples/crosstests.conf | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/jhash.h b/tools/include/linux/jhash.h
index 348c6f47e4cc..af8d0fe1c6ce 100644
--- a/tools/include/linux/jhash.h
+++ b/tools/include/linux/jhash.h
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2006. Bob Jenkins (bob_jenkins@burtleburtle.net)
  *
- * http://burtleburtle.net/bob/hash/
+ * https://burtleburtle.net/bob/hash/
  *
  * These are the credits from Bob's sources:
  *
diff --git a/tools/lib/rbtree.c b/tools/lib/rbtree.c
index 06ac7bd2144b..727396de6be5 100644
--- a/tools/lib/rbtree.c
+++ b/tools/lib/rbtree.c
@@ -13,7 +13,7 @@
 #include <linux/export.h>
 
 /*
- * red-black trees properties:  http://en.wikipedia.org/wiki/Rbtree
+ * red-black trees properties:  https://en.wikipedia.org/wiki/Rbtree
  *
  *  1) A node is either red or black
  *  2) The root is black
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index b77837f75a0d..ad7799c85429 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -379,7 +379,7 @@ enum tep_errno {
 	 * errno since SUS requires the errno has distinct positive values.
 	 * See 'Issue 6' in the link below.
 	 *
-	 * http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
+	 * https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
 	 */
 	__TEP_ERRNO__START			= -100000,
 
diff --git a/tools/testing/ktest/examples/README b/tools/testing/ktest/examples/README
index a12d295a09d8..4f048789b260 100644
--- a/tools/testing/ktest/examples/README
+++ b/tools/testing/ktest/examples/README
@@ -11,7 +11,7 @@ crosstests.conf - this config shows an example of testing a git repo against
     lots of different architectures. It only does build tests, but makes
     it easy to compile test different archs. You can download the arch
     cross compilers from:
-  http://kernel.org/pub/tools/crosstool/files/bin/x86_64/
+  https://kernel.org/pub/tools/crosstool/files/bin/x86_64/
 
 test.conf - A generic example of a config. This is based on an actual config
      used to perform real testing.
diff --git a/tools/testing/ktest/examples/crosstests.conf b/tools/testing/ktest/examples/crosstests.conf
index 6907f32590b2..3b15e85f26bd 100644
--- a/tools/testing/ktest/examples/crosstests.conf
+++ b/tools/testing/ktest/examples/crosstests.conf
@@ -3,7 +3,7 @@
 #
 # In this config, it is expected that the tool chains from:
 #
-#   http://kernel.org/pub/tools/crosstool/files/bin/x86_64/
+#   https://kernel.org/pub/tools/crosstool/files/bin/x86_64/
 #
 # running on a x86_64 system have been downloaded and installed into:
 #
-- 
2.27.0

