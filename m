Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE69C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDF522202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jag8221i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgDQBjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbgDQBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:39:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD2C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:39:05 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so887248qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPtQ7coh4iLhBPuUOtg9WgiEyYbfPFLKSwoFKmaeBKM=;
        b=Jag8221i4RN4j5c2xJkI3PEkuiLswUaiHKz9yyangYdEaZcFXJGlpgKtwUe3bzQJC8
         iY99EMGRhZn54OwbXAAnLwEVeL4moF3vx2VEJXV/6tk3ez0pOxjHyq+BXNBVTqbzAt7u
         2SNiEPnOnxRyaTrIRb6snTxtBkY8IcxPNotOgzZtg2fZdqdZV0YqHxg1EUTH837L9C6j
         bk6vi1y5dMD4Svm9n2x9SksOp7cBEeAcPmjLAUxKQ/1wETgryURdQOKwRa6beHoaJ32l
         llOYL62xRpCdiVOpt9HTt2liankaVybvGaGs8QyUlL44jHAMDkOS17fHeIyxPCuC3uIZ
         Cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPtQ7coh4iLhBPuUOtg9WgiEyYbfPFLKSwoFKmaeBKM=;
        b=cCjwirpIpU+COQjMrcZ2CnCjUilCPeqvAKOGGwXWAvNAvD4rw5guufLtAGy6w3hDy9
         Eq+ehwxYH/Q7oc/4qweCzJk/gpMnujjHOAEmUmek8IXUZZEMLxR3zkL3Ipyc8c7vIEjP
         UtmQgeCXPO0WCCiIwe72ZPfj8YXuwC+Tb7fv9LfqM2KZLOcAxhUg6RNXO4idUBwH34kA
         y5WYZUZ6aRNjhzTKopXnRGKAvP7LFx868pyMvFH3CylBJ9vK48D0G68YV7gqSGmVYCz/
         5YD5Ftbly+mVtAyha2XE/pj7zq850pdortXLrsKlsNOw2p/FE1kbZp0/ZF97T/d0EKqF
         RXJg==
X-Gm-Message-State: AGi0PuaN05FHXz/GL5zJ5CjvSIZtLwfiafzMEvZpcKklqvJUyNB7WQhT
        7nwSoPwKjE2d13jrVQM5ZnU/JP6w3AXNUElsoGs=
X-Google-Smtp-Source: APiQypLZO8+eg7K9Hv3Q1LLCitcVuMfTZ4zq72JOEpcVFJs23USk+riDSAzWdZAWVb9hk5PFztW/UqVywzmKirZMZJk=
X-Received: by 2002:a37:8cc1:: with SMTP id o184mr919597qkd.187.1587087544738;
 Thu, 16 Apr 2020 18:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com> <20200416161133.GA178028@cmpxchg.org>
In-Reply-To: <20200416161133.GA178028@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 17 Apr 2020 10:38:53 +0900
Message-ID: <CAAmzW4M5EBXDarx-Xkryrf+BKgdOJqBr7aBaB=4P3gBRN-v30Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the swap cache
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:11, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello Joonsoo,
>
> On Fri, Apr 03, 2020 at 02:40:43PM +0900, js1304@gmail.com wrote:
> > @@ -112,7 +112,7 @@ void show_swap_cache_info(void)
> >   * but sets SwapCache flag and private instead of mapping and index.
> >   */
> >  int add_to_swap_cache(struct page *page, swp_entry_t entry,
> > -                     gfp_t gfp, void **shadowp)
> > +                     struct vm_area_struct *vma, gfp_t gfp, void **sha=
dowp)
> >  {
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> >       pgoff_t idx =3D swp_offset(entry);
> > @@ -120,14 +120,26 @@ int add_to_swap_cache(struct page *page, swp_entr=
y_t entry,
> >       unsigned long i, nr =3D compound_nr(page);
> >       unsigned long nrexceptional =3D 0;
> >       void *old;
> > +     bool compound =3D !!compound_order(page);
> > +     int error;
> > +     struct mm_struct *mm =3D vma ? vma->vm_mm : current->mm;
> > +     struct mem_cgroup *memcg;
> >
> >       VM_BUG_ON_PAGE(!PageLocked(page), page);
> >       VM_BUG_ON_PAGE(PageSwapCache(page), page);
> >       VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
> >
> >       page_ref_add(page, nr);
> > +     /* PageSwapCache() prevent the page from being re-charged */
> >       SetPageSwapCache(page);
> >
> > +     error =3D mem_cgroup_try_charge(page, mm, gfp, &memcg, compound);
> > +     if (error) {
> > +             ClearPageSwapCache(page);
> > +             page_ref_sub(page, nr);
> > +             return error;
> > +     }
> > +
> >       do {
> >               xas_lock_irq(&xas);
> >               xas_create_range(&xas);
> > @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_entr=
y_t entry,
> >               xas_unlock_irq(&xas);
> >       } while (xas_nomem(&xas, gfp));
> >
> > -     if (!xas_error(&xas))
> > +     if (!xas_error(&xas)) {
> > +             mem_cgroup_commit_charge(page, memcg, false, compound);
>
> Unfortunately you cannot commit here yet because the rmap isn't set up
> and that will cause memcg_charge_statistics() to account the page
> incorrectly as file. And rmap is only set up during a page fault.

I also found this problem a few days ago. In my investigation, what we need=
 for
anonymous page to make accounting correct is a way to find the type of the =
page,
file or anon, since there is no special code to use the rmap. And, I
think that it
could be done by checking NULL mapping or something else. Is there anything
I missed? And, I cannot find the function, memcg_charge_statistics(). Pleas=
e
let me know the file name of this function.

This is just my curiosity and I agree what you commented below.

> This needs a bit of a rework of the memcg charging code that appears
> out of scope for your patches. I'm preparing a series right now to do
> just that. It'll also fix the swap ownership tracking problem when the
> swap controller is disabled, so we don't have to choose between
> charging the wrong cgroup or hampering swap readahead efficiency.

Sound good! I also think that these patches are out of scope of my series.
I will wait your patches. Could you let me know when your series is submitt=
ed?
I'd like to plan my work schedule based on your patch schedule.

> The patches also unblock Alex Shi's "per lruvec lru_lock for memcg"
> series, which is all the more indication that memcg needs fixing in
> that area.

Okay.

Thanks.
