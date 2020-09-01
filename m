Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B292065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598947078;
	bh=AFTvUebiyRMETzn8S38/k45wbiUemiQHqeohzIX/Qck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeGmMIZ6m1lupEg9pV6NOzBPAaYSePinZXvCYYWlYy6decvYK1SAWK/F05K2iznoO
	 qZRIqOIRHyUXeJEdzD8YVeO0cKbIucF2FqRwDqWYcA9JHrYdegP1LGe+kAjjMJDFZ1
	 fBJtpdiWW+h/g/NyLW9Q/DijxvNIFsBhTAuSSyq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgIAH54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAH5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:57:39 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97DE2065F;
        Tue,  1 Sep 2020 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598947059;
        bh=AFTvUebiyRMETzn8S38/k45wbiUemiQHqeohzIX/Qck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=os8N4wpCG1avmrACnpBYPn6bCTIi8ZIDHkImdUHYO9Mj/Hp4rQa/Fd8zng/yMJ67K
         n8e0amlA8glK3ki9SSHo6X2p3duckywOuVOVeSqUT7YNh+w1aoFnkdt2p38okPG7wH
         /GVIyPVGZ/sWOevdx5OyOnzJKRbJ3cQrDWwjodxI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 6/6] Documentation: tracing: boot: Add an example of tracing function-calls
Date:   Tue,  1 Sep 2020 16:57:30 +0900
Message-Id: <159894705036.1478826.3872028049320971135.stgit@devnote2>
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

