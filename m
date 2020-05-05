Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F272C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7485E206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G768Va8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgEENlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEENlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:41:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC63DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:41:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so841200plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BsCTpVIH2hYgIyAZzwlMyXVEC7jiBc22QaQN/32S3rc=;
        b=G768Va8Tw4djhjT/eMQr63Ic+SIDXuohirY4qS9/+QpDD6MQbjtyd9T9N1GkCa1po3
         bPJ5r4pkhRaxEvcuJ4dkvVA7Ti9eImuuD5HyWQKpShWMFci8S0vFy/KiSqUleudqZpVE
         a5PrDy+L3dOGtHleS50WiETG+WWVDCXDROorYA5n8E1tX00FVPRxKp3Y01qKxPneFLsp
         B2ly2K6O1V35bB1mpUrIFbagRJJ+VZflA8NASXDIXaGsXpHleDT1CVNp//kOF6aj4im/
         kFxnSpYwsArafr5KQ+gs5I9uFz8ViMOy3nHt3Nnw9nz26+imBJxe+XD9OsBKCB0T4Ptd
         +fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BsCTpVIH2hYgIyAZzwlMyXVEC7jiBc22QaQN/32S3rc=;
        b=VC6jmpzeUusvtBGjrvRAOqE9DKPkieSKxEq72fmNsazIhKPZlImF+6qxY8lxXYn4lb
         N7mIID92d9QwLCJa5IE7U0Bk+8CoeXaVb7Ct4pAi7AO2CLisKReKd0HvaZuo6XuBU+15
         zo3WwoMLOiZhuj1+wpExW2l2MDLZh/bnvM53iCvGWKo03mgfB/vB3fkxphqnPav3ixEX
         g3S+dVGd23a9Vp7mx7amvmqWguwFqIX3xVD8nh/XSZbad8jytbWVg9Ny8S0mFtEz17dS
         wgk3DlYgF0vh49K/KcFsUGVKqAEBzRIQ7gNSOGI1ZgAwFjK/aufV/cYx3mJCgaZTrgiX
         u7MA==
X-Gm-Message-State: AGi0PuYl8TjxtvQumyQ+wAfPd0Ny5atXIEK0i1NgEO1wYfuqc4cL/UZ6
        dFna8/c5XIqWmkNspvY7Iha3l5li
X-Google-Smtp-Source: APiQypLK8mEGpvD7solf+uZ1AOOzOnLCG+W770KX2w84hkuYwkcDXITXIISOJ1jwitZJAYfEU6ubsw==
X-Received: by 2002:a17:902:8496:: with SMTP id c22mr3265291plo.182.1588686061336;
        Tue, 05 May 2020 06:41:01 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id b1sm2076944pfi.140.2020.05.05.06.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:41:00 -0700 (PDT)
Date:   Tue, 5 May 2020 21:40:56 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        iwtbavbm@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix nohz.next_balance update
Message-ID: <20200505134056.GA31680@iZj6chx1xj0e0buvshuecpZ>
References: <20200503083407.GA27766@iZj6chx1xj0e0buvshuecpZ>
 <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNG9Y4xNA-iLd+JRRsUCA1+SkkFFRbbzk5n7q6v401tw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 05:17:11PM +0200, Vincent Guittot wrote:
> On Sun, 3 May 2020 at 10:34, Peng Liu <iwtbavbm@gmail.com> wrote:
> >
> > commit c5afb6a87f23 ("sched/fair: Fix nohz.next_balance update")
> > During idle load balance, this_cpu(ilb) do load balance for the other
> > idle CPUs, also gather the earliest (nohz.)next_balance.
> >
> > Since commit:
> >   'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
> >
> > We update nohz.next_balance like this:
> >
> >   _nohz_idle_balance() {
> >       for_each_cpu(nohz.idle_cpus_mask) {
> >           rebalance_domains() {
> >               update nohz.next_balance <-- compare and update
> >           }
> >       }
> >       rebalance_domains(this_cpu) {
> >           update nohz.next_balance <-- compare and update
> >       }
> >       update nohz.next_balance <-- unconditionally update
> >   }
> >
> > For instance, nohz.idle_cpus_mask spans {cpu2,3,5,8}, and this_cpu is
> > cpu5. After the above loop we could gather the earliest *next_balance*
> > among {cpu2,3,8}, then rebalance_domains(this_cpu) update
> > nohz.next_balance with this_rq->next_balance, but finally overwrite
> > nohz.next_balance with the earliest *next_balance* among {cpu2,3,8},
> > we may end up with not getting the earliest next_balance.
> >
> > Since we can gather all the updated rq->next_balance, including this_cpu,
> > in _nohz_idle_balance(), it's safe to remove the extra lines in
> > rebalance_domains() which are originally intended for this_cpu. And
> > finally the updating only happen in _nohz_idle_balance().
> 
> I'm not sure that's always true. Nothing prevents nohz_idle_balance()
> to return false . Then run_rebalance_domains() calls
> rebalance_domains(this_rq ,SCHED_IDLE) outside _nohz_idle_balance().
> In this case we must keep the code in rebalance_domains().
> 
> For example when the tick is not stopped when entering idle. Or when
> need_resched() returns true.
> 
> So instead of removing the code from rebalance_domains, you should
> move the one in _nohz_idle_balance() to make sure that the "if
> (likely(update_next_balance)) ..." is called before calling
> rebalance_domains for the local cpu
> 

