Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0D220857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n44gaBx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgCCNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:38:44 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34154 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:38:44 -0500
Received: by mail-io1-f68.google.com with SMTP id z190so3600754iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYvtLVzi18cIH6u0PRaiZ+x+kMrKvMGPICXTKLEmlk4=;
        b=n44gaBx7J09bO0aLDcRtttMXYmMiYYEMy7D8QsoilKQYF/NcqQlhD8Z+kjxuhKBSSu
         Wl3s5P5ZgXFmSe/6IFfmOEyzCksX0OeaIyOw8gM1eVBr5IS4rFViV4YnJD5f8zguw8d4
         BY7hLvhyYGG3HpyoSeDYAvNfsAwV/ZWwfDuEpAntd5kBmv0/RY88cAGJrvYbKfoGpRuo
         OwlgJXgDBOF11BpDmdn3NG0wPH1ocEKxE2n0bY9ewqnA1OR38lSTQSzFTmZezw5I3V+w
         LFh9aNc+jMuj0lUpJU24gIEul247Ug9i1VZ84vlDzZ9/kHodRXbJE9BCdjiEP2XSBKig
         4bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYvtLVzi18cIH6u0PRaiZ+x+kMrKvMGPICXTKLEmlk4=;
        b=KAvRYGRC2g1ZfpL7urHmEC1EfgeYwwc3k+e0cv3tsgK5ZbbRAkQpC6PxJNxl6dTc7H
         05Md4O+c2L2KCrZFN+p82oYDH5Yyg1wrbyrncR2o82WYPeSaD/Z66qTWgdZuciVmwy+b
         q0GqHAHzxoxGbM2Y74zySBLFANFTmFz/xzH1UMhcveIwKn6qnHuAlinvpyyblJgyRNfF
         zILbqDpgv6cBSi4l+Abh7MN5mah+hFTkbmBsTiizUIQbKl8bdmIIs0DtEHyXUxy/CRjr
         4PHam3BCo4SuPMBN282T91MY0UgXuAWIGNsy4G7chduNpeel8XYqji9y+Bdac0Si7euh
         YwmA==
X-Gm-Message-State: ANhLgQ2RzPT2xx9ozcTx9HD+5t4MiDMSTdu0cjO/XrLZafkLO/3gLk6C
        ULXQgxZtD5fh7K3rV5pFzTwv+xiiu194pSr1Vg==
X-Google-Smtp-Source: ADFU+vt4acEi2rH4gaRHNqkKwa1P0yr+sPIbgUyPKs0Ei5EeGEkmnjhXuMHANnRWBsK11F38ccB5yPzOz9SmGb/O5Vs=
X-Received: by 2002:a02:3093:: with SMTP id q141mr3343332jaq.121.1583242723230;
 Tue, 03 Mar 2020 05:38:43 -0800 (PST)
MIME-Version: 1.0
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com> <1433456b-733c-02dc-d4fd-50e5b2be50bc@nvidia.com>
In-Reply-To: <1433456b-733c-02dc-d4fd-50e5b2be50bc@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 3 Mar 2020 21:38:31 +0800
Message-ID: <CAFgQCTvob1+cTeVA7Gn=6dGRb-YPxChefJQoAKp8k=YE8Q6vaQ@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 7:51 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/28/20 3:32 AM, Pingfan Liu wrote:
> > FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> > can't move. It would truncate CMA permanently and should be excluded.
> >
> > FOLL_LONGTERM has already been checked in the slow path, but not checked in
> > the fast path, which means a possible leak of CMA page to longterm pinned
> > requirement through this crack.
> >
> > Place a check in try_get_compound_head() in the fast path.
> >
> > Some note about the check:
> > Huge page's subpages have the same migrate type due to either
> > allocation from a free_list[] or alloc_contig_range() with param
> > MIGRATE_MOVABLE. So it is enough to check on a single subpage
> > by is_migrate_cma_page(subpage)
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > To: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/gup.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index cd8075e..f0d6804 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -33,9 +33,21 @@ struct follow_page_context {
> >   * Return the compound head page with ref appropriately incremented,
> >   * or NULL if that failed.
> >   */
> > -static inline struct page *try_get_compound_head(struct page *page, int refs)
> > +static inline struct page *try_get_compound_head(struct page *page, int refs,
> > +     unsigned int flags)
>
>
> ohhh...please please look at the latest gup.c in mmotm, and this one in particular:
>
>     commit 0ea2781c3de4 mm/gup: track FOLL_PIN pages
>
> ...where you'll see that there is a concept of "try_get*" vs. "try_grab*"). This is going
> to be a huge mess if we do it as above, from a code structure point of view.
>
> The "grab" functions take gup flags, the "get" functions do not.
>
> Anyway, as I said in reply to the cover letter, I'm really uncomfortable with this
> being applied to linux.git. So maybe if we see a fix to mmotm, it will be clearer how
> to port that back to linux.git (assuming that you need 5.6 fixed--do you though?)
Sure, I will read your series and figure out the way to rebase my
patches on mmotm at first.

Thanks,
Pingfan
