Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66802071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF7bXBGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAHBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgIAHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:01:52 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4716C0612AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 00:01:51 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h9so52256ooo.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tw1MV8GeiFQ+Xv3XeAF7O+O+i26Ube8CLE3F3n/lzf8=;
        b=jF7bXBGxOz4P+3nsSzIPUW0/U+b/Ri+JDAtx6iSdwuhHsRjNItRUsewTfAjG+M/4bW
         /lScLL/z3u1kCcF6vrusQRO/+Vzc/sdO7IxpKJSzKYFGZ2YCCVUbey09jnvYwaBMb+1m
         hVt/h8W74xYw+77rVTwtoHhM+DfomsXvCegLDq+GT+nBn+emqYGKhmQ+jxuhH84tnkie
         Y5vDA1hA71RO1vBpm0tAEIXRvqhNJBrjMZGP0bj8EMpfbmEc7a9kkz8GJsjbzI3ZKqKq
         uYrauX4d+UQeR++31gkXrN0BrH7ZyYrCLyEgKLCpxjFZcSR/BqDkzweRHWTBEkNvj5CX
         INVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tw1MV8GeiFQ+Xv3XeAF7O+O+i26Ube8CLE3F3n/lzf8=;
        b=W3jnmR47LIdSqpdOKz5aGUivl+x+UiKhrQVDcFkmn6KuO6hSpSnFDEwUB0SkHIskky
         E0u4PCZCTRfmMMVULnPSudp+llrJmlxKkV5+wjyCVhFDXkg6Io4scqNctfXnAHeGv+zY
         ANaYuQRsAqTrWTuPYrQbJhI3Xn2HBoZUoSZ8qYhyxrFh37AxJAeWFeMZGu82IH8GuLyH
         JRt0XJfSlZ/HslwBdEQ5VTkRLahvoEWpAwp7oOLQgNWcclzuCuy03hxSP0vVTb587Sec
         5QYaFyynUSS3QNN+AQWCV8TxpGZQc/jnOX5TdtMjjG1DKT9DeDiPofWAvsUAKHS9mGqs
         9bHw==
X-Gm-Message-State: AOAM530DoekhWFloJS/1YOq4FvK204HNrprbzbMoGlqXgYt2YPhKABgZ
        CyJIZDT4N6eqGFtNOd9aJpp/Bg==
X-Google-Smtp-Source: ABdhPJzGk5leZUzCMIZ+F8TJMVGLuyVC7+BZvgcGWCa9tZMqOZJSnZ961gdf7AYdme4vU1BwhDOjcw==
X-Received: by 2002:a4a:c299:: with SMTP id b25mr202617ooq.35.1598943710135;
        Tue, 01 Sep 2020 00:01:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k1sm77427oot.20.2020.09.01.00.01.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2020 00:01:49 -0700 (PDT)
Date:   Tue, 1 Sep 2020 00:01:35 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
In-Reply-To: <CAHk-=whXyMiXLujhPdfQN3q5n-DpbVRFZfJqjBYLTYw37uSMvA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008312207450.1212@eggly.anvils>
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-2-peterx@redhat.com> <42bc9a68-ef9e-2542-0b21-392a7f47bd74@virtuozzo.com> <20200824143010.GG24877@quack2.suse.cz> <dd6eb3e6-2797-1cf3-e1af-62a809ce83f2@virtuozzo.com>
 <CAHk-=whXyMiXLujhPdfQN3q5n-DpbVRFZfJqjBYLTYw37uSMvA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not happy with this patch.  But every time I come back to it,
I realize that you've written more to justify it here or there, that
I haven't fully digested; yet if I wait until I've grasped it all,
I shall never arrive at responding at all, so let's wade in now.
(Sometimes I wonder why I say "I" more than other people.)

On Mon, 24 Aug 2020, Linus Torvalds wrote:
> On Mon, Aug 24, 2020 at 8:38 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >
> > Sure, KSM does not increment page counter, when a page becomes PageKsm().
> > Is patch comment about that? Even if so, I don't understand what this
> > comment is about. "PageKsm() does not take additional counter" is not
> > a reason the page can't be reused there.
> 
> No, the reason is that we don't want to reuse a KSM page, and the
> page_count() check apparently isn't sufficient in all circumstances.
> 
> So the comment is there to explain why a plain "page_count()"
> apparently isn't sufficient.
> 
> > The reason is that readers
> > of this page may increase a counter without taking the lock, so
> > this page_count() == 1 under the lock does not guarantee anything.

One thing I'm happy with, is the removal of reuse_ksm_page().  I did
not speak up at the time, but it always seemed to me a misdirected
optimization, if even an optimization at all; and it violates the
comment in mm/rmap.c "but PageKsm is never downgraded to PageAnon" -
though I'd have some trouble enumerating where that assumption matters.

> 
> The intent is to get rid of
> 
>  (a) all the locking costs. The "lock_page()" we had here used to be
> very expensive.
> 
>      It's shown up several times in the page lock problems, and the
> reason seems to be simply that this is _the_ hottest non-IO path there
> is, so it's somewhat easy to generate lots of contention on a shared
> page.

And I'd be happy with adding a "page_mapcount(page) > 1" check, to
avoid trying for page lock in unambiguous cases of shared PageAnon.

But it's there that we part company: you believe in page_count()
and trylock_page(), which to me are buggily unreliable indicators.

2.6.13 21jun05 c475a8ab625d ("can_share_swap_page: use page_mapcount")
2.6.29 06jan09 ab967d86015a ("mm: wp lock page before deciding cow")

