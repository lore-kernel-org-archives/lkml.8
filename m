Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E01420853
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm96wzx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgFHTB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgFHTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:01:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC2C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:01:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a9so18332002ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FucO5MLasbHMeieVZwCp4so/qb2dT28pU+uSLCZS5M=;
        b=Bm96wzx0eHCz9RVuq8YNY58shtaHHnB0Q2i9bRONPfy8EScS//y6ohWKHkIHW1evs6
         qW3VIGSO2fGXHsCHMHBzCM80juJ/J881xgkO8F4JtSprjriAw5t+MlLILZazFAkfaqGk
         Knt2BOl49N22NIhY+7vKxYJ4GljKzQbml8k7WmtwiQLhwrwlE3qoDBsU5br0UArdqdiR
         Ct/oF6vYlm8MRDgiXJ9G3QvVM+ankc6052/xviSY1stfz+eG9N01ckbDKtG+sBElCMNZ
         vRksYctqar0jOmETl3d0vc/39iseMz60xrjFgzmA86tJxT17cAnsLpV6JORtB+qWK38l
         dvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FucO5MLasbHMeieVZwCp4so/qb2dT28pU+uSLCZS5M=;
        b=oUTXz9CBOtqMGdTuWcp2JNT6YQ4hgjtOhryb392giFnPJDfSBd6usNhx3RT23Aiz3i
         Pq1n9MKr8luPgKwMgzkev8siH8my6iHsg6QtMjU2UBW0ZBIKR64NcN4cchX39gKqhL0+
         f+iFv+duOUe1ayhvBYX3OHf1ZWLPYbJarRW28ZVuJOCiue4lmAlS+8O2RcAPeGvzFQVz
         o6V+QtmQZxrlNk8ukdpKFpfBrw1DRv8e32dMHif8N4TLFONUWMlOcuKVPtMhM0zMrH/L
         YphaaOutjhgTHiLG6r4L1mOlws7HSvlJFHaqTgv8UqYTQKIH0WJziIzhWwJBb01ELozY
         D8Yw==
X-Gm-Message-State: AOAM532JbhUkBULb02U8rwUUfu53e3oeeVJTOnBrU/ABDwVBB99RUedZ
        ey8xSS1RyymGPYLUdId4OQHuKGfuGb77nUL7PEI=
X-Google-Smtp-Source: ABdhPJw7CT7C9gP/zfojSads0VPQlRMkA55J0SyhS9SBc/vqgzoDP/Y0/OEuWgFVVqr4DuBR/kNmBGxB/DyDxjRTUok=
X-Received: by 2002:a2e:83c7:: with SMTP id s7mr12178294ljh.68.1591642914410;
 Mon, 08 Jun 2020 12:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com> <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
In-Reply-To: <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 9 Jun 2020 00:31:42 +0530
Message-ID: <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() --> pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jane.pnx9@gmail.com,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        harshjain32@gmail.com, festevam@gmail.com, jeremy@azazel.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 7:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-31 10:51, Souptick Joarder wrote:
> > In 2019, we introduced pin_user_pages*() and now we are converting
> > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > be referred for more information.
> >
> > When pin_user_pages() returns numbers of partially mapped pages,
> > those pages were not unpinned as part of error handling. Fixed
> > it as part of this patch.
> >
>
> Hi Souptick,
>
> btw, Bharath (+cc) attempted to do the "put" side of this, last year.
> That got as far as a v4 patch [1], and then I asked him to let me put
> it into my tree. But then it didn't directly apply anymore after the
> whole design moved to pin+unpin, and so here we are now.
>
>
> If Bharath is still doing kernel work, you might offer him a Co-Developed-by:
> tag (see https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html).

