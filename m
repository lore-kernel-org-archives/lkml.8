Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D923C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BC520656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgDPBkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbgDPBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:40:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC1520656;
        Thu, 16 Apr 2020 01:40:34 +0000 (UTC)
Date:   Wed, 15 Apr 2020 21:40:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [GIT PULL] tracing: Fix the race between registering 'snapshot'
 event trigger and triggering 'snapshot' operation
Message-ID: <20200415214033.47e3f95f@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fixes a small race between allocating a snapshot buffer and setting the
snapshot trigger. On a slow machine, the trigger can occur before the
snapshot is allocated causing a warning to be displayed in the ring buffer,
and no snapshot triggering. Reversing the allocation and the enabling of the
trigger fixes the problem.


Please pull the latest trace-v5.7-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7-rc1

Tag SHA1: c27f0128144b8ec3d133d39c81ccdbb53ce811e8
Head SHA1: 0bbe7f719985efd9adb3454679ecef0984cb6800


Xiao Yang (1):
      tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation

----
 kernel/trace/trace_events_trigger.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)
---------------------------
commit 0bbe7f719985efd9adb3454679ecef0984cb6800
Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date:   Tue Apr 14 09:51:45 2020 +0800

    tracing: Fix the race between registering 'snapshot' event trigger and triggering 'snapshot' operation
    
    Traced event can trigger 'snapshot' operation(i.e. calls snapshot_trigger()
    or snapshot_count_trigger()) when register_snapshot_trigger() has completed
    registration but doesn't allocate buffer for 'snapshot' event trigger.  In
    the rare case, 'snapshot' operation always detects the lack of allocated
    buffer so make register_snapshot_trigger() allocate buffer first.
    
    trigger-snapshot.tc in kselftest reproduces the issue on slow vm:
    -----------------------------------------------------------
    cat trace
    ...
    ftracetest-3028  [002] ....   236.784290: sched_process_fork: comm=ftracetest pid=3028 child_comm=ftracetest child_pid=3036
         <...>-2875  [003] ....   240.460335: tracing_snapshot_instance_cond: *** SNAPSHOT NOT ALLOCATED ***
         <...>-2875  [003] ....   240.460338: tracing_snapshot_instance_cond: *** stopping trace here!   ***
    -----------------------------------------------------------
    
    Link: http://lkml.kernel.org/r/20200414015145.66236-1-yangx.jy@cn.fujitsu.com
    
    Cc: stable@vger.kernel.org
    Fixes: 93e31ffbf417a ("tracing: Add 'snapshot' event trigger command")
    Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index dd34a1b46a86..3a74736da363 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1088,14 +1088,10 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = register_trigger(glob, ops, data, file);
-
-	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
-		unregister_trigger(glob, ops, data, file);
-		ret = 0;
-	}
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
-	return ret;
+	return register_trigger(glob, ops, data, file);
 }
 
 static int
