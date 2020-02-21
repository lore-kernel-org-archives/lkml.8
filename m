Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06320C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE08222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271964;
	bh=o+o0M9tu1mUFpsW0wcJx7bRm3a8dmU2NUuterE4EqvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSk2QPEOUreBmiNingwbUFg/s2wnR1373ABAxShCnGzeEF87lDkVRxXX8IrHIdJ1U
	 pzPhFSl31d28m1gu3jiwR2glsFm+3hyJ45HNqsvR0YfDRciiCxKAhmYXboeAMH8EUZ
	 jfUGUws9Z+m5g6QFejr48J5ZnOKEYjn24WeowoGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgBUH7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbgBUH7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:59:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEB620578;
        Fri, 21 Feb 2020 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271959;
        bh=o+o0M9tu1mUFpsW0wcJx7bRm3a8dmU2NUuterE4EqvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsmV/0zFe2hoTaAPt6zOhoZD0cpadN2C6gKWD+r+VDVwxgOiGsN6y2DZLah9qtYHB
         +T6eul0znHRA4m/pRygRmR3K9/Q0AVIde8X2qV04G+gtgkOHPwu/5ZOFLkv+s0umnh
         XQxD0CyCI8FNLDeAfa0I7Hh3sQ97QJgP4re4zSfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 364/399] trigger_next should increase position index
Date:   Fri, 21 Feb 2020 08:41:29 +0100
Message-Id: <20200221072436.038385515@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



