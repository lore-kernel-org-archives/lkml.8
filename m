Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C27C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9CB2496B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589040739;
	bh=GRg+XPx/ppr4bhH1Xu+X9xtmuanimZw1qctmLW2li7Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aPriyq6GrCo3qQEDlf8d2xW2SzjiLjL3i5iQWEFWB7aCCm8xSs1FDmWeR1xN0Lj+5
	 T0DB+7WNMwHUQr4JE/DPRJngHIDHuK0foRKi9ihxwbwmJjnvEZ3Oa+8pMoAssFfi7J
	 aS0p4tKJ+7p+06em3ZX+iHdFaSNj1Vy/ZV6slPaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgEIQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 12:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgEIQMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 12:12:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF48B2192A;
        Sat,  9 May 2020 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589040737;
        bh=GRg+XPx/ppr4bhH1Xu+X9xtmuanimZw1qctmLW2li7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r6zZHqW7nMBd5sgCesF7ELQmY3TQqE4F+5ycfbjEHOZkAHnLUpbzG4yr2SP/f5zJU
         cphyHJYsOruFmGnYg6tWyV8v2LnPtGG8EXBCr380yp0YyGT17XppCQ9jwYfd7MOISa
         EpPRyroTXqFALw4qg1qpXyZi+NPXp6BWAAIMC3Tg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C90E7352268A; Sat,  9 May 2020 09:12:17 -0700 (PDT)
Date:   Sat, 9 May 2020 09:12:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Will Deacon <will@kernel.org>, Elver Marco <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH -next v2] locking/osq_lock: annotate a data race in
 osq_lock
Message-ID: <20200509161217.GN2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1581429255-12542-1-git-send-email-cai@lca.pw>
 <2C8BF141-5384-475F-B713-6D473557C65C@lca.pw>
 <20200509043308.GL2869@paulmck-ThinkPad-P72>
 <9FBC2A17-2821-49F7-9A0F-5E41116BBC70@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9FBC2A17-2821-49F7-9A0F-5E41116BBC70@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 09:01:53AM -0400, Qian Cai wrote:
> 
> 
> > On May 9, 2020, at 12:33 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Fri, May 08, 2020 at 04:59:05PM -0400, Qian Cai wrote:
> >> 
> >> 
> >>> On Feb 11, 2020, at 8:54 AM, Qian Cai <cai@lca.pw> wrote:
> >>> 
> >>> prev->next could be accessed concurrently as noticed by KCSAN,
> >>> 
> >>> write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
> >>> osq_lock+0x25f/0x350
> >>> osq_wait_next at kernel/locking/osq_lock.c:79
> >>> (inlined by) osq_lock at kernel/locking/osq_lock.c:185
> >>> rwsem_optimistic_spin
> >>> <snip>
> >>> 
> >>> read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
> >>> osq_lock+0x196/0x350
> >>> osq_lock at kernel/locking/osq_lock.c:157
> >>> rwsem_optimistic_spin
> >>> <snip>
> >>> 
> >>> Since the write only stores NULL to prev->next and the read tests if
> >>> prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
> >>> shattered, the code is still working correctly. Thus, mark it as an
> >>> intentional data race using the data_race() macro.
> >>> 
> >>> Signed-off-by: Qian Cai <cai@lca.pw>
> >> 
> >> Hmm, this patch has been dropped from linux-next from some reasons.
> >> 
> >> Paul, can you pick this up along with KCSAN fixes?
> >> 
> >> https://lore.kernel.org/lkml/1581429255-12542-1-git-send-email-cai@lca.pw/
> > 
> > I have queued it on -rcu, but it is too late for v5.8 via the -rcu tree,
> > so this is v5.9 at the earliest.  Plus I would need an ack from one of
> > the locking folks.
> 
> Peter, Will, can you give an ACK? This v2 should incorporate all the feedback from Peter,
> 
> https://lore.kernel.org/lkml/20200211124753.GP14914@hirez.programming.kicks-ass.net/
> 
> V5.9 is fine. All I care about is it is always in linux-next (so the testing bots won’t trigger this over and over again) and to be in mainline at some point in the future.

Ah, and I forgot to ask.  Why "if (data_race(prev->next == node)" instead
of "if (data_race(prev->next) == node"?

							Thanx, Paul

> >>> ---
> >>> 
> >>> v2: insert some code comments.
> >>> 
> >>> kernel/locking/osq_lock.c | 6 +++++-
> >>> 1 file changed, 5 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> >>> index 1f7734949ac8..f733bcd99e8a 100644
> >>> --- a/kernel/locking/osq_lock.c
> >>> +++ b/kernel/locking/osq_lock.c
> >>> @@ -154,7 +154,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
> >>> 	 */
> >>> 
> >>> 	for (;;) {
> >>> -		if (prev->next == node &&
> >>> +		/*
> >>> +		 * cpu_relax() below implies a compiler barrier which would
> >>> +		 * prevent this comparison being optimized away.
> >>> +		 */
> >>> +		if (data_race(prev->next == node) &&
> >>> 		    cmpxchg(&prev->next, node, NULL) == node)
> >>> 			break;
> >>> 
> >>> -- 
> >>> 1.8.3.1
> 
