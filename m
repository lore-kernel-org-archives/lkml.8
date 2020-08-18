Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E066206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtgAZxRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRJ5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:57:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5286C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:57:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so9208870qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfOEACjh/QsOL13/8B8TglBfnAUxbCJSo9rU0NqtdyI=;
        b=EtgAZxRb38TOztAaSduARXIPvPHZFM95tYQk4ZRdGQy451E/huH1cbbBJ5SLT3puZI
         Sy/X6TR4x6gz1y5oqr3Cg/gfQ8KDKof68tm/VOWVhJeRzJIoQNV7HeSVMKv1kvlqVbjd
         qtUI5wlL7l+8oFRj0WZM47tmyGt2zewEn3bc5bLHrv577qRB2X/AQ9rPxkKSlmBX1sVS
         EICkP4rsNTcrDIJyccpvqXhWDKclxmf6vLq8bK2cq1cXIWPj5tBjA3JC8SqNNzvFKaWw
         i2MOKjzOr7fmO26Tdixb2b91zRdzkjQK7YoZyhkkH4GQtA/v8MWn8c71uuj2RaJJF0xF
         kt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfOEACjh/QsOL13/8B8TglBfnAUxbCJSo9rU0NqtdyI=;
        b=Gr7o6L10GKCfpFMgJCeY+r2zy/74iGjBlmlsXvdco1iuNBBMHzfHFWHrZUC+EmN74Y
         p1iFIUgKX/SjXCpXZj2DKS6NTevqSM6QRpWWG4PIgEWDPKD9xGKTmsJP/7yawP/tJpcx
         /1oiKkBbQc7JlzUPyeHHOEt3vu76CpTDw6fXDV8jkrE3j2MGapL/wSC5Y26av7V+zP06
         DSO1M3QJNmKhkK/Kmpo250yBuo2gZs8OHMdVnOscioa4/4TELvSxqbNQWvILjeKmcDhl
         iivGL7W7W+gtMI7R0DNnGQTK6r64R9tuWPJwJKp6NW54gvKvIyLED6ZjjnFfq9+qjQn7
         97Tg==
X-Gm-Message-State: AOAM532MuKgytYwE8AFVbCFCSfc1TPWnq7TlTaqK4KRwVe+sUKFJdm3M
        TEZFe9mH2jvpVUbP+O5dbFd3b8CPLXxNr+TLUrFFUA==
X-Google-Smtp-Source: ABdhPJxas6mk96CCCq6K2EbrhFAmDFY+8RxVLUdXFs3/UGXBQxgwATGli05rfUqMrlfS/GKtjJkpQwyEEbYFR+Kuc5g=
X-Received: by 2002:a0c:f849:: with SMTP id g9mr18632025qvo.80.1597744632772;
 Tue, 18 Aug 2020 02:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
 <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp> <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
In-Reply-To: <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Aug 2020 11:57:01 +0200
Message-ID: <CACT4Y+Y0ptJDj1F89jKQEKB_L8U2yFCUUZ7pwxh+fcE-ZpsBkg@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:36 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello, Peter, Ingo and Will.
>
> (Q1) Can we change the capacity using kernel config?
>
> (Q2) If we can change the capacity, is it OK to specify these constants
>      independently? (In other words, is there inter-dependency among
>      these constants?)


I think we should do this.
syzbot uses a very beefy kernel config and very broad load.
We are hitting "BUG: MAX_LOCKDEP_ENTRIES too low!" for the part 428
days and already hit it 96K times. It's just harming overall kernel
testing:
https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b

I think it's better if exact values are not hardcoded, but rather
specified in the config. Today we are switching from 4K to 8K, but as
we enable more configs and learn to reach more code, we may need 16K.


> (Q3) Do you think that we can extend lockdep to be used as a tool for auditing
>      locks held in kernel space and rebuilding lock dependency map in user space?

This looks like lots of work. Also unpleasant dependencies on
user-space. If there is a user-space component, it will need to be
deployed to _all_ of kernel testing systems and for all users of
syzkaller. And it will also be a dependency for reproducers. Currently
one can run a C reproducer and get the errors message from LOCKDEP. It
seems that a user-space component will make it significantly more
complicated.


> On 2020/07/25 14:23, Tetsuo Handa wrote:
> >> Also somebody may use it to _reduce_ size of the table for a smaller kernel.
> >
> > Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
> > as soon as lockdep warned the possibility of deadlock.
> >
> > Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
> > checking the same dependency tree. However, the possibility of deadlock can be
> > warned for only locks held within each kernel boot, and it is impossible to hold
> > all locks with one kernel boot.
> >
> > Then, it might be nice if lockdep can audit only "which lock was held from which
> > context and what backtrace" and export that log like KCOV data (instead of evaluating
> > the possibility of deadlock), and rebuild the whole dependency (and evaluate the
> > possibility of deadlock) across multiple kernel boots in userspace.
>
