Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566C32082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc157TVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgAaSsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:48:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46158 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:48:36 -0500
Received: by mail-yw1-f65.google.com with SMTP id z141so5218174ywd.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHbT6Ac2Utt1izmtrGIgoXBCRv+tY8YJ9GCZjdZfzQo=;
        b=mc157TVXVtIe6dTeKX8LhWZSj5dMOIA0rjVjZHdgcrgnCAfxLlqP47EwwosUL0PNal
         COnniRVCIBHM1euzHZzBAZ2v1ccekc/L1D30FxLXJGcZw2WdSU9wh5L6iJYjqyygQ2p0
         5eXBbAChHMmqjloHAt3j4hL+UoRmbsg4yGI0iUGWCvQK+WhLMW8hKguIuSzt/0SB1suf
         Nt2GaQ3VlYJvYBKuY70w6bQhQ6uDtgCmbeXNH+/7RLujzHJqB5yX8saYQG/7IaDVfTQ+
         XdVfuBxOqKwVDIhU5bARRzVtL19R3uUqTa4/4DGMsDO+9tmkKDfxrlnJLGfEtWbal/bh
         5vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHbT6Ac2Utt1izmtrGIgoXBCRv+tY8YJ9GCZjdZfzQo=;
        b=ZFHgW2G2ID2QXD+GYz3fTPMIpUfyTBgDaO7juva8KUOB3t6v7dj5SSSsqfY6IRiWDM
         B7lrB3MEw96sGuvyFDzUhplxY2FDS9/YCAmR+jY4p+OGVMvaJJGwQS9n4inEKmarMchH
         TTWupNCpECv+XzYj81RE7iyiBO2tgWociMsgwvInmsK67UKjYBF1oV/vTRZxbrp4liVf
         4O1CXdrKWLK4MfLelj32AYl5MmlvIZGhpMBikay1LNNhXrbNM+iAmMh8oAGqLQoGzN04
         synbpf4Y900iMLaW/5g4TFRzIuCzdnKVPer9frGoI022iFv4MjpTSJ/bgJjjPl27O3ro
         jnlQ==
X-Gm-Message-State: APjAAAV167ue4BAvyvIBGIIz/zV3lFsp5fGwoFD0VNdAXC/sWE/rIrBk
        Gin9Nw6rnVAiDrEazFuWfzgre3i9xZ0E8zUTPFNhbg==
X-Google-Smtp-Source: APXvYqxNvI5T9I3zwCPBLxgf/2yHo0wwyGAczs4eQSWLQQ3Hd4Zk+NJxIZQQcjzOsAWjUonAxXp/tvIuy9oC0PjbEuM=
X-Received: by 2002:a81:3a06:: with SMTP id h6mr8801695ywa.170.1580496513329;
 Fri, 31 Jan 2020 10:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20200131164308.GA5175@willie-the-truck> <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
In-Reply-To: <20200131184322.GA11457@worktop.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 10:48:21 -0800
Message-ID: <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
Subject: Re: Confused about hlist_unhashed_lockless()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> >     BUG: KCSAN: data-race in del_timer / detach_if_pending
>
> > diff --git a/include/linux/timer.h b/include/linux/timer.h
> > index 1e6650ed066d5d28251b0bd385fc37ef94c96532..0dc19a8c39c9e49a7cde3d34bfa4be8871cbc1c2
> > 100644
> > --- a/include/linux/timer.h
> > +++ b/include/linux/timer.h
> > @@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct
> > timer_list *timer) { }
> >   */
> >  static inline int timer_pending(const struct timer_list * timer)
> >  {
> > - return timer->entry.pprev != NULL;
> > + return !hlist_unhashed_lockless(&timer->entry);
> >  }
>
> That's just completely wrong.
>
> Aside from any memory barrier issues that might or might not be there
> (I'm waaaay to tired atm to tell), the above code is perfectly fine.
>
> In fact, this is a KCSAN compiler infrastructure 'bug'.
>
> Any load that is only compared to zero is immune to load-tearing issues.
>
> The correct thing to do here is something like:
>
> static inline int timer_pending(const struct timer_list *timer)
> {
>         /*
>          * KCSAN compiler infrastructure is insuffiently clever to
>          * realize that a 'load compared to zero' is immune to
>          * load-tearing.
>          */
>         return data_race(timer->entry.pprev != NULL);
> }


This is nice, now with have data_race()

Remember these patches were sent 2 months ago, at a time we were
trying to sort out things.

data_race() was merged a few days ago.
