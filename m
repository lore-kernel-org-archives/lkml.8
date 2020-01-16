Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2C2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6nHPSvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAPPdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:33:09 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:45230 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:33:09 -0500
Received: by mail-lj1-f180.google.com with SMTP id j26so23142176ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS+Hl9Q/ylrazrT+fzPu6GDT46aYof0kfpLgCgBrCUU=;
        b=O6nHPSvBofo0SBi5gEmgHRENSleMwxXl2I0DTIFevm7tEJ9WXNGz1Q4se8017gQ9yy
         +06MlemafbldNah89AfxzAkfx/wTkaiv81dviDXw7R4FPysgdrsFoNqOlQi2Efxc30m8
         E7F/+RUgQy477f8opgYxX9SwAtWi333Te9JyFCQx+jrqQbbLG8hwQJnGXOT0qTCp8/qQ
         HB7v90iJfHpnU6/MePplq2iph41f0Hn2gO1w+yUGZo4gZ5tpYLwR7M9TjW0xLbT68Ntm
         a1Rm7edi0+nhCTbcShN8jqYoDxuQSHfAu0VrE6wJ3NtbJVDpOllD4x/4vYD8itg5fUbJ
         yWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS+Hl9Q/ylrazrT+fzPu6GDT46aYof0kfpLgCgBrCUU=;
        b=nqO8t8RBjFV72NxS9rlozzs33xcAlac5Qc58nhDV9X8nlj/nXPsqOaSyyGdFdJTwDD
         JhqdhB1TAdrvut1RE0ZEOiY9bVEr310Vqlont0PNsnToB02D7zkcsv9TiJpXpvwovd+E
         T4CrKXtn0fcqQOZWlfOTur8x0Tl3LaTxXg8Pz+wTV11eH/GIj00iWH5U7AYe3d8NJlCO
         l6Sj/PeEvtP5/t5clC1NFxksvvBGdcd3QIien3WDPlSdAmT+AXgATvEaGdDCOXBBjlug
         7/o8hiXE8HQXp+TBc4jGCg+dWEapLmReJuUhq1udOsJiiJslpPodqCIPxikQxy/q5GpM
         nggw==
X-Gm-Message-State: APjAAAXl8h1qH7VWbwOrHTiAF52pIpCWH7X4QcsCiVchjCxUDZNMsReN
        Hvj4dD1SDID+NKUlM+WVN9/p2FbXYThUCmx0ZP8=
X-Google-Smtp-Source: APXvYqxdqUTBSUXzJ23tqgZMWtO57u6gr/dflWBTd0/ZyeSa/9zQm3vHQWtbvujwYrOJ/kN3HIjPxDMuhgg0PHhhlSg=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr2486818ljl.74.1579188787396;
 Thu, 16 Jan 2020 07:33:07 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
 <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com> <CACT4Y+YuM55YUT37jwRP163J7ha25cN03sZ5WqTUPkz3e43Ggw@mail.gmail.com>
In-Reply-To: <CACT4Y+YuM55YUT37jwRP163J7ha25cN03sZ5WqTUPkz3e43Ggw@mail.gmail.com>
From:   Taehee Yoo <ap420073@gmail.com>
Date:   Fri, 17 Jan 2020 00:32:55 +0900
Message-ID: <CAMArcTXq=nV5kNSdWPgvpMmYXuet9gxZgmxO2JJJ7_T3vLRoRg@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 14:25, Dmitry Vyukov <dvyukov@google.com> wrote:
>

Hi Dmitry!

> On Wed, Jan 15, 2020 at 10:53 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > +Taehee, Cong,
> > >
> > > In the other thread Taehee mentioned the creation of dynamic keys for
> > > net devices that was added recently and that they are subject to some
> > > limits.
> > > syzkaller creates lots of net devices for isolation (several dozens
> > > per test process, but then these can be created and destroyed
> > > periodically). I wonder if it's the root cause of the lockdep limits
> > > problems?
> >
> > Very possibly. In current code base, there are 4 lockdep keys
> > per netdev:
> >
> >         struct lock_class_key   qdisc_tx_busylock_key;
> >         struct lock_class_key   qdisc_running_key;
> >         struct lock_class_key   qdisc_xmit_lock_key;
> >         struct lock_class_key   addr_list_lock_key;
> >
> > so the number of lockdep keys is at least 4x number of network
> > devices.
>
> And these are not freed/reused, right? So with dynamic keys LOCKDEP
> inherently can't handle prolonged running, only O(1) work?

When netdev interface is removed, these dynamic keys are removed.
But if so many netdev interfaces are existing concurrently
(more than 2000), lockdep will stop because of a lack of keys.
In addition, as far as I know, freeing dynamic lockdep key routine is
slower than creating a new dynamic lockdep key. If there are so many
netdev interface add/delete operations, for a while, there may be no
available lockdep key. At this moment, lockdep will stop.

Thank you
Taehee Yoo
