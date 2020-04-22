Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426FC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84E42073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552601;
	bh=Yq/4dSBQMcLbsy7yk8jjhK3ecu2E/bi+KFr3L6FhotQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHgfJQVEwI5IRDtXA/RIuq2/H7lhunKEbgkQdS0KKqS0d5hFId3JmGq9oBu/lWKbu
	 1sUk4FYgzV6DOQHjFeiic/g1qM2LGSnJKXXFgso6/oIh2HU/N6aNJAtOoIWpND6FxY
	 GBDUrCk6rR084pPkaXEyHn2bFNmuFJSn8bAfGQP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgDVKuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgDVKM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:12:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54702070B;
        Wed, 22 Apr 2020 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550376;
        bh=Yq/4dSBQMcLbsy7yk8jjhK3ecu2E/bi+KFr3L6FhotQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHhIhVxLQ6xytfkxj9g7bHeba/3TcxI8LE4eoBncGEgcgs8rdel4YoYmFmCrOfjKP
         mlE7zATKMqYdbENfO/QN9JYlxXw4qt2CQYiCMFqlzRulHAtJDVfIm/WDIeIW33BU7T
         kMwINjW4sm3n4udVd8tjyDKiUO6k9004eNKqFnNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 121/199] tracing: Fix the race between registering snapshot event trigger and triggering snapshot operation
Date:   Wed, 22 Apr 2020 11:57:27 +0200
Message-Id: <20200422095109.673056616@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

commit 0bbe7f719985efd9adb3454679ecef0984cb6800 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_trigger.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1075,14 +1075,10 @@ register_snapshot_trigger(char *glob, st
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	int ret = register_trigger(glob, ops, data, file);
+	if (tracing_alloc_snapshot_instance(file->tr) != 0)
+		return 0;
 
-	if (ret > 0 && tracing_alloc_snapshot_instance(file->tr) != 0) {
-		unregister_trigger(glob, ops, data, file);
-		ret = 0;
-	}
-
-	return ret;
+	return register_trigger(glob, ops, data, file);
 }
 
 static int


