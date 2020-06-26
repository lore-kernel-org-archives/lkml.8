Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC92053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNYit8mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFZQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:01:05 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75AC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6rTnIjYBWSFaXSKyt5x//x/3Hp9oYrcMIr20sDCEQRM=; b=WNYit8mGWuNlSFXor5FgejX45+
        LeJOqjhkAWrSc6Vcrimsb8JkalVAZpDRgSY3YHyCbLLD0Fyx3s393+fT/AqXmVQ1ssdywjHfieC5r
        uzcfL0ohu2W9Bs42NlLPKcn1OkVPibcoTiIw4GI1CYc7i9JrVX0+G3X5KsRTR+OYyw948ObdxIT/D
        2l/547ycLFsAcLoFMMyN1vX860/eiBB+Kh/fJHVPsxxZ206Xk7QYIUuU64QVhQncuS0D716bakWYv
        YT0e01fxtgyQ6Awx6yZdzLSN/MKly3luN0XavygYCQkI0J1SgJLOHgH/b1H2/JT497OmL195ecXIQ
        7Vf3AThQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joqm4-0006no-RN; Fri, 26 Jun 2020 16:00:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A519301DFC;
        Fri, 26 Jun 2020 18:00:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 476F32B0AEC81; Fri, 26 Jun 2020 18:00:17 +0200 (CEST)
Date:   Fri, 26 Jun 2020 18:00:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        paulmck <paulmck@kernel.org>, Julien Desfossez <ju@klipix.org>
Subject: Re: [RFC PATCH v2] sched_pair_cpu: Introduce scheduler task pairing
 system call
Message-ID: <20200626160017.GJ4817@hirez.programming.kicks-ass.net>
References: <20200619202516.7109-1-mathieu.desnoyers@efficios.com>
 <20200624121136.GF4800@hirez.programming.kicks-ass.net>
 <269292405.11607.1593023493676.JavaMail.zimbra@efficios.com>
 <20200624195030.GG4800@hirez.programming.kicks-ass.net>
 <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115572712.12427.1593096995446.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:56:35AM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 24, 2020, at 3:50 PM, Peter Zijlstra peterz@infradead.org wrote:

I'll try and read the earlier bit later, I can't think today.

> > That's exactly what that signal would do. It would send SIGIO when the
> > state changes.
> > 
> > So you want to access CPU-n's data, you open that file, register a
> > signal and read it's state, if offline, you good, do the rseq. If it
> > suddenly decides to come back online, you're guaranteed that SIGIO
> > before it reaches userspace.
> >
> > The nice thing is that it's all R/O so available to normal users, you
> > don't have to write to the file.
> 
> So let's say you have two threads trying to access (offline) CPU-n's data
> with that algorithm concurrently. How are they serialized with each other ?

Also implement F_SETLK or something :-)

> >> We do not want to override the affinity restricted by cgroups because
> >> we don't want to hurt performance characteristics of another partition
> >> of the system.
> >> 
> >> The sched_pair_cpu approach has the benefit of allowing us to touch
> >> per-cpu data of a given CPU without requiring to run on that CPU, which
> >> ensures that we do not thrash the cpu cache of cpus on which a thread
> >> is not allowed to run. It takes care of issues caused by both cgroup
> >> cpusets and cpu hotplug.
> > 
> > But now I worry that your thing allows escaping the cgroup contraints,
> > you can perturb random CPUs you're not allowed on. That's a really bad
> > 'feature'.
> > 
> > Offline cpus are okay, because you don't actually need to do anything as
> > long as they're offline, but restricted CPUs we really should not be
> > touching, not even a little.
> 
> With sched_pair_cpu, the paired task never needs to run on the target CPU.
> The kworker thread runs on the target CPU in the same way other existing
> worker threads run today, e.g. the ones handling RCU callbacks. AFAIK the
> priority of those threads can be configured by a system administrator.

Ah, but the critical difference is that all those are only ever ran if
the initial work was initialized on _that_ CPU to begin with. Consider
an isolated CPU that's spinning in userspace, it would _never_ get any
kthreads running.

Except now you can, and you even want this system call to be unpriv.

It utterly and completely wrecks NOHZ_FULL.

> Are there additional steps we should take to minimize the impact of this
> worker thread ? In the same way "no rcu callbacks" CPU can be configured
> at boot time, we could have "no sched pair cpu" configured at boot, which
> would prevent sched_pair_cpu system calls from targeting that CPU entirely,
> and not spawn any kworker on that cpu.

No, no, no! "at boot time" is an utter trainwreck. I've been trying to
get NOHZ_FULL runtime configurable. This means that your cpuset can
change at runtime and the CPU you tought you had now is a NOHZ_FULL CPU.

We must not allow pears on it.

I'm thinking that the best option might be to treat CPUs outside of your
cpuset the same as offline CPUs. That more-or-less requires that tasks
outside of your cpuset partition don't have access to your shared
memory, but that isn't an entirely insane assumption.

If you want to share memory across cpuset partitions, you get to keep
the pieces.

And the nice thing about offline, is that you don't actually need to run
anything. You only need some exclusion thing (and using a spin-loop on a
random other CPU for that is bloody insane).
