Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA65C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C4920738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598293351;
	bh=yB/q2ZH9mJcmtSbXg1wzcvPjCKwnc0uh+eh3M0VAa3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I6g/Tqj6DeOC4gjDDBIOJjWGGTlPX7um+2mDy2woz6XWRJ0h0vNxVjfIC1oKyccRc
	 WIeDPyoP0KBD9bKyZ7DvNAnK3lCeySfSbo4nTqfpOR7xJ/pgGn5bwv5Aowk+eZ2SC1
	 EukrtsOrJ07HENwJklAqPH4Ca8YrH1ZM1q8DjZzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHXSW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgHXSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:22:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A2C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:22:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so10771171ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCA+s152YJiJ+Il+TIRuhaCvynuTGiQyINLcfVKy8IQ=;
        b=dn6J2FbU4rCrL4EbGjNRl2ZKLtfyTCLkz7qQbEtxItri+EN6yIzU8gPIGmvbILfIiS
         FHcy6co1UyWSNl0WMsxb4flnbS98QOdSO5x8OHKRKHzHPDg8Y7cpC1iHqbm0YCCvCB/X
         CrsRGjWX1e/D4KCSzGuu1O+ycchu18Da0lxqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCA+s152YJiJ+Il+TIRuhaCvynuTGiQyINLcfVKy8IQ=;
        b=P6ge+KOM53mL/UZ5u2L7fWcyLn+a9tX+Zp/tt6yrbjJs2K+iftMpiS0qVqqhd+Vyz9
         /4GtRH0ad3l1zhDgFaJhftcUJTWW2NaU8zBYVR8z1QY1/U1co9q7qg8eB7SmvagXwnGd
         9rSca491mWwsqmneyW1FBpciLxT8ajE9SlvSo7ZObC/iXyPdLTd1wa6iWhlkVG4TiFXb
         42PJ5WNAlsabPtE4bi8+ikEEeiVOuv36OwxVz7PaKhyjCWsy1zx82OzQnxo0VteOuWeM
         ro180q8P8BOfZEkUZm3jG6CKSRpd/psSr24bH91m0zg8pUtG3xdASTKol7WJN6Ug9M6p
         rg/w==
X-Gm-Message-State: AOAM530WxFcrVaZ0gFmvHJNm1MxtKznSTXAkPcnp3VWB/dgsEDUYOlPe
        QC6dRhtyaNwoOAgXtM/PZWsysF8I9btjGg==
X-Google-Smtp-Source: ABdhPJwOE4qj2iWCwDpJjgdbsO/RNbQJcYxZyVHRRpjKxBYpAykOt5UCbsBavvgW/i3+vuPUSUf7jQ==
X-Received: by 2002:a2e:9f02:: with SMTP id u2mr3193647ljk.128.1598293341131;
        Mon, 24 Aug 2020 11:22:21 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e14sm2438325lfd.19.2020.08.24.11.22.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:22:20 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v9so10805384ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:22:19 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3044182lji.314.1598293339479;
 Mon, 24 Aug 2020 11:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-2-peterx@redhat.com>
 <42bc9a68-ef9e-2542-0b21-392a7f47bd74@virtuozzo.com> <20200824143010.GG24877@quack2.suse.cz>
 <dd6eb3e6-2797-1cf3-e1af-62a809ce83f2@virtuozzo.com>
In-Reply-To: <dd6eb3e6-2797-1cf3-e1af-62a809ce83f2@virtuozzo.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Aug 2020 11:22:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXyMiXLujhPdfQN3q5n-DpbVRFZfJqjBYLTYw37uSMvA@mail.gmail.com>
Message-ID: <CAHk-=whXyMiXLujhPdfQN3q5n-DpbVRFZfJqjBYLTYw37uSMvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Jan Kara <jack@suse.cz>, Peter Xu <peterx@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 8:38 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Sure, KSM does not increment page counter, when a page becomes PageKsm().
> Is patch comment about that? Even if so, I don't understand what this
> comment is about. "PageKsm() does not take additional counter" is not
> a reason the page can't be reused there.

