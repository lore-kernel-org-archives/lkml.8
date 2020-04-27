Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE5FC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7A820775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588015462;
	bh=Vp0vnRvKFg1r1dD6nYGeZLym1g/qiYVKG/3/dYtACSI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=rqyLdYaSvhOrV+7Px1eooEGlVXecXy1k2h5aaiX5UBa7ROi78Wo3m4i2g8mGAaWpq
	 2lXUZWU7ngovn5zTu63LBJREQ3EV0K0+rsmbPRBNy7eDqCYKvEUZHqBfTnu577FoAc
	 HjOPWrtzOBhO+W/WCoiopZLivrx0a7DKx5pM2akE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD0TYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgD0TYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:24:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE77B2078C;
        Mon, 27 Apr 2020 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588015460;
        bh=Vp0vnRvKFg1r1dD6nYGeZLym1g/qiYVKG/3/dYtACSI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ARK9w/7v+ttJmUZ8ezHZ3hnJkjbfAfH6DY8lhhhFAlCzT6Ml+1GrZMnA8IirtO/no
         B/j1PZ2ONXnGLAlEz7o+/REseF4JTijbD4eu00/c8xGSp32iifSa8vqJv1r5lKFiJC
         GmDIm0lfcj+2i9NN46J6w+TedGgSoNUQJFjjKl18=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A050D35227CC; Mon, 27 Apr 2020 12:24:20 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:24:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with
 data_race()
Message-ID: <20200427192420.GL7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <20200324165128.GS20696@hirez.programming.kicks-ass.net>
 <CAG48ez2WJo5+wqWi1nxstR=WWyseVfZPMnpdDBsZKW5G+Tt3KQ@mail.gmail.com>
 <20200324213200.GA21176@willie-the-truck>
 <20200330231315.GZ19865@paulmck-ThinkPad-P72>
 <20200424173932.GK21141@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424173932.GK21141@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 06:39:33PM +0100, Will Deacon wrote:
> On Mon, Mar 30, 2020 at 04:13:15PM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 24, 2020 at 09:32:01PM +0000, Will Deacon wrote:
> > > [mutt crashed while I was sending this; apologies if you receive it twice]
> > > 
> > > On Tue, Mar 24, 2020 at 05:56:15PM +0100, Jann Horn wrote:
> > > > On Tue, Mar 24, 2020 at 5:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > On Tue, Mar 24, 2020 at 03:36:25PM +0000, Will Deacon wrote:
> > > > > > diff --git a/include/linux/list.h b/include/linux/list.h
> > > > > > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > > > > > --- a/include/linux/list.h
> > > > > > +++ b/include/linux/list.h
> > > > > > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> > > > > >   */
> > > > > >  static inline int list_empty(const struct list_head *head)
> > > > > >  {
> > > > > > -     return READ_ONCE(head->next) == head;
> > > > > > +     return data_race(READ_ONCE(head->next) == head);
> > > > > >  }
> > > > >
> > > > > list_empty() isn't lockless safe, that's what we have
> > > > > list_empty_careful() for.
> > > > 
> > > > That thing looks like it could also use some READ_ONCE() sprinkled in...
> > > 
> > > Crikey, how did I miss that? I need to spend some time understanding the
> > > ordering there.
> > > 
> > > So it sounds like the KCSAN splats relating to list_empty() and loosely
> > > referred to by 1c97be677f72 ("list: Use WRITE_ONCE() when adding to lists
> > > and hlists") are indicative of real bugs and we should actually restore
> > > list_empty() to its former glory prior to 1658d35ead5d ("list: Use
> > > READ_ONCE() when testing for empty lists"). Alternatively, assuming
> > > list_empty_careful() does what it says on the tin, we could just make that
> > > the default.
> > 
> > The list_empty_careful() function (suitably annotated) returns false if
> > the list is non-empty, including when it is in the process of becoming
> > either empty or non-empty.  It would be fine for the lockless use cases
> > I have come across.
> 
> Hmm, I had a look at the implementation and I'm not at all convinced that
> it's correct. First of all, the comment above it states:
> 
>  * NOTE: using list_empty_careful() without synchronization
>  * can only be safe if the only activity that can happen
>  * to the list entry is list_del_init(). Eg. it cannot be used
>  * if another CPU could re-list_add() it.

Huh.  This thing is unchanged since 2.6.12-rc2, back in 2005:

static inline int list_empty_careful(const struct list_head *head)
{
	struct list_head *next = head->next;
	return (next == head) && (next == head->prev);
}

I can imagine compiler value-caching optimizations that would cause
trouble, for example, if a previous obsolete fetch from head->prev was
lying around in a register, causing this function to say "not empty" when
it was in fact empty.  Of course, if obsolete values for both head->next
and head->prev were lying around, pretty much anything could happen.

> but it seems that people disregard this note and instead use it as a
> general-purpose lockless test, taking a lock and rechecking if it returns
> non-empty. It would also mean we'd have to keep the WRITE_ONCE() in
> INIT_LIST_HEAD, which is something that I've been trying to remove.
> 
> In the face of something like a concurrent list_add(); list_add_tail()
> sequence, then the tearing writes to the head->{prev,next} pointers could
> cause list_empty_careful() to indicate that the list is momentarily empty.
> 
> I've started looking at whether we can use a NULL next pointer to indicate
> an empty list, which might allow us to kill the __list_del_clearprev() hack
> at the same time, but I've not found enough time to really get my teeth into
> it yet.

In the delete-only case, I kind of get it, other than the potential for
optimization.  Once the list becomes empty, it will forever remain empty.
And the additional test of head->prev avoids this returning true while the
deletion is half done (again, aside from the potential for optimization).

If insertions are allowed, the thing I haven't quite figured out yet is
what is being gained by the additional check of head->prev.  After all,
if updates are not excluded, the return value can become obsolete
immediately anyhow.  Yes, it could be used as a heuristic, but it could
report empty immediately before a list_add(), so there would need to
either be a careful wakeup protocol or a periodic poll of the list.

Or am I missing a trick here?

							Thanx, Paul
