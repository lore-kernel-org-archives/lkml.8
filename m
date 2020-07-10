Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BC72076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NT6hn6KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGJK1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:27:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F85C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:27:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so5861739ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irAYaXay27AD2lSUWXkja3Lk/12VaS/aPk24zD+y1jA=;
        b=NT6hn6KGBeSQNYoJ4TSGOgqeZXB5x8xlaW3d75qpNeg6Y8S8odq5NytrN3uXcansjX
         R0wU3gTNmnz8FvK3Xg1hyZj/sgS0qA5XQ0TCT9LQ8HC/FvTbv4wOAlDmXUeoOB/eAD5G
         ComUdluQ8Bv9ZUBNdjeD4l9ho5eoD9jAlcwZkH4XNt/r42KU8uiqb/TkhmhBuUoodSGA
         JQTeh+H3b09tnx0BdzjWCrq02e0kDiKyc5EISTsdRP6DrpF2DT8ZXA6IuOwG+DG8LwmW
         4Y/40sJnOCpYyM0snl68oDWdwCQPJa2lt6rbsuF2paDlX8AOYHdSuOwyfcM42WNNTaUN
         vAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irAYaXay27AD2lSUWXkja3Lk/12VaS/aPk24zD+y1jA=;
        b=LRc4m+1ljeLok+jl2RAqsDuQTcqIc+ilS6gaYqrfKwEo4eNBGwbMmtRn9aMLdb0upG
         mct97oNe5Yj4/AVLZFbVR+NeMEwQFJVIKN75x5IkBumZPWzK0G/a3oSunZ2qC5Es3H2A
         /QT2ajfILfOL0P9hSWLR+TsickFoBNFKaF7gelFojOBL2RXr2tBEhCHkFxVAnExVbpS3
         hqUdGGORTIJWRHorZw8MdveVehd4X8/UHpHPyTA675s55Zsgaf6Cm65R9Y7yQ22lskpo
         wBj4f5AkVSL9Q8Qm7f31375G88RAsIVrCSZfw3NAjsgKuAmTd2/re/LQvCv28XgrsQSL
         C6xw==
X-Gm-Message-State: AOAM532vKo0WJWyQ4kNvLhuIdD86xXpJxMENZ+T8bc1wWHvQvUejeed6
        IimOpT6Xgb83x+tVAF9oVsfu2Kc/OIUxIE3Pioyhog==
X-Google-Smtp-Source: ABdhPJyvjlEfU5AEHqHy1TpQ6u3w5UGbNJbg/vKjfQjSlvZ99aPTn9iHVT52rgNOqMSP3WBHmgzMbme69Qni0E5tUhk=
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr28230968ljn.139.1594376854785;
 Fri, 10 Jul 2020 03:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200709223948.1051613-1-jannh@google.com> <20200710065418.GA1143105@kroah.com>
In-Reply-To: <20200710065418.GA1143105@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Jul 2020 12:27:08 +0200
Message-ID: <CAG48ez2kjacpSyesHQxnpq5oTX1Dgp8wDhtMOXuH7u7tXxBM+w@mail.gmail.com>
Subject: Re: [PATCH resend] binder: Prevent context manager from incrementing
 ref 0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Mattias Nissler <mnissler@google.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 8:54 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 10, 2020 at 12:39:48AM +0200, Jann Horn wrote:
> > Binder is designed such that a binder_proc never has references to
> > itself. If this rule is violated, memory corruption can occur when a
> > process sends a transaction to itself; see e.g.
> > <https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.
> >
> > There is a remaining edgecase through which such a transaction-to-self
> > can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
> > access:
> >
> >  - task A opens /dev/binder twice, creating binder_proc instances P1
> >    and P2
> >  - P1 becomes context manager
> >  - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
> >    handle table
> >  - P1 dies (by closing the /dev/binder fd and waiting a bit)
> >  - P2 becomes context manager
> >  - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
> >    handle table
> >    [this triggers a warning: "binder: 1974:1974 tried to acquire
> >    reference to desc 0, got 1 instead"]
> >  - task B opens /dev/binder once, creating binder_proc instance P3
> >  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
> >    transaction)
> >  - P2 receives the handle and uses it to call P3 (two-way transaction)
> >  - P3 calls P2 (via magic handle 0) (two-way transaction)
> >  - P2 calls P2 (via handle 1) (two-way transaction)
> >
> > And then, if P2 does *NOT* accept the incoming transaction work, but
> > instead closes the binder fd, we get a crash.
> >
> > Solve it by preventing the context manager from using ACQUIRE on ref 0.
> > There shouldn't be any legitimate reason for the context manager to do
> > that.
> >
> > Additionally, print a warning if someone manages to find another way to
> > trigger a transaction-to-self bug in the future.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Acked-by: Todd Kjos <tkjos@google.com>
> > ---
> > sending again because I forgot to CC LKML the first time... sorry about
> > the spam.
>
> This spits out a bunch of warnings when built, how did it work on your
> end?

... by creating the patch file before fixing the warnings. Sigh. I'll
send the proper patch as v2...
