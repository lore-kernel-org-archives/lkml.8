Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA259C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB99920707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N88PsLIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAaVEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:04:50 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:42011 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaVEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:04:49 -0500
Received: by mail-yw1-f50.google.com with SMTP id b81so6125069ywe.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTgNziuRHiebqCRs8Ftl4lUxabpxqkWWvHQH8URdpLY=;
        b=N88PsLIwzfKcJ2T2b3m59l6fJWSfA2GPZAI7PMFFVqqp0WQneu6THg4mgLnlEE0GgP
         VUn8g1r/0QwNBaMww6vVK8Zndi3t2kBFbX1OSM+OJF1lWSw0I8DDR6P6bld6UCOBnN9c
         TKx7s7Q2vR5weXrJf44MV23ZwACE57VBc2dZNY5ORcqwd3dyNuIfUeqEhlLRWXj8xG46
         STzKEUrhDlW4XOnjxl8XJRwCbso1EYQC4UwRtyguO/IIDzvM1oNUMPudOrWTQxOoSymL
         xCIIVtYr4ot+QkgQCYjEG8FwzpeQmIad3JCQMG7jHZ3z7YEtfqMaY5CgL2InRivIdY+A
         cOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTgNziuRHiebqCRs8Ftl4lUxabpxqkWWvHQH8URdpLY=;
        b=HB6yWUR3uRsyxsDIMGf2XECKMEYTDrgwSR015qQdCiWrEGAkUqSZL94sCWurXmFyQl
         dxpzvZ8asGvSDWRDcFlIo9x4jPrYSoP/Rtd9DeZvozgPdNSuXmrAsrCTaIkmhKs6EZZz
         RxdNq3KuUAV+o0HYhpiQKVT5YpEAOlRKImR9gfQa6zwfJf6zJUO/I6xgL5nMgwu+BkIa
         YwDqyCwT1Esh7B1RScN0htvNgpILJHI1edMxfDUNfiKfK+FGZAOpPtTbFNYSO2sHBcur
         dFelpy4fFx+9AjhpGhvAucjYM1sKumx2x+kF3AQOI10ZlbE/Fw4LdMUe+ZdhQt2lB8y0
         M6Nw==
X-Gm-Message-State: APjAAAUIh2I26lJVHtE4UGMGx/O6svGCKDRoNQnYGXSFYPl49SUOXsu6
        fUDDuergo4a2JnEnEBR6X89i5KB1iRU4g7EYEUijOvNA
X-Google-Smtp-Source: APXvYqyEEv8hsruVVrjm4bVR5CJQcKzfuFAtVgteFYVPNxwsQipjlJhxorhxG+gkp5vVZzooLO9RE2f8JQG9bwoAIIs=
X-Received: by 2002:a25:cfd8:: with SMTP id f207mr1479272ybg.408.1580504688521;
 Fri, 31 Jan 2020 13:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com> <20200131205337.GU2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200131205337.GU2935@paulmck-ThinkPad-P72>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 13:04:37 -0800
Message-ID: <CANn89iJzzws6MbbwuwXs+GPHAe3X-jB=JnKLh_6bX76keoKLwA@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Jan 31, 2020 at 10:52:46AM -0800, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> >
> > > This is nice, now with have data_race()
> > >
> > > Remember these patches were sent 2 months ago, at a time we were
> > > trying to sort out things.
> > >
> > > data_race() was merged a few days ago.
> >
> > Well, actually data_race() is not there yet anyway.
> >
> > Is it really scheduled for 5.7 kernel ?
>
> Right now, yes.  Would it make sense to separate it out and push it
> into the current merge window?


That would be very nice, because we could start using it before KCSAN is merged.
