Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12FAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6FB20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p5NGKl29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896673AbgDOKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896660AbgDOKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:55:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pe8PVEu48fWSKZ5P+5UvfvD/3iJ+41ZHTskcjEn0pVc=; b=p5NGKl29ejcIzF1Mc8fNqajYE1
        jIJ/WnRpRPtXB4L80OKxXNlwzhFXh2s4SivO3fxXPTgXBqvU10rrLp2pnP6baAA1rLPrgowCKmQWB
        T/sEeLAAaESB+D+ytHLSmnYvccPlPOuMdaXYGXvrm0KxsoV+oK8csqITp2/OsqOKTSa8OMgZ3gNw2
        zEd53nU5qiV8T/eyNrRtqV+IRBorAMmyMsKzjD8DGjRrT8s5CU0VzxkkA6xy2Iiy4QYB+QuTOss0B
        vUBFrOEwyDlS+KSBAnb8bzcaTHmXmEuCnfEfpTWwxliJbjNuH/PEzwNJYtoghwoQMAFRDBUkR1Dj+
        gBwV9jDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOfhJ-0008DJ-OZ; Wed, 15 Apr 2020 10:55:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 963D830066E;
        Wed, 15 Apr 2020 12:55:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79A9B2BB393EA; Wed, 15 Apr 2020 12:55:11 +0200 (CEST)
Date:   Wed, 15 Apr 2020 12:55:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH 03/13] sched: Core-wide rq->lock
Message-ID: <20200415105511.GC20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200414113639.GS20730@hirez.programming.kicks-ass.net>
 <CANaguZDwK6bXvJabt5gS=kLMVsGNf97u50+1-v_t8bJxCrJ6sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDwK6bXvJabt5gS=kLMVsGNf97u50+1-v_t8bJxCrJ6sQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:35:07PM -0400, Vineeth Remanan Pillai wrote:
> > Aside from the fact that it's probably much saner to write this as:
> >
> >         rq->core_enabled = static_key_enabled(&__sched_core_enabled);
> >
> > I'm fairly sure I didn't write this part. And while I do somewhat see
> > the point of disabling core scheduling for a core that has only a single
> > thread on, I wonder why we care.
> >
> I think this change was to fix some crashes which happened due to
> uninitialized rq->core if a sibling was offline during boot and is
> onlined after coresched was enabled.
> 
> https://lwn.net/ml/linux-kernel/20190424111913.1386-1-vpillai@digitalocean.com/
> 
> I tried to fix it by initializing coresched members during a cpu online
> and tearing it down on a cpu offline. This was back in v3 and do not
> remember the exact details. I shall revisit this and see if there is a
> better way to fix the race condition above.

Argh, that problem again. So AFAIK booting with maxcpus= is broken in a
whole number of 'interesting' ways. I'm not sure what to do about that,
perhaps we should add a config around that option and make it depend on
CONFIG_BROKEN.

That said; I'm thinking it shouldn't be too hard to fix up the core
state before we add the CPU to the masks, but it will be arch specific.
See speculative_store_bypass_ht_init() for inspiration, but you'll need
to be even earlier, before set_cpu_sibling_map() in smp_callin() on x86
(no clue about other archs).

Even without maxcpus= this can happen when you do physical hotplug and
add a part (or replace one where the new part has more cores than the
old).

The moment core-scheduling is enabled and you're adding unknown
topology, we need to set up state before we publish the mask,... or I
suppose endlessly do: 'smt_mask & active_mask' all over the place :/ In
which case you can indeed do it purely in sched/core.

Hurmph...