Sure, will add him as *Co-Developed-by*
>
> Anyway, I'd recommend splitting the bug fix(es) into it at least one
> separate patch. That's a "best practice", and I don't see any reason
> not to do it here, even though the bugs are not huge.
>
> Also I think there may be more than one bug to fix, because I just
> noticed that the pre-existing code is doing set_page_dirty(), when
> it should be doing set_page_dirty_lock(). See below.
>
>
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >          https://lwn.net/Articles/807108/
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> > Hi,
> >
> > I'm compile tested this, but unable to run-time test, so any testing
> > help is much appriciated.
> >
> >   drivers/staging/kpc2000/kpc_dma/fileops.c | 15 ++++++++-------
> >   1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > index 8975346..29bab13 100644
> > --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> > +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > @@ -48,6 +48,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >       u64 card_addr;
> >       u64 dma_addr;
> >       u64 user_ctl;
> > +     int nr_pages = 0;
>
> Probably best to correct the "rv" type as well: it should be an int, rather
> than a long.

Noted.

>
> >
> >       ldev = priv->ldev;
> >
> > @@ -76,13 +77,15 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >
> >       // Lock the user buffer pages in memory, and hold on to the page pointers (for the sglist)
> >       mmap_read_lock(current->mm);      /*  get memory map semaphore */
> > -     rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
> > +     rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
> >       mmap_read_unlock(current->mm);        /*  release the semaphore */
> >       if (rv != acd->page_count) {
> > -             dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
> > +             dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%ld)\n", rv);
> > +             nr_pages = rv;
> >               goto err_get_user_pages;
> >       }
> >
> > +     nr_pages = acd->page_count;
> >       // Allocate and setup the sg_table (scatterlist entries)
> >       rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE - 1), iov_len, GFP_KERNEL);
> >       if (rv) {
> > @@ -189,10 +192,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >       sg_free_table(&acd->sgt);
> >    err_dma_map_sg:
> >    err_alloc_sg_table:
>
> So now we end up with two unnecessary labels. Probably best to delete two of these
> three and name the remaining one appropriately:

Hmm, I thought about it. But later decided to wait for review comments
on the same in v1.
I will remove it now.

>
>   err_dma_map_sg:
>   err_alloc_sg_table:
>   err_get_user_pages:
>
> > -     for (i = 0 ; i < acd->page_count ; i++)
> > -             put_page(acd->user_pages[i]);
> > -
> >    err_get_user_pages:
> > +     if (nr_pages > 0)
> > +             unpin_user_pages(acd->user_pages, nr_pages);
> >       kfree(acd->user_pages);
> >    err_alloc_userpages:
> >       kfree(acd);
> > @@ -217,8 +219,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
> >
>
> There is code up here (not shown in this diff), that does a set_page_dirty().
> First of all, that should be set_page_dirty_lock(), and second, maybe (or maybe not)
> it can all be done after the dma_unmap_sg(), at the same time as the unpin, via
> unpin_user_pages_dirty_lock(). In fact, it's misleading at best to leave those
> pages mapped, because there is an interval in there after set_page_dirty() and
> before put_page(), in which the device could be running and setting pages dirty.
> (Remember that writeback attempts can be happening concurrently with all of this,
> and writeback is deeply involved with page dirtiness.)
>
> I remember Bharath wrestled with this in an earlier conversion attempt (back when
> we were only converting the "put_page" side of things), let me see if I can dig up
> that email thread for some guidance...OK, in [1] it appears that everyone
> finally settled on keeping the PageReserved check, but OK to move everything below
> the dma_unmap_sg() call.
>
> [1] https://lore.kernel.org/r/20190720173214.GA4250@bharath12345-Inspiron-5559

Well, I need to rework on this based on the above feedback and
suggestions. Will post the
new series.

>
>
> >       dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> >
> > -     for (i = 0 ; i < acd->page_count ; i++)
> > -             put_page(acd->user_pages[i]);
> > +     unpin_user_pages(acd->user_pages, acd->page_count);
> >
> >       sg_free_table(&acd->sgt);
> >
> >
>
> thanks,
> --
> John Hubbard
> NVIDIA
