Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D6A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589227676;
	bh=/Oy/Sf2u70Yzd63mUcR8KEbAcs1JY1pR2AzcGOPrLA4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CZ2o5sqm4pj/2Yhtq1dy1bbGLlj2rmzIQtmfXqYMeWUZxU7jZ7bj8qlTJKwRxcvD6
	 ZTOTnWd8ukqo3z9OyhEXT05pj2x1ToEkcSmwd67QNlnnwAfU5OtkNN8DBXdR4SsyAx
	 AYiY6r2wwJmAxtZCBLFttNtLcYD/Z07sAUNbScjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgEKUH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:07:55 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9ED206F5;
        Mon, 11 May 2020 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589227674;
        bh=/Oy/Sf2u70Yzd63mUcR8KEbAcs1JY1pR2AzcGOPrLA4=;
        h=Date:From:To:Cc:Subject:From;
        b=RxVbVM1go98ghgRmXsKhAPljplz/QBHdCeitk1fe1WOPCo3w6VLg/KUYs2uAX8Ac2
         sahuyYyvVhljvswaAIiglR9itd+IHOPwQ5k8VXpa+ZevDvxsMxxp3tn71XIPReCLph
         AsS2Xd0UPrVEo9FvHopYfrp9mGtGHkZyUBOHK/pM=
Date:   Mon, 11 May 2020 15:12:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf/core: Replace zero-length array with flexible-array
Message-ID: <20200511201227.GA14041@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 include/linux/perf_event.h | 4 ++--
 kernel/events/callchain.c  | 2 +-
 kernel/events/internal.h   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9c3e7619c929..306b07b56cc6 100644
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
index c2b41a263166..b1991043b7d8 100644
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
index f16f66b6b655..fcbf5616a441 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -55,7 +55,7 @@ struct perf_buffer {
 	void				*aux_priv;
 
 	struct perf_event_mmap_page	*user_page;
-	void				*data_pages[0];
+	void				*data_pages[];
 };
 
 extern void rb_free(struct perf_buffer *rb);
-- 
2.26.2

