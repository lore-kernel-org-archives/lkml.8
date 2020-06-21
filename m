Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76CCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C1520707
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt/yIIKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgFUUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:25:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730288AbgFUUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592771121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/416N7OwlJjOjmFHaXcfpzRSt86NuMHjindDKu4elw=;
        b=bt/yIIKrRkjIH/w+D051eMUO2e54tKJOasQo27efcBVyoUquDDgeZYyeALOgO3rIxdXrZZ
        mZGO84X1K1FkdDMyM85z4hVUt0R9WfyZa+mo1wTJek1fQiUiavgIjt6gBw+m0N2mhCW4bd
        zwlTZrkmyYxcbj8YbFllAaPp+Pf9Hkw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-X2LyB50bPhyjqClfCbKkhg-1; Sun, 21 Jun 2020 16:25:18 -0400
X-MC-Unique: X2LyB50bPhyjqClfCbKkhg-1
Received: by mail-il1-f199.google.com with SMTP id i7so10615479ilq.16
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/416N7OwlJjOjmFHaXcfpzRSt86NuMHjindDKu4elw=;
        b=hjTjRsp0oMfBfE1xyx8WcK0FSFB7MVwCy6h8CC3zmT0Z1IT7LiNcBBauNt2/RGnYRs
         T1+oyQiX+xyEwdTsGPE9Lr3RL1knnKbchvKh839xbJ27BkD1Us/lVYW2EtxJ/090ab3e
         e9tB2INmboHjiBm2jcxMm6W9AoS4ad7gbOtgTKCE1AKJWEOdzyNH06xW6sI58BAnqdMq
         Qg1QUYvc8BGRTt++GBdSFUa/gudvSVYwQiGh+u4Qwhnv3b6UFRzwESY9chS7fda/vDVL
         WDjAW148KNCEdz96KElOihaZOGHLxbiY0PLui3W4t8KM25u+5+uLQhh6maGIGsaHJxLk
         4aRA==
X-Gm-Message-State: AOAM530Hf9yL2Ivph4tXa04DA7JaB+5Gxvkly+VKBVmNJFfy/O8pQslu
        Th6T38Gd6iW9d78VXJZxV2pOvkO58WoajcHICtub5wv8wsxOgmutIc8iUouMyYo//KE6Hzm2447
        n/KU92FtiM/y9VsMnOpBWFNUhoOdB3zbkar0T6blN
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr14997818jaj.120.1592771118168;
        Sun, 21 Jun 2020 13:25:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKXchW2IkCUudcu/hdCr7QHYigi+b86NqbkSX1mig6hhJzcchDc2IFpZUYJFqMRZrlB3nf0blwbHndk1Ho/BM=
X-Received: by 2002:a05:6638:d96:: with SMTP id l22mr14997805jaj.120.1592771117909;
 Sun, 21 Jun 2020 13:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200608210058.37352-1-jarod@redhat.com> <20200610185910.48668-1-jarod@redhat.com>
 <20200610185910.48668-4-jarod@redhat.com> <68f2ff6ee06bf4520485121b15c0d8c10cad60d2.camel@mellanox.com>
In-Reply-To: <68f2ff6ee06bf4520485121b15c0d8c10cad60d2.camel@mellanox.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Sun, 21 Jun 2020 16:25:07 -0400
Message-ID: <CAKfmpSeM4zf_rY_oLJJcE=vqjS43qKE8C+vAQb2NohXe3Zxxew@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] mlx5: become aware of when running as a
 bonding slave
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vfalico@gmail.com" <vfalico@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "andy@greyhouse.net" <andy@greyhouse.net>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
        Boris Pismenny <borisp@mellanox.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 5:51 PM Saeed Mahameed <saeedm@mellanox.com> wrote:
>
> On Wed, 2020-06-10 at 14:59 -0400, Jarod Wilson wrote:
> > I've been unable to get my hands on suitable supported hardware to
> > date,
> > but I believe this ought to be all that is needed to enable the mlx5
> > driver to also work with bonding active-backup crypto offload
> > passthru.
> >
> > CC: Boris Pismenny <borisp@mellanox.com>
> > CC: Saeed Mahameed <saeedm@mellanox.com>
> > CC: Leon Romanovsky <leon@kernel.org>
> > CC: Jay Vosburgh <j.vosburgh@gmail.com>
> > CC: Veaceslav Falico <vfalico@gmail.com>
> > CC: Andy Gospodarek <andy@greyhouse.net>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > CC: Jakub Kicinski <kuba@kernel.org>
> > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: netdev@vger.kernel.org
> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > index 92eb3bad4acd..72ad6664bd73 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > @@ -210,6 +210,9 @@ static inline int
> > mlx5e_xfrm_validate_state(struct xfrm_state *x)
> >       struct net_device *netdev = x->xso.dev;
> >       struct mlx5e_priv *priv;
> >
> > +     if (x->xso.slave_dev)
> > +             netdev = x->xso.slave_dev;
> > +
>
> Do we really need to repeat this per driver ?
> why not just setup xso.real_dev, in xfrm layer once and for all before
> calling device drivers ?
>
> Device drivers will use xso.real_dev blindly.
>
> Will be useful in the future when you add vlan support, etc..

Apologies, I didn't catch your reply until just recently. Yeah, that
sounds like a better approach, if I can work it out cleanly. We just
init xso.real_dev to the same thing as xso.dev, then overwrite it in
the upper layer drivers (bonding, vlan, etc), while device drivers
just always use xso.real_dev, if I'm understanding your suggestion.
I'll see what I can come up with.


-- 
Jarod Wilson
jarod@redhat.com

