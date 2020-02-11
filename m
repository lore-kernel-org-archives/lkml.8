Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B35C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC12220842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="q10Zmw35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgBKVof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:44:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42521 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgBKVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:44:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so13336752ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCK0sjqQ6cf0msl3lwipyWtRkRUXU+cty6zPWQtzLQE=;
        b=q10Zmw35nWzQ+Ks+WJkGDdW8XCtpT85M4eQqywc2ctI6T4G5zUSfHVSVfDXoeczmZ6
         KqDhcFVNDXgUGxxf685OTB2vgSgSt3s1BDrP4zBza1y29niy1aVn3bTS1wyTDfCztCna
         tRIJ8taz2VeW7Yvqb7M4iOlKVs+yTH4Zv+lRZ3wVeMnpt8whWRc8S8gdBYKrsFkGl2kM
         2yau7YRTJU+uhvYM6njqf3WJVZcnsuUpUGq23OMn5RF3Ix91D9KciE0tY/m4U0P0vo6C
         +YvPT6pQyjD2h7SDl2jwxFvAzKUnFvMGv9+yBU+9dfVyy/VpXxREhblkFFGOebNdMJWw
         muHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCK0sjqQ6cf0msl3lwipyWtRkRUXU+cty6zPWQtzLQE=;
        b=U0ElzwvgEf4h4jQuYpHVXkhYlBhRGa6TWKQRSr9UP0Mdg3pxFCgDuZifMl+bOsQm9E
         M/pUgiR7mWoyWuw6BHWMcEfWyl5HP+GRL1TBoX5xvh1SAcGgCUJuMv+D9QhZ0wdwiikA
         Bi5TO/OvVlFtZhwlVt7iAZmHPTN3gAhUkMjjZUFccZuCi/g2W9yLN5bOBcxOgz60K04v
         5/o5jelvUwnqoRwPJ4J00vU5ul8IzTaSmY6kBFoy94RIBwUzZt3S6zSPLk36qf+o+qJ2
         qidrcsCAZjPHxfkS1p+cJPTI+zKva63bNo7jByftkUBsqqlHKaH/Cd6pD8cH5WX9BD8y
         zUzg==
X-Gm-Message-State: APjAAAUCo7WoPliBtLIeR3xcBMv5z08F5mBj3kvFeW5DDZHMdGtlBD5c
        yEYUzHD/00wYMbmdkoI3HPpfbSdU5FrHktiS74WekQ==
X-Google-Smtp-Source: APXvYqzbGwK9xhWlDNmDqBmMndHvGHadA0WVrHPIzqAN+tt/TmeaBdatK4HRV1EWwnNItMxWoK9IsSUjpN3Y4AgupfM=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr5429721ljk.139.1581457472754;
 Tue, 11 Feb 2020 13:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20200126175104.17948-1-christophe.jaillet@wanadoo.fr> <f9b066c7-e59a-9106-da57-a7c0ffc36d9b@mellanox.com>
In-Reply-To: <f9b066c7-e59a-9106-da57-a7c0ffc36d9b@mellanox.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Tue, 11 Feb 2020 13:44:21 -0800
Message-ID: <CALzJLG_Nyub5YJpP+b=7B128QHOir-vyDs_yrsSoHEPHTfP1bw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Remove a useless 'drain_workqueue()' call in 'mlx5e_ipsec_cleanup()'
To:     Boris Pismenny <borisp@mellanox.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:08 AM Boris Pismenny <borisp@mellanox.com> wrote:
>
>
> On 1/26/2020 7:51 PM, Christophe JAILLET wrote:
> > 'destroy_workqueue()' already calls 'drain_workqueue()', there is no need
> > to call it explicitly.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > index cf58c9637904..29626c6c9c25 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > @@ -433,7 +433,6 @@ void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv)
> >       if (!ipsec)
> >               return;
> >
> > -     drain_workqueue(ipsec->wq);
> >       destroy_workqueue(ipsec->wq);
> >
> >       ida_destroy(&ipsec->halloc);
> LGTM

applied to net-next-mlx5
Thanks!
