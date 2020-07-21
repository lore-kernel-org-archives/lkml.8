Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0E2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Shgje8OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGULiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGULiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:38:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6D3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tpyw0chAssPmFG8KNQPzQ0FPhO/9AMR0ayHA9eSMRYI=; b=Shgje8OSUo7EBFGzdIYoFtushi
        pBqnlelD35A1ckoiIBluaHMiQGI/7wK0bnSYnrGFfxUpntkP3fPXBTWWXjUx6QSm+53YJEJCc7ooB
        FhVkdpCN0JDHhlyWS9E8MYEK2654SUBeqrqWd8qu9GfYDD9x7kEBz6BFD3HQMoCZydhWat+KuAvYw
        X24UX6yl9nlmpX/08R1dZHBoemmCwxSkx/M5nmkhV9wfXOQXHv//f4FjUgag2ik/iU2nrCLJ38eqH
        myBOZDpe5hd0HMlGkto3cw4J75Rsv+xfsVm8YAVNlLs/hVkdlt1IjsiYhadxby/MhinZzVB339NV5
        gQ2bLZ8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxqaL-0007mG-44; Tue, 21 Jul 2020 11:37:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBFE23060F3;
        Tue, 21 Jul 2020 13:37:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC3A6207A666B; Tue, 21 Jul 2020 13:37:19 +0200 (CEST)
Date:   Tue, 21 Jul 2020 13:37:19 +0200
From:   peterz@infradead.org
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
Message-ID: <20200721113719.GI119549@hirez.programming.kicks-ass.net>
References: <20200622100122.477087977@infradead.org>
 <20200622100825.726200103@infradead.org>
 <159532854586.15672.5123219635720172265@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159532854586.15672.5123219635720172265@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:49:05AM +0100, Chris Wilson wrote:
> Quoting Peter Zijlstra (2020-06-22 11:01:23)
> > @@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int c
> >  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
> >  {
> >         if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> > +               if (WARN_ON_ONCE(cpu == smp_processor_id()))
> > +                       return false;
> > +
> >                 sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> >                 __ttwu_queue_wakelist(p, cpu, wake_flags);
> >                 return true;
> 
> We've been hitting this warning frequently, but have never seen the
> rcu-torture-esque oops ourselves.

How easy is it to hit this? What, if anything, can I do to make my own
computer go bang?

> <4> [181.766705] RIP: 0010:ttwu_queue_wakelist+0xbc/0xd0
> <4> [181.766710] Code: 00 00 00 5b 5d 41 5c 41 5d c3 31 c0 5b 5d 41 5c 41 5d c3 31 c0 f6 c3 08 74 f2 48 c7 c2 00 ad 03 00 83 7c 11 40 01 77 e4 eb 80 <0f> 0b 31 c0 eb dc 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 bf 17
> <4> [181.766726] RSP: 0018:ffffc90000003e08 EFLAGS: 00010046
> <4> [181.766733] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffff888276a00000
> <4> [181.766740] RDX: 000000000003ad00 RSI: ffffffff8232045b RDI: ffffffff8233103e
> <4> [181.766747] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> <4> [181.766754] R10: 00000000d3fa25c3 R11: 0000000053712267 R12: ffff88825b912940
> <4> [181.766761] R13: 0000000000000000 R14: 0000000000000087 R15: 000000000003ad00
> <4> [181.766769] FS:  0000000000000000(0000) GS:ffff888276a00000(0000) knlGS:0000000000000000
> <4> [181.766777] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4> [181.766783] CR2: 000055b8245814e0 CR3: 0000000005610003 CR4: 00000000003606f0
> <4> [181.766790] Call Trace:
> <4> [181.766794]  <IRQ>
> <4> [181.766798]  try_to_wake_up+0x21b/0x690
> <4> [181.766805]  autoremove_wake_function+0xc/0x50
> <4> [181.766858]  __i915_sw_fence_complete+0x1ee/0x250 [i915]
> <4> [181.766912]  dma_i915_sw_fence_wake+0x2d/0x40 [i915]

Please, don't trim oopses..

> We are seeing this on the ttwu_queue() path, so with p->on_cpu=0, and the
> warning is cleared up by
> 
> -               if (WARN_ON_ONCE(cpu == smp_processor_id()))
> +               if (WARN_ON_ONCE(p->on_cpu && cpu == smp_processor_id()))
> 
> which would appear to restore the old behaviour for ttwu_queue() and
> seem to be consistent with the intent of this patch. Hopefully this
> helps identify the problem correctly.

Hurmph, that's actively wrong. We should never queue to self, as that
would result in self-IPI, which is not possible on a bunch of archs. It
works for you because x86 can in fact do that.

So ttwu_queue_cond() will only return true when:

 - target-cpu and current-cpu do not share cache;
   so it cannot be this condition, because you _always_
   share cache with yourself.

 - when WF_ON_CPU and target-cpu has nr_running <= 1;
   which means p->on_cpu == true.

So now you have cpu == smp_processor_id() && p->on_cpu == 1, however
your modified WARN contradicts that.

*puzzle*


