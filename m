Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C062C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2946620786
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNpP4m+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgFRWQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbgFRWQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:16:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6BC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:16:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s90so7875789ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oQKKZ4WrQm+MQALLCvtvV2adeUnLqGSBm5iBOXJSAVI=;
        b=mNpP4m+Mv8HzHDTcYjY8uHTBurHXJNuYeurpmiuQQs4iBkRkcT8Qi2EUCwfRgy6jpE
         Ye6/iUbajeYyy+b0gJMqYWFhJHh3ZYRayGVlJhC6DRG17+kn+6NFbjJZEXkVs6qZLzhK
         OiJ57JnbDkar5m32pfswnqjrBphU8d5LDG6OxYwIAznYmhWGr/iI7nacFfmRbble3/ik
         cwuTY9FHheG5KbDkyKHxVmsEOep+ltNk+PYS7W7b+vnuzicJjl6FMMMNhNoLsSXUyiNK
         jo3BcDzl7+FS4jD57iO1dajLmOCPUZ/Z7MJH1Ga3OeGwvdeNxdKZAWg+rjtxTjUcfNns
         L0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oQKKZ4WrQm+MQALLCvtvV2adeUnLqGSBm5iBOXJSAVI=;
        b=XAb0M2YFkqLC7b5rk01bikvZVkUYibkz5M1G1EWf0fikv33CyycW3aCN8DKyyS8au6
         Jx0A8fNdDe6KsFBJXwvkhvsiT1CgruA6VJWF+BzhgdJlB7v4kkm3C5WQ4L+Vpt37Gtn5
         dw5Oup/fF9BflSI+HmLW07I+pd41Uz3+mIBMrPzdkC3CpYL3rkktoWefzteORTCEXvhU
         MDwCoKbq+qjFw8nI6+FcSyu71MkVZ21kvoemGq10tqdGVT2SNXkpfIsRFmFhvdY48jyD
         xBM1v90/W8U6CTfzHD9+N26DpYHS0Ah3yYIr0eQaDLAWhMjLAaqteVwsPiTX2pmZiSVx
         AyJw==
X-Gm-Message-State: AOAM532rIS7saLqgr9v+IbP6ZFbW6elK2p4heXIDt5glQCu1C25sJNF4
        MREb2QSv47dUuknsxwJCNoRify0/VX4=
X-Google-Smtp-Source: ABdhPJxFCAMKrzkjJhBReHmJfxLI1SRR8yckiGufUzfvAZxHTF1H6tNPjfPQb2xxacNMKdZysavpLZhrgDo=
X-Received: by 2002:a25:908d:: with SMTP id t13mr1274201ybl.450.1592518593230;
 Thu, 18 Jun 2020 15:16:33 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:15:40 -0700
In-Reply-To: <20200618221541.247643-1-korben@google.com>
Message-Id: <20200618221541.247643-2-korben@google.com>
Mime-Version: 1.0
References: <20200618221541.247643-1-korben@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH 1/2] Add force-abs-timestamp trace option.
From:   Korben Rusek <korben@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Shier <pshier@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jbehmer@google.com,
        franksie@google.com, Korben Rusek <korben@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally a data event includes the delta time between itself and
the previous data event. But if a write interrupts another write
then the event cannot check the timestamp of the previous event
and so it uses a delta of 0.

Adds a new trace option: force-abs-timestamp. When this is on
each event is proceeded by an absolute timestamp event.

Reviewed-by: Peter Shier <pshier@google.com>
Signed-off-by: Korben Rusek <korben@google.com>
---
 Documentation/trace/ftrace.rst | 5 +++++
 kernel/trace/trace.c           | 4 ++++
 kernel/trace/trace.h           | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 430a16283103..704264164ffd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1029,6 +1029,7 @@ To see what is available, simply cat the file::
 	irq-info
 	markers
 	noevent-fork
+	noforce-abs-timestamp
 	function-trace
 	nofunction-fork
 	nodisplay-graph
@@ -1212,6 +1213,10 @@ Here are the available options:
 
         This affects PIDs listed in set_event_notrace_pid as well.
 
+  force-abs-timestamp
+	When set, always use absolute timestamps rather than
+	defaulting to deltas.
+
   function-trace
 	The latency tracers will enable function tracing
 	if this option is enabled (default it is). When
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec44b0e2a19c..8b5c4e998895 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4852,6 +4852,12 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		trace_printk_control(enabled);
 	}
 
+	if (mask == TRACE_ITER_FORCE_ABS_TIMESTAMP) {
+		ring_buffer_set_time_stamp_abs(tr->array_buffer.buffer, enabled);
+#ifdef CONFIG_TRACER_MAX_TRACE
+		ring_buffer_set_time_stamp_abs(tr->max_buffer.buffer, enabled);
+#endif
+	}
 	return 0;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index def769df5bf1..cb1ecc540494 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1330,6 +1330,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
+		C(FORCE_ABS_TIMESTAMP,	"force-abs-timestamp"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-- 
2.27.0.290.gba653c62da-goog

