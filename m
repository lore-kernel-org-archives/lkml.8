Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA17C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4527A206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yhehKYns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506261AbgDPLMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506032AbgDPLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:04:47 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926FDC03C1A9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uT2ucy3qx5aL2WVYyVl5nm3yhCGAKoXW4NTEdyzjdRI=; b=yhehKYnstqda4PzxJiK7i/0lWu
        FF4DXLsczqcjq6INSj8GeFF/bI1by+iDATbLPlhasSlC/i2I1U979VDslg9hen6Upv4wpp8krz1dV
        +Y6thdzQnF+5m3sKbJCGZYdgwe9zXByT161HaFQp20VHeOiNOAcRohajcWBxATtD/DIEpBF46pGh5
        q4CQIZXdqBY/PwC2QeMWQ1SDg5PaqouC24SXFtL6t6g/RUTLtx7+M3F2qJnxhoCL+kvwZc/ZV4fSc
        UgiulBR+vG07XElyQmY3D2ghaMHRDQiZ0vMd2RITGXIRdAnnXk29KDm79Fv6sUMs7Kzx0qV556R8b
        G7tat/MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP23N-0005D0-HG; Thu, 16 Apr 2020 10:47:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13440307005;
        Thu, 16 Apr 2020 12:47:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E597B2B0DC738; Thu, 16 Apr 2020 12:47:25 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:47:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 6/9] sched: Kill select_task_rq()'s sd_flag parameter
Message-ID: <20200416104725.GM20730@hirez.programming.kicks-ass.net>
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200415210512.805-7-valentin.schneider@arm.com>
 <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA5-S_EyzZMDMr9SuVQmWZNdLXOVSLMAMTD+6Bow4jJBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:42:36AM +0200, Vincent Guittot wrote:
> On Wed, 15 Apr 2020 at 23:05, Valentin Schneider
> > @@ -6622,13 +6622,25 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >   * preempt must be disabled.
> >   */
> >  static int
> > +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >  {
> > +       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> >         struct sched_domain *tmp, *sd = NULL;
> >         int cpu = smp_processor_id();
> >         int new_cpu = prev_cpu;
> >         int want_affine = 0;
> > -       int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> > +       int sd_flag;
> > +
> > +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> 
> You remove a function parameter, which was directly set with the right
> flag, but then you add a switch case to recreate this sd_flag
> internally. Not sure we can say that it's real benefit
> 
> > +       case WF_TTWU:
> > +               sd_flag = SD_BALANCE_WAKE;
> > +               break;
> > +       case WF_FORK:
> > +               sd_flag = SD_BALANCE_FORK;
> > +               break;
> > +       default:
> > +               sd_flag = SD_BALANCE_EXEC;
> > +       }

Agreed, that's a bit yuck, how about something like so instead:


--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,10 +11,12 @@
  */
 #ifdef CONFIG_SMP
 
+/* First nibble of SD_flag is shared with WF_flag */
 #define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
 #define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
 #define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
 #define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
+
 #define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
 #define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
 #define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6635,16 +6635,8 @@ select_task_rq_fair(struct task_struct *
 	int want_affine = 0;
 	int sd_flag;
 
-	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
-	case WF_TTWU:
-		sd_flag = SD_BALANCE_WAKE;
-		break;
-	case WF_FORK:
-		sd_flag = SD_BALANCE_FORK;
-		break;
-	default:
-		sd_flag = SD_BALANCE_EXEC;
-	}
+	/* SD_flags and WF_flags share the first nibble */
+	sd_flag = wake_flags & 0xf;
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1685,11 +1685,12 @@ static inline int task_on_rq_migrating(s
 /*
  * Wake flags
  */
-#define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_TTWU                 0x02            /* Regular task wakeup */
-#define WF_FORK			0x04		/* Child wakeup after fork */
-#define WF_EXEC			0x08		/* "Fake" wakeup at exec */
-#define WF_MIGRATED		0x10		/* Internal use, task got migrated */
+#define WF_EXEC			0x02	/* SD_BALANCE_EXEC */
+#define WF_FORK			0x04	/* SD_BALANCE_FORK */
+#define WF_TTWU			0x08	/* SD_BALANCE_WAKE */
+
+#define WF_SYNC			0x10	/* Waker goes to sleep after wakeup */
+#define WF_MIGRATED		0x20	/* Internal use, task got migrated */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