The latter was (two years belated) response to bugreport
https://lore.kernel.org/lkml/20060913140241.60C5FFB046@ncic.ac.cn/
which after some confusion I came to understand in
https://lore.kernel.org/lkml/Pine.LNX.4.64.0609151431320.22674@blonde.wat.veritas.com/

2006: some years before the net_dma adventures that you highlighted in
https://lore.kernel.org/lkml/CAHk-=whw3QcceKCdYS2ktCPQ96m8Ysyek+w4ny0ygvy7z-_2rw@mail.gmail.com/

> 
>  (b) the problems with GUP - because GUP (and some other page sharing
> cases) don't increase the page_mapping() count, GUP was "invisible" to
> the re-use code, and as a result the reuse code was a buggy mess.

We have certainly had lots of GUP/fork/COW bugs and difficulties down
the years, plenty of mail threads that I haven't attempted to collate,
2.6.16 14feb06 f822566165dd ("madvise MADV_DONTFORK/MADV_DOFORK").

But I thought that we had arrived at a reasonably understood compromise
eleven years ago.  "the reuse code was a buggy mess" is news to me, and
I still haven't grasped why GUP needs to be "visible" to it.

Obviously, if someone is writing to private pages via GUP, without having
declared that intention with the appropriate flag to break COW in advance,
trouble may follow.  But you saw a problem just with reading, that I have
failed to grasp.

> 
>  (c) the complete and pointless complexity of this path, that isn't
> actually done anywhere else. The GUP issue was the immediate - and
> currently existing - bug caused by this, but the locking costs are
> another example.

I probably need that particular GUP issue explained again.  But no rush:
having sounded this alarm, I must turn attention to other things.

> 
> So the page reuse is simply wrong. It's almost certainly also
> pointless and entirely historical. The _reason_ for trying to reuse
> the KSM pages was documented not as performance, but simple to match
> the other (also pointless) complexity of the swap cache reuse.

I concede on KSM, but disagree that the rest was pointless: Yingchao
Zhou in the lore links above had a reasonable expectation, that COW
would *not* be broken erratically and unnecessarily.  You see it
differently, you think that relying on COW not being broken is wrong.

You may be right that it's all historical by now; but we do risk
breaking users by changing the guarantee of the last eleven years:
blame me for establishing that guarantee by fixing the page_count
and trylock_page unreliabilities.

Hugh

(Not snipping what you wrote below, so it's easy to come back to if
necessary: some I agree with, some I don't, but have said enough.)

> 
> So the intent is to do the "page_count()" test early, to get rid of
> the locking issues with any shared pages.
> 
> So the logic is "if this page is marked PageKsm(), or if it has an
> elevated page count, don't even try - just copy".
> 
> To make a very concrete example: it's not unusual at all to basically
> have simultaneous page faults on a dirty page because it's COW-shared
> in both parent and child. Trivial to trigger, with the child and
> parent running on different CPU's and just writing to the same page
> right after a fork. And there is absolutely _zero_ reason that should
> be serialized by anything at all. The parent and child are complete
> share-nothing things: taking the page lock was and is simply wrong.
> 
> Solution: don't do it. Just notice "Oh, this page has other users"
> (and page_count() is the correct thing to do for that, not
> page_mappings(), since GUP is also another user), and actively *avoid*
> any serialization. Just copy the damn thing.
> 
> I'll take full blame for the historical stupidity. This was a bigger
> deal back in the days when 4MB of RAM was considered normal. Plus page
> locking wasn't even an issue back then. In fact, no locking at all was
> needed back when the "try to reuse" code was originally written.
> Things were simpler back then.
> 
> It's just that I'm 100% convinced that that historical legacy is very
> very wrong these days. That "serialize on page lock if COW fault in
> parent and child" is just an example of where this is fundamentally
> wrong. But the whole complexity in the map count logic is just wholly
> and totally wrong too.
> 
> I dare anybody to read the swapfile code for "total_map_swapcount" and
> tell me they understand it fully.
> 
> So my theory is that this code - that is meant to *improve*
> performance by sharing pages aggressively after a fork(), because that
> used to be a primary issue, is now in fact making performance *much
> worse*, because it's trying to optimize for a case that doesn't even
> matter any more (does anybody truly believe that swap cache and shared
> COW pages are a major source of performance?) and it does so at a huge
> complexity _and_ performance cost.
> 
> So ripping out the KSM reuse code is just another "this is pointless
> and wrong" issue. If you seriously try to KSM share a page that now
> only has _one_ single user left, and that one single user writes to it
> and is modifying it, then the problem is absolutely *NOT* that we
> should try to re-use the page. No, the problem is that the KSM code
> picked a horribly bad page to try to share.
> 
> Will that happen _occasionally_? Sure. But if it happens once in a
> blue moon, we really shouldn't have that code to deal with it.
> 
> It's really that simple. All that reuse code is pointless and wrong.
> It has historical roots, and it made sense at the time, but in this
> day and age I'm convinced it's completely wrong.
> 
> Now, I'm _also_ admittedly convinced that I am occasionally completely
> wrong, and people do odd things, and maybe there are loads where it
> really matters. I doubt it in this case, but I think what we should do
> is rip out all the existing historical code, and _if_ somebody has a
> case where it matters, we can look at THAT case, and people can show
> 
>  (a) what the exact pattern is that we actually care about
> 
>  (b) numbers
> 
> and then maybe we can re-introduce some sort of re-use code with -
> hopefully - a much more targeted and documented "this is why this
> matters" approach.
> 
> So the intent is to get rid of the page lock thing, but I also hope
> that long-term, we can get rid of reuse_swap_page() and some of that
> mapcount stuff entirely.
> 
>                 Linus
