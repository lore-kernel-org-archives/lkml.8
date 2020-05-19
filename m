Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1201C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2CE20826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgESUCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEST6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291FC08C5C2;
        Tue, 19 May 2020 12:58:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nh-0008G7-29; Tue, 19 May 2020 21:58:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 914651C0813;
        Tue, 19 May 2020 21:58:26 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:26 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lib/bsearch: Provide __always_inline variant
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135313.624443814@linutronix.de>
References: <20200505135313.624443814@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830648.17951.969963884359483871.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     83b169bb1d30546c21cf1e22a0834547bfe91f06
Gitweb:        https://git.kernel.org/tip/83b169bb1d30546c21cf1e22a0834547bfe91f06
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 19 Feb 2020 18:25:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:05 +02:00

lib/bsearch: Provide __always_inline variant

For code that needs the ultimate performance (it can inline the @cmp
function too) or simply needs to avoid calling external functions for
whatever reason, provide an __always_inline variant of bsearch().

[ tglx: Renamed to __inline_bsearch() as suggested by Andy ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135313.624443814@linutronix.de


---
 include/linux/bsearch.h | 26 ++++++++++++++++++++++++--
 lib/bsearch.c           | 22 ++--------------------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/bsearch.h b/include/linux/bsearch.h
index 8ed53d7..e66b711 100644
--- a/include/linux/bsearch.h
+++ b/include/linux/bsearch.h
@@ -4,7 +4,29 @@
 
 #include <linux/types.h>
 
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp);
+static __always_inline
+void *__inline_bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
+{
+	const char *pivot;
+	int result;
+
+	while (num > 0) {
+		pivot = base + (num >> 1) * size;
+		result = cmp(key, pivot);
+
+		if (result == 0)
+			return (void *)pivot;
+
+		if (result > 0) {
+			base = pivot + size;
+			num--;
+		}
+		num >>= 1;
+	}
+
+	return NULL;
+}
+
+extern void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp);
 
 #endif /* _LINUX_BSEARCH_H */
diff --git a/lib/bsearch.c b/lib/bsearch.c
index 8b3aae5..bf86aa6 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -28,27 +28,9 @@
  * the key and elements in the array are of the same type, you can use
  * the same comparison function for both sort() and bsearch().
  */
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp)
+void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
 {
-	const char *pivot;
-	int result;
-
-	while (num > 0) {
-		pivot = base + (num >> 1) * size;
-		result = cmp(key, pivot);
-
-		if (result == 0)
-			return (void *)pivot;
-
-		if (result > 0) {
-			base = pivot + size;
-			num--;
-		}
-		num >>= 1;
-	}
-
-	return NULL;
+	return __inline_bsearch(key, base, num, size, cmp);
 }
 EXPORT_SYMBOL(bsearch);
 NOKPROBE_SYMBOL(bsearch);
