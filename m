Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DCDC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E07207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mwkksggy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEKWEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:04:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162EDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:04:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so11294827ljl.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olyg5BleQvWOok0H/W0T/3hEIKhdj40HkG84B1Qp8Mk=;
        b=MwkksggyB7hO8niRFHCNEvzqnttDKzZhbF6bX7zyQlg6Z9k9/odEcDN9Av/YYp7/FP
         lwQ8gEJ5veg1LluP89YM6zlDQfidZvcCHIg66ATTwEoLN/6GrDBuKhwyt2JM5HDx3CQo
         eg6QuRIFpfO3RxIuFhZvq7vuERLhBJjGZpAjj22HDfFNtgkafZ04l40Cift48ut2e3G6
         VMQ6C9J/BoTu22NyRBOSNXiewfJvOO9coYK6Puw1+k7+U1PqivrEFSlD5TisyC0xLBvu
         b0cBtTTyods9Vl5xtjBMWC3+BDkx+jnYO4CpQKgH6i1w12zxdzo/cEcYXJUnrEEmYWaf
         sw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olyg5BleQvWOok0H/W0T/3hEIKhdj40HkG84B1Qp8Mk=;
        b=N3tUaL7LD5rY2NizaHvLlWkWn8kcShRYHFMNJMR6ALon0gz1qzPgoMeXSiStHhzrud
         6qwsSKX+cS0sdMheAN24XMLTeK/h6r+x9Ntv2U04qIxq8L+R+TQIajO/jWaizVpTQJST
         E9cz/gSaq88lU/hftbSr8uXstm5QliMOWW2hprYPzQBzEEbxAatOjlQZFXhgBXWNIyhv
         7Tprv2p8OjiL6cH6OcrtlTLyUokgwmpnxuClhRwOwGTnQGj69eAW+hFVyyG2oyLSeDQV
         0g1mhecQwSJT0a09ib0HIif1xawsAXJ2+kOZNld3C6yWZyg8DY80fH1bqeS4DYlRsAgw
         9oAQ==
X-Gm-Message-State: AOAM531qwQliVot45ieIqPfaj9bFZ6PMvOg6S2s5hKwFq/3Y+UA7ZcpB
        2HoU6zqIXZz+BqH7Sn2I6i9Z6f4S2brkRGb2X66jWw==
X-Google-Smtp-Source: ABdhPJxEzF0xbkVw+pIhwSjLBsTmnQO4i4A9Izu9MStBQuQQYoj878fBgf2Bxsu4yCT20viSeq4ril4g+4u8nMV0Be4=
X-Received: by 2002:a2e:1659:: with SMTP id 25mr9288748ljw.250.1589234653280;
 Mon, 11 May 2020 15:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200509141946.158892-1-shakeelb@google.com> <20200511141122.9b03e2f0852b57b224eab066@linux-foundation.org>
 <CALvZod7848_BETonZJFxXN1n1E7KtZ4DzT1-BeaN6hvBysN8WQ@mail.gmail.com> <20200511145817.a1379d6117b43c3f6474e199@linux-foundation.org>
In-Reply-To: <20200511145817.a1379d6117b43c3f6474e199@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 11 May 2020 15:04:01 -0700
Message-ID: <CALvZod5D8prx=D3gLxVBFeOkK6gONVJPVHa2k8A-ugxsRa12Jw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix LRU balancing effect of new transparent huge pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 2:58 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 11 May 2020 14:38:23 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > On Mon, May 11, 2020 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Sat,  9 May 2020 07:19:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > > Currently, THP are counted as single pages until they are split right
> > > > before being swapped out. However, at that point the VM is already in
> > > > the middle of reclaim, and adjusting the LRU balance then is useless.
> > > >
> > > > Always account THP by the number of basepages, and remove the fixup
> > > > from the splitting path.
> > >
> > > Confused.  What kernel is this applicable to?
> >
> > It is still applicable to the latest Linux kernel.
>
> The patch has
>
> > @@ -288,7 +288,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
> >
> >               __count_vm_events(PGACTIVATE, nr_pages);
> >               __count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
> > -             update_page_reclaim_stat(lruvec, file, 1);
> > +             update_page_reclaim_stat(lruvec, file, 1, nr_pages);
> >       }
> >  }
>
> but current mainline is quite different:
>
> static void __activate_page(struct page *page, struct lruvec *lruvec,
>                             void *arg)
> {
>         if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
>                 int file = page_is_file_lru(page);
>                 int lru = page_lru_base_type(page);
>
>                 del_page_from_lru_list(page, lruvec, lru);
>                 SetPageActive(page);
>                 lru += LRU_ACTIVE;
>                 add_page_to_lru_list(page, lruvec, lru);
>                 trace_mm_lru_activate(page);
>
>                 __count_vm_event(PGACTIVATE);
>                 update_page_reclaim_stat(lruvec, file, 1);
>         }
> }
>
> q:/usr/src/linux-5.7-rc5> patch -p1 --dry-run < ~/x.txt
> checking file mm/swap.c
> Hunk #2 FAILED at 288.
> Hunk #3 FAILED at 546.
> Hunk #4 FAILED at 564.
> Hunk #5 FAILED at 590.
> Hunk #6 succeeded at 890 (offset -9 lines).
> Hunk #7 succeeded at 915 (offset -9 lines).
> Hunk #8 succeeded at 958 with fuzz 2 (offset -10 lines).
> 4 out of 8 hunks FAILED
>

Oh sorry my mistake. It is dependent on the first two patches at [1].
Basically I replaced the third patch of the series with this one. I
should have re-send them all together.

[1] http://lkml.kernel.org/r/20200508212215.181307-1-shakeelb@google.com
