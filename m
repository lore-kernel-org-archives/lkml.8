Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C92C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED55246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696726;
	bh=o+o0M9tu1mUFpsW0wcJx7bRm3a8dmU2NUuterE4EqvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVP+oxjD+WWYLnRbn45xAYhuIkqlYRr4ueyUgft3wuDMivDUrVU/TFXtLwkqwx3hX
	 iYNavobi6j5jDSLdF6DlC+6riMY6skDiyYBXGWd2D0+FWdRVkmO3e9Crzfr1rZ7+UJ
	 B4c3iJ1zwGXZpOYpc908CO9tMnT75jkOGzKQtdEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbgBNQMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391651AbgBNQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49844246A4;
        Fri, 14 Feb 2020 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696652;
        bh=o+o0M9tu1mUFpsW0wcJx7bRm3a8dmU2NUuterE4EqvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7PpOhOW6zvyFdaUdjOTgO16xB9MP0gyhfpXZGM9oxJqW1D3Ew9NNnMwCpvpOu8sk
         ENlIjzbGiwQHgl5eQRNss7xrfrA9Z+w2rQGP49QnFVku1/GvVxago6YLYUO/QPxByC
         1S+/ISn+KwCbHjY6LbomTQuvwSG+raVkqNpPUW/Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 428/459] trigger_next should increase position index
Date:   Fri, 14 Feb 2020 11:01:18 -0500
Message-Id: <20200214160149.11681-428-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 6722b23e7a2ace078344064a9735fb73e554e9ef ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Without patch:
 # dd bs=30 skip=1 if=/sys/kernel/tracing/events/sched/sched_switch/trigger
 dd: /sys/kernel/tracing/events/sched/sched_switch/trigger: cannot skip to specified offset
 n traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 # Available triggers:
 # traceon traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 6+1 records in
 6+1 records out
 206 bytes copied, 0.00027916 s, 738 kB/s

Notice the printing of "# Available triggers:..." after the line.

With the patch:
 # dd bs=30 skip=1 if=/sys/kernel/tracing/events/sched/sched_switch/trigger
 dd: /sys/kernel/tracing/events/sched/sched_switch/trigger: cannot skip to specified offset
 n traceoff snapshot stacktrace enable_event disable_event enable_hist disable_hist hist
 2+1 records in
 2+1 records out
 88 bytes copied, 0.000526867 s, 167 kB/s

It only prints the end of the file, and does not restart.

Link: http://lkml.kernel.org/r/3c35ee24-dd3a-8119-9c19-552ed253388a@virtuozzo.com

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 40106fff06a48..287d77eae59b3 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -116,9 +116,10 @@ static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
 {
 	struct trace_event_file *event_file = event_file_data(m->private);
 
-	if (t == SHOW_AVAILABLE_TRIGGERS)
+	if (t == SHOW_AVAILABLE_TRIGGERS) {
+		(*pos)++;
 		return NULL;
-
+	}
 	return seq_list_next(t, &event_file->triggers, pos);
 }
 
-- 
2.20.1

