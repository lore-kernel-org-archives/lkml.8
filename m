Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAD1C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C12220842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578672327;
	bh=d2+PrFib/7EQ2hUA9lLU5t8sP3MMa40LSLUXqEMp4gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wErFAf8qwoGkxrqxdL71WYSDNnQHGwTEKGF7sUwvZsdOOrhVgyOVFGfgoTw8Ios+N
	 JXsZs5a3hVS8TKN+TRfkreY0hrAWQ4fzpyYDjqbob6O+zS5JNXskmrGk0kD3DveLzv
	 N5aD/b+QpVg4fmyy/s1CknAnAzPhmeGjH85T9gAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgAJQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgAJQF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:05:26 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE29D20838;
        Fri, 10 Jan 2020 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672325;
        bh=d2+PrFib/7EQ2hUA9lLU5t8sP3MMa40LSLUXqEMp4gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnrPIBiw1b/jQMvVUrIVhzumFsPkjnoBlpjR+bG2MujzAo5ygo5WzJUJKcIdrmZbx
         MW3NZZy5z5+ckqSPiNtmllsoLUwUP314JwFYanvDY1xqHBcgbKofDtYOE39/1IBF7B
         +DYJaPWUndiF60lecIWmvNKuS2WG7d4EHbIQbQUA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/22] tracing: Apply soft-disabled and filter to tracepoints printk
Date:   Sat, 11 Jan 2020 01:05:18 +0900
Message-Id: <157867231876.17873.15825819592284704068.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply soft-disabled and the filter rule of the trace events to
the printk output of tracepoints (a.k.a. tp_printk kernel parameter)
as same as trace buffer output.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f5fe8d..43f0f255ad66 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2610,6 +2610,7 @@ static DEFINE_MUTEX(tracepoint_printk_mutex);
 static void output_printk(struct trace_event_buffer *fbuffer)
 {
 	struct trace_event_call *event_call;
+	struct trace_event_file *file;
 	struct trace_event *event;
 	unsigned long flags;
 	struct trace_iterator *iter = tracepoint_print_iter;
@@ -2623,6 +2624,12 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	    !event_call->event.funcs->trace)
 		return;
 
+	file = fbuffer->trace_file;
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
+	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	     !filter_match_preds(file->filter, fbuffer->entry)))
+		return;
+
 	event = &fbuffer->trace_file->event_call->event;
 
 	spin_lock_irqsave(&tracepoint_iter_lock, flags);