Yes, you're right. When need_resched() returns true, things become out
of expectation. We haven't really got the earliest next_balance, abort
the update immediately and let the successor to help. Doubtless this
will incur some overhead due to the repeating work.

About the "tick is not stopped when entering idle" case, defer the
update to nohz_balance_enter_idle() would be a choice too.

Of course, only update nohz.next_balance in rebalance_domains() is the
simpliest way, but as @Valentin put, too many write to it may incur
unnecessary overhead. If we can gather the earliest next_balance in
advance, then a single write is considered to be better.

By the way, remove the redundant check in nohz_idle_balance().

FWIW, how about the below?
***********************************************
* Below code is !!!ENTIRELY UNTESTED!!!, just *
* a draft to see whehter it's sensible!       *
***********************************************
-------------------<-----------------------
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..a7d63ea706ac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9943,22 +9943,8 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	 * When the cpu is attached to null domain for ex, it will not be
 	 * updated.
 	 */
-	if (likely(update_next_balance)) {
+	if (likely(update_next_balance))
 		rq->next_balance = next_balance;
-
-#ifdef CONFIG_NO_HZ_COMMON
-		/*
-		 * If this CPU has been elected to perform the nohz idle
-		 * balance. Other idle CPUs have already rebalanced with
-		 * nohz_idle_balance() and nohz.next_balance has been
-		 * updated accordingly. This CPU is now running the idle load
-		 * balance for itself and we need to update the
-		 * nohz.next_balance accordingly.
-		 */
-		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
-			nohz.next_balance = rq->next_balance;
-#endif
-	}
 }

 static inline int on_null_domain(struct rq *rq)
@@ -10218,6 +10204,9 @@ void nohz_balance_enter_idle(int cpu)

 	rq->nohz_tick_stopped = 1;

+	if (time_after(nohz.next_balance, rq->next_balance))
+		nohz.next_balance = rq->next_balance;
+
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
 	atomic_inc(&nohz.nr_cpus);

@@ -10287,6 +10276,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		 */
 		if (need_resched()) {
 			has_blocked_load = true;
+			update_next_balance = 0;
 			goto abort;
 		}

@@ -10321,9 +10311,15 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		has_blocked_load |= this_rq->has_blocked_load;
 	}

-	if (flags & NOHZ_BALANCE_KICK)
+	if (flags & NOHZ_BALANCE_KICK) {
 		rebalance_domains(this_rq, CPU_IDLE);

+		if (time_after(next_balance, this_rq->next_balance)) {
+			next_balance = this_rq->next_balance;
+			update_next_balance = 1;
+		}
+	}
+
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));

@@ -10354,9 +10350,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
 	int this_cpu = this_rq->cpu;
 	unsigned int flags;
-
-	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
-		return false;
+	bool done;

 	if (idle != CPU_IDLE) {
 		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
@@ -10368,9 +10362,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (!(flags & NOHZ_KICK_MASK))
 		return false;

-	_nohz_idle_balance(this_rq, flags, idle);
+	/*
+	 * If idle load balance terinated due to this CPU become busy,
+	 * pretend it has successfully pulled some loads, and abort
+	 * the following load balance.
+	 */
+	done = _nohz_idle_balance(this_rq, flags, idle);
+	if (done == false && need_resched())
+		return true;

-	return true;
+	return done;
 }

 static void nohz_newidle_balance(struct rq *this_rq)
