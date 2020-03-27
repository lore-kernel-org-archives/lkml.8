Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD8E2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT9KaL6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgC0VcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:32:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39740 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0VcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:32:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so13039902edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d/BcDy55M6k3RsToyaQtP26qvola5RUqyCk9DPFq0TY=;
        b=dT9KaL6H+W6iFJ4UK/UE1Ag6+7J+nTZ56mmSDmdPsBjK2xLeysBUgDFdPJ2GEJmFXF
         5cZYPpL1/6d5OmpHh+GdgM8MEbTnuRT1F48G20Dkr3ARIWb/nsNTbZbsAbYy2aI1sTEr
         0+dYI7gMBDdb8M78ERSECrXwZaUue6G9Xbh62yqtCGeu8ZwTxi6vGSNValRRWGxHxPxv
         S0qJmPHgtVEHQiVnAUWGQK35vMwYrPcHDANLob/6OpglYROKZ8A5CeKTS0HiGRP/0B3B
         oQAPX4W+xBHCJaVfCpp3+XIH5hncUjOaggfZeSAwfZJWnCVRfI8XpGgXWRK6ooDGzpCR
         dYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d/BcDy55M6k3RsToyaQtP26qvola5RUqyCk9DPFq0TY=;
        b=CpDSc1jGvCFofzWzjaIxQ3m6IZmnUMsrtoWlnz48ODM1F6rvp89BKAi/dPmbrRbQ5h
         1VroPuV1BRgw9C513NJK6bmG5ecIVt/JnNdSA6WOMRD5HOCzL1kSR/guypEqWZpNWur+
         qtTwW8OYyBL85K722V4YPNuIanLDtdrJUvRWqYKrIHcdybQRC+/dlAYfMYPro8dpa9Kf
         T1buVXCQjTN638VWJrYSpQUpXXfvnNLs7FBZVSVU/RlMwB/YKJ0A8CB/R594G/1MY6jQ
         xpN+DhGqtqAgkCb+S/AtM2r66MGXu7m9tnocPFa/Ginb80AEj09DlVEcje80JcfS1hWY
         HHqQ==
X-Gm-Message-State: ANhLgQ0RE8n5PgQbB184UGZsX/z1+HeeaQSN+KxJUnJSkSYHRNywEI7t
        xs4UjTpZybUw8MooeGdghaZK8pzyx/+1KkDBlZ68p/34
X-Google-Smtp-Source: ADFU+vsJJJGRfxvQ8W0NpLPVRfEQ2EuvR2uA7o9ESLPIjR4d7+tl9r1LSz1bqDCwKkIkPeYq7/CqWEGa7o1yG/sc2XA=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr1197996edf.372.1585344727711;
 Fri, 27 Mar 2020 14:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-5-kirill.shutemov@linux.intel.com> <AD80A72A-8FB7-4F89-A2C9-CDD5C616A479@sent.com>
In-Reply-To: <AD80A72A-8FB7-4F89-A2C9-CDD5C616A479@sent.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 14:31:55 -0700
Message-ID: <CAHbLzkrLxB93xs78xejsBsZ=-b+oqNao6a5Bydi8-6+wpzjKQg@mail.gmail.com>
Subject: Re: [PATCH 4/7] khugepaged: Allow to callapse a page shared across fork
To:     Zi Yan <zi.yan@sent.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:20 AM Zi Yan <zi.yan@sent.com> wrote:
>
> On 27 Mar 2020, at 13:05, Kirill A. Shutemov wrote:
>
> > The page can be included into collapse as long as it doesn't have extra
> > pins (from GUP or otherwise).
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/khugepaged.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 39e0994abeb8..b47edfe57f7b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -581,18 +581,26 @@ static int __collapse_huge_page_isolate(struct vm=
_area_struct *vma,
> >               }
> >
> >               /*
> > -              * cannot use mapcount: can't collapse if there's a gup p=
in.
> > -              * The page must only be referenced by the scanned proces=
s
> > -              * and page swap cache.
> > +              * Check if the page has any GUP (or other external) pins=
.
> > +              *
> > +              * The page table that maps the page has been already unl=
inked
> > +              * from the page table tree and this process cannot get
> > +              * additinal pin on the page.
> > +              *
> > +              * New pins can come later if the page is shared across f=
ork,
> > +              * but not for the this process. It is fine. The other pr=
ocess
> > +              * cannot write to the page, only trigger CoW.
> >                */
> > -             if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> > +             if (total_mapcount(page) + PageSwapCache(page) !=3D
> > +                             page_count(page)) {
>
> Do you think having a function for this check would be better? Since the =
check is used three times.
>
> >                       /*
> >                        * Drain pagevec and retry just in case we can ge=
t rid
> >                        * of the extra pin, like in swapin case.
> >                        */
> >                       lru_add_drain();
> >               }
> > -             if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> > +             if (total_mapcount(page) + PageSwapCache(page) !=3D
> > +                             page_count(page)) {
> >                       unlock_page(page);
> >                       result =3D SCAN_PAGE_COUNT;
> >                       goto out;
> > @@ -680,7 +688,6 @@ static void __collapse_huge_page_copy(pte_t *pte, s=
truct page *page,
> >               } else {
> >                       src_page =3D pte_page(pteval);
> >                       copy_user_highpage(page, src_page, address, vma);
> > -                     VM_BUG_ON_PAGE(page_mapcount(src_page) !=3D 1, sr=
c_page);
>
> Maybe replace it with this?
>
> VM_BUG_ON_PAGE(page_mapcount(src_page) + PageSwapCache(src_page) !=3D pag=
e_count(src_page), src_page);

I don't think this is correct either. If a THP is PTE mapped its
refcount would be bumped by the number of PTE mapped subpages. But
page_mapcount() would just return the mapcount of that specific
subpage. So, total_mapcount() should be used, but the same check has
been done before reaching here.

>
>
> >                       release_pte_page(src_page);
> >                       /*
> >                        * ptl mostly unnecessary, but preempt has to
> > @@ -1209,12 +1216,9 @@ static int khugepaged_scan_pmd(struct mm_struct =
*mm,
> >                       goto out_unmap;
> >               }
> >
> > -             /*
> > -              * cannot use mapcount: can't collapse if there's a gup p=
in.
> > -              * The page must only be referenced by the scanned proces=
s
> > -              * and page swap cache.
> > -              */
> > -             if (page_count(page) !=3D 1 + PageSwapCache(page)) {
> > +             /* Check if the page has any GUP (or other external) pins=
 */
> > +             if (total_mapcount(page) + PageSwapCache(page) !=3D
> > +                             page_count(page)) {
> >                       result =3D SCAN_PAGE_COUNT;
> >                       goto out_unmap;
> >               }
> > --
> > 2.26.0
>
> Thanks.
>
> =E2=80=94
> Best Regards,
> Yan Zi
