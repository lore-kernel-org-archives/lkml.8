Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573B720714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589215401;
	bh=cEElB1fEcv9uVWPfoj300JLJHL/JtJuOk23Pkm3fy1Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PqIUJy7vfKwtbb8TRN1ra0JUTk7WcoHib+dd61D/5ZJ9n95QsWEjn5T3ye2HJa522
	 Tgh6w38uKL4EQFNbOeOXNwh46vmhsIZ4R9PiRinTRFG7UQklnJMXhCY7yGV/0Qatjv
	 emCzUspps1jYjxB3IlhvgkaWvIA1Me85c38F25Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgEKQnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbgEKQnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:43:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706F32070B;
        Mon, 11 May 2020 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589215399;
        bh=cEElB1fEcv9uVWPfoj300JLJHL/JtJuOk23Pkm3fy1Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BMnBEol8dZ6ge7mAx8zXbZfqFZ9G+E/KPdsBE+Yxjkbkdl4j5HjwEtgrL71GmZHbq
         cOT/Tk8a3OrVwaND8wxfX3O/gJzqKxVAqHDCwECWIjBA47Lm8uhROGth8Ho6fkkfvH
         pe9MrTz6NaJ+K/AIigIgTzkz7Lnvw54hht4RULaI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5233F352271C; Mon, 11 May 2020 09:43:19 -0700 (PDT)
Date:   Mon, 11 May 2020 09:43:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200511164319.GV2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200509161217.GN2869@paulmck-ThinkPad-P72>
 <45D9EEEB-D887-485D-9045-417A7F2C6A1A@lca.pw>
 <20200509213654.GO2869@paulmck-ThinkPad-P72>
 <20200511155812.GB22270@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511155812.GB22270@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 04:58:13PM +0100, Will Deacon wrote:
> On Sat, May 09, 2020 at 02:36:54PM -0700, Paul E. McKenney wrote:
> > On Sat, May 09, 2020 at 12:53:38PM -0400, Qian Cai wrote:
> > > 
> > > 
> > > > On May 9, 2020, at 12:12 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > Ah, and I forgot to ask.  Why "if (data_race(prev->next == node)" instead
> > > > of "if (data_race(prev->next) == node"?
> > > 
> > > I think the one you suggested is slightly better to point out the exact race. Do you want me to resend or you could squash it instead?
> > 
> > The patch was still at the top of my stack, so I just amended it.  Here
> > is the updated version.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 13e69ca01ce1621ce74248bda86cfad47fa5a0fa
> > Author: Qian Cai <cai@lca.pw>
> > Date:   Tue Feb 11 08:54:15 2020 -0500
> > 
> >     locking/osq_lock: Annotate a data race in osq_lock
> >     
> >     The prev->next pointer can be accessed concurrently as noticed by KCSAN:
> >     
> >      write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
> >       osq_lock+0x25f/0x350
> >       osq_wait_next at kernel/locking/osq_lock.c:79
> >       (inlined by) osq_lock at kernel/locking/osq_lock.c:185
> >       rwsem_optimistic_spin
> >       <snip>
> >     
> >      read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
> >       osq_lock+0x196/0x350
> >       osq_lock at kernel/locking/osq_lock.c:157
> >       rwsem_optimistic_spin
> >       <snip>
> >     
> >     Since the write only stores NULL to prev->next and the read tests if
> >     prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
> >     shattered, the code is still working correctly. Thus, mark it as an
> >     intentional data race using the data_race() macro.
> >     
> >     Signed-off-by: Qian Cai <cai@lca.pw>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > index 1f77349..1de006e 100644
> > --- a/kernel/locking/osq_lock.c
> > +++ b/kernel/locking/osq_lock.c
> > @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> >  	 */
> >  
> >  	for (;;) {
> > -		if (prev->next == node &&
> > +		/*
> > +		 * cpu_relax() below implies a compiler barrier which would
> > +		 * prevent this comparison being optimized away.
> > +		 */
> > +		if (data_race(prev->next) == node &&
> >  		    cmpxchg(&prev->next, node, NULL) == node)
> >  			break;
> 
> I'm fine with the data_race() placement, but I don't find the comment
> very helpful. We assign the result of a READ_ONCE() to 'prev' in the
> loop, so I don't think that the cpu_relax() is really relevant.

Suppose that the compiler loaded a value that was not equal to "node".
In that case, the cmpxchg() won't happen, so something else must force
the compiler to do the reload in order to avoid an infinite loop, right?
Or am I missing something here?

							Thanx, Paul

> The reason we don't need READ_ONCE() here is because if we race with
> the writer then either we'll go round the loop again after accidentally
> thinking prev->next != node, or we'll erroneously attempt the cmpxchg()
> because we thought they were equal and that will fail.
> 
> Make sense?
> 
> Will
