Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009B4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC246205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="HIjkSvyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgCPI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:29:40 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41100 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:29:40 -0400
Received: by mail-il1-f194.google.com with SMTP id l14so15600159ilj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1D+wjdugV/y1Q47KeInW9Mmw89G28fLR6ZadfHbc4M=;
        b=HIjkSvyPZLtEb4iXzde6Ix5XffFFmkPurFn/U121bbPBtbujoYwwn4eyosbz0L9vvk
         5jaxYV4K1MXcFkDkwegYyeOVLng8UQLMFqV8s0+SLBE6GXm69rMH45c0hfYZJDkLdz6N
         U56WIchE25+rnvwdbQlbWwKx5lG/FcsoB/igM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1D+wjdugV/y1Q47KeInW9Mmw89G28fLR6ZadfHbc4M=;
        b=RCU2VkGELl66qUY0QexulGJVnjICdu+GbY5rBd1ccSZBtSpQnlsx+0czV9chfCi51F
         9txkvzvkNxPgnSpmbhbzhvNvJSTFFPRuz7KRbkGq9hi+uNjt3Y9ZiwaDjtQEpv7HZzlZ
         DhudYQHMRA/efXLObSAOBpndwLluMxxILW2NTXi7ZF+yDP6DFaC3B0Wr9nI0WrTD/4vE
         Q+L36Jt28oq6bhXdn1RVbmII7l+WfORsxBNeE0OeQb/pjow2Nh4jSzgXRKz1GNNBKH2o
         hB3s8m4gFE5j5FZHBsQ0zAyLlaxeg/7V+4yi3MvKVX2sGNJjD3YQtmBWv5LRu/h8Sg2E
         RkUA==
X-Gm-Message-State: ANhLgQ0GvRrpCSjxwWlJ8QQIOwrcn6PKHj7vFhQcpZdMAduYBGNmhYm6
        Ag0mvgM5KJvXRo6Tn/ko7kXdRsfsI8sZ/DU92F/GjHBqkWQ=
X-Google-Smtp-Source: ADFU+vtXE09BAcrOPyPClQLsFRUKhnHpYABL8mSQVJ+/t4ODqTRTGRWqNtE5SlHR1U6K8RTSnjU15paCnMYtrzwVCTQ=
X-Received: by 2002:a05:6e02:4c6:: with SMTP id f6mr5178826ils.272.1584347378918;
 Mon, 16 Mar 2020 01:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com> <20200315094604.62dc96be@archlinux>
 <CAJCx=gkZEDa5vg1R2gta9vERy2+W4vst0et0THO9Oth3d3Yzfg@mail.gmail.com>
In-Reply-To: <CAJCx=gkZEDa5vg1R2gta9vERy2+W4vst0et0THO9Oth3d3Yzfg@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 16 Mar 2020 01:29:28 -0700
Message-ID: <CAJCx=g=7_S5=JJ1K8JCLd06hTbhqTHupUJ1tYX6uiAP+1WtjsQ@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: remove mlock usage
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 1:21 AM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> On Sun, Mar 15, 2020 at 2:46 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Tue, 10 Mar 2020 00:01:28 +0530
> > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >
> > > Use local lock instead of indio_dev's mlock.
> > > The mlock was being used to protect local driver state thus using the
> > > local lock is a better option here.
> > >
> > > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> >
> > Matt.  Definitely need your input on this.
> >
> > > ---
> > >  drivers/iio/health/max30100.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > > index 84010501762d..8ddc4649547d 100644
> > > --- a/drivers/iio/health/max30100.c
> > > +++ b/drivers/iio/health/max30100.c
> > > @@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> > >                * Temperature reading can only be acquired while engine
> > >                * is running
> > >                */
> > > -             mutex_lock(&indio_dev->mlock);
> > > +             mutex_lock(&data->lock);
> >
> > Hmm.. It's another complex one.  What is actually being protected here is
> > the buffer state, but not to take it exclusively like claim_direct does.
> >
> > Here we need the inverse, we want to ensure we are 'not' in the direct
> > mode because this hardware requires the buffer to be running to read the
> > temperature.
> >
> > That is the sort of interface that is going to get userspace very
> > confused.
> >
> > Matt, normally what I'd suggest here is that the temperature read should:
> >
> > 1) Claim direct mode, if it fails then do the dance you have here
> > (with more comments to explain why you are taking an internal lock)
> > 2) Start up capture as if we were in buffered mode
> > 3) Grab that temp
> > 4) stop capture to return to non buffered mode.
> > 5) Release direct mode.
> >
> > I guess we decided it wasn't worth the hassle.
> >
> > So Rohit.  This one probably needs a comment rather than any change.
> > We 'could' add a 'hold_buffered_mode' function that takes the mlock,
> > verifies we are in buffered mode and continues to hold the lock
> > until the 'release_buffered_mode'.  However, I'm not sure any other
> > drivers do this particular dance, so clear commenting in the driver
> > might be enough.   Should we ever change how mlock is used in the
> > core, we'd have to fix this driver up as well.
> >
> > Hmm.  This is really hammering home that perhaps all the remaining
> > mlock cases are 'hard'.
>
> Heh really had to look this over what I was doing since it has been
> almost half a decade now :).
>
> Think locking that mutex was only to prevent another read during the
> temp reading, and not really
> not sure how effective that is actually. Especially since the I2C
> subsystem should handle those reads
> in a queue like fashion.
>
> - Matt
>

So to be clear I think we can just remove the lock period since the
odds of this actually being requested (or disabled) at the
exact time so very remote. Along with the worse case being a failed read.

- Matt

> >
> > Thanks,
> >
> > Jonathan
> >
> > >
> > >               if (!iio_buffer_enabled(indio_dev))
> > >                       ret = -EAGAIN;
> > > @@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> > >
> > >               }
> > >
> > > -             mutex_unlock(&indio_dev->mlock);
> > > +             mutex_unlock(&data->lock);
> > >               break;
> > >       case IIO_CHAN_INFO_SCALE:
> > >               *val = 1;  /* 0.0625 */
> >
