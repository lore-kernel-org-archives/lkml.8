Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DFD2065D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bzp4nvwY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fsv0VzaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgHISmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:42:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHISmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 14:42:51 -0400
Date:   Sun, 9 Aug 2020 20:42:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596998569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFLB3TBK6fJfIcKCoZtE+lRNYpp7h26frAFau4FZd5U=;
        b=Bzp4nvwYV/adkunmZqjDgzm4J8ZvNK0+EFM3qznN9T/r/eIHKQJMbE6dRcRkY2gk1CWp6n
        zC3/SiPizr67T9Q7KnmPsn0bf4F86l8695uf+wd6sb9nKQgx6QjpUD0uhAKNlRvfC9OkZE
        bUN6Xir+Y8wlwSbmKXtGWDphp+TuBcjE4kkx5KiBLe1vhyikx6L8kyZXlX6BByRIye7Eh4
        xb9XmrIaof/SvLhq9xxwGnDX4VmPwWATxy2bdoBhT5lUzMK4FqcbqSBQ0iO0/zKVCm/Zd7
        OdiG0Hi9W8FYGiVNJbZIDSX4X6sVR++IM+2wHDDgn4MkTDhEV13MLhdgVe76Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596998569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFLB3TBK6fJfIcKCoZtE+lRNYpp7h26frAFau4FZd5U=;
        b=Fsv0VzaBJjZ4X6r+zG/tgnVyugFlwIw3Kj34YpoG5f7cNhBrZuKTX6ef63RuHoyR3pJ6GM
        hDfvoRMkmlG6WvBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200809184251.GA94072@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808232122.GA176509@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 04:21:22PM -0700, Guenter Roeck wrote:
> On Mon, Jul 20, 2020 at 05:55:14PM +0200, Ahmed S. Darwish wrote:
> > Preemption must be disabled before entering a sequence count write side
> > critical section.  Failing to do so, the seqcount read side can preempt
> > the write side section and spin for the entire scheduler tick.  If that
> > reader belongs to a real-time scheduling class, it can spin forever and
> > the kernel will livelock.
> >
> > Assert through lockdep that preemption is disabled for seqcount writers.
> >
>
> This patch is causing compile failures for various images (eg arm:allmodconfig,
> arm:imx_v6_v7_defconfig, mips:allmodconfig).
>
> In file included from arch/arm/include/asm/bug.h:60,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:12,
>                  from include/asm-generic/current.h:5,
>                  from ./arch/arm/include/generated/asm/current.h:1,
>                  from include/linux/sched.h:12,
>                  from arch/arm/kernel/asm-offsets.c:11:
> include/linux/seqlock.h: In function 'write_seqcount_begin_nested':
> include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id'
>
> Reverting it fixes the problem. Is this being addressed ?
>

@Peter, I think let's revert this one for now?

Shall I also send you a version of:

    [PATCH v4 09/24] seqlock: Extend seqcount API with associated locks
    https://lkml.kernel.org/r/20200720155530.1173732-10-a.darwish@linutronix.de/

with the problematic "lockdep_assert_preemption_disabled()" removed?

> Guenter
>

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
