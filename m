Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2D0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAD120725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594491657;
	bh=wjeCOKsX7lOhR9Ru/RpN03WK7WFljNGY9tQvfhw58hI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YG008z7TpC3z0AbvmjJhlxwgE//Fjo4tJLKGvY3Td6a2aBM6ThNNScYHAXkvmBzjM
	 ZjrIwLtub5eNIZ7guMgr5ZCXxhiAdmwdVNIxLOcN9aeAamJRrt2hrKe6s70niYL/BY
	 mMrizZ2O1kzFaGf5GHbsM7DP6pWNWW3CU8l9VYSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGKSU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgGKSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:20:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB72C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:20:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so9717862ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOYGlWMMEU7tyKGZLlNjUtNxoe6S2h/oz0+oUhK+rOk=;
        b=VBBPUfpiOu0muHbqeP4r3/fUpKQexAHw4DwIqUVNkb43xD+nP+XZ31NsLPUx/vRkRa
         zzaUKWdXrUMfP1FaX3/iNfjqwE1q1Ok1Kix+hzrcv/inVzkMy6FKF046RABJFAJTQy8g
         /oNUGPpsZ3sEzfL5OAQbTJjbjvnkfKAkigYrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOYGlWMMEU7tyKGZLlNjUtNxoe6S2h/oz0+oUhK+rOk=;
        b=lglFRwWMsfQaciMkc/BLozstwIXlsQVcygPFaIxR2Qr96TxHI1zXsST0LkvXT3/U5z
         730bmdY21qnGGeJguDUbnOI73gG12R47aibzthXzLJK4F+S58+Wg4GDamK1rTQEHZn9G
         PZxU9PrCUqCms6R3qPtTvkCWcRPOvvXw7a1lE4mahadLmSsksNwLecmKoyDQ6bmSK7xI
         ZF4ldk4eK2JK8OUh2CTBGr3CuAN6zDIS8pAU7a3B4Yq/wZZ5tfEZtsFOvRgkvN0fleDp
         NOtlXJXaIebSAlihhKWhmBULE/JDsahqEKA/JMdaXh7LkxZqxWLtPRF4mzGWAPAvR32h
         e5fQ==
X-Gm-Message-State: AOAM5336IDc9psrdmTs0WEg03BxaxBgGWoPhX5HuDE6XIftJMhrfH9CU
        BJgwA+SXZ8a67VWY5oH6Dtz0AD+PayM=
X-Google-Smtp-Source: ABdhPJxWDxVe//614M1gb8WNyPJOHIlFhFFWSCG7jsiSLEfhzquMw67aSyXrE+eyPpeiOiHmoQm/RQ==
X-Received: by 2002:a17:906:e2ca:: with SMTP id gr10mr64347738ejb.81.1594491654263;
        Sat, 11 Jul 2020 11:20:54 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id q21sm5975496ejc.112.2020.07.11.11.20.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 11:20:54 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id n26so9739378ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:20:53 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr42771907ljj.102.1594491195002;
 Sat, 11 Jul 2020 11:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <CA+G9fYudT63yZrkWG+mfKHTcn5mP+Ay6hraEQy3G_4jufztrrA@mail.gmail.com>
 <CAHk-=whPrCRZpXYKois-0t8MibxH9KVXn=+-O1YVvOA016fqhw@mail.gmail.com> <CA+G9fYusSSrc5G_pZV6Lc-LjjkzQcc3EsLMo+ejSzvyRcMgbqw@mail.gmail.com>
In-Reply-To: <CA+G9fYusSSrc5G_pZV6Lc-LjjkzQcc3EsLMo+ejSzvyRcMgbqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Jul 2020 11:12:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Bqu5n3OJCnKiO_gs97fYEpdx6eSacEw2kv9YnnSv_w@mail.gmail.com>
Message-ID: <CAHk-=wj_Bqu5n3OJCnKiO_gs97fYEpdx6eSacEw2kv9YnnSv_w@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 10:27 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> I have started bisecting this problem and found the first bad commit

Thanks for the effort. Bisection is often a great tool to figure out
what's wrong.

Sadly, in this case:

> commit 9f132f7e145506efc0744426cb338b18a54afc3b
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Thu Jan 3 15:28:41 2019 -0800
>
>     mm: select HAVE_MOVE_PMD on x86 for faster mremap

Yeah, that's just the commit that enables the code, not the commit
that introduces the fundamental problem.

That said, this is a prime example of why I absolutely detest patch
series that do this kind of thing, and are several patches that create
new functionality, followed by one patch to enable it.

If you can't get things working incrementally, maybe you shouldn't do
them at all. Doing a big series of "hidden work" and then enabling it
later is wrong.

In this case, though, the real patch that did the code isn't that kind
of "big series of hidden work" patch series, it's just the (single)
previous commit 2c91bd4a4e2e ("mm: speed up mremap by 20x on large
regions").

So your bisection is useful, it's just that it really points to that
previous commit, and it's where this code was introduced.

It's also worth noting that that commit doesn't really *break*
anything, since it just falls back to the old behavior when it warns.

So to "fix" your test-case, we could just remove the WARN_ON.

But the WARN_ON() is still worrisome, because the thing it tests for
really _should_ be true.

Now, we actually have a known bug in this area that is talked about
elsewhere: the way unmap does the pgtable_free() is

        /* Detach vmas from rbtree */
        detach_vmas_to_be_unmapped(mm, vma, prev, end);

        if (downgrade)
                mmap_write_downgrade(mm);

        unmap_region(mm, vma, prev, start, end);

(and unmap_region() is what does the pgtable_free() that should have
cleared the PMD).

And the problem with the "downgrade" is that another thread can change
the beginning of the next vma when it's a grow-down region (or the end
of the prev one if it's a grow-up).

See commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
munmap") for the source of that

But that requires an _actual_ "unmap()" system call (the others set
"downgrade" to false - I'm not entirely sure why), and it requires
another thread to be attached to that VM in order to actually do that
racy concurrent stack size change.

And neither of those two cases will be true for the execve() path.
It's a new VM, with just one thread attached, so no threaded munmap()
going on there.

The fact that it seems to happen with

    https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/thp/thp01.c

makes me think it's somehow related to THP mappings, but I don't see
why those would matter. All the same pmd freeing should still have
happened, afaik.

And the printout I asked for a few days back for when it triggered
clearly showed a normal non-huge pmd ("val: 7d530067" is just
"accessed, dirty, rw, user and present", which is a perfectly normal
page directory entry for 4kB pages, and we could move the whole thing
and move 2MB (or 4MB) of aligned virtual memory in one go).

Some race with THP splitting and pgtable_free()? I can't see how
anything would race in execve(), or how anything would have touched
that address below the stack in the first place..

Kirill, Oleg, and reaction from this? Neither of you were on the
original email, I think, it's this one:

    https://lore.kernel.org/lkml/CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com/

and I really think it is harmless in that when the warning triggers,
we just go back to the page-by-page code, but while I think the
WARN_ON() should probably be downgraded to a WARN_ON_ONCE(), I do
think it's showing _something_.

I just can't see how this would trigger for execve(). That's just
about the _simplest_ case for us: single-threaded, mappings set up
purely by load_elf_binary() etc.

I'm clearly missing something.

               Linus
