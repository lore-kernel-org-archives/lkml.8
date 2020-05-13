Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F39C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B3E24927
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589339993;
	bh=3evM/3WoUY87UjYJg6kocy7JRyvcnZJAhsOd5UgvkMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rYuX01KeVJ97wIth0vojmFDBuYFB4Fe9f6mM/a6GdNeHd+vncOskqtRBUhPQsh4zB
	 e+Afr7NDN0hN+nnNxMybhMj4qnJ62M9y1qtUygv9luGobvwDO4aXUmhOueZVrYG3i7
	 CSSqMyqSETwcunJLJHqMn4EXlVdzYQdrNIJTbwZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgEMDTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 23:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEMDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 23:19:51 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CA0420714;
        Wed, 13 May 2020 03:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589339991;
        bh=3evM/3WoUY87UjYJg6kocy7JRyvcnZJAhsOd5UgvkMQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kdXcrlFVRId5W4tSKz2O+7bJSB24kuk9EK2RoEBms3JY4jhtAH4wBk2NsC/fRBGq+
         Y4Vkyn2Yu/0NnQy3N3V0LHNZIbyxfMJdFmAcjqNo9jQqJYpn+TCbdNVRvzlSi43+Uo
         zbhmsSWI4UQWFdk6BmTRCRPg7o/LaluyBQfj/GVE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 349373523471; Tue, 12 May 2020 20:19:51 -0700 (PDT)
Date:   Tue, 12 May 2020 20:19:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
Message-ID: <20200513031951.GO2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <20200511180527.GZ2869@paulmck-ThinkPad-P72>
 <1589250993.19238.22.camel@mtksdccf07>
 <CACT4Y+b6ZfmZG3YYC_TkoeGaAQjSEKvF4dZ9vHzTx5iokD4zTQ@mail.gmail.com>
 <20200512142541.GD2869@paulmck-ThinkPad-P72>
 <CACT4Y+ZfzLhcG2Wy_iEMB=hJ5k=ib+X-m29jDG2Jcs7S-TPX=w@mail.gmail.com>
 <20200512161422.GG2869@paulmck-ThinkPad-P72>
 <CACT4Y+aWNDntO6+Rhn0a-4N1gLOTe5UzYB9m5TnkFxG_L15cXA@mail.gmail.com>
 <1589335531.19238.52.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589335531.19238.52.camel@mtksdccf07>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:05:31AM +0800, Walter Wu wrote:
> On Tue, 2020-05-12 at 18:22 +0200, Dmitry Vyukov wrote:
> > On Tue, May 12, 2020 at 6:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > > This feature will record first and last call_rcu() call stack and
> > > > > > > > > print two call_rcu() call stack in KASAN report.
> > > > > > > >
> > > > > > > > Suppose that a given rcu_head structure is passed to call_rcu(), then
> > > > > > > > the grace period elapses, the callback is invoked, and the enclosing
> > > > > > > > data structure is freed.  But then that same region of memory is
> > > > > > > > immediately reallocated as the same type of structure and again
> > > > > > > > passed to call_rcu(), and that this cycle repeats several times.
> > > > > > > >
> > > > > > > > Would the first call stack forever be associated with the first
> > > > > > > > call_rcu() in this series?  If so, wouldn't the last two usually
> > > > > > > > be the most useful?  Or am I unclear on the use case?
> > > > > >
> > > > > > 2 points here:
> > > > > >
> > > > > > 1. With KASAN the object won't be immediately reallocated. KASAN has
> > > > > > 'quarantine' to delay reuse of heap objects. It is assumed that the
> > > > > > object is still in quarantine when we detect a use-after-free. In such
> > > > > > a case we will have proper call_rcu stacks as well.
> > > > > > It is possible that the object is not in quarantine already and was
> > > > > > reused several times (quarantine is not infinite), but then KASAN will
> > > > > > report non-sense stacks for allocation/free as well. So wrong call_rcu
> > > > > > stacks are less of a problem in such cases.
> > > > > >
> > > > > > 2. We would like to memorize 2 last call_rcu stacks regardless, but we
> > > > > > just don't have a good place for the index (bit which of the 2 is the
> > > > > > one to overwrite). Probably could shove it into some existing field,
> > > > > > but then will require atomic operations, etc.
> > > > > >
> > > > > > Nobody knows how well/bad it will work. I think we need to get the
> > > > > > first version in, deploy on syzbot, accumulate some base of example
> > > > > > reports and iterate from there.
> > > > >
> > > > > If I understood the stack-index point below, why not just move the
> > > > > previous stackm index to clobber the previous-to-previous stack index,
> > > > > then put the current stack index into the spot thus opened up?
> > > >
> > > > We don't have any index in this change (don't have memory for such index).
> > > > The pseudo code is"
> > > >
> > > > u32 aux_stacks[2]; // = {0,0}
> > > >
> > > > if (aux_stacks[0] != 0)
> > > >     aux_stacks[0] = stack;
> > > > else
> > > >    aux_stacks[1] = stack;
> > >
> > > I was thinking in terms of something like this:
> > >
> > > u32 aux_stacks[2]; // = {0,0}
> > >
> > > if (aux_stacks[0] != 0) {
> > >     aux_stacks[0] = stack;
> > > } else {
> > >    if (aux_stacks[1])
> > >         aux_stacks[0] = aux_stacks[1];
> > >    aux_stacks[1] = stack;
> > > }
> > >
> > > Whether this actually makes sense in real life, I have no idea.
> > > The theory is that you want the last two stacks.  However, if these
> > > elements get cleared at kfree() time, then I could easily believe that
> > > the approach you already have (first and last) is the way to go.
> > >
> > > Just asking the question, not arguing for a change!
> > 
> > Oh, this is so obvious... in hindsight! :)
> > 
> > Walter, what do you think?
> > 
> 
> u32 aux_stacks[2]; // = {0,0}
> 
> if (aux_stacks[0] != 0) {
>      aux_stacks[0] = stack;
> } else {
>     if (aux_stacks[1])
>          aux_stacks[0] = aux_stacks[1];
>     aux_stacks[1] = stack;
> }
> 
> Hmm...why I think it will always cover aux_stacks[0] after aux_stacks[0]
> has stack, it should not record last two stacks?
> 
> How about this:
> 
> u32 aux_stacks[2]; // = {0,0}
> 
> if (aux_stacks[1])
>     aux_stacks[0] = aux_stacks[1];
> aux_stacks[1] = stack;

Even better!  ;-)

							Thanx, Paul

> > I would do this. I think latter stacks are generally more interesting
> > wrt shedding light on a bug. The first stack may even be "statically
> > known" (e.g. if object is always queued into a workqueue for some lazy
> > initialization during construction).
> 
> I think it make more sense to record latter stack, too.
> 
> Thanks for your and Paul's suggestion.
> 
> 
