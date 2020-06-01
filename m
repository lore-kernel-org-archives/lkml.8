Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7B920772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="ldYjGDwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgFALOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFALOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:14:06 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3978CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 04:14:05 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z12so3189765uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXOAaMoBz4R8U5dwNZ1YfVLsYcbZLZ+dVXxKsEXRwXY=;
        b=ldYjGDwxIV0HzE2xVPpuBE0NOAVS/wx8H146GJymaAusL8tM4TbALmC5vckRW1Mz2h
         iYHXRI042v6RPOvV2TxuBXm7yKSuQ7eAGi19pRqoDsXPm3eaQdEDp4agW/pkDWzJvswX
         lHKPP/PrvdEZKioAgAXdN3Cj9R582GOgxZERyU0rXTDPVUz+dF01KRgtgKNI01FFXGls
         E+Qd4105igPjLgGxPH/nSEIxB87EZD8JPlhCjxUjxqOxlAp/6OMwg9lcHLUtH6ThPs3f
         BQyv/5nbSVdTe2MuD3wqDiKM6D164XduVY61OUE0kRFs1W0aTXn5NNNVEWXzqkBI1Y7y
         8nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXOAaMoBz4R8U5dwNZ1YfVLsYcbZLZ+dVXxKsEXRwXY=;
        b=PsFAYUrqYiIggTiNWlNRx9Ylb33g1L+lBAplzz45OAaEVMA2iBaMdboHELQm02UJzV
         1MxDf1PsE4oVmLSZYSEc3+XdP4vnU7s3xhphOvpF+6eB7Eitxzf+yKnXyUsnno0a19Q0
         GXRPO0mCA6olSlinjJWvG4iyg7gYdEK973JkVtUCU0wW391WO66MqnMp7ndvff22MOqF
         /HMeI4PhMMT4Tehpdl6nswtGbw7D1Y36IE7VhdKBiO66BxLprskjoe/LzAnP6VgszYYP
         LiD1xO4xp1qiH1FQm/jw7h0CHKPAnSO0BxSe2VJouU0VvAl369Tq0EYlKTPVfkALp0pZ
         lTqQ==
X-Gm-Message-State: AOAM5333smWekGIEsgYD8QLG/pVCs7Can5XqEo13W/mdauOx1elB+fMN
        FPU3WAFPFHn4RvQU+HIvgnq+UJHr08BYyZ+jmFGYDg==
X-Google-Smtp-Source: ABdhPJz8Ar6V60hnAAObpp+yduGb260FWlbMjEdQ4KdG8I/hXKgn7dO8wizKMxc1REqOfKGvnrW5O/i0ftzKsyinRv0=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr9356732uan.19.1591010044429;
 Mon, 01 Jun 2020 04:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200523035909.418683-1-jhubbard@nvidia.com> <89244e74-f619-e515-083a-3bf2586fa5c3@nvidia.com>
In-Reply-To: <89244e74-f619-e515-083a-3bf2586fa5c3@nvidia.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 1 Jun 2020 07:13:53 -0400
Message-ID: <CAOg9mSQYvPcjCOoTj5_zq-62pxe_XCnqxiaiNLefx10M-MSYuw@mail.gmail.com>
Subject: Re: [PATCH v2] orangefs: convert get_user_pages() --> pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

Thanks for the patch, and the testing, and the reference to the
lwn article.

I have also applied your patch to 5.7-rc7 and have run xfstests.

I applied your patch to the orangefs for-next tree.

-Mike

On Sat, May 30, 2020 at 3:39 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-22 20:59, John Hubbard wrote:
> > This code was using get_user_pages*(), in a "Case 1" scenario
> > (Direct IO), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages*() + put_page() calls to
> > pin_user_pages*() + unpin_user_pages() calls.
> >
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >      https://lwn.net/Articles/807108/
> >
> > Cc: Mike Marshall <hubcap@omnibond.com>
> > Cc: Martin Brandenburg <martin@omnibond.com>
> > Cc: devel@lists.orangefs.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >
> > Hi,
> >
> > Note that I have only compile-tested this patch, although that does
> > also include cross-compiling for a few other arches.
>
> An update on the run-time testing: Just now, I got basic orangefs tests
> running in xfstests, with this patch applied, and it all looks normal.
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > Changes since v1 [3]: correct the commit description, so that
> > it refers to "Case 1" instead of "Case 2".
> >
> >
> > [3] https://lore.kernel.org/r/20200518060139.2828423-1-jhubbard@nvidia.com
> >
> > thanks,
> > John Hubbard
> > NVIDIA
> >
> >   fs/orangefs/orangefs-bufmap.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
> > index 2bb916d68576..538e839590ef 100644
> > --- a/fs/orangefs/orangefs-bufmap.c
> > +++ b/fs/orangefs/orangefs-bufmap.c
> > @@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
> >   static void
> >   orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
> >   {
> > -     int i;
> > -
> > -     for (i = 0; i < bufmap->page_count; i++)
> > -             put_page(bufmap->page_array[i]);
> > +     unpin_user_pages(bufmap->page_array, bufmap->page_count);
> >   }
> >
> >   static void
> > @@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
> >       int offset = 0, ret, i;
> >
> >       /* map the pages */
> > -     ret = get_user_pages_fast((unsigned long)user_desc->ptr,
> > +     ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
> >                            bufmap->page_count, FOLL_WRITE, bufmap->page_array);
> >
> >       if (ret < 0)
> > @@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
> >
> >               for (i = 0; i < ret; i++) {
> >                       SetPageError(bufmap->page_array[i]);
> > -                     put_page(bufmap->page_array[i]);
> > +                     unpin_user_page(bufmap->page_array[i]);
> >               }
> >               return -ENOMEM;
> >       }
> >
>
