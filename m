Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CBC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84292467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579106276;
	bh=yaW19YPDHAr0JEMcNjhzEvXn1QsUKQsWgwEkkYO2kSc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OPBl9fU38p+PgzMbqhXv/vQzCJ5840WZvaxtMcl4IHLpJFmtvJJZh1bqIr4/vvAYt
	 vWPaUJnZ+3zArGuMFdvruojx+gvPgJiS8/q1VV42YBUcW8tm0bXfvF2FafTK1507v0
	 LdF2GHkDShSfXcU7bjZYaO1qmF6fQdITg1sB9MJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAOQhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgAOQhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:37:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6FF214AF;
        Wed, 15 Jan 2020 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579106274;
        bh=yaW19YPDHAr0JEMcNjhzEvXn1QsUKQsWgwEkkYO2kSc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=otOeJmqzXwa9TsciCsN7ELdm1kILRqmrqVfcgqnMMKcZFKOXCYubLrhm9ifsxMB89
         owDv8uyWmP4YvlfX/NRY1RwwEEQOZt/Ei/10dzP+ab4DO+E+nKEMdCbMg1CvUQN39y
         fVEpxO1H2/P0RSNHvRv0hMEIfozgrQRUjbsyRvOw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 239A73520BAE; Wed, 15 Jan 2020 08:37:54 -0800 (PST)
Date:   Wed, 15 Jan 2020 08:37:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
Message-ID: <20200115163754.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200114124919.11891-1-elver@google.com>
 <CAG_fn=X1rFGd1gfML3D5=uiLKTmMbPUm0UD6D0+bg+_hJtQMqA@mail.gmail.com>
 <CANpmjNP6+NTr7_rkNPVDbczst5vutW2K6FXXqkqFg6GGbQC31Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP6+NTr7_rkNPVDbczst5vutW2K6FXXqkqFg6GGbQC31Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 05:26:55PM +0100, Marco Elver wrote:
> On Tue, 14 Jan 2020 at 18:24, Alexander Potapenko <glider@google.com> wrote:
> >
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -337,7 +337,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> > >          *      detection point of view) to simply disable preemptions to ensure
> > >          *      as many tasks as possible run on other CPUs.
> > >          */
> > > -       local_irq_save(irq_flags);
> > > +       raw_local_irq_save(irq_flags);
> >
> > Please reflect the need to use raw_local_irq_save() in the comment.
> >
> > >
> > >         watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
> > >         if (watchpoint == NULL) {
> > > @@ -429,7 +429,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
> > >
> > >         kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
> > >  out_unlock:
> > > -       local_irq_restore(irq_flags);
> > > +       raw_local_irq_restore(irq_flags);
> >
> > Ditto
> 
> Done. v2: http://lkml.kernel.org/r/20200115162512.70807-1-elver@google.com

Alexander and Qian, could you please let me know if this fixes things
up for you?

							Thanx, Paul
