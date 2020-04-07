Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4DBC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE6E20787
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNKOZDHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDGAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:40:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42575 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDGAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:40:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id 123so7133qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 17:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3LF/o4UOLHZ7u5AeS29ADFIWE/RbgKztcg6yxkuc2qQ=;
        b=vNKOZDHkVJsbIEl7B7c09QFBaVWbhOwlnie7l8bQaV7AYsc9mGKPyWD/eASJY9Vo4X
         sK+TIV22dunx7p11iPc1/gUFM3n632Nb5QGtVSA6r+s0pRCjvuCJTp/Pw4URio2TACHk
         cBPNCV0W206g4WLSdowuC4Zqnnjil4NH2lwpyYrFHaSwp9PiZ7TzpFrxgFrKgQ0bwRh3
         rC4vY+aRHIGemp3dKSWPWJtPpeEQs0Yb0U+ArAknFJ36qVwHIC+y0SW+dCaRTBR5kQWX
         a4jae8RXk6OejxqWk8TdsZObJ7GU98u+I7xlS+ygtKwi9MlGxW5nC4gPC+u9Hk+MMOck
         XJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3LF/o4UOLHZ7u5AeS29ADFIWE/RbgKztcg6yxkuc2qQ=;
        b=LZBSTHkHqD/B6WHYz38mpG5lYZvhoFC6wSgTdwDqm0L5iwePPpRH7sgToOfvJ+yrD/
         LTJl9fM6EQdYEx8y0voLKwphXwRoNOHbipBhauUF7Uk4KQSECOoSakOI0m4ODFISFGIO
         yk9PHc5U7q1zd0jThG9zPGyyTMPldS1nXLsnYo6ZA/6aCdI76QYTElWr9cgqfyHjHjbm
         v/RjN74AxWclDmqbD5pILC4DdP8xragU9H7zJH52nTewIdYHCLliAALRe2KieOigI3us
         itoObiAhrNNimD2GWO+Dlpl7/fR5lzDRGIWLlRMNA+J/sZOegR40FAJx27Nc4dQJUrUb
         iDpQ==
X-Gm-Message-State: AGi0PuaYk2WIXGkRk72wDy/81nfD/TTrqyqPpI2looeZv92hyq3TT5/A
        6Tae/PwVwoHv9NNJ0zRnk34x3HrHOUtPV0Esn5E=
X-Google-Smtp-Source: APiQypJFrTcD8M7cUC55n3DG+zlL6SuC0I0p5zWmGQ68W8FY6zH5fvJsjpMf8bVNRdIshpZimFwOSYplzRb7pfniCZw=
X-Received: by 2002:a37:af86:: with SMTP id y128mr24790013qke.429.1586220054400;
 Mon, 06 Apr 2020 17:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com> <20200406091814.17256-1-hdanton@sina.com>
In-Reply-To: <20200406091814.17256-1-hdanton@sina.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 7 Apr 2020 09:40:43 +0900
Message-ID: <CAAmzW4MZG9m+wDYSnG3ZGy_9X_ajv6eU8AdtGyrSJ7kW1K3TQQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] mm/vmscan: protect the workingset on anonymous LRU
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

2020=EB=85=84 4=EC=9B=94 6=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:18, Hi=
llf Danton <hdanton@sina.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On Fri,  3 Apr 2020 14:40:40 +0900 Joonsoo Kim wrote:
> >
> > @@ -3093,11 +3093,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (unlikely(page !=3D swapcache && swapcache)) {
> >               page_add_new_anon_rmap(page, vma, vmf->address, false);
> >               mem_cgroup_commit_charge(page, memcg, false, false);
> > -             lru_cache_add_active_or_unevictable(page, vma);
> > +             lru_cache_add_inactive_or_unevictable(page, vma);
> >       } else {
> >               do_page_add_anon_rmap(page, vma, vmf->address, exclusive)=
;
> >               mem_cgroup_commit_charge(page, memcg, true, false);
> > -             activate_page(page);
> >       }
> >
> >       swap_free(entry);
> ...
> > @@ -996,8 +996,6 @@ static enum page_references page_check_references(s=
truct page *page,
> >               return PAGEREF_RECLAIM;
> >
> >       if (referenced_ptes) {
> > -             if (PageSwapBacked(page))
> > -                     return PAGEREF_ACTIVATE;
> >               /*
> >                * All mapped pages start out with page table
> >                * references from the instantiating fault, so we need
> > @@ -1020,7 +1018,7 @@ static enum page_references page_check_references=
(struct page *page,
> >               /*
> >                * Activate file-backed executable pages after first usag=
e.
> >                */
> > -             if (vm_flags & VM_EXEC)
> > +             if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
> >                       return PAGEREF_ACTIVATE;
> >
> >               return PAGEREF_KEEP;
> > --
> > 2.7.4
>
> Both changes other than
> s/lru_cache_add_active_or_unevictable/lru_cache_add_inactive_or_unevictab=
le/
> are likely worth their own seperate commits with a concise log.

IMO, all of the changes in this patch provides just one logical change
for LRU management
on anonymous page so it's better to be together.

Thanks.
