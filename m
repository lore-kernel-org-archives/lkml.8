Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7147D208A7
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6b0nQig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgEaGnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 02:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgEaGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:43:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F769C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:43:00 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 202so2085988lfe.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqGZTy1VqOexcid65oEqQ0+wrF0QdU2KCXSQUQInTJc=;
        b=Y6b0nQigzK2NweGGGk31Ubu51PGKGcmPfj3MeMagnsT016n5zsTOxGVagrxYlsUF5E
         A+XYAvsnVi7Wyaw5rDfSqav6CC2hwwlcqRwqKBDN5GOThuHzQ1sFo6Q7irbczLv4A4bU
         X44+e3Yuv432OI500QGSpq9iHKJknbEnRfCZruzfT85ij9QxnDtJXLk/W1XQ2nHAJyWT
         ImUR51WrKDg0v9KuhGieicUM+r/5tEc7bUbI+646ziZGEwAhBBdc06d9L27AoeA9IxhX
         Vj+mpYi+sr7M/KNQ/LibV9dw/sqeukVii/1bRGWmPQwXNe5xxTnlX1itO2G/BLWPZONb
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqGZTy1VqOexcid65oEqQ0+wrF0QdU2KCXSQUQInTJc=;
        b=G7St1pzIyAfwxNKp08z2RWju7uv/zIYGYO5Se+qv2txBxPKRrGgdhcs5eDEMxC9/w/
         OlvL8joLso3QkrUgNvrzVSwucrrmSFye4pT6tnZzPi2Hyb/upiGXuuWC4rvyDzxyWhyp
         MrS+jyBR5EkADyX2q7FZ4V6t5lVSxoAMPlrVCCuE/c9JoQa99p0NxisNvbakBlotHJKQ
         MybarnxowIoI0uGegFpiS60W36OG4Emw0curPoot1VYEz41jZQujnBZrOjj1AhvjVUTH
         daawXvO3RXwWAwSK1rTXHEz/ffB1tv9H+nB+Eusu4GOdjC32wdnOVwO0NwyfAlVMLxG0
         +SWw==
X-Gm-Message-State: AOAM532R206u67PbJCmpbIXzd/hIFGttwc3qoJmn1UhTBFrd5SbRvH15
        3l8fmBXEGag9ttgY6bcW+LymkHZgNzNgigSAbXl89DCF
X-Google-Smtp-Source: ABdhPJwvjnc1PCInE8i4TlX+kufQSoXGXtRTv3a5hDdmx8ySRDNuW08+ZajG7rq7Oqy101E/ckI70VCYf7Vjii2f5rE=
X-Received: by 2002:ac2:53a2:: with SMTP id j2mr8170978lfh.139.1590907377726;
 Sat, 30 May 2020 23:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200529084515.46259-1-jhubbard@nvidia.com> <37811e3c-cf0c-eb52-0365-7980a9c0f334@redhat.com>
In-Reply-To: <37811e3c-cf0c-eb52-0365-7980a9c0f334@redhat.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 31 May 2020 12:21:05 +0530
Message-ID: <CAFqt6za3N3gyDvEdoQb5d6_p-Ri_DGM=+eVv+wfQMadNn7g5tQ@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: documentation fix for pin_user_pages*() APIs
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 2:41 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.05.20 10:45, John Hubbard wrote:
> > All of the pin_user_pages*() API calls will cause pages to be
> > dma-pinned. As such, they are all suitable for either DMA, RDMA,
> > and/or Direct IO. The documentation should say so, but it was
> > instead saying that three of the API calls were only suitable for
> > Direct IO. This was discovered when a reviewer wondered why an
> > API call that specifically recommended against Case 2 (DMA/RDMA)
> > was being used in a DMA situation [1].
> >
> > Fix this by simply deleting those claims. The gup.c comments already
> > refer to the more extensive Documentation/core-api/pin_user_pages.rst,
> > which does have the correct guidance. So let's just write it once,
> > there.
> >
> > [1] https://lore.kernel.org/r/20200529074658.GM30374@kadam
> >
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >
> > Hi,
> >
> > This applies on top of linux-next, in order to avoid a conflict with
> > Mauro Carvalho Chehab's fix to the lines right above these.
> >
> > thanks,
> > John Hubbard
> > NVIDIA
> >
> >
> >  mm/gup.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index ee039d421746d..311d0f11b35e6 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2875,9 +2875,6 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
> >   *
> >   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> >   * see Documentation/core-api/pin_user_pages.rst for further details.
> > - *
> > - * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> >   */
> >  int pin_user_pages_fast(unsigned long start, int nr_pages,
> >                       unsigned int gup_flags, struct page **pages)
> > @@ -2951,9 +2948,6 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
> >   *
> >   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> >   * see Documentation/core-api/pin_user_pages.rst for details.
> > - *
> > - * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> >   */
> >  long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
> >                          unsigned long start, unsigned long nr_pages,
> > @@ -2987,9 +2981,6 @@ EXPORT_SYMBOL(pin_user_pages_remote);
> >   *
> >   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> >   * see Documentation/core-api/pin_user_pages.rst for details.
> > - *
> > - * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst. It
> > - * is NOT intended for Case 2 (RDMA: long-term pins).
> >   */
> >  long pin_user_pages(unsigned long start, unsigned long nr_pages,
> >                   unsigned int gup_flags, struct page **pages,
> >
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by : Souptick Joarder <jrdr.linux@gmail.com>

>
> --
> Thanks,
>
> David / dhildenb
>
