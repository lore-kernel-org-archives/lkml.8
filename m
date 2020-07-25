Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840C7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5658D20674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595674052;
	bh=D+OlUFIKHFsGPg+EcHtEVQ79GrmeWwK/Ft46bQop9ek=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yl31qT4WPf2z7v68eVorNsm3JGtXuCUf2Zb9JQWtdcSk/eStznR5rezomcrb3gZtX
	 fJYTLEOFnJjucPOS1P8bxFSEaPpEj4IEpRvY+7FIiGUWXv4FAx7582ze1MZRr3+VS7
	 PZ/C9xHC4E41pg0RwazOJH7UztznIoX/zG4ntKhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGYKra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:47:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB6C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:47:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bm28so8764849edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nKZZUZLtBdss6MLIYizDjF6vswJxIgYnfX5J9vknXv0=;
        b=eFVLbRVVF0/gIuHAC6jmueFuRVuVYnxv9llMNOCkNQNL8phBTzPLZVdbFmn+I8hW1i
         eIAzEHZcVM0TG4TelqrAv99jr3V/h4Gm1fhxPuAGLLGWLaHQOhBDgeUqF392WJO3MXjI
         7A71FI5Un1fEJeb2QVR+OMBkCPBWtsCAkr/A9vOY3NPDRzR0Xq/wu2iBtuDfgPwuoB14
         gbR89G/7fIMNgsriWt+whiR+AKATdKDelvRZguh9EeP+Ys+NlGitQmpkbEBSc6LA5osG
         V70zm36lLR7xUutW+OvHNKSzQLNeiBvOLRD2xNwrHYWWXkwB8o0suKvFSYUOcA15Ui6s
         80/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=nKZZUZLtBdss6MLIYizDjF6vswJxIgYnfX5J9vknXv0=;
        b=fxRYeT84QgP7fSiy4Fy070nw/xK/xD+ucpg2ItLdotKjxCAzBX3eVn5rFg4Yq694FB
         NI5HDHG3oDahz0rzcC1awmN4cV6ak3PDIqGeukChVUr5TJ7rr75wNkHr+ogyP/Li3TmZ
         tMjPev2JEoNEGMRV4OS6XcomV9Dt2FmsM8yylXdOkcLO4xHqKVTeYNzC/23Lg1TTECqK
         29i5YoKCUZdTWLsmgwunpd7+8WsQ9K9rlNDFIgXoFIEy8CW0Lei4bNb/4mFUMOkBpeyj
         VQtP0ZEExTUPLGGBbw4eCty1vdfXhtPM2rgdeLdon469+mTDp1st9FUx548pn2pXixkj
         mWCw==
X-Gm-Message-State: AOAM532dkMf4gaSU4VxQoQfV2oc6+Pc52oZx3otpMrUIrFufBWvkhocx
        EFQ3AfthoOTiGV7V7hFrwLhcOnFJ
X-Google-Smtp-Source: ABdhPJxp4CS4v/1qrUntY/5BkQzjQgCD/mzi1e4LeNdqETi1n5JPOtydea5/fz5ieP+5yvEfiuVOQg==
X-Received: by 2002:a05:6402:1845:: with SMTP id v5mr935502edy.66.1595674042906;
        Sat, 25 Jul 2020 03:47:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d5sm2737633eds.40.2020.07.25.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:47:22 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:47:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20200725104720.GA824189@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-07-25

   # HEAD: 062d3f95b630113e1156a31f376ad36e25da29a7 sched: Warn if garbage is passed to default_wake_function()

Fix a race introduced by the recent loadavg race fix, plus add a
debug check for a hard to debug case of bogus wakeup function flags.

 Thanks,

	Ingo

------------------>
Chris Wilson (1):
      sched: Warn if garbage is passed to default_wake_function()

Peter Zijlstra (1):
      sched: Fix race against ptrace_freeze_trace()


 kernel/sched/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543cb8481..2142c6767682 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4119,9 +4119,6 @@ static void __sched notrace __schedule(bool preempt)
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
-	/* See deactivate_task() below. */
-	prev_state = prev->state;
-
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
@@ -4145,11 +4142,16 @@ static void __sched notrace __schedule(bool preempt)
 	update_rq_clock(rq);
 
 	switch_count = &prev->nivcsw;
+
 	/*
-	 * We must re-load prev->state in case ttwu_remote() changed it
-	 * before we acquired rq->lock.
+	 * We must load prev->state once (task_struct::state is volatile), such
+	 * that:
+	 *
+	 *  - we form a control dependency vs deactivate_task() below.
+	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
-	if (!preempt && prev_state && prev_state == prev->state) {
+	prev_state = prev->state;
+	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			prev->state = TASK_RUNNING;
 		} else {
@@ -4163,10 +4165,12 @@ static void __sched notrace __schedule(bool preempt)
 
 			/*
 			 * __schedule()			ttwu()
-			 *   prev_state = prev->state;	  if (READ_ONCE(p->on_rq) && ...)
-			 *   LOCK rq->lock		    goto out;
-			 *   smp_mb__after_spinlock();	  smp_acquire__after_ctrl_dep();
-			 *   p->on_rq = 0;		  p->state = TASK_WAKING;
+			 *   prev_state = prev->state;    if (p->on_rq && ...)
+			 *   if (prev_state)		    goto out;
+			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
+			 *				  p->state = TASK_WAKING
+			 *
+			 * Where __schedule() and ttwu() have matching control dependencies.
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
@@ -4481,6 +4485,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
