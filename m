Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ACEC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBE62070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585085528;
	bh=WAEG2qvqlmwF1kcQfLLblGPBwt/+mnbg8XT6Bvt/JzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S5/RPBR41Ztq+fe1mrYQHg2K8pFIZj0SjFx+Y3PparPM4VXVv7bX3SdizgbDHUPAa
	 +hPpdpwVezEGFtDXvP++HRFdlROMeedQ1EIuzNBvTVDEAveI+A/NNgPQYT61yi1jMh
	 57Tfumpu+jjlOWu1V3tFdYznEA76alRqmXrZ5U1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCXVcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgCXVcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:32:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B51B206F6;
        Tue, 24 Mar 2020 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585085526;
        bh=WAEG2qvqlmwF1kcQfLLblGPBwt/+mnbg8XT6Bvt/JzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XX6bno7D7g8zvIKr88jks2+DO+aByMHZAU1xp4RtU01CeTnn/b6I7lqzXtSZsziOh
         AfEt7apQ8lT6qPLpDCTIiZ61oloIGP/8cmXQjODGz9mSHQTeVTMfQ660utCXUNa0OO
         /aUabDZwpOhhyegZa1iTUpYJBgg8u7z7F/lxGClY=
Date:   Tue, 24 Mar 2020 21:32:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with
 data_race()
Message-ID: <20200324213200.GA21176@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
 <20200324165128.GS20696@hirez.programming.kicks-ass.net>
 <CAG48ez2WJo5+wqWi1nxstR=WWyseVfZPMnpdDBsZKW5G+Tt3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2WJo5+wqWi1nxstR=WWyseVfZPMnpdDBsZKW5G+Tt3KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[mutt crashed while I was sending this; apologies if you receive it twice]

On Tue, Mar 24, 2020 at 05:56:15PM +0100, Jann Horn wrote:
> On Tue, Mar 24, 2020 at 5:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Mar 24, 2020 at 03:36:25PM +0000, Will Deacon wrote:
> > > diff --git a/include/linux/list.h b/include/linux/list.h
> > > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > > --- a/include/linux/list.h
> > > +++ b/include/linux/list.h
> > > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> > >   */
> > >  static inline int list_empty(const struct list_head *head)
> > >  {
> > > -     return READ_ONCE(head->next) == head;
> > > +     return data_race(READ_ONCE(head->next) == head);
> > >  }
> >
> > list_empty() isn't lockless safe, that's what we have
> > list_empty_careful() for.
> 
> That thing looks like it could also use some READ_ONCE() sprinkled in...

Crikey, how did I miss that? I need to spend some time understanding the
ordering there.

So it sounds like the KCSAN splats relating to list_empty() and loosely
referred to by 1c97be677f72 ("list: Use WRITE_ONCE() when adding to lists
and hlists") are indicative of real bugs and we should actually restore
list_empty() to its former glory prior to 1658d35ead5d ("list: Use
READ_ONCE() when testing for empty lists"). Alternatively, assuming
list_empty_careful() does what it says on the tin, we could just make that
the default.

Will
