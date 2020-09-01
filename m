Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F332C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020FD208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598947037;
	bh=xpciEiK1NwSQDebvBUt8PqEJ0Povb15SzOC+Y7MqoZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPiRjZMc3HFJXkfkHm5vVoOD2eORQjuXeJ4GUDBDWxlt8FALlGq7tO5Y0O9mPvfp4
	 bVzJv7fohmukrxpm/T+OMpprL9W600fbl5CZSQJbac9eyM4LtK0WFVnmnyLAYYeIAu
	 BjIdq3Usk6VmdezHLJojnXopvgtoPSlQAXHNl7gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIAH5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAH5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:57:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9B72065F;
        Tue,  1 Sep 2020 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598947035;
        bh=xpciEiK1NwSQDebvBUt8PqEJ0Povb15SzOC+Y7MqoZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmeUZbmsyHCSqmM8wBNNJ6HUwklakXmVlQHrTSceCEUHPpY5q/SbCYtnjnTMpVLCP
         RMorO/omzQq/YaZlhaY6SqU921Av/0TUXMcun/DdMVqbAtIoEDCFVa0CuVbfT0lAIg
         PAFqMBcHbjx96OJPgx7PxktqzzXpm7sa9jd9KAJY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 4/6] tracing/kprobes: Support perf-style return probe
Date:   Tue,  1 Sep 2020 16:57:10 +0900
Message-Id: <159894703070.1478826.15755889933157654537.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159894698993.1478826.2813843560314595660.stgit@devnote2>
References: <159894698993.1478826.2813843560314595660.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support perf-style return probe ("SYMBOL%return") in kprobe events.
This will allow boot-time tracing user to define a return probe event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..391361b67c8f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -709,6 +709,18 @@ static inline void sanitize_event_name(char *name)
 			*name = '_';
 }
 
+static inline bool split_return_suffix(char *symbol)
+{
+	char *p = strchr(symbol, '%');
+
+	if (p && !strcmp(p, "%return")) {
+		*p = '\0';
+		return true;
+	}
+
+	return false;
+}
+
 static int trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -717,6 +729,9 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
 	 *  - Add kretprobe:
 	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
+	 *    Or
+	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
+	 *
 	 * Fetch args:
 	 *  $retval	: fetch return value
 	 *  $stack	: fetch stack address
@@ -746,7 +761,6 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	switch (argv[0][0]) {
 	case 'r':
 		is_return = true;
-		flags |= TPARG_FL_RETURN;
 		break;
 	case 'p':
 		break;
@@ -804,12 +818,17 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		symbol = kstrdup(argv[1], GFP_KERNEL);
 		if (!symbol)
 			return -ENOMEM;
+
+		is_return = split_return_suffix(symbol) || is_return;
+
 		/* TODO: support .init module functions */
 		ret = traceprobe_split_symbol_offset(symbol, &offset);
 		if (ret || offset < 0 || offset > UINT_MAX) {
 			trace_probe_log_err(0, BAD_PROBE_ADDR);
 			goto parse_error;
 		}
+		if (is_return)
+			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
 		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {

