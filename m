Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D1020771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609998;
	bh=PpxCxvKLaRJ3LSmf1WVhJNuLiZcY8a+gLLy8BYzmxKs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CNDZljp8AJVb9f0L6e4iHLsxZOYe0008bG4TiHjq3NfM4z6YV7GgY8Px1vD/OHOwG
	 FwTVxDE2Et0zMab8x2+nTZOeIDsa6O2UWYOPFI1xewGF9N5g4bCNm6UH/hHHTqb9f/
	 +He4YGTxiX0DozMHrIj5FByLMuY+2eWtKsZ3deF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgC3XNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgC3XNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:13:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0B720733;
        Mon, 30 Mar 2020 23:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585609996;
        bh=PpxCxvKLaRJ3LSmf1WVhJNuLiZcY8a+gLLy8BYzmxKs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bL+lH8/woQHRfbfj6X0OQm3jLCC/PyAVz624J3d3ldSRIkJT1jDwr7HQW+n0LG4Il
         CyGPUF3pinRoPEQQoJC46Cjh8gikh9/dc4Jec+VcryFNQe9hEtROWG/kt4gf4h1Djk
         e5Bz7vm38oee3hPXpXnLakPax4v+rbh77n/XESIQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D45883523140; Mon, 30 Mar 2020 16:13:15 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:13:15 -0700
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
Message-ID: <20200330231315.GZ19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <20200324165128.GS20696@hirez.programming.kicks-ass.net>
 <CAG48ez2WJo5+wqWi1nxstR=WWyseVfZPMnpdDBsZKW5G+Tt3KQ@mail.gmail.com>
 <20200324213200.GA21176@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324213200.GA21176@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:32:01PM +0000, Will Deacon wrote:
> [mutt crashed while I was sending this; apologies if you receive it twice]
> 
> On Tue, Mar 24, 2020 at 05:56:15PM +0100, Jann Horn wrote:
> > On Tue, Mar 24, 2020 at 5:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Tue, Mar 24, 2020 at 03:36:25PM +0000, Will Deacon wrote:
> > > > diff --git a/include/linux/list.h b/include/linux/list.h
> > > > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > > > --- a/include/linux/list.h
> > > > +++ b/include/linux/list.h
> > > > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> > > >   */
> > > >  static inline int list_empty(const struct list_head *head)
> > > >  {
> > > > -     return READ_ONCE(head->next) == head;
> > > > +     return data_race(READ_ONCE(head->next) == head);
> > > >  }
> > >
> > > list_empty() isn't lockless safe, that's what we have
> > > list_empty_careful() for.
> > 
> > That thing looks like it could also use some READ_ONCE() sprinkled in...
> 
> Crikey, how did I miss that? I need to spend some time understanding the
> ordering there.
> 
> So it sounds like the KCSAN splats relating to list_empty() and loosely
> referred to by 1c97be677f72 ("list: Use WRITE_ONCE() when adding to lists
> and hlists") are indicative of real bugs and we should actually restore
> list_empty() to its former glory prior to 1658d35ead5d ("list: Use
> READ_ONCE() when testing for empty lists"). Alternatively, assuming
> list_empty_careful() does what it says on the tin, we could just make that
> the default.

The list_empty_careful() function (suitably annotated) returns false if
the list is non-empty, including when it is in the process of becoming
either empty or non-empty.  It would be fine for the lockless use cases
I have come across.

							Thanx, Paul
