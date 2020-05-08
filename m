Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75296C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5925924955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgEHNrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbgEHNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575CC05BD43;
        Fri,  8 May 2020 06:46:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kj-0001lr-2m; Fri, 08 May 2020 15:46:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B7E991C03AB;
        Fri,  8 May 2020 15:46:32 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:32 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Fix function matching in report
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559268.8414.10759675966256934757.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     f770ed10a9ee65529f3ec8d90eb374bbd8b7c238
Gitweb:        https://git.kernel.org/tip/f770ed10a9ee65529f3ec8d90eb374bbd8b7c238
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 10 Apr 2020 18:44:17 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 13 Apr 2020 17:18:15 -07:00

kcsan: Fix function matching in report

Pass string length as returned by scnprintf() to strnstr(), since
strnstr() searches exactly len bytes in haystack, even if it contains a
NUL-terminator before haystack+len.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ddc18f1..cf41d63 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -192,11 +192,11 @@ skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 		 * maintainers.
 		 */
 		char buf[64];
+		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
 
-		snprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
-		if (!strnstr(buf, "rcu_", sizeof(buf)) &&
-		    !strnstr(buf, "_rcu", sizeof(buf)) &&
-		    !strnstr(buf, "_srcu", sizeof(buf)))
+		if (!strnstr(buf, "rcu_", len) &&
+		    !strnstr(buf, "_rcu", len) &&
+		    !strnstr(buf, "_srcu", len))
 			return true;
 	}
 
@@ -262,15 +262,15 @@ static const char *get_thread_desc(int task_id)
 static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
 {
 	char buf[64];
+	int len;
 	int skip = 0;
 
 	for (; skip < num_entries; ++skip) {
-		snprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
-		if (!strnstr(buf, "csan_", sizeof(buf)) &&
-		    !strnstr(buf, "tsan_", sizeof(buf)) &&
-		    !strnstr(buf, "_once_size", sizeof(buf))) {
+		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
+		if (!strnstr(buf, "csan_", len) &&
+		    !strnstr(buf, "tsan_", len) &&
+		    !strnstr(buf, "_once_size", len))
 			break;
-		}
 	}
 	return skip;
 }
