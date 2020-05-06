Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606A3C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410812082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncii/QMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgEFJiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728640AbgEFJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:38:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A42DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 02:38:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so1224546qkm.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=da9Msd6VhXx/3o4OwwaQEairzk+A5t5H6NDxBwzjlV0=;
        b=ncii/QMt765z12zCCRyYs27sJbBG55KS6EXgAt7uA/nAMWDhb5SHWhLAsl67GI2EoZ
         M8oLJnLRBvHLjeXdD4dcTwGX5lvZsRQlXW/VdJ5A5UG4MK0C0ulIURk5H/8tNBoDaiIx
         gdHY6M1cX35EHbi2BxS2kf8m7sXjfDgqqg+VdiCZ49OiOv2jz2Ef46X8koWsWasgYdK+
         bpeXm4R264TMadTOVkieNdWTkWI29YNk27LeBy3LsP8sRxUuonyXbewfko/HGB0BL9AB
         CTgR25v8+cAv6LwtMchkSgHRNjqGZDYpLsrhiIe5fjWVqJq9Nb1O7fnneO6+SAspPv3J
         L7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=da9Msd6VhXx/3o4OwwaQEairzk+A5t5H6NDxBwzjlV0=;
        b=gx/SsJtbiiPXu1gI79iBFvZQ2BLN//VuqUWLEZAwoCTbJIo850KWOFeDIq0s+qCiS1
         r93J5xRwRobgS1Q/SRxd2nsDRMIFIi3/5Vee8VRKuxfbSSBz+iU3hCBJ1eQQd+dHcHm8
         YLBE/1QzTc8bim4opo5G5q3nuQ1JJVKR7trpHSRRvJFucFklOL+aSdQYn1MlEM/14IQQ
         QLyDfd8Qf7VIbsvOpgaCID4VoON8BhnM/GEtyLmrWI7kMvNh3cbQbqfl+nOR0Tfor5iP
         RhKTVm0RnibMtnXOu2R/JCYHzaGg9tYDmNu7sTodO9Q8ASVE29qsMvArdZ84F+U2r0u0
         xFuw==
X-Gm-Message-State: AGi0PuY2jaIIsX63LuW+saORxQKronuhW8ErBydBGs9t52xmUnk0YkYy
        /ehUL2zcCj7M2QIQTHBfJ82woVBYDi5/LBHtLKpx9w==
X-Google-Smtp-Source: APiQypKkPwnxUq8+DlhhdqgWHdUkT5LHK+5uGXTodzsX0U7vrL7xa9kBwImSOF/TnuGRNKJl1K2bC7yaOlhwM1P6u2E=
X-Received: by 2002:ae9:ed05:: with SMTP id c5mr2109866qkg.250.1588757886424;
 Wed, 06 May 2020 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
 <2BF68E83-4611-48B2-A57F-196236399219@lca.pw> <1588746219.16219.10.camel@mtksdccf07>
In-Reply-To: <1588746219.16219.10.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 May 2020 11:37:54 +0200
Message-ID: <CACT4Y+atTS6p4b23AH+G9LM-k2gU=kMdkKQdARSboxc-H8CLTQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] kasan: memorize and print call_rcu stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 8:23 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > This patchset improves KASAN reports by making them to have
> > > call_rcu() call stack information. It is helpful for programmers
> > > to solve use-after-free or double-free memory issue.
> > >
> > > The KASAN report was as follows(cleaned up slightly):
> > >
> > > BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
> > >
> > > Freed by task 0:
> > > save_stack+0x24/0x50
> > > __kasan_slab_free+0x110/0x178
> > > kasan_slab_free+0x10/0x18
> > > kfree+0x98/0x270
> > > kasan_rcu_reclaim+0x1c/0x60
> > > rcu_core+0x8b4/0x10f8
> > > rcu_core_si+0xc/0x18
> > > efi_header_end+0x238/0xa6c
> > >
> > > First call_rcu() call stack:
> > > save_stack+0x24/0x50
> > > kasan_record_callrcu+0xc8/0xd8
> > > call_rcu+0x190/0x580
> > > kasan_rcu_uaf+0x1d8/0x278
> > >
> > > Last call_rcu() call stack:
> > > (stack is not available)
> > >
> > >
> > > Add new CONFIG option to record first and last call_rcu() call stack
> > > and KASAN report prints two call_rcu() call stack.
> > >
> > > This option doesn't increase the cost of memory consumption. It is
> > > only suitable for generic KASAN.
> >
> > I don=E2=80=99t understand why this needs to be a Kconfig option at all=
. If call_rcu() stacks are useful in general, then just always gather those=
 information. How do developers judge if they need to select this option or=
 not?
>
> Because we don't want to increase slub meta-data size, so enabling this
> option can print call_rcu() stacks, but the in-use slub object doesn't
> print free stack. So if have out-of-bound issue, then it will not print
> free stack. It is a trade-off, see [1].
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D198437

Hi Walter,

Great you are tackling this!

I have the same general sentiment as Qian. I would enable this
unconditionally because:

1. We still can't get both rcu stack and free stack. I would assume
most kernel testing systems need to enable this (we definitely enable
on syzbot). This means we do not have free stack for allocation
objects in any reports coming from testing systems. Which greatly
diminishes the value of the other mode.

2. Kernel is undertested. Introducing any additional configuration
options is a problem in such context. Chances are that some of the
modes are not working or will break in future.

3. That free stack actually causes lots of confusion and I never found
it useful:
https://bugzilla.kernel.org/show_bug.cgi?id=3D198425
If it's a very delayed UAF, either one may get another report for the
same bug with not so delayed UAF, or if it's way too delayed, then the
previous free stack is wrong as well.

4. Most users don't care that much about debugging tools to learn
every bit of every debugging tool and spend time fine-tuning it for
their context. Most KASAN users won't even be aware of this choice,
and they will just use whatever is the default.

5. Each configuration option increases implementation complexity.

What would have value is if we figure out how to make both of them
work at the same time without increasing memory consumption. But I
don't see any way to do this.

I propose to make this the only mode. I am sure lots of users will
find this additional stack useful, whereas the free stack is even
frequently confusing.
