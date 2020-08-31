Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B8C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C612068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598877991;
	bh=AFTvUebiyRMETzn8S38/k45wbiUemiQHqeohzIX/Qck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cwUKfMhiAKqcsma5Fn3o3of+kt6hw2vL4hDRjzabR5hxb310rtNZYH5LOhIqxToUR
	 Vi9+DMiZPMMcin2qyZX9r/phCDHDFOEniL7fIyUXHrsWyO4wLKGA9qZLZoiIDTDhz1
	 B99VHd5gXQPwXzxjoGDcYZ2ctrIN+MNiStSUWKW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHaMq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:46:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FFCB206E3;
        Mon, 31 Aug 2020 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877983;
        bh=AFTvUebiyRMETzn8S38/k45wbiUemiQHqeohzIX/Qck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS8W2VhYLLjCBZevvcwKhsU+PhJ8LNdeio0v4vyGQdL9nMa+Y/TQ4Vk7nx+oCKT9i
         nDuGtkNZTeFFMD9NUUV1v5kHp0B8C58D0zjL2sdvv2xImjPtFZ+GSyS2sfGxr5TzTJ
         xCY56F2Gv+4lQ5iX4yOGWe8gsEwvcZ92behfydjU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 6/6] Documentation: tracing: boot: Add an example of tracing function-calls
Date:   Mon, 31 Aug 2020 21:46:19 +0900
Message-Id: <159887797965.1330989.8398347951884039748.stgit@devnote2>
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

Add an example of tracing function calls on a specific function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 1341b449acaa..c216f5695ae2 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -168,6 +168,26 @@ is for tracing functions starting with "user\_", and others tracing
 The instance node also accepts event nodes so that each instance
 can customize its event tracing.
 
+With the trigger action and kprobes, you can trace function-graph while
+a function is called. For example, this will trace all function calls in
+the pci_proc_init()::
+
+  ftrace {
+        tracing_on = 0
+        tracer = function_graph
+        event.kprobes {
+                start_event {
+                        probes = "pci_proc_init"
+                        actions = "traceon"
+                }
+                end_event {
+                        probes = "pci_proc_init%return"
+                        actions = "traceoff"
+                }
+        }
+  }
+
+
 This boot-time tracing also supports ftrace kernel parameters via boot
 config.
 For example, following kernel parameters::

