Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609610;
	bh=V4Vj4iXVZCOwvr/0Kky48M0kWDdquu7/d64KrYgidMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwKRasxn74ypC5eqdT1AIs9nycSTs2l5wK9Vp5hmZ/hs2jB7S2HGdymLxJal+dxVa
	 KOjU5ShF7ADKYk6TfAEsOg2cjglkhiWCE6WnXUUFB9+NLvFMZk3p/Wzxco8Xu5f/Za
	 1iaVBP20Lw0a/9no9hftM+3telMR7Dh1Aa1eZVjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgBMQAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgBMPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:49 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C5720848;
        Thu, 13 Feb 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607488;
        bh=V4Vj4iXVZCOwvr/0Kky48M0kWDdquu7/d64KrYgidMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8flxxld25WEhMFqSDAHr+Sag22jhBOOzXzcTc+kmI02yT5ZX516QAz9FbFb6p+lb
         fd2WZAoIPv9/f4Aro40sxmTpm3+GsFN4UMQSjG29xQJobrelSzyulGZAco0lXtMBEl
         /9V/0JdsZMik3olCpdAcQK0kfHnSNMT7NE/QXezQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 4.14 020/173] tracing: Fix sched switch start/stop refcount racy updates
Date:   Thu, 13 Feb 2020 07:18:43 -0800
Message-Id: <20200213151938.226429469@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 64ae572bc7d0060429e40e1c8d803ce5eb31a0d6 upstream.

Reading the sched_cmdline_ref and sched_tgid_ref initial state within
tracing_start_sched_switch without holding the sched_register_mutex is
racy against concurrent updates, which can lead to tracepoint probes
being registered more than once (and thus trigger warnings within
tracepoint.c).

[ May be the fix for this bug ]
Link: https://lore.kernel.org/r/000000000000ab6f84056c786b93@google.com

Link: http://lkml.kernel.org/r/20190817141208.15226-1-mathieu.desnoyers@efficios.com

Cc: stable@vger.kernel.org
CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
CC: Joel Fernandes (Google) <joel@joelfernandes.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Paul E. McKenney <paulmck@linux.ibm.com>
Reported-by: syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com
Fixes: d914ba37d7145 ("tracing: Add support for recording tgid of tasks")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_sched_switch.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -89,8 +89,10 @@ static void tracing_sched_unregister(voi
 
 static void tracing_start_sched_switch(int ops)
 {
-	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+	bool sched_register;
+
 	mutex_lock(&sched_register_mutex);
+	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
 
 	switch (ops) {
 	case RECORD_CMDLINE:


