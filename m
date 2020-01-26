Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEAFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342220842
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAZTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbgAZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFAAC2083E;
        Sun, 26 Jan 2020 19:20:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSG-000zr4-TV; Sun, 26 Jan 2020 14:20:20 -0500
Message-Id: <20200126192020.793380330@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>
Subject: [for-next][PATCH 3/7] tracing: Set kernel_stacks caller size properly
References: <20200126191932.984391723@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

I noticed when trying to use the trace-cmd python interface that reading the raw
buffer wasn't working for kernel_stack events.  This is because it uses a
stubbed version of __dynamic_array that doesn't do the __data_loc trick and
encode the length of the array into the field.  Instead it just shows up as a
size of 0.  So change this to __array and set the len to FTRACE_STACK_ENTRIES
since this is what we actually do in practice and matches how user_stack_trace
works.

Link: http://lkml.kernel.org/r/1411589652-1318-1-git-send-email-jbacik@fb.com

Signed-off-by: Josef Bacik <jbacik@fb.com>
[ Pulled from the archeological digging of my INBOX ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_entries.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fc8e97328e54..78c146efb862 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -174,7 +174,7 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	F_STRUCT(
 		__field(	int,		size	)
-		__dynamic_array(unsigned long,	caller	)
+		__array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES	)
 	),
 
 	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
-- 
2.24.1


