Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AAD206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uC26ZjQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgFAGkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgFAGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:40:07 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522BC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:40:06 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g18so6878623qtu.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oL022P9vCPxNbqvST58uSq8Z98BV5spczkI6DhdRhmA=;
        b=uC26ZjQZe9xJXF99/nrXwhOxZ0/BKVZ5jbouogDnEgb0Yj8sw1pDQUFZ384ClSYGa8
         xFNCsYt6fkjG7gtL3rhaFr+wuVGEOJMl3HcIP7KUuvRaWk+BCvpo6mmRHFQT4RcSF68f
         HG2IeZaFdLXpovtc3Pb2xvs+wsNFJCJaGX3bhM6Z4ByiAfUjs4J/H+RDi02VClyluJUV
         qJXaoSdyhXcH9U1xWjInzFP8OHW9FU3eLfzhZEjz7ybUmH9wGWhfeB1Ruth3zZwEpJTz
         sc8EYypgCQdq9+qqgjrJiiWwFMYVxvva/d9+WO7o0dI/B4uv/DsDWLJ8UoNkWbvNs/M6
         Y6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oL022P9vCPxNbqvST58uSq8Z98BV5spczkI6DhdRhmA=;
        b=fBq+zpKi717h+9YeZ907QdzJAwAtct8p8jkJt8cNa0q7EdJNc/AyQos/rysRlGS0C4
         wp4HYN5JCeo+dci2BMBoG3AAEY760E2XDmtOXDIUK8KasWx5JigrAFIb3REVyQw2HKxN
         Fr409z+5hn/fTkO21kkJFN795BZ4DDQePhnMtUX67SpyrxjtwZA2TduQyF7TmcO90taS
         owUBNrxf/YsynUhP2aEuUe32VG/CHHKzd9EFzNwUZdj0N4G5xcBJiRKaqfWxpzz/ggPD
         LwCKZ/3sb3sYVNmVfm6XV4RuK06UK/Q32se9BhE5vr7Mo/M+FPwgbyrgB9/AsCHdBZIJ
         wNkw==
X-Gm-Message-State: AOAM532QLOZy0yw6FjcDgyg/SyXUokl0pRA6emFYNH3iurDrfAQ1is6k
        3Rq+uU/OhBOpHSfkNQc7ITk4+AV1aZYYJbymWG0=
X-Google-Smtp-Source: ABdhPJwm5XAuoeOFgp7lKIDJEuRKhKg31buCY+N/ZfNV7a8C/hJez6utFb4tZuP0xz6w1mB69OnusyjWsBDlRC7vkLo=
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr20307684qth.194.1590993605401;
 Sun, 31 May 2020 23:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <45a8ee8b-ec3a-df0f-fe23-6f64097cd263@suse.cz> <CAAmzW4OY9gOPcWsUwQ+O3vfFJvrWvNFnuy4O5FbPYwnWfF1wEw@mail.gmail.com>
In-Reply-To: <CAAmzW4OY9gOPcWsUwQ+O3vfFJvrWvNFnuy4O5FbPYwnWfF1wEw@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 1 Jun 2020 15:40:00 +0900
Message-ID: <CAAmzW4Ne3V6p2a9R4KiHCRX47nVp4+2A-GATmf2DxbxpzkjHBA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] clean-up the migration target allocation functions
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:50, J=
oonsoo Kim <js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2020=EB=85=84 5=EC=9B=94 29=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:25,=
 Vlastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On 5/27/20 8:44 AM, js1304@gmail.com wrote:
> > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >
> > > This patchset clean-up the migration target allocation functions.
> > >
> > > * Changes on v2
> > > - add acked-by tags
> > > - fix missing compound_head() call for the patch #3
> > > - remove thisnode field on alloc_control and use __GFP_THISNODE direc=
tly
> > > - fix missing __gfp_mask setup for the patch
> > > "mm/hugetlb: do not modify user provided gfp_mask"
> > >
> > > * Cover-letter
> > >
> > > Contributions of this patchset are:
> > > 1. unify two hugetlb alloc functions. As a result, one is remained.
> > > 2. make one external hugetlb alloc function to internal one.
> > > 3. unify three functions for migration target allocation.
> > >
> > > The patchset is based on next-20200526.
> > > The patchset is available on:
> >
> > I went through the series and I'd like to make some high-level suggesti=
ons
> > first, that should hopefully simplify the code a bit more and reduce ch=
urn:
>
> Thanks for review!
> I have not enough time today to check your suggestions.
> I will check on next week and then reply again.
>
> Thanks.
>
> > - in the series, alloc_huge_page_nodemask() becomes the only caller of
> > alloc_migrate_huge_page(). So you can inline the code there, and it's o=
ne less
> > function out of many with similar name :)
> >
> > - after that, alloc_huge_page_nodemask(ac) uses ac mostly just to extra=
ct
> > individual fields, and only pass it as a whole to dequeue_huge_page_nod=
emask().
> > The only other caller of dequeue...() is dequeue_huge_page_vma() who ha=
s to
> > construct ac from scratch. It might be probably simpler not to introduc=
e struct
> > alloc_control into hugetlb code at all, and only keep it for
> > alloc_migrate_target(), at which point it can have a more specific name=
 as
> > discussed and there's less churn
> >
> > - I'd suggest not change signature of migrate_pages(), free_page_t and
> > new_page_t, keeping the opaque private field is fine as not all callbac=
ks use
> > struct alloc_context pointer, and then e.g. compaction_alloc has to use=
 the
> > private field etc. alloc_migration_target() can simply cast the private=
 to
> > struct alloc_control *ac as the first thing

Looks like all your suggestions are reasonable. I will try them and make v3=
.

Thanks.
