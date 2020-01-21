Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A2C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB2D24650
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="T5DUMBdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAUDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:20:51 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37625 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAUDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:20:50 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so1212247iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 19:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDcWE9EWGtVID/iKX16rez9xRzd/8Nb913yHk9dAMYM=;
        b=T5DUMBdxwLNNZ2G6qr8/JwsZn+Orq7oGwZHKldGB2lBt2xpg9AjyfbW2/wzCP9PSdm
         8CgNcUWgZa9614tn+w5aZLOx8tW88UzdZt/hmnm2yp/VClsrsP4l5QJfsoD6TuMd3dVE
         fmzAtzVsPouElzps7mYBPOH0HVkeS+xtAjSn/dpf+iG+W6x45PGkjEw3Hlh+8p2QR/fP
         bY7mC0S/30YPNLxD7TU3rd1Q7DEHzZ2vMbzHTpUOp0LnuxoIcqPaqpj0YWGSEVtJ8sfw
         KEgK6inoc29l49Yf8u+JVxMYKU030evP3NCibeYe+ThDYnvdckvBF2hhyl/nEY+sNUI2
         ms2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDcWE9EWGtVID/iKX16rez9xRzd/8Nb913yHk9dAMYM=;
        b=C3d4Apsm2G4gnz+5LRHyPMD2aIkVC6pgu38+GG145QnG4xRtG8BvXYGsk5k/hmrEDl
         IkW1zhTFyDWRZ6bnXonW7klYcHkTw4t7fNlA5EhinkW+UXXVJSlGialB0pqWE4+9N+CO
         Mv5BhYQGGeTHnLM81b9yQgQSOzwJ9g8LZ7lL6LHGwMC7CCkptwDl4HFqokI3tD429t1A
         x/QklOG2PTvzZv2DCRqIyBJkInnZiIjrfGwlCk0Ps4SRcWEAvN9phdLkYYWRxh91a3F/
         67jc8p9XFwuBb5i2e1QdMPn6JuxDrADkbTJQOhoJadMzQsYDdZ6nGg9KSmsjgEodhl8V
         8zqg==
X-Gm-Message-State: APjAAAWYaKTsxmN/Nwouhla/ZK10qg6OpUD4eyuTsff6DP1hQQwLdzqJ
        uz+jWnDD9aRGk9peQe99OPlu3oibuxSzgRH2/hwMBA==
X-Google-Smtp-Source: APXvYqx9zjbvVKABtdD59999UxaHDFsXuScZSoky+6zJEAyheszYYxPT63r0lZj7p1c8DjDNzhyUxBooXqS0Fhwfkxk=
X-Received: by 2002:a92:db49:: with SMTP id w9mr1812972ilq.277.1579576849943;
 Mon, 20 Jan 2020 19:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20191220001517.105297-1-olof@lixom.net> <ff6dc8997083c5d8968df48cc191e5b9e8797618.camel@perches.com>
 <CAOesGMgxHGBdkdVOoWYpqSF-13iP3itJksCRL8QSiS0diL26dA@mail.gmail.com> <CALzJLG-L+0dgW=5AXAB8eMjAa3jaSHVaDLuDsSBf9ahqM0Ti-A@mail.gmail.com>
In-Reply-To: <CALzJLG-L+0dgW=5AXAB8eMjAa3jaSHVaDLuDsSBf9ahqM0Ti-A@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 20 Jan 2020 19:20:38 -0800
Message-ID: <CAOesGMhXHCz+ahs6whKsS32uECVry9Lk6BQxcvczPXgcoh6b6w@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Fix printk format warning
To:     Saeed Mahameed <saeedm@dev.mellanox.co.il>
Cc:     Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 30, 2019 at 8:35 PM Saeed Mahameed
<saeedm@dev.mellanox.co.il> wrote:
>
> On Sat, Dec 21, 2019 at 1:19 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Thu, Dec 19, 2019 at 6:07 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Thu, 2019-12-19 at 16:15 -0800, Olof Johansson wrote:
> > > > Use "%zu" for size_t. Seen on ARM allmodconfig:
> > > []
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.c b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
> > > []
> > > > @@ -89,7 +89,7 @@ void mlx5_wq_cyc_wqe_dump(struct mlx5_wq_cyc *wq, u16 ix, u8 nstrides)
> > > >       len = nstrides << wq->fbc.log_stride;
> > > >       wqe = mlx5_wq_cyc_get_wqe(wq, ix);
> > > >
> > > > -     pr_info("WQE DUMP: WQ size %d WQ cur size %d, WQE index 0x%x, len: %ld\n",
> > > > +     pr_info("WQE DUMP: WQ size %d WQ cur size %d, WQE index 0x%x, len: %zu\n",
> > > >               mlx5_wq_cyc_get_size(wq), wq->cur_sz, ix, len);
> > > >       print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, wqe, len, false);
> > > >  }
> > >
> > > One might expect these 2 outputs to be at the same KERN_<LEVEL> too.
> > > One is KERN_INFO the other KERN_WARNING
> >
> > Sure, but I'll leave that up to the driver maintainers to decide/fix
> > -- I'm just addressing the type warning here.
>
> Hi Olof, sorry for the delay, and thanks for the patch,
>
> I will apply this to net-next-mlx5 and will submit to net-next myself.
> we will fixup and address the warning level comment by Joe.

This seems to still be pending, and the merge window is soon here. Any
chance we can see it show up in linux-next soon?


Thanks,

-Olof
