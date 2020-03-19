Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48968C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118920732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGUmJAis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCSGBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:01:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35211 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgCSGBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:01:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id d8so1499147qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eCxSZQRC9mU6ikJj9Kf2AGR9r6dmYjhkzwdN+IOcnFY=;
        b=rGUmJAisnmikEgH17MaYp7Q5qSWFp9gsorLUBBhdz/QhY/IyZ3zL8fE6Mrwb2HbrvK
         b2WLU51qN7OZyVPpMx98aqTyOzmi5+5/fEkO36QEP1khJWiJAhYZngbkwKAMh9tSRKms
         AfZHxiVWEFqXdu/xGS0W3vC9m1WxLUllS3YlAPNa5yCTp9t4+oMxsTOj+av5155+MtEk
         55YCA+xkjdZ3BvFqXglkGOfY5h/J6rUPiowWAIBqRWGibuZiVLGV0h8Mjt/ERIxiLCMl
         U86heWXmXtTxu3AoXF+pTaz/sW9hgRYWM1L3VahOpBmIMF5PZ5Oi2PHJ+PKBMYE94U0Q
         SJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eCxSZQRC9mU6ikJj9Kf2AGR9r6dmYjhkzwdN+IOcnFY=;
        b=gtLvt48EkINNJuzNQB205QLKlXLwxWWnvrWt1D55Y897ELrtV755xhWclrYdn3I0uK
         qg6/wf92xE7uHO1Lzalug/tlfS0YOknnAQIJ5/9lxARzs5cZ/V1E/5K95ruiFBHV2/YN
         MPzD1fMlRMO8OsVkNhsYyXMj1ja2onwaO/z97RasaZtv+LNl37rZJqmjL2eCJLaMhsOs
         MWwaVNQMiEDqk2SL7QYZgCWADjMKawcLWMUtS+z3BQI+4QNJ2yrTq4MfAgcPI/JG6i/P
         LiNkt5/JQlQvaa/pwRRfNOZ1PZUK3X3uRP2VQVP7NLZqBw7+ywNAtgqdSd7bZ3pV9AoB
         Y19w==
X-Gm-Message-State: ANhLgQ2NZoXXpL2cfHoSwYXaZO5+ui6LWAnZuqTQT0hodPE1SF/Dbv45
        EgW+pLEqlk9kFYu6NZ6H09rqiJmOzIGe+zYjdGM=
X-Google-Smtp-Source: ADFU+vtlCKIt8CYc1mLZdtKBx+I3STE84KKoWJY9XTbvMMi5W52y+DXmlXlks513cy5hVUjF9+9MDEeuW3cYcb8lHzk=
X-Received: by 2002:a37:b4c1:: with SMTP id d184mr1490325qkf.452.1584597674075;
 Wed, 18 Mar 2020 23:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-5-git-send-email-iamjoonsoo.kim@lge.com> <20200318183318.GD154135@cmpxchg.org>
In-Reply-To: <20200318183318.GD154135@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 19 Mar 2020 15:01:03 +0900
Message-ID: <CAAmzW4M2wqA4kJ7rzR7GsoS72krQRZx5i53jZh2uGikmVWLntQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] mm/swapcache: support to handle the value in swapcache
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

2020=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 3:33, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Mar 17, 2020 at 02:41:52PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Swapcache doesn't handle the value since there is no case using the val=
ue.
> > In the following patch, workingset detection for anonymous page will be
> > implemented and it stores the value into the swapcache. So, we need to
> > handle it and this patch implement handling.
>
> "value" is too generic, it's not quite clear what this refers to
> here. "Exceptional entries" or "shadow entries" would be better.

Okay. Will change it.

> > @@ -155,24 +163,33 @@ int add_to_swap_cache(struct page *page, swp_entr=
y_t entry, gfp_t gfp)
> >   * This must be called only on pages that have
> >   * been verified to be in the swap cache.
> >   */
> > -void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
> > +void __delete_from_swap_cache(struct page *page,
> > +                     swp_entry_t entry, void *shadow)
> >  {
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> >       int i, nr =3D hpage_nr_pages(page);
> >       pgoff_t idx =3D swp_offset(entry);
> >       XA_STATE(xas, &address_space->i_pages, idx);
> >
> > +     /* Do not apply workingset detection for the hugh page */
> > +     if (nr > 1)
> > +             shadow =3D NULL;
>
> Hm, why is that? Should that be an XXX/TODO item? The comment should
> explain the reason, not necessarily what the code is doing.

It was my TODO. Now, I check the code and find that there is no blocker
for the huge page support. So, I will remove this code and enable the
workingset detection even for the huge page.

> Also, s/hugh/huge/

Okay.

> The rest of the patch looks straight-forward to me.

Thanks.
