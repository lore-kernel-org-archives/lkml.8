Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2D3C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B26206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:00:05 -0400
Received: from foss.arm.com ([217.140.110.172]:37810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgICRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:00:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E974101E;
        Thu,  3 Sep 2020 10:00:03 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475D53F68F;
        Thu,  3 Sep 2020 10:00:02 -0700 (PDT)
References: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: SD_LOAD_BALANCE
In-reply-to: <alpine.DEB.2.22.394.2009031605190.2496@hadrien>
Date:   Thu, 03 Sep 2020 17:59:57 +0100
Message-ID: <jhj7dtaokxe.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Julia,

On 03/09/20 15:09, Julia Lawall wrote:
> Uses of SD_LOAD_BALANCE were removed in commit e669ac8ab952 (first
> released in v5.8), with the comment:
>
> The SD_LOAD_BALANCE flag is set unconditionally for all domains in
> sd_init().
>
> I have the impression that this was not quite true.  The NUMA domain was
> not initialized with sd_init, and didn't have the SD_LOAD_BALANCE flag
> set.

Did you check the contents of

  /proc/sys/kernel/sched_domain/cpu*/domain*/flags

(requires CONFIG_SCHED_DEBUG)? If the LSB is set, it would mean
SD_LOAD_BALANCE is set.

The sched_domain construction flow isn't the easiest thing to follow, but
NUMA domains *have* to go through sd_init().

What happens is we first go through sched_init_numa(), and there we add
some more topology levels on top of the default ones (or the arch-defined
ones if using an arch-defined topology hierarchy) by using the NUMA
distance table.

We then build the actual domains in sched_init_domains(), and that goes
through a loop that looks like

  for_each_cpu() {
      for_each_sd_topology() {
          build_sched_domain() -> sd_init()
      }
  }

where the SD topology loop is going to iterate over the newly-added
NUMA-specific topology levels. Since that used to unconditionally set
SD_LOAD_BALANCE, NUMA domains really ought to have it.

If that wasn't the case, we would have fired the (now removed) warning in
sched_domain_debug_one() that would do:

       if (!(sd->flags & SD_LOAD_BALANCE)) {
               printk("does not load-balance\n");
               if (sd->parent)
                       printk(KERN_ERR "ERROR: !SD_LOAD_BALANCE domain has parent");
               return -1;
       }

> The effect is that in v5.8, the for_each_domain loop in
> select_task_rq_fair can always end up at the global NUMA domain, and thus
> consider any pair of waking cpu (cpu) and previous cpus of the wakee
> (prev_cpu) as arguments to wake_affine.  Up to v5.7, this was only
> possible if cpu and prev_cpu were together in some lower level domain, ie
> sharing the LLC.  The effect is that in v5.8 wake_affine can often end up
> choosing as a target a core that does not share the LLC with the core
> where the thread ran previously.  Threads then move around a lot between
> the different sockets.
>
> Was this intentional?
>

AFAICT it isn't forbidden for the logic here to peek outside of the
previous LLC. The NUMA reclaim distance thing says we allow affine wakeups
and fork / exec balancing to move a task to a CPU at most RECLAIM_DISTANCE
away (in NUMA distance values). However, I don't remember any patch
changing this between v5.7 and v5.8.

Briefly glancing over the kernel/sched log between v5.7 and v5.8, I don't
see any obvious culprits. Did you try to bisect this? If it indeed ends on
the SD_LOAD_BALANCE thing, well, I'll be off eating my keyboard.

> The effect can be seen in the traces of the parsec vips benchmark at the
> following URL:
>
> https://pages.lip6.fr/Julia.Lawall/vips.pdf
>
> The first two graphs (complete run and small fragment) are Linux v5.7 and
> the next two are Linux v5.8.  The machine has 160 hardware threads
> organized in 4 sockets and the colors are by socket.  In the small
> fragment for v5.7 (second graph), one can see that a given pid pretty much
> stays on the same socket, while in the corresponding fragment for v5.8
> (fourth graph), the pids move around between the sockets.  The x's
> describe the unblocks that result in a migration.  A pink x means that the
> migration is in the same socket, while a blue x means that the migration
> is to another socket. It's not apparent from the graphs, but by adding
> some tracing, it seems that the new socket is always the one of the core
> that handles the wakeup.
>

Interesting graphs, thanks for sharing!

> I haven't yet studied the early part of the execution of vips in detail,
> but I suspect that the same issue causes all of the threads to be
> initially on the same socket in v5.7, while in v5.8 they are more quickly
> dispersed to other sockets.
>
> My impression from the parsec and the NAS benchmarks is that the v5.8
> performance is a bit better than v5.7, probably because of getting more
> threads to more different sockets earlier, but other benchmarks might
> rely more on locality and might react less well to threads moving around
> so much in this way.
>
> julia
