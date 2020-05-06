Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF1C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B18420769
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHr6Q2jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgEFMRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgEFMRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:17:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0FBC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 05:17:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y19so548017qvv.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2a9aw64zHH2XF20M2Lyiu+UmzKecSTayjdQ/idjqxfY=;
        b=BHr6Q2jzo+84lP6Z7rD+n92hBNK0J3xtLZiORVstiSPMFaJU2Q08ATAnMyiKLt7Iq/
         WJow5rRUtuEqLl5IfJON+yyxZEvqPXXkHJ/N9UjYJK6fnTil18q6e5XcpOkjjLljW8Ka
         5GeRpv26dpS8o+n/1Rczh3Mv/jLV4aSlNReTRicrUOzXSYO1WM1X/beJQvgIHG+AhF8n
         M0BASyfeJuiA3B7amYptZ3U9XnZLWQUrQptic3LY4SIGh7ipe23bf9ss1Cn1cj8XWJql
         HZnBp9AUiL8Dd9GGFT2ohEukPgv+URk1d6Hvonk751ChvkcIQYnzBbODSCLSPAj9kk3O
         TH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2a9aw64zHH2XF20M2Lyiu+UmzKecSTayjdQ/idjqxfY=;
        b=IywgaPsFS//EWV6XkUcvAkvFb19gVEwNjCELzNMv8HVv2QlVmUFOPrfxPI9Cy5s7Vt
         onEaAKkX7ATB1dSBZXW/3RVX2582J0mdDWdJ5hy+SqYkPlb+vpmRvw6vBeQOcoXl+Qek
         3tRDIdGNDm88N9188Fk1nXRCcbtU69/rAGLtSh7EALGgWqxwHH1nByPa9QEYtjuDDL8P
         rlzkQbo9v62wTEZ4UsSyl6H0wUa3XK4zn1gXx7Ct02JDE63xSWSIS+mHFDTkReAas99r
         t8u090qXUkQc8EhJlR9MMjEt1lb6asWLZnBnsOLb4YBXwtf6nmnv6832dstdd45gdSDY
         pqVg==
X-Gm-Message-State: AGi0Puburbp1r0RpkO7n60EUC0O7a9d7vmNTqWyk4OpBYXi09eLJuSF/
        HjLfoNG4sx/gXNO8evgwmrI0rOpvf6fKzMoRaE41NA==
X-Google-Smtp-Source: APiQypJbI2sDdte0KVJrP00sH4lrzaXCuhrc9uqDNq31LxmRU2w1Jfi7oSoFrR2PB+CFe6EOcMAP0hph9TTqo0L/XA0=
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr7710326qvl.34.1588767429553;
 Wed, 06 May 2020 05:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
 <2BF68E83-4611-48B2-A57F-196236399219@lca.pw> <1588746219.16219.10.camel@mtksdccf07>
 <CACT4Y+atTS6p4b23AH+G9LM-k2gU=kMdkKQdARSboxc-H8CLTQ@mail.gmail.com> <1588766510.23664.31.camel@mtksdccf07>
In-Reply-To: <1588766510.23664.31.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 May 2020 14:16:58 +0200
Message-ID: <CACT4Y+baJtLf=ppLjjYtcZNQwPW0daQYcQLTmYe-WU2-FxPHEg@mail.gmail.com>
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

On Wed, May 6, 2020 at 2:01 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Wed, 2020-05-06 at 11:37 +0200, 'Dmitry Vyukov' via kasan-dev wrote:
> > On Wed, May 6, 2020 at 8:23 AM Walter Wu <walter-zh.wu@mediatek.com> wr=
ote:
> > > > > This patchset improves KASAN reports by making them to have
> > > > > call_rcu() call stack information. It is helpful for programmers
> > > > > to solve use-after-free or double-free memory issue.
> > > > >
> > > > > The KASAN report was as follows(cleaned up slightly):
> > > > >
> > > > > BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
> > > > >
> > > > > Freed by task 0:
> > > > > save_stack+0x24/0x50
> > > > > __kasan_slab_free+0x110/0x178
> > > > > kasan_slab_free+0x10/0x18
> > > > > kfree+0x98/0x270
> > > > > kasan_rcu_reclaim+0x1c/0x60
> > > > > rcu_core+0x8b4/0x10f8
> > > > > rcu_core_si+0xc/0x18
> > > > > efi_header_end+0x238/0xa6c
> > > > >
> > > > > First call_rcu() call stack:
> > > > > save_stack+0x24/0x50
> > > > > kasan_record_callrcu+0xc8/0xd8
> > > > > call_rcu+0x190/0x580
> > > > > kasan_rcu_uaf+0x1d8/0x278
> > > > >
> > > > > Last call_rcu() call stack:
> > > > > (stack is not available)
> > > > >
> > > > >
> > > > > Add new CONFIG option to record first and last call_rcu() call st=
ack
> > > > > and KASAN report prints two call_rcu() call stack.
> > > > >
> > > > > This option doesn't increase the cost of memory consumption. It i=
s
> > > > > only suitable for generic KASAN.
> > > >
> > > > I don=E2=80=99t understand why this needs to be a Kconfig option at=
 all. If call_rcu() stacks are useful in general, then just always gather t=
hose information. How do developers judge if they need to select this optio=
n or not?
> > >
> > > Because we don't want to increase slub meta-data size, so enabling th=
is
> > > option can print call_rcu() stacks, but the in-use slub object doesn'=
t
> > > print free stack. So if have out-of-bound issue, then it will not pri=
nt
> > > free stack. It is a trade-off, see [1].
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D198437
> >
> > Hi Walter,
> >
> > Great you are tackling this!
> >
> > I have the same general sentiment as Qian. I would enable this
> > unconditionally because:
> >
> > 1. We still can't get both rcu stack and free stack. I would assume
> > most kernel testing systems need to enable this (we definitely enable
> > on syzbot). This means we do not have free stack for allocation
> > objects in any reports coming from testing systems. Which greatly
> > diminishes the value of the other mode.
> >
> > 2. Kernel is undertested. Introducing any additional configuration
> > options is a problem in such context. Chances are that some of the
> > modes are not working or will break in future.
> >
> > 3. That free stack actually causes lots of confusion and I never found
> > it useful:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D198425
> > If it's a very delayed UAF, either one may get another report for the
> > same bug with not so delayed UAF, or if it's way too delayed, then the
> > previous free stack is wrong as well.
> >
> > 4. Most users don't care that much about debugging tools to learn
> > every bit of every debugging tool and spend time fine-tuning it for
> > their context. Most KASAN users won't even be aware of this choice,
> > and they will just use whatever is the default.
> >
> > 5. Each configuration option increases implementation complexity.
> >
> > What would have value is if we figure out how to make both of them
> > work at the same time without increasing memory consumption. But I
> > don't see any way to do this.
> >
> > I propose to make this the only mode. I am sure lots of users will
> > find this additional stack useful, whereas the free stack is even
> > frequently confusing.
> >
>
> Ok.
> If we want to have a default enabling it, but it should only work in
> generic KASAN, because we need to get object status(allocation or
> freeing) from shadow memory, tag-based KASAN can't do it. So we should
> have a default enabling it in generic KASAN?

Yes, let's do generic KASAN always memorizes rcu stack; tags KASAN
never memorizes rcu stacks. No new configurations.
