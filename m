Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D86FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6563F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260772;
	bh=mUdn7UuU3nwJp2IY9r4db0B/5TkIdr3gT2nHsWEQrW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7oYANA0obOJgszR8yV1zAhkqmqn/LgjU76sS9XUw1+L0J6yJju8d3lIshez2VYdn
	 AejfW6IAFVeteNNX0aOK/sp5mgDRchIX0OM/JveKwRNzD981LvbpJgAToEDjqoBwhz
	 5Ydlocenio3NSXpkcNFLxqKvhPpibDCvIrRo2Kcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgHXJTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgHXIzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:55:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53643207DF;
        Mon, 24 Aug 2020 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259352;
        bh=mUdn7UuU3nwJp2IY9r4db0B/5TkIdr3gT2nHsWEQrW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHFNMf1HAUNmXIFe1Y1M6EdA/jM+ABPi7HV2Yy8O9taVxJB4xOQ9Sy8VmyFKqUM1g
         ciChUsuJbawMLadqQi8K9A5W3bfW2dnXksWho9BmnMkB8pJZJm4OkW60AD7xjPgolK
         3YGPvJVKCh5R8Y9BdEM82UgO2lZ55L9yd2uFac9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang Chen <cl@rock-chips.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 4.19 19/71] kthread: Do not preempt current task if it is going to call schedule()
Date:   Mon, 24 Aug 2020 10:31:10 +0200
Message-Id: <20200824082356.854382859@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

commit 26c7295be0c5e6da3fa45970e9748be983175b1b upstream.

when we create a kthread with ktrhead_create_on_cpu(),the child thread
entry is ktread.c:ktrhead() which will be preempted by the parent after
call complete(done) while schedule() is not called yet,then the parent
will call wait_task_inactive(child) but the child is still on the runqueue,
so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
time,especially on startup.

  parent                             child
ktrhead_create_on_cpu()
  wait_fo_completion(&done) -----> ktread.c:ktrhead()
                             |----- complete(done);--wakeup and preempted by parent
 kthread_bind() <------------|  |-> schedule();--dequeue here
  wait_task_inactive(child)     |
   schedule_hrtimeout(1 jiffy) -|

So we hope the child just wakeup parent but not preempted by parent, and the
child is going to call schedule() soon,then the parent will not call
schedule_hrtimeout(1 jiffy) as the child is already dequeue.

The same issue for ktrhead_park()&&kthread_parkme().
This patch can save 120ms on rk312x startup with CONFIG_HZ=300.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200306070133.18335-2-cl@rock-chips.com
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kthread.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -190,8 +190,15 @@ static void __kthread_parkme(struct kthr
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
 
+		/*
+		 * Thread is going to call schedule(), do not preempt it,
+		 * or the caller of kthread_park() may spend more time in
+		 * wait_task_inactive().
+		 */
+		preempt_disable();
 		complete(&self->parked);
-		schedule();
+		schedule_preempt_disabled();
+		preempt_enable();
 	}
 	__set_current_state(TASK_RUNNING);
 }
@@ -236,8 +243,14 @@ static int kthread(void *_create)
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
+	/*
+	 * Thread is going to call schedule(), do not preempt it,
+	 * or the creator may spend more time in wait_task_inactive().
+	 */
+	preempt_disable();
 	complete(done);
-	schedule();
+	schedule_preempt_disabled();
+	preempt_enable();
 
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {


