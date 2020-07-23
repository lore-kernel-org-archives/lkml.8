Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AACC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1F82065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGWTmJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:42:09 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:51996 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgGWTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:42:09 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21911803-1500050 
        for multiple; Thu, 23 Jul 2020 20:41:05 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200723182841.GS10769@hirez.programming.kicks-ass.net>
References: <20200622100122.477087977@infradead.org> <20200622100825.726200103@infradead.org> <159532854586.15672.5123219635720172265@build.alporthouse.com> <20200721113719.GI119549@hirez.programming.kicks-ass.net> <159541187604.15672.2433896906671712337@build.alporthouse.com> <20200723182841.GS10769@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
To:     Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 23 Jul 2020 20:41:03 +0100
Message-ID: <159553326368.21069.3167204000119437062@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2020-07-23 19:28:41)
> On Wed, Jul 22, 2020 at 10:57:56AM +0100, Chris Wilson wrote:
> 
> > Perhaps more damning is that I can replace WF_ON_CPU with p->on_cpu to
> > suppress the warning:
> 
> *argh*, I'm starting to go mad...
> 
> Chris, could you please try the below patch?

 ttwu-IPI-self: 1==1, p->on_cpu=0;0, task_cpu(p)=1;1
 ttwu-IPI-self: 1==1, p->on_cpu=0;0, task_cpu(p)=1;1
 ttwu-IPI-self: 0==0, p->on_cpu=0;0, task_cpu(p)=0;0
 ttwu-IPI-self: 3==3, p->on_cpu=0;0, task_cpu(p)=3;3
 ttwu-IPI-self: 2==2, p->on_cpu=0;0, task_cpu(p)=2;2
 ttwu-IPI-self: 1==1, p->on_cpu=0;0, task_cpu(p)=1;1
 ttwu-IPI-self: 2==2, p->on_cpu=0;0, task_cpu(p)=2;2
 ttwu-IPI-self: 2==2, p->on_cpu=0;0, task_cpu(p)=2;2
 ttwu-IPI-self: 2==2, p->on_cpu=0;0, task_cpu(p)=2;2

> Can you also confirm that if you do:
> 
> $ echo NO_TTWU_QUEUE_ON_CPU > /debug/sched_features

With,

 sched_feat_disable(10):TTWU_QUEUE_ON_CPU

the pr_alert is still being hit

 ttwu-IPI-self: 3==3, p->on_cpu=0;0, task_cpu(p)=3;3

At which point, it darns on me. Mea culpa, stray bits being passed into
default_wake_function.

I am very sorry for the wild goose chase.
-Chris
