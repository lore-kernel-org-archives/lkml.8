Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5572067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584840;
	bh=2UiOKpwvFOU5Vo8N/enJfvVJn4GIF4DuO5f6nV7hmE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bA1TzJoz+1bc9BegjXhh72tCXCTvLDmt1qihHbTzvtvnkg3OSqDv/438a8pVJ0W70
	 Fe2dQAEYfoglZsR6AEhSjv6W6KQ0UeJCfJbz1vMDbBZmjIpEcMubgPR6m+2qcezG8Y
	 jDzP9tIyBw7hmzDGztglNj+iLRhlblXzVdq8kCNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395442AbgFSQki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388326AbgFSOp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44C7720A8B;
        Fri, 19 Jun 2020 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577925;
        bh=2UiOKpwvFOU5Vo8N/enJfvVJn4GIF4DuO5f6nV7hmE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W24456n3XmqRUHRiINpVyAPWpYyzQuyc/0JJlU8YQNzS+useZAZrwR61pxhr8QJa2
         UyxDNZbyICPOZ3b8sZxANSOdPBc8pyIiW2J0evM1QsRxl2YgV/DWc4f31Ela6S/nsH
         ZBvpwZY7Gmwu/PIHLfNlMvTqaEK5kDRRjmVbV39o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuxuan Shui <yshuiv7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 016/190] perf probe: Accept the instance number of kretprobe event
Date:   Fri, 19 Jun 2020 16:31:01 +0200
Message-Id: <20200619141634.273433018@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit c6aab66a728b6518772c74bd9dff66e1a1c652fd ]

Since the commit 6a13a0d7b4d1 ("ftrace/kprobe: Show the maxactive number
on kprobe_events") introduced to show the instance number of kretprobe
events, the length of the 1st format of the kprobe event will not 1, but
it can be longer.  This caused a parser error in perf-probe.

Skip the length check the 1st format of the kprobe event to accept this
instance number.

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
Reported-by: Yuxuan Shui <yshuiv7@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Yuxuan Shui <yshuiv7@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207587
Link: http://lore.kernel.org/lkml/158877535215.26469.1113127926699134067.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6670e12a2bb3..6062ae817ff7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1762,8 +1762,7 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 	fmt1_str = strtok_r(argv0_str, ":", &fmt);
 	fmt2_str = strtok_r(NULL, "/", &fmt);
 	fmt3_str = strtok_r(NULL, " \t", &fmt);
-	if (fmt1_str == NULL || strlen(fmt1_str) != 1 || fmt2_str == NULL
-	    || fmt3_str == NULL) {
+	if (fmt1_str == NULL || fmt2_str == NULL || fmt3_str == NULL) {
 		semantic_error("Failed to parse event name: %s\n", argv[0]);
 		ret = -EINVAL;
 		goto out;
-- 
2.25.1



