Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F3CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13882071A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAVqvjvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFQRfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFQRfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:35:19 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4433C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:35:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so1839992lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBfyqghJKD3m/c732ySG1Fw+Y6n0LHho3bg3oKuG+xA=;
        b=CAVqvjvRMog+bjNFWR098Fzm3DpZRbmqyHxJ5L7Q9ThFxc4uMWGwQIb74eiwPMr4eW
         ZW77MraUmYqH/IHn5s5MLRyPW4AOPoanjpRelbxLccqc5Cbvte58gbQyb7wMOit9b/ey
         ILxgp8+WeLqDlT68gan2QUtBtbWsWAByGfmH7Z2oH8cp0+6asEGvUfXeiZY/0/i7cPS7
         d+4l50hzL62DBTIapKl8c1HISeXQgdFhMRjjtRbEeHHaPyzowLlIw/tRjLIjN2iqjjlP
         R5cX6caph7PVwf0vG5qFl5G5G55uLb5Q0yKXN4IBFQm1H2ZnOEEBXpZokNUeASSzZ7rB
         sTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBfyqghJKD3m/c732ySG1Fw+Y6n0LHho3bg3oKuG+xA=;
        b=NPdLNqD1DlgZJ85vI9a8zSCw+RUvN5UlyJrh4cWmhrxBlr7w7Z1jRroWX/VUEf6+tK
         CHywOgaEhoKmCcy/hcfLKXxawNshZ24A3VObrV/ylDzY6nu0EEfWfGHTrxMeYv6DdjOG
         /WqUtvIEBAanzM+HnC10gfDM1oTGEY6zKQWtJOIhDJmIbNTGCgg8DQf5Aao0Pl562c0n
         ZszA/Vm8b0nwFJw2+A2D9zP++INi+3oAnV5PXYbSCNRAqw+4sAjGdPXXgULHo5h7vK+1
         FlYhECFavFQy7OwquEcBpVguXw7ZpYY2O7mafXeIegZ7sqVFPj+xwT1h9ilUJ8NUWkTX
         ejUA==
X-Gm-Message-State: AOAM530aR8npT8oF+zQmpNKAk+RjxqyM+z88gMv4XLd3UZTtuXXeX5JT
        9SnMAR4+p6AxIPAuNs2Ggy9dVB3aHeQiPJThsac=
X-Google-Smtp-Source: ABdhPJzZ1YAM0FpboUkZO9r5P/pnDaVpgtgboON71+GoUO0FE7ZPVzWbfvU2Oz+ggufdhItv0bp5P8NNQjX3UUSGT0g=
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr39884lfe.38.1592415317231;
 Wed, 17 Jun 2020 10:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
 <1592360843-3440-2-git-send-email-jrdr.linux@gmail.com> <20200617111321.GP4282@kadam>
In-Reply-To: <20200617111321.GP4282@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 17 Jun 2020 23:13:32 +0530
Message-ID: <CAFqt6zYHXmoCrWLEru2FZsRnXptFERJv1qiDFPip=q_cZaZEBg@mail.gmail.com>
Subject: Re: [PATCH 1/4] staging: kpc2000: Unpin partial pinned pages
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jane.pnx9@gmail.com,
        pakki001@umn.edu, ldufour@linux.ibm.com, harshjain32@gmail.com,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Michel Lespinasse <walken@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 4:43 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 17, 2020 at 07:57:20AM +0530, Souptick Joarder wrote:
> > There is a bug, when get_user_pages() failed but partially pinned
> > pages are not unpinned. Fixed it.
> >
> > Also, int is more appropriate type for rv. Changed it.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Bharath Vedartham <linux.bhar@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > index 8975346..b136353 100644
> > --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> > +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > @@ -35,7 +35,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >                           unsigned long iov_base, size_t iov_len)
> >  {
> >       unsigned int i = 0;
> > -     long rv = 0;
> > +     int rv = 0;
> >       struct kpc_dma_device *ldev;
> >       struct aio_cb_data *acd;
> >       DECLARE_COMPLETION_ONSTACK(done);
> > @@ -193,6 +193,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >               put_page(acd->user_pages[i]);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >   err_get_user_pages:
> > +     if (rv > 0) {
> > +             for (i = 0; i < rv; i++)
> > +                     put_pages(acd->user_pages[i])
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > +     }
>
> This isn't a complete fix.  "rv" is the negative error code but here we
> are returning a positive value on this path.

In case of error of get_user_pages(), it will return -errno, 0 and 3rd one is
(rv > 0 && rv != acd->page_count). When rv is -errno or 0 there is no need
to call put_pages() in error path. But for 3rd case partially mapped pages
need to unpin.

Correct me if I am missing anything.

>Also it's ugly to have
> same put_page() loop repeated twice.

Yes, I agree, but these are intermediate steps. Patch [4/4] of this series
finally did the same.

>
> It would be better to write it like this:
>
>         rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
>         mmap_read_unlock(current->mm);        /*  release the semaphore */
>         if (rv < 0)
>                 goto free_pages;
>         if (rv != acd->page_count) {
>                 acd->page_count = rv;
>                 rv = -EFAULT;
>                 goto put_pages;
>         }
>
>         ...
>
> put_pages:
>         for (i = 0 ; i < acd->page_count ; i++)
>                 put_pages(acd->user_pages[i]);
> free_pages:
>         kfree(acd->user_pages);
>
> regards,
> dan carpenter
>
