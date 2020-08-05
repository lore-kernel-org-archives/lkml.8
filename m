Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B46C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8F722CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTFMp8Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgHEUGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgHEQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:35:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21128C008686;
        Wed,  5 Aug 2020 07:25:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so8421945pgn.13;
        Wed, 05 Aug 2020 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AC9ky2C3Ij8fAbqbNhEO64rPYUTHmvfPvc5f+fIvzK8=;
        b=FTFMp8DnK1Q4yCvVpBK237B45BNVaxqLnYbQeyXwNQKF3T0ZVU+frSVo2esy4lqhLh
         UePeEM1VFfFpKnHfqUwbxpdTEgtDQShJwz55PkiFECm7qsuRTvY6kYyy9S47l4ATuIST
         dua2Rmvkia9HCFr72HBFOWjaa0TWmFVmzg7hq2BZynnJVB8GEhIzk7/gG4Vhy4/L0i8L
         2azsYhrCvRtU5v6COB/6TuounJ6wQoB0k2vQbZr2TB2bwcPsfsOLTOVXglXguUvlCY2W
         d5r80JAsoCHdPTRcH3pi7HNGXontHgVz8GQsJGEZFOk6QpEXe/9i9TR89eHn4CQABQJE
         QRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AC9ky2C3Ij8fAbqbNhEO64rPYUTHmvfPvc5f+fIvzK8=;
        b=suwqqfbNEyFVR0HtOzzQ/5qz8hGlUjd3YjO/AbcpdghzZzhxqIjNv+Hdew114er+vc
         1mkgw7zvGwoxkFUibxFn0LPEZVZRVf0CeeNh64LOzfPiF0HsahAl46yA8YeDppSCaobG
         td6vXsedUN1p6D7YIi9LFEo7PFBbf5Kyqr7X+FFvHlDEIyG2cNmy9MZbIMwYuiU7hwTH
         HStBSVkx2U4/aHkyo/zAN6CqOIf3LEuNmhGEyqX02gYFk/bCPsRQV5ZpfGqQ6GoI+qyc
         54NP3XBAEWkyF5q/vjj0hUKNsie14iNW8ky7BoiD+EHYqFd+tgNR4HCL98WwIAyB0ulE
         qdqA==
X-Gm-Message-State: AOAM5329X9MnIcmmnGW1Dbut81pLxMfDSh1sqnzwWSlRZX535ka9RJ5X
        1bcliss3NdIV/iygIn8dqRgE0/wGGDKRzKLM61ELMzK9o9c=
X-Google-Smtp-Source: ABdhPJy3Zwn4T8BNUfOUv+eXKmotLpzwuZ7FaC/MF6rO2BR8iLdAlMXguhBtGU6wXRb1rk93OIPQquvJFGErG8XjcBo=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr3503195pfc.130.1596637508595;
 Wed, 05 Aug 2020 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200805134226.1106164-1-mst@redhat.com> <20200805134226.1106164-19-mst@redhat.com>
In-Reply-To: <20200805134226.1106164-19-mst@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Aug 2020 17:24:53 +0300
Message-ID: <CAHp75Vfyjxegi8EtNqVZLVUDzR_0WOJQVmJFoJi4DFxDgNRG-g@mail.gmail.com>
Subject: Re: [PATCH v3 18/38] mlxbf-tmfifo: sparse tags for config access
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> mlxbf-tmfifo accesses config space using native types -
> which works for it since the legacy virtio native types.
>
> This will break if it ever needs to support modern virtio,
> so with new tags previously introduced for virtio net config,
> sparse now warns for this in drivers.
>
> Since this is a legacy only device, fix it up using
> virtio_legacy_is_little_endian for now.
>
> No functional changes.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 5739a9669b29..bbc4e71a16ff 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -625,7 +625,10 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
>                         vdev_id = VIRTIO_ID_NET;
>                         hdr_len = sizeof(struct virtio_net_hdr);
>                         config = &fifo->vdev[vdev_id]->config.net;
> -                       if (ntohs(hdr.len) > config->mtu +
> +                       /* A legacy-only interface for now. */
> +                       if (ntohs(hdr.len) >
> +                           __virtio16_to_cpu(virtio_legacy_is_little_endian(),
> +                                             config->mtu) +
>                             MLXBF_TMFIFO_NET_L2_OVERHEAD)
>                                 return;
>                 } else {
> @@ -1231,8 +1234,12 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
>
>         /* Create the network vdev. */
>         memset(&net_config, 0, sizeof(net_config));
> -       net_config.mtu = ETH_DATA_LEN;
> -       net_config.status = VIRTIO_NET_S_LINK_UP;
> +
> +       /* A legacy-only interface for now. */
> +       net_config.mtu = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
> +                                          ETH_DATA_LEN);
> +       net_config.status = __cpu_to_virtio16(virtio_legacy_is_little_endian(),
> +                                             VIRTIO_NET_S_LINK_UP);
>         mlxbf_tmfifo_get_cfg_mac(net_config.mac);
>         rc = mlxbf_tmfifo_create_vdev(dev, fifo, VIRTIO_ID_NET,
>                                       MLXBF_TMFIFO_NET_FEATURES, &net_config,
> --
> MST
>


-- 
With Best Regards,
Andy Shevchenko
