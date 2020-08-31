Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64538C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3625C206E3
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598877974;
	bh=xpciEiK1NwSQDebvBUt8PqEJ0Povb15SzOC+Y7MqoZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DE0AGnoUaolX1rpR9FusGJnJEWcHtI9cIbKlVeTDEi5Z9i72ME/c38URXHVjLAUZ7
	 s+BiEarRWpbW+ixeWO8+i9gURRQAnrvPBDARGoY2S4oQb0Mm/DE41Z7MS9DVYmGMNR
	 cgtawuP5eOgZ1EWuqgKhicakDv8r/pOpSw4FehgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHaMqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:46:05 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC7F20936;
        Mon, 31 Aug 2020 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877965;
        bh=xpciEiK1NwSQDebvBUt8PqEJ0Povb15SzOC+Y7MqoZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tm0X0Bnskgtx626aIhezv8tq7tulaFU3a02p5jY8yCe97ApiLEIeMVX4lpuYoRS9S
         aIo2O9kvct12CyFJvs6hK2BD66CXX8xM57Zb8O8hqh1FvH0+zp2K68OTBsN6T/t1Sg
         nwbU9+gYaddTY/+CoLhEyShzLNIQJpwhyBL4b9XA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 4/6] tracing/kprobes: Support perf-style return probe
Date:   Mon, 31 Aug 2020 21:46:01 +0900
Message-Id: <159887796151.1330989.2690618021941671783.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159887792384.1330989.5993224243767476896.stgit@devnote2>
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
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

