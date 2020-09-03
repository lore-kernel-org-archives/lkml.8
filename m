Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F20C2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/tFSSmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgICHNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:12:59 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD7AC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 00:12:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so1293400lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 00:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+YHglauWyo1GpdJHdSOrL6fqb9MSa+7lxYYxKcetf0w=;
        b=M/tFSSmEvorZluN8EPZwgE5Tgn3kvpXb09Z3o12FeaxXZnpiVOm2R09pYwftnj4bMz
         YI5qV3nmRKPhR9Kzj9Xs4SHdUw2A8SejSAhbTu2ymuaH3OTHtgfmJiUwd6C1NeOl8tbc
         iwaC3enWC/wFq8pILWDBOJ8p+4Tb9VDbyRZfFJDlpMLfT1fBa/mt5s4sVnxArB8JVxFw
         7YOD4is4mtZECMvMJnYfOwNylGf/2zQj4eiaNMGNTVf2qnixSNRhZ2AsegMdLaGQkk1k
         V6vSuk7WKbJUos5jcAZu58DYZtm4TgqGjAgEWfx5mUCrFMEY+QLcCfQ1kOHZg8t9GQap
         u17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+YHglauWyo1GpdJHdSOrL6fqb9MSa+7lxYYxKcetf0w=;
        b=CCjw+gjaRGF8P5m4fGalI5V6XGxV3/0W1fRZSZOK5AGuK1zVfAhqZ51BP7/5U/dTeF
         aNL2xXjPT0XGxVklz1KAdOxuHpff45XJPuX8zeicA1xWTKQ8TY6vXl0Q+9Rp+ZGs0223
         BHiQF3K8SIRPJVzuu51/Re1Wl7F/zqAmRNMKWgwZarr76QhwQOTRZvXVG/Mgr3SG4zDU
         UFzrVIQNiOyGis+eTa4fiHCZJcJsrxFszL2JsE3ZagacXJ/WADotkPv2A58/lz64L/Bk
         YQGbz39N4HQktGqP7DhBQ+6Tn5AykTJyMQwExvXbBG0p1+kt9Eav+To4QwLsVvoMvdkf
         YV2Q==
X-Gm-Message-State: AOAM530gJhG+eQhOzJCMzF15XIb7ZuVMNfSE5AFr8LCCr7llA2sKhotG
        eJAY+2OJ4momtODAWgC8TJI+rIsUPE5gHy3GBQI=
X-Google-Smtp-Source: ABdhPJz4vBiWgH7j7O6wQk0s6XYJWDAbW6Sz7JU6Ag7skgwd7SxNKZFkpJIGrf650+mdKX7h/zafyBdSX9nQ4Hw/+Xw=
X-Received: by 2002:a19:ee0d:: with SMTP id g13mr495606lfb.139.1599117176910;
 Thu, 03 Sep 2020 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com> <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com>
In-Reply-To: <e4265ac0-793d-053b-81b1-15e57c04b830@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 3 Sep 2020 12:42:44 +0530
Message-ID: <CAFqt6zb2GjO9KOVdKT1P0P-Wn+isnArous5gpw-AJ3va+fi9rw@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:45 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/19/20 4:01 AM, Barry Song wrote:
> > gug prohibits users from calling get_user_pages() with FOLL_PIN. But it
>
> Maybe Andrew can fix the typo above: gug --> gup.
>
>
> > allows users to call get_user_pages() with FOLL_LONGTERM only. It seems
> > insensible.
> >
> > since FOLL_LONGTERM is a stricter case of FOLL_PIN, we should prohibit
> > users from calling get_user_pages() with FOLL_LONGTERM while not with
> > FOLL_PIN.
> >
> > mm/gup_benchmark.c used to be the only user who did this improperly.
> > But it has been fixed by moving to use pin_user_pages().
>
> For future patches, you don't have to write everything in the
> commit log. Some things are better placed in a cover letter or after
> the "---" line, because they don't need to be recorded forever.
>
> Anyway, the diffs seem fine, assuming that you've audited the call sites.

We can use is_valid_gup_flags() inside ->
get_user_pages_locked(),
get_user_pages_unlocked(),
pin_user_pages_locked() as well.

Are you planning to add it in future patches ?

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   mm/gup.c | 37 ++++++++++++++++++++++---------------
> >   1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index ae096ea7583f..4da669f79566 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1789,6 +1789,25 @@ static long __get_user_pages_remote(struct mm_st=
ruct *mm,
> >                                      gup_flags | FOLL_TOUCH | FOLL_REMO=
TE);
> >   }
> >
> > +static bool is_valid_gup_flags(unsigned int gup_flags)
> > +{
> > +     /*
> > +      * FOLL_PIN must only be set internally by the pin_user_pages*() =
APIs,
> > +      * never directly by the caller, so enforce that with an assertio=
n:
> > +      */
> > +     if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> > +             return false;
> > +     /*
> > +      * FOLL_PIN is a prerequisite to FOLL_LONGTERM. Another way of sa=
ying
> > +      * that is, FOLL_LONGTERM is a specific case, more restrictive ca=
se of
> > +      * FOLL_PIN.
> > +      */
> > +     if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> >   /**
> >    * get_user_pages_remote() - pin user pages in memory
> >    * @mm:             mm_struct of target mm
> > @@ -1854,11 +1873,7 @@ long get_user_pages_remote(struct mm_struct *mm,
> >               unsigned int gup_flags, struct page **pages,
> >               struct vm_area_struct **vmas, int *locked)
> >   {
> > -     /*
> > -      * FOLL_PIN must only be set internally by the pin_user_pages*() =
APIs,
> > -      * never directly by the caller, so enforce that with an assertio=
n:
> > -      */
> > -     if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> > +     if (!is_valid_gup_flags(gup_flags))
> >               return -EINVAL;
> >
> >       return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
> > @@ -1904,11 +1919,7 @@ long get_user_pages(unsigned long start, unsigne=
d long nr_pages,
> >               unsigned int gup_flags, struct page **pages,
> >               struct vm_area_struct **vmas)
> >   {
> > -     /*
> > -      * FOLL_PIN must only be set internally by the pin_user_pages*() =
APIs,
> > -      * never directly by the caller, so enforce that with an assertio=
n:
> > -      */
> > -     if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> > +     if (!is_valid_gup_flags(gup_flags))
> >               return -EINVAL;
> >
> >       return __gup_longterm_locked(current->mm, start, nr_pages,
> > @@ -2810,11 +2821,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast_only);
> >   int get_user_pages_fast(unsigned long start, int nr_pages,
> >                       unsigned int gup_flags, struct page **pages)
> >   {
> > -     /*
> > -      * FOLL_PIN must only be set internally by the pin_user_pages*() =
APIs,
> > -      * never directly by the caller, so enforce that:
> > -      */
> > -     if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> > +     if (!is_valid_gup_flags(gup_flags))
> >               return -EINVAL;
> >
> >       /*
> >
>
>
