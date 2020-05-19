Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1BA207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgESSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:44:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDCFC08C5C0;
        Tue, 19 May 2020 11:44:15 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Dn-0006ae-Dj; Tue, 19 May 2020 20:44:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F36B11C0178;
        Tue, 19 May 2020 20:44:10 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:10 -0000
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Replace zero-length array with flexible-array
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511201227.GA14041@embeddedor>
References: <20200511201227.GA14041@embeddedor>
MIME-Version: 1.0
Message-ID: <158991385084.17951.9715501149382778359.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c50c75e9b87946499a62bffc021e95c87a1d57cd
Gitweb:        https://git.kernel.org/tip/c50c75e9b87946499a62bffc021e95c87a1d57cd
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Mon, 11 May 2020 15:12:27 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:16 +02:00

perf/core: Replace zero-length array with flexible-array

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200511201227.GA14041@embeddedor
---
 include/linux/perf_event.h | 4 ++--
 kernel/events/callchain.c  | 2 +-
 kernel/events/internal.h   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 87e2168..d7b610c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -61,7 +61,7 @@ struct perf_guest_info_callbacks {
 
 struct perf_callchain_entry {
 	__u64				nr;
-	__u64				ip[0]; /* /proc/sys/kernel/perf_event_max_stack */
+	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
 };
 
 struct perf_callchain_entry_ctx {
@@ -113,7 +113,7 @@ struct perf_raw_record {
 struct perf_branch_stack {
 	__u64				nr;
 	__u64				hw_idx;
-	struct perf_branch_entry	entries[0];
+	struct perf_branch_entry	entries[];
 };
 
 struct task_struct;
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c2b41a2..b199104 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -16,7 +16,7 @@
 
 struct callchain_cpus_entries {
 	struct rcu_head			rcu_head;
-	struct perf_callchain_entry	*cpu_entries[0];
+	struct perf_callchain_entry	*cpu_entries[];
 };
 
 int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index f16f66b..fcbf561 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -55,7 +55,7 @@ struct perf_buffer {
 	void				*aux_priv;
 
 	struct perf_event_mmap_page	*user_page;
-	void				*data_pages[0];
+	void				*data_pages[];
 };
 
 extern void rb_free(struct perf_buffer *rb);
