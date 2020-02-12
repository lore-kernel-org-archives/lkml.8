Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgBLP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:59:31 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:58419 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727531AbgBLP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:59:31 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id B9F10FA7BD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:59:28 +0000 (GMT)
Received: (qmail 22674 invoked from network); 12 Feb 2020 15:59:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 15:59:28 -0000
Date:   Wed, 12 Feb 2020 15:59:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] sched/numa: Distinguish between the different
 task_numa_migrate failure cases
Message-ID: <20200212155927.GR3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <20200212093654.4816-6-mgorman@techsingularity.net>
 <20200212094308.04bcf8a2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200212094308.04bcf8a2@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:43:08AM -0500, Steven Rostedt wrote:
> > -DEFINE_EVENT(sched_move_task_template, sched_move_numa,
> > -	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
> > +TRACE_EVENT(sched_stick_numa,
> >  
> > -	TP_ARGS(tsk, src_cpu, dst_cpu)
> > -);
> > +	TP_PROTO(struct task_struct *src_tsk, int src_cpu, struct task_struct *dst_tsk, int dst_cpu),
> >  
> > -DEFINE_EVENT(sched_move_task_template, sched_stick_numa,
> > -	TP_PROTO(struct task_struct *tsk, int src_cpu, int dst_cpu),
> > +	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu),
> >  
> > -	TP_ARGS(tsk, src_cpu, dst_cpu)
> > +	TP_STRUCT__entry(
> > +		__field( pid_t,	src_pid			)
> > +		__field( pid_t,	src_tgid		)
> > +		__field( pid_t,	src_ngid		)
> > +		__field( int,	src_cpu			)
> > +		__field( int,	src_nid			)
> > +		__field( pid_t,	dst_pid			)
> > +		__field( pid_t,	dst_tgid		)
> > +		__field( pid_t,	dst_ngid		)
> > +		__field( int,	dst_cpu			)
> > +		__field( int,	dst_nid			)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->src_pid	= task_pid_nr(src_tsk);
> > +		__entry->src_tgid	= task_tgid_nr(src_tsk);
> > +		__entry->src_ngid	= task_numa_group_id(src_tsk);
> > +		__entry->src_cpu	= src_cpu;
> > +		__entry->src_nid	= cpu_to_node(src_cpu);
> > +		__entry->dst_pid	= dst_tsk ? task_pid_nr(dst_tsk) : 0;
> > +		__entry->dst_tgid	= dst_tsk ? task_tgid_nr(dst_tsk) : 0;
> > +		__entry->dst_ngid	= dst_tsk ? task_numa_group_id(dst_tsk) : 0;
> > +		__entry->dst_cpu	= dst_cpu;
> > +		__entry->dst_nid	= dst_cpu >= 0 ? cpu_to_node(dst_cpu) : -1;
> > +	),
> > +
> > +	TP_printk("src_pid=%d src_tgid=%d src_ngid=%d src_cpu=%d src_nid=%d dst_pid=%d dst_tgid=%d dst_ngid=%d dst_cpu=%d dst_nid=%d",
> > +			__entry->src_pid, __entry->src_tgid, __entry->src_ngid,
> > +			__entry->src_cpu, __entry->src_nid,
> > +			__entry->dst_pid, __entry->dst_tgid, __entry->dst_ngid,
> > +			__entry->dst_cpu, __entry->dst_nid)
> >  );
> >  
> 
> The above looks the same as the below sched_swap_numa. Can you make a
> DECLARE_EVENT_CLASS() and merge the two for sched_swap_numa?
> 
> Note, most the footprint of a trace event happens in the
> DECLARE_EVENT_CLASS() (a TRACE_EVENT() is just a DECLARE_EVENT_CLASS()
> and DEFINE_EVENT() put together). The more DECLARE_EVENT_CLASS()s you
> can share, the less the footprint is.
> 

No problem, I've it fixed aka, it builds. Thanks Steven

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 3d07c0af4ab8..f5b75c5fef7e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -523,9 +523,10 @@ TRACE_EVENT(sched_move_numa,
 			__entry->dst_cpu, __entry->dst_nid)
 );
 
-TRACE_EVENT(sched_stick_numa,
+DECLARE_EVENT_CLASS(sched_numa_pair_template,
 
-	TP_PROTO(struct task_struct *src_tsk, int src_cpu, struct task_struct *dst_tsk, int dst_cpu),
+	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
+		 struct task_struct *dst_tsk, int dst_cpu),
 
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu),
 
@@ -562,46 +563,23 @@ TRACE_EVENT(sched_stick_numa,
 			__entry->dst_cpu, __entry->dst_nid)
 );
 
-TRACE_EVENT(sched_swap_numa,
+DEFINE_EVENT(sched_numa_pair_template, sched_stick_numa,
 
 	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
 		 struct task_struct *dst_tsk, int dst_cpu),
 
-	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu),
+	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
+);
 
-	TP_STRUCT__entry(
-		__field( pid_t,	src_pid			)
-		__field( pid_t,	src_tgid		)
-		__field( pid_t,	src_ngid		)
-		__field( int,	src_cpu			)
-		__field( int,	src_nid			)
-		__field( pid_t,	dst_pid			)
-		__field( pid_t,	dst_tgid		)
-		__field( pid_t,	dst_ngid		)
-		__field( int,	dst_cpu			)
-		__field( int,	dst_nid			)
-	),
+DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 
-	TP_fast_assign(
-		__entry->src_pid	= task_pid_nr(src_tsk);
-		__entry->src_tgid	= task_tgid_nr(src_tsk);
-		__entry->src_ngid	= task_numa_group_id(src_tsk);
-		__entry->src_cpu	= src_cpu;
-		__entry->src_nid	= cpu_to_node(src_cpu);
-		__entry->dst_pid	= task_pid_nr(dst_tsk);
-		__entry->dst_tgid	= task_tgid_nr(dst_tsk);
-		__entry->dst_ngid	= task_numa_group_id(dst_tsk);
-		__entry->dst_cpu	= dst_cpu;
-		__entry->dst_nid	= cpu_to_node(dst_cpu);
-	),
+	TP_PROTO(struct task_struct *src_tsk, int src_cpu,
+		 struct task_struct *dst_tsk, int dst_cpu),
 
-	TP_printk("src_pid=%d src_tgid=%d src_ngid=%d src_cpu=%d src_nid=%d dst_pid=%d dst_tgid=%d dst_ngid=%d dst_cpu=%d dst_nid=%d",
-			__entry->src_pid, __entry->src_tgid, __entry->src_ngid,
-			__entry->src_cpu, __entry->src_nid,
-			__entry->dst_pid, __entry->dst_tgid, __entry->dst_ngid,
-			__entry->dst_cpu, __entry->dst_nid)
+	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
 
+
 /*
  * Tracepoint for waking a polling cpu without an IPI.
  */

> 

-- 
Mel Gorman
SUSE Labs
