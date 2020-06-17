Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7814DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CE520884
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9SMlyM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFQTVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFQTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:21:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4493C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:21:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so4250888ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6zPV8zobDf9HXBdYcU6mVid6vbxVvMja1AcfqC3AhY=;
        b=f9SMlyM/U0Pqzn1ZfwPovFVY6pZbMaVNMoLSufan6Hon09QmB+eZa9nTGXfGxBQyIe
         PQULWwLtmklVkIMpg9pFaEPTNvi2LC9IcxyTkpI/nBKVXWG3U0wSSuyj8AbbZMKiq4EL
         OwS61L9Q6Exu+JDkyDU+jwWBB4UHVz/IkhsdeBAJdL60GDpDSexutvvHvx7VHaAPNwb0
         FnlqEr9i019s7c+rJ7WxAlpIIYFqrnAFs8U6vfs8J2tYfCZFlRTNQg6JB5oYjGsmP5Iz
         rqP5WAiuJJNGDIoK/swk2D9TyycjNZRhwlFDD2mZ41qIct+Dy4I6wr1vYDthC2JvIh/L
         vNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6zPV8zobDf9HXBdYcU6mVid6vbxVvMja1AcfqC3AhY=;
        b=rVqXJLNEFoWsH+RpLPMrIL9YCeaHcQgm+C5kjvQyTqAAg+L2ej2jIt14MzWXF0tEOE
         jC035ZnxZP5coqE4i5AsySV6u9E13qoMaWJ5B+g38KMe5iX8EU3GiUvELEVRse+qNFBz
         JGQBYU3Vk0v/qhi0W1lny9rvmpB7RZShpfBbm2e8W4WTsG0vVgMMpgQaD39A1d5rADLi
         x5X4q2qNnhWOCMtZZZSGCm1v6PBZggIe1cqnPTfKsczseSWABMwSlrhbBZg3cqpRYmFm
         05IROMXnOPOS5sBcMVuvGfJ5WY7E80ltugiISnRnjxvC9RtCm2U2ao0Dcye5sTCa36YF
         286A==
X-Gm-Message-State: AOAM531QRwqiP5LBdQjkE5CSYRwUH23czORXvHuR21yqDWBhwiHrhwb/
        TILqRrta9MEFt3JZ6cI3avQMjKQpmq8zdIYff+8=
X-Google-Smtp-Source: ABdhPJy/zgi6evi5V74dtl6A1Gnb2qzWqwv0aC2J/qtn2wVcoQui5pDVfUgL66fQBPwxEv0f/1kKdEbuFTWgUKo0FhA=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr333356ljc.315.1592421701149;
 Wed, 17 Jun 2020 12:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
 <1592360843-3440-2-git-send-email-jrdr.linux@gmail.com> <20200617111321.GP4282@kadam>
 <CAFqt6zYHXmoCrWLEru2FZsRnXptFERJv1qiDFPip=q_cZaZEBg@mail.gmail.com> <20200617175918.GO4151@kadam>
In-Reply-To: <20200617175918.GO4151@kadam>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 18 Jun 2020 00:59:57 +0530
Message-ID: <CAFqt6za2Npg147p=47_PKjGehKKP=s5dgtu1O=nrrPePxjXPkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] staging: kpc2000: Unpin partial pinned pages
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        harshjain32@gmail.com, John Hubbard <jhubbard@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>, pakki001@umn.edu,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        ldufour@linux.ibm.com, Michel Lespinasse <walken@google.com>,
        jane.pnx9@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:29 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Jun 17, 2020 at 11:13:32PM +0530, Souptick Joarder wrote:
> > On Wed, Jun 17, 2020 at 4:43 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Wed, Jun 17, 2020 at 07:57:20AM +0530, Souptick Joarder wrote:
> > > > There is a bug, when get_user_pages() failed but partially pinned
> > > > pages are not unpinned. Fixed it.
> > > >
> > > > Also, int is more appropriate type for rv. Changed it.
> > > >
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: Bharath Vedartham <linux.bhar@gmail.com>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > > > index 8975346..b136353 100644
> > > > --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> > > > +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > > > @@ -35,7 +35,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> > > >                           unsigned long iov_base, size_t iov_len)
> > > >  {
> > > >       unsigned int i = 0;
> > > > -     long rv = 0;
> > > > +     int rv = 0;
> > > >       struct kpc_dma_device *ldev;
> > > >       struct aio_cb_data *acd;
> > > >       DECLARE_COMPLETION_ONSTACK(done);
> > > > @@ -193,6 +193,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> > > >               put_page(acd->user_pages[i]);
> > >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > >
> > > >   err_get_user_pages:
> > > > +     if (rv > 0) {
> > > > +             for (i = 0; i < rv; i++)
> > > > +                     put_pages(acd->user_pages[i])
> > >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > > +     }
> > >
> > > This isn't a complete fix.  "rv" is the negative error code but here we
> > > are returning a positive value on this path.
> >
> > In case of error of get_user_pages(), it will return -errno, 0 and 3rd one is
> > (rv > 0 && rv != acd->page_count). When rv is -errno or 0 there is no need
> > to call put_pages() in error path. But for 3rd case partially mapped pages
> > need to unpin.
> >
> > Correct me if I am missing anything.
> >
>
>    182                  kfree(acd);
>    183          }
>    184          return rv;
>    185
>    186   err_descr_too_many:
>    187          unlock_engine(ldev);
>    188          dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
>    189          sg_free_table(&acd->sgt);
>    190   err_dma_map_sg:
>    191   err_alloc_sg_table:
>    192          for (i = 0 ; i < acd->page_count ; i++)
>    193                  put_page(acd->user_pages[i]);
>    194
>    195   err_get_user_pages:
>    196          if (rv > 0) {
>                     ^^^^^^
> "rv" is positive.
>
>    197                  for (i = 0; i < rv; i++)
>    198                          put_pages(acd->user_pages[i])
>    199          }
>    200          kfree(acd->user_pages);
>    201   err_alloc_userpages:
>    202          kfree(acd);
>    203          dev_dbg(&priv->ldev->pldev->dev, "%s returning with error %ld\n", __func__, rv);
>    204          return rv;
>                        ^^
> "rv" is still positive but it should be -EFAULT.
>

Ahh,  my mistake. Will correct it in v2.
Do other patches in the series looks good ?