No, the reason is that we don't want to reuse a KSM page, and the
page_count() check apparently isn't sufficient in all circumstances.

So the comment is there to explain why a plain "page_count()"
apparently isn't sufficient.

> The reason is that readers
> of this page may increase a counter without taking the lock, so
> this page_count() == 1 under the lock does not guarantee anything.

The intent is to get rid of

 (a) all the locking costs. The "lock_page()" we had here used to be
very expensive.

     It's shown up several times in the page lock problems, and the
reason seems to be simply that this is _the_ hottest non-IO path there
is, so it's somewhat easy to generate lots of contention on a shared
page.

 (b) the problems with GUP - because GUP (and some other page sharing
cases) don't increase the page_mapping() count, GUP was "invisible" to
the re-use code, and as a result the reuse code was a buggy mess.

 (c) the complete and pointless complexity of this path, that isn't
actually done anywhere else. The GUP issue was the immediate - and
currently existing - bug caused by this, but the locking costs are
another example.

So the page reuse is simply wrong. It's almost certainly also
pointless and entirely historical. The _reason_ for trying to reuse
the KSM pages was documented not as performance, but simple to match
the other (also pointless) complexity of the swap cache reuse.

So the intent is to do the "page_count()" test early, to get rid of
the locking issues with any shared pages.

So the logic is "if this page is marked PageKsm(), or if it has an
elevated page count, don't even try - just copy".

To make a very concrete example: it's not unusual at all to basically
have simultaneous page faults on a dirty page because it's COW-shared
in both parent and child. Trivial to trigger, with the child and
parent running on different CPU's and just writing to the same page
right after a fork. And there is absolutely _zero_ reason that should
be serialized by anything at all. The parent and child are complete
share-nothing things: taking the page lock was and is simply wrong.

Solution: don't do it. Just notice "Oh, this page has other users"
(and page_count() is the correct thing to do for that, not
page_mappings(), since GUP is also another user), and actively *avoid*
any serialization. Just copy the damn thing.

I'll take full blame for the historical stupidity. This was a bigger
deal back in the days when 4MB of RAM was considered normal. Plus page
locking wasn't even an issue back then. In fact, no locking at all was
needed back when the "try to reuse" code was originally written.
Things were simpler back then.

It's just that I'm 100% convinced that that historical legacy is very
very wrong these days. That "serialize on page lock if COW fault in
parent and child" is just an example of where this is fundamentally
wrong. But the whole complexity in the map count logic is just wholly
and totally wrong too.

I dare anybody to read the swapfile code for "total_map_swapcount" and
tell me they understand it fully.

So my theory is that this code - that is meant to *improve*
performance by sharing pages aggressively after a fork(), because that
used to be a primary issue, is now in fact making performance *much
worse*, because it's trying to optimize for a case that doesn't even
matter any more (does anybody truly believe that swap cache and shared
COW pages are a major source of performance?) and it does so at a huge
complexity _and_ performance cost.

So ripping out the KSM reuse code is just another "this is pointless
and wrong" issue. If you seriously try to KSM share a page that now
only has _one_ single user left, and that one single user writes to it
and is modifying it, then the problem is absolutely *NOT* that we
should try to re-use the page. No, the problem is that the KSM code
picked a horribly bad page to try to share.

Will that happen _occasionally_? Sure. But if it happens once in a
blue moon, we really shouldn't have that code to deal with it.

It's really that simple. All that reuse code is pointless and wrong.
It has historical roots, and it made sense at the time, but in this
day and age I'm convinced it's completely wrong.

Now, I'm _also_ admittedly convinced that I am occasionally completely
wrong, and people do odd things, and maybe there are loads where it
really matters. I doubt it in this case, but I think what we should do
is rip out all the existing historical code, and _if_ somebody has a
case where it matters, we can look at THAT case, and people can show

 (a) what the exact pattern is that we actually care about

 (b) numbers

and then maybe we can re-introduce some sort of re-use code with -
hopefully - a much more targeted and documented "this is why this
matters" approach.

So the intent is to get rid of the page lock thing, but I also hope
that long-term, we can get rid of reuse_swap_page() and some of that
mapcount stuff entirely.

                Linus
