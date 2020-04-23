Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA72C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497DE20784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgDWXHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:07:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49748 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728428AbgDWXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:48 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvU-0004hq-2r; Fri, 24 Apr 2020 00:06:36 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvS-00E6ru-Kc; Fri, 24 Apr 2020 00:06:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kaitao Cheng" <pilgrimtao@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Fri, 24 Apr 2020 00:06:23 +0100
Message-ID: <lsq.1587683028.183327539@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 156/245] kernel/trace: Fix do not unregister
 tracepoints when register sched_migrate_task fail
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kaitao Cheng <pilgrimtao@gmail.com>

commit 50f9ad607ea891a9308e67b81f774c71736d1098 upstream.

In the function, if register_trace_sched_migrate_task() returns error,
sched_switch/sched_wakeup_new/sched_wakeup won't unregister. That is
why fail_deprobe_sched_switch was added.

Link: http://lkml.kernel.org/r/20191231133530.2794-1-pilgrimtao@gmail.com

Fixes: 478142c39c8c2 ("tracing: do not grab lock in wakeup latency function tracing")
Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_sched_wakeup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -567,7 +567,7 @@ static void start_wakeup_tracer(struct t
 	if (ret) {
 		pr_info("wakeup trace: Couldn't activate tracepoint"
 			" probe to kernel_sched_migrate_task\n");
-		return;
+		goto fail_deprobe_sched_switch;
 	}
 
 	wakeup_reset(tr);
@@ -585,6 +585,8 @@ static void start_wakeup_tracer(struct t
 		printk(KERN_ERR "failed to start wakeup tracer\n");
 
 	return;
+fail_deprobe_sched_switch:
+	unregister_trace_sched_switch(probe_wakeup_sched_switch, NULL);
 fail_deprobe_wake_new:
 	unregister_trace_sched_wakeup_new(probe_wakeup, NULL);
 fail_deprobe:

