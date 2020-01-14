Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDFAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC46520678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996967;
	bh=hp3tyotnzJKkUh2bGZfuSWRRRn68vaaDLm7ShU8eO6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0mWIBCgR31yjzaAwsTZrqub99B72mmB42NPkzg55KjioZ6sI/xeE4Cd4ypPohhrM
	 fedwj45GLrllfaJwNlScnFtXkrPWQ7bJxq+vVsCO01jJhzErhYMzlqZD2yE2dyMCDC
	 kiwV/9T5YR+Izpxmu7Fj4q9YXgFNBP3/pfZxpYk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgANKQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbgANKKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B43A20678;
        Tue, 14 Jan 2020 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996599;
        bh=hp3tyotnzJKkUh2bGZfuSWRRRn68vaaDLm7ShU8eO6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=so8nOLiPwTnunJQttMjdBy+noJ+tKTJ46bqCx/4gdh7MpX543mPlcv7c9t9at/o5R
         /wgCpacdrDroSv3DCXZugkvl0aAV9iG4/SWHgYvezA3AgcF/Dy+9yJyQ/YZHthfaDx
         CjMycHSWVxDZMoQry3C4OOUUNOcOl0AItz9uXYqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kaitao Cheng <pilgrimtao@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 06/39] kernel/trace: Fix do not unregister tracepoints when register sched_migrate_task fail
Date:   Tue, 14 Jan 2020 11:01:40 +0100
Message-Id: <20200114094340.673452739@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

commit 50f9ad607ea891a9308e67b81f774c71736d1098 upstream.

In the function, if register_trace_sched_migrate_task() returns error,
sched_switch/sched_wakeup_new/sched_wakeup won't unregister. That is
why fail_deprobe_sched_switch was added.

Link: http://lkml.kernel.org/r/20191231133530.2794-1-pilgrimtao@gmail.com

Cc: stable@vger.kernel.org
Fixes: 478142c39c8c2 ("tracing: do not grab lock in wakeup latency function tracing")
Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_sched_wakeup.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -640,7 +640,7 @@ static void start_wakeup_tracer(struct t
 	if (ret) {
 		pr_info("wakeup trace: Couldn't activate tracepoint"
 			" probe to kernel_sched_migrate_task\n");
-		return;
+		goto fail_deprobe_sched_switch;
 	}
 
 	wakeup_reset(tr);
@@ -658,6 +658,8 @@ static void start_wakeup_tracer(struct t
 		printk(KERN_ERR "failed to start wakeup tracer\n");
 
 	return;
+fail_deprobe_sched_switch:
+	unregister_trace_sched_switch(probe_wakeup_sched_switch, NULL);
 fail_deprobe_wake_new:
 	unregister_trace_sched_wakeup_new(probe_wakeup, NULL);
 fail_deprobe:


