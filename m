Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19767C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87CC20756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597176407;
	bh=9kVJER9GnmAJgIf1v0EsXQx3cmVIVjyDJgu9AFSZDAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yMrU+NwTvTldr7CaxGVAZMd9/+BV8dypuhSvtWnl0Z+DzOdDkDrwo1EQ3VbHEJS6U
	 vV8LGD3h7nWcezLXG1u0S1vvimRrklP3/sfMEW74lhfA59cRHC2vL3OaK2eeOsPdCu
	 ILRPwjJeMc759Vy/SuviZv6o2Sr5U67v+vNos8KQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHKUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHKUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:06:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D62C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:06:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z6so85804iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9Z56G7Sq+yoxF26YYsaVBF/VyvZNYi0ExatDmNcea8=;
        b=CmHP/prH5/FP2ejP8hzk1TIK0ioM1mTElZ2Xxat1dgv6XbaDed3rUDQIZjKALmYmYW
         M2Wpi1pa2zNkpS0Il8/Tlx3hEW8wDBHDDMl9j+p7tY795MeaYQkirp7mw2hLYW098fYa
         mvwBVOUXNuGA+5s9y1TTFETU57MNRjCYyagQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9Z56G7Sq+yoxF26YYsaVBF/VyvZNYi0ExatDmNcea8=;
        b=DaIQEeQJnEMcsYY76U2/rNRBh0N81mrDO8GqvN/ETefX8fw8KjECJKuIYuQgXmIH2w
         q8hWUhMF+Kg7W3BOIx+34ReK+wsDuRxOWIyg2m3qOubk0EMYI22CDZheeZofj+oNzLYb
         fGcWbiJ8wGQudrWTKCcbVqk8FXQDF04+5qvxo+mLXduZw8dRSX3wlPwGgBfpGhMhUWuB
         KMZ1li+E5CQEgXI6/qFvZjjzNU9HrENXyfcjVdWglbPh78bCEOGYDmZOSqZDhErYwf6v
         Jh+pH7eUEXG5wkx2ZCpMFMKRcEtFMfjmEmrQ0yuOEdmhWh/fa/gjGHK/CPALVyYFKM7C
         nJWQ==
X-Gm-Message-State: AOAM532dn3mxRuFVqprsJVz0x03ezB8Np5wEez2w2m0Jgr4eFZCzA+tv
        tUT+Gg9IzhXdEIXyFPOcl5THb6i9x3o=
X-Google-Smtp-Source: ABdhPJxt7J4Yz+saDja0hs4hbbCY2wxkcPJTzkfMm3klrxtA/5R73fQ8qccYz0C7xutctQijFvlhyw==
X-Received: by 2002:a05:6602:2d43:: with SMTP id d3mr24043574iow.39.1597176383128;
        Tue, 11 Aug 2020 13:06:23 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id t26sm7007850ilb.80.2020.08.11.13.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:06:21 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id z6so85527iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:06:21 -0700 (PDT)
X-Received: by 2002:a02:9247:: with SMTP id y7mr26798836jag.140.1597176381447;
 Tue, 11 Aug 2020 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com> <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
In-Reply-To: <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 13:06:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
Message-ID: <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

;

On Tue, Aug 11, 2020 at 12:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now I wonder if there's any other case of FOLL_WRITE that is missing.

Actually, now I wonder if we really should have tried to handle the
wrong-way cow reuse case some other way entirely.

When discussing this wrong-way-COW issue originally I looked at just doing

        struct page *page = vmf->page;

        if (page_count(page) != 1)
                goto copy;
        if (!trylock_page(page))
                goto copy;
        if (page_mapcount(page) != 1 && page_count(page) != 1) {
                unlock_page(page);
                goto copy;
        }
        /* Ok, we've got the only map reference, and the only
         *  page count reference, and the page is locked,
         * it's dark out, and we're wearing sunglasses. Hit it.
         */
        wp_page_reuse(vmf);
        unlock_page(page);
        return VM_FAULT_WRITE

at the top of the PageAnon() case in do_wp_page(), and be entirely done with it.

Make the rule be that we *only* re-use the page if there is no
question what-so-ever that we're the only possible owner of it.
Anything else at all - whether they be GUP users, other processes,
KSM, hughepage collapsing, whatever: don't even try.

That would possibly cause a lot of extra copies, but our rules for
"can we re-use this page" are just crazy complicated. And now the
"minimal" thing of just always breaking COW ends up causing
complications of its own.

IOW, maybe all of this falls under "yeah, we have historical reasons
for all of it, but it's just not worth the pain".

We do a _lot_ of complex stuff just to check whether we could possibly
share the page.

Maybe trying to reuse the page just isn't worth it?

Adding Andrea to the cc (although he probably sees this through
linux-mm anyway). Maybe he can go "naah, that will be horribly bad,
because..."

Then we could get rid of all the FAULT_FORCE_COW games again entirely,
and people can point fingers at me and laugh behind my back because of
what a bad idea it was.

                    Linus
