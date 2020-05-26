Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57467C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DD720776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7zciMlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgEZK3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbgEZK3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:29:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82DC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:29:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so23788258lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C17FM7zfHQ0g98Gec6oNVi7D+Q2Y1g6U9re2DPGSx3A=;
        b=n7zciMlS+Shx8E1gyRxUwYdyLy9yDiMH6342nQRAW0saRLV/8rnaupFSs0Lg8PnVtT
         e4yfRTfbT23/AiYuipQhzvt2jWzBUplDWivYuDKVfzgLFyywT8ygHaHJ1xyIRgE/uDvf
         DHNaF4PlkSNMnGSRcOofYWyhKZl3GaG+4QQH2o1lDi5CrpwVHq9yGbser3BA9lNKZnQt
         ATbwExoRp8TnVsag9j0eAVDW8KHLVN3fy+kuMO8XqrZlZUT83FSt2/OAUj3/RnJQMBFb
         RXjZGfyGO+PpW4OfraEeZ5Ue6HkH/eM3964Lj1l8knMLedS94K/+CGlWtE0TwPKJ2zQE
         CZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C17FM7zfHQ0g98Gec6oNVi7D+Q2Y1g6U9re2DPGSx3A=;
        b=KrG8wD/4PkF3U0qKinoplBW1qHH1hgqqphm5jV5pHYtG7WFSdeF0IbGR9xlDjFwC8W
         gctOTo6S/2rvig/pgYH60OC0SkDcHWV7n6zMTie+nVPX7aP5M5wtTfBWtyzybPyJTKA7
         +qVNTzjVDqBOlzynXCGbRMlaCd3+zD6u7WTB1faGHyL7BH/xRuYQ/Nqs2vnN2pcJdycw
         ho0GzYqH1BZiTH7e8ZZYLbmqcWzePvU6aZVqb2qt5cjBbf1joTdSdVgdbHniSIHXscny
         B9K6Vw4Kdju5szdOFFqRL6O7gKcELCs+Cv06/ygfMYPsgugnfe+q12WHlChcqJl500d+
         rWcQ==
X-Gm-Message-State: AOAM532VjmVsPSEpaAmYgBtb4wZxd1T1bxyMNdHbpdAB9Pu0eShgCe7J
        NJC3ADSVmjDf9/4Tbk3Og7S6+szzSohRSr3pKqA=
X-Google-Smtp-Source: ABdhPJzB8WZp+opke9KXwEhpl7yy8WsS+MMNRScSuw8OaKmfYc2e7dRbUp0Xo5ZMGMORZIcqz4TVIMcfSF/6Z9YTdlM=
X-Received: by 2002:a2e:8191:: with SMTP id e17mr308580ljg.68.1590488990512;
 Tue, 26 May 2020 03:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200526081338.179532-1-vkuznets@redhat.com> <16496017-14a9-146a-c257-35f9d3c2d3cb@nvidia.com>
In-Reply-To: <16496017-14a9-146a-c257-35f9d3c2d3cb@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 26 May 2020 15:59:37 +0530
Message-ID: <CAFqt6zaPtpGkDcproUU4Jw0qHzS+Lmd_uCBG52sHuePEjFJJSw@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: correct pin_user_pages.rst location
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 1:49 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-26 01:13, Vitaly Kuznetsov wrote:
> > pin_user_pages.rst lives in Documentation/core-api/, not Documentation/vm/,
> > adjust all links accordingly.
> >
> > Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> > Fixes: eddb1c228f79 ("mm/gup: introduce pin_user_pages*() and FOLL_PIN")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >   include/linux/mm.h |  4 ++--
> >   mm/gup.c           | 18 +++++++++---------
> >   2 files changed, 11 insertions(+), 11 deletions(-)
>
> Hi Vitaly,
>
> Thanks for the fix,
>
>      Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>
> (+CC Souptick, who fixed a similar set of links, maybe in a different
> file, as I recall.)

Changes related to mm/gup.c are merged in linux-next which means we
need to take care
of only *mm.h* part. rebase on top of linux-next should work fine. With that,

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> NVIDIA
>
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5a323422d783..1f2850465f59 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1219,7 +1219,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
> >    * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
> >    * scheme).
> >    *
> > - * For more information, please see Documentation/vm/pin_user_pages.rst.
> > + * For more information, please see Documentation/core-api/pin_user_pages.rst.
> >    *
> >    * @page:   pointer to page to be queried.
> >    * @Return: True, if it is likely that the page has been "dma-pinned".
> > @@ -2834,7 +2834,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> >    * releasing pages: get_user_pages*() pages must be released via put_page(),
> >    * while pin_user_pages*() pages must be released via unpin_user_page().
> >    *
> > - * Please see Documentation/vm/pin_user_pages.rst for more information.
> > + * Please see Documentation/core-api/pin_user_pages.rst for more information.
> >    */
> >
> >   static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 87a6a59fe667..87a3a4b400f9 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2845,10 +2845,10 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
> >    * the arguments here are identical.
> >    *
> >    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> > - * see Documentation/vm/pin_user_pages.rst for further details.
> > + * see Documentation/core-api/pin_user_pages.rst for further details.
> >    *
> > - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> > + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> > + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
> >    */
> >   int pin_user_pages_fast(unsigned long start, int nr_pages,
> >                       unsigned int gup_flags, struct page **pages)
> > @@ -2885,10 +2885,10 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
> >    * the arguments here are identical.
> >    *
> >    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> > - * see Documentation/vm/pin_user_pages.rst for details.
> > + * see Documentation/core-api/pin_user_pages.rst for details.
> >    *
> > - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> > + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> > + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
> >    */
> >   long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> >                          unsigned long start, unsigned long nr_pages,
> > @@ -2921,10 +2921,10 @@ EXPORT_SYMBOL(pin_user_pages_remote);
> >    * FOLL_PIN is set.
> >    *
> >    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> > - * see Documentation/vm/pin_user_pages.rst for details.
> > + * see Documentation/core-api/pin_user_pages.rst for details.
> >    *
> > - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> > + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> > + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
> >    */
> >   long pin_user_pages(unsigned long start, unsigned long nr_pages,
> >                   unsigned int gup_flags, struct page **pages,
> >
>
