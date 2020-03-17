Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0BC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89B220767
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCQVeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgCQVeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1053220780;
        Tue, 17 Mar 2020 21:34:17 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEJqp-000EW6-W9; Tue, 17 Mar 2020 17:34:16 -0400
Message-Id: <20200317213415.870741809@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:32:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [RFC][PATCH 02/11] ring-buffer: Have ring_buffer_empty() not depend on tracing stopped
References: <20200317213222.421100128@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

It was complained about that when the trace file is read, that the tracing
is disabled, as the iterator expects writing to the buffer it reads is not
updated. Several steps are needed to make the iterator handle a writer,
by testing if things have changed as it reads.

This step is to make ring_buffer_empty() expect the buffer to be changing.
Note if the current location of the iterator is overwritten, then it will
return false as new data is being added. Note, that this means that data
will be skipped.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 61f0e92ace99..1718520a2809 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3590,16 +3590,37 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	struct buffer_page *reader;
 	struct buffer_page *head_page;
 	struct buffer_page *commit_page;
+	struct buffer_page *curr_commit_page;
 	unsigned commit;
+	u64 curr_commit_ts;
+	u64 commit_ts;
 
 	cpu_buffer = iter->cpu_buffer;
-
-	/* Remember, trace recording is off when iterator is in use */
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
 	commit_page = cpu_buffer->commit_page;
+	commit_ts = commit_page->page->time_stamp;
+
+	/*
+	 * When the writer goes across pages, it issues a cmpxchg which
+	 * is a mb(), which will synchronize with the rmb here.
+	 * (see rb_tail_page_update())
+	 */
+	smp_rmb();
 	commit = rb_page_commit(commit_page);
+	/* We want to make sure that the commit page doesn't change */
+	smp_rmb();
+
+	/* Make sure commit page didn't change */
+	curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
+	curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);
+
+	/* If the commit page changed, then there's more data */
+	if (curr_commit_page != commit_page ||
+	    curr_commit_ts != commit_ts)
+		return 0;
 
+	/* Still racy, as it may return a false positive, but that's OK */
 	return ((iter->head_page == commit_page && iter->head == commit) ||
 		(iter->head_page == reader && commit_page == head_page &&
 		 head_page->read == commit &&
-- 
2.25.1


