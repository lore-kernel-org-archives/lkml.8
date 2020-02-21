Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A364DC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CC246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273517;
	bh=vlf97Y1nqpYO4jMzzG3f0waHkPIn4KcjspbyRaKjCcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLZqw3AEnybcMEDE0crf6eE2bvkwaZLM90xrDz4FL7O/QExG5DWzV+iSBOeFIUxcF
	 AxRIZyr6MONSAAN6nM4Pb+h0JJh+Duydds0Q2YFkXSaSGjDlBXN8q7bqbm5IolCCIe
	 KQIhwKkz7PPRfSHBGdQui4KID0DWArrUcy1w5Kc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgBUIZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbgBUIZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:25:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0891E2469D;
        Fri, 21 Feb 2020 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273508;
        bh=vlf97Y1nqpYO4jMzzG3f0waHkPIn4KcjspbyRaKjCcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfAM9JD7RfBsDZdmkiXYYNVwkWhAf6IHl284j+7x+zWAe9cdXcQRKvXATsB9KAzN8
         MNbT/cHw2/27nvRnjMRfNgzEWGcj20feATlOrCVDougsZhPu7vt4BAy/vOHPO+4J9/
         HKfYWulk91SuEJ8Fv7/Fbi+1GxZqB1B9p6oLfyqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 173/191] ftrace: fpid_next() should increase position index
Date:   Fri, 21 Feb 2020 08:42:26 +0100
Message-Id: <20200221072311.466978394@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 53795237e9751..0c379cd40bea3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6525,9 +6525,10 @@ static void *fpid_next(struct seq_file *m, void *v, loff_t *pos)
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



