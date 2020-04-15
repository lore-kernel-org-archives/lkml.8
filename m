Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D11C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307C62078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977755;
	bh=tO0wbxDZwj8aNGBThgk3367qf2+SgqyrvnqQRadJAfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvgYZJfePqBNShZreCbi3XGiUC2IvpHI083yrE58VNrNV8x8pt5vItX6kvjzxLRyM
	 SUqBZDHhvSbpvMDbXj+wklQE6cXxEoIRCHjwUFtWmQqJVGkChO/TX+/rAVQ8eJfjfg
	 XpddhsblWTWhOnLAfDiAB5xWDPuafazkMXmVX98s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441587AbgDOTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416824AbgDOSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9B82166E;
        Wed, 15 Apr 2020 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975656;
        bh=tO0wbxDZwj8aNGBThgk3367qf2+SgqyrvnqQRadJAfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKmQtSlYttvzpTXl5nXSi+jIYPkMJ3YPCxu5hmWm5x71lqXO+zofCCHbcW/7lM8WR
         ZUbF+mZQvt0JRYi7EilTksfeKZHdPXG5Hnq+TgquVwlf0jZ/tRTLxKwaEK6MwwOYb8
         25QzmE9b7l7emAvoeOTrb7mmRs2Hi8h6NmWe4HHo=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 14/15] kcsan: Fix function matching in report
Date:   Wed, 15 Apr 2020 11:34:10 -0700
Message-Id: <20200415183411.12368-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Pass string length as returned by scnprintf() to strnstr(), since
strnstr() searches exactly len bytes in haystack, even if it contains a
NUL-terminator before haystack+len.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ddc18f1..cf41d63d 100644
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
-- 
2.9.5

