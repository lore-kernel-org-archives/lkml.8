Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D765C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED1320769
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588775358;
	bh=AI9x0xuZnv9+yQgyWPjO6l+C5qqXvu+8N9ZTrnmdLqQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JqTk6hTggZOje2CcGdAYaWnmDTsjrVs61Y+puriWEsmYkPgOKVm7LwbVrkPGRuGQi
	 g0nYQXDFtQctteef9wsSQlN3ApclwUeYdokhQ3JsOn7H8dwOQoSyxgaQ+wBuIewssN
	 EEtVJO70yNFsn3I1hL873EziQC1W/cF98/vYmKbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEFO3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEFO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:29:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5616206DB;
        Wed,  6 May 2020 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588775356;
        bh=AI9x0xuZnv9+yQgyWPjO6l+C5qqXvu+8N9ZTrnmdLqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l9ziEJ+J23audz5AAB8xRp6meeYXG0H4Vl2HNGDyIhk4r3CAfPnRYcjESzr4Y7UkJ
         G96hwbUonGmeP3OEKHV1bYmcxci/JWls7X6RVUP3OzK+tnMQU6iehmPmVUen/3Z9h3
         F3DkdQAufnb1EE6E4jyAeob0c7IOge0eOmFki6Ss=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf-probe: Accept the instance number of kretprobe event
Date:   Wed,  6 May 2020 23:29:12 +0900
Message-Id: <158877535215.26469.1113127926699134067.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 6a13a0d7b4d1 ("ftrace/kprobe: Show the
maxactive number on kprobe_events") introduced to show the
instance number of kretprobe events, the length of the 1st
format of the kprobe event will not 1, but it can be longer.
This caused a parser error in perf-probe.

Skip the length check the 1st format of the kprobe event
to accept this instance number.

Without this fix:

  # perf probe -a vfs_read%return
  Added new event:
    probe:vfs_read__return (on vfs_read%return)

  You can now use it in all perf tools, such as:

  	perf record -e probe:vfs_read__return -aR sleep 1

  # perf probe -l
  Semantic error :Failed to parse event name: r16:probe/vfs_read__return
    Error: Failed to show event list.

And with this fixes:

  # perf probe -a vfs_read%return
  ...
  # perf probe -l
    probe:vfs_read__return (on vfs_read%return)


Fixes: 6a13a0d7b4d1 ("ftrace/kprobe: Show the maxactive number on kprobe_events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=207587
---
 tools/perf/util/probe-event.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index eea132f512b0..c6bcf5709564 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1765,8 +1765,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 	fmt1_str = strtok_r(argv0_str, ":", &fmt);
 	fmt2_str = strtok_r(NULL, "/", &fmt);
 	fmt3_str = strtok_r(NULL, " \t", &fmt);
-	if (fmt1_str == NULL || strlen(fmt1_str) != 1 || fmt2_str == NULL
-	    || fmt3_str == NULL) {
+	if (fmt1_str == NULL || fmt2_str == NULL || fmt3_str == NULL) {
 		semantic_error("Failed to parse event name: %s\n", argv[0]);
 		ret = -EINVAL;
 		goto out;

