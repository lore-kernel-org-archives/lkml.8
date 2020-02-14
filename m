Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F1F2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698568;
	bh=Pi388ptHgVYkZ8WA+e2JmRExMa36mn92aIiORGlgohw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0d8I1v8btPUpKXZHfqt38BQe1FOpVGTsGk5MGBd4FfQGqML1Q9Ie3sLjkBY6vIpb
	 3RFJ7rZTjPMdsXMzz/YMhjlFP6TlsMdiyRSIhZqFvwydabOWhl6akjkwQtr+sa5x+B
	 Mb7bd4ofBreKN5QB24ZMoeek+YEgojq2O4a2RQjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405419AbgBNQWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390590AbgBNQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:20:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B021E24746;
        Fri, 14 Feb 2020 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697255;
        bh=Pi388ptHgVYkZ8WA+e2JmRExMa36mn92aIiORGlgohw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyjyyvEwG5pKyBkA/PtLgU00jhfegg9geDZg2J2QtvGj46CR2LVQnghBZmg4P8NRO
         AFOfYEytYlbmrQKiVttfo47gexoH8dDJgUSy1Dqoe6OQ2h5sx+NakS2Ya4fHlGcek3
         GOvb13eN928J0jCyo44oWNDlH0st3rcR7eaMPL98=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 172/186] ftrace: fpid_next() should increase position index
Date:   Fri, 14 Feb 2020 11:17:01 -0500
Message-Id: <20200214161715.18113-172-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit e4075e8bdffd93a9b6d6e1d52fabedceeca5a91b ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

Without patch:
 # dd bs=4 skip=1 if=/sys/kernel/tracing/set_ftrace_pid
 dd: /sys/kernel/tracing/set_ftrace_pid: cannot skip to specified offset
 id
 no pid
 2+1 records in
 2+1 records out
 10 bytes copied, 0.000213285 s, 46.9 kB/s

Notice the "id" followed by "no pid".

With the patch:
 # dd bs=4 skip=1 if=/sys/kernel/tracing/set_ftrace_pid
 dd: /sys/kernel/tracing/set_ftrace_pid: cannot skip to specified offset
 id
 0+1 records in
 0+1 records out
 3 bytes copied, 0.000202112 s, 14.8 kB/s

Notice that it only prints "id" and not the "no pid" afterward.

Link: http://lkml.kernel.org/r/4f87c6ad-f114-30bb-8506-c32274ce2992@virtuozzo.com

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3864d23414429..3d0ffee0ed78f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6310,9 +6310,10 @@ static void *fpid_next(struct seq_file *m, void *v, loff_t *pos)
 	struct trace_array *tr = m->private;
 	struct trace_pid_list *pid_list = rcu_dereference_sched(tr->function_pids);
 
-	if (v == FTRACE_NO_PIDS)
+	if (v == FTRACE_NO_PIDS) {
+		(*pos)++;
 		return NULL;
-
+	}
 	return trace_pid_next(pid_list, v, pos);
 }
 
-- 
2.20.1

