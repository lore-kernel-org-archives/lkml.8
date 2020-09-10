Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE0CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302662078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599741944;
	bh=XEkvMKygs9JcPL5/1o66Pvj/zS3t7Yf8iNmlW4M5nk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1xycxys6jsnl5hDZ5Yvy7GvD+8aPYIC3WowtI6ldeVajW/eGbQZW8Sin4xKfGwvj
	 PdieYGBVs89HJMandCjARccBBkQpGOiWMFmIcl/p5JWGuxEPJ7Xc1FenfnOH+FHfxo
	 3uCaMmsX75hDG0qxL6ZiOHm2shWyeiLd4wZq1PkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgIJMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbgIJMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:40:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F30521D7E;
        Thu, 10 Sep 2020 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741561;
        bh=XEkvMKygs9JcPL5/1o66Pvj/zS3t7Yf8iNmlW4M5nk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wdc0Ha0Q40NwP/GzjI5Pge5jsRFaDTPCd1b4FkhE4oD+A0nxnyfbWeaLaLPtjnL4m
         YkTx36P59UuRTfmz7ebvitlUgF4YIS+igxbzmYlRsNpJy1OfA3spPHtvpuxQjrO+Pr
         cdMru46eu06b0AtBTzhzLb2nHqCJ0WqYY7IHLD40=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/6] tracing/boot,kprobe,synth: Initialize boot-time tracing earlier
Date:   Thu, 10 Sep 2020 21:39:17 +0900
Message-Id: <159974155727.478751.7486926132902849578.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159974150897.478751.17933810682730471522.stgit@devnote2>
References: <159974150897.478751.17933810682730471522.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize boot-time tracing in core_initcall_sync instead of
fs_initcall, and initialize required tracers (kprobes and synth)
in core_initcall. This will allow the boot-time tracing to trace
__init code from the beginning of postcore_initcall stage.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c         |    7 +++++--
 kernel/trace/trace_events_synth.c |   22 ++++++++++++++++------
 kernel/trace/trace_kprobe.c       |    6 +++---
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index d52d441a17e8..754e3cf2df3a 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -340,5 +340,8 @@ static int __init trace_boot_init(void)
 
 	return 0;
 }
-
-fs_initcall(trace_boot_init);
+/*
+ * Start tracing at the end of core-initcall, so that it starts tracing
+ * from the beginning of postcore_initcall.
+ */
+core_initcall_sync(trace_boot_init);
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c6cca0d1d584..6eb77d95fd64 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1754,17 +1754,27 @@ static const struct file_operations synth_events_fops = {
 	.release        = seq_release,
 };
 
-static __init int trace_events_synth_init(void)
+/*
+ * Register dynevent at core_initcall. This allows kernel to setup kprobe
+ * events in postcore_initcall without tracefs.
+ */
+static __init int trace_events_synth_init_early(void)
 {
-	struct dentry *entry = NULL;
-	struct dentry *d_tracer;
 	int err = 0;
 
 	err = dyn_event_register(&synth_event_ops);
-	if (err) {
+	if (err)
 		pr_warn("Could not register synth_event_ops\n");
-		return err;
-	}
+
+	return err;
+}
+core_initcall(trace_events_synth_init_early);
+
+static __init int trace_events_synth_init(void)
+{
+	struct dentry *entry = NULL;
+	struct dentry *d_tracer;
+	int err = 0;
 
 	d_tracer = tracing_init_dentry();
 	if (IS_ERR(d_tracer)) {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e33690a12255..a6a08199e79f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1896,8 +1896,8 @@ static __init void setup_boot_kprobe_events(void)
 }
 
 /*
- * Register dynevent at subsys_initcall. This allows kernel to setup kprobe
- * events in fs_initcall without tracefs.
+ * Register dynevent at core_initcall. This allows kernel to setup kprobe
+ * events in postcore_initcall without tracefs.
  */
 static __init int init_kprobe_trace_early(void)
 {
@@ -1912,7 +1912,7 @@ static __init int init_kprobe_trace_early(void)
 
 	return 0;
 }
-subsys_initcall(init_kprobe_trace_early);
+core_initcall(init_kprobe_trace_early);
 
 /* Make a tracefs interface for controlling probe points */
 static __init int init_kprobe_trace(void)

