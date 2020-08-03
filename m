Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8578DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905082075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/E7offS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgHCVZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:25:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59923 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbgHCVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596489948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tk3Rs2qegFZypVO27BFx2r1W0ZQxCF8/+L4irxiO1hU=;
        b=R/E7offSZUakpKP8Bffqh/i48RnIpHafaePDEgIWphFhSTxgThy6eWGwtXsgUeMmm54nDI
        sEpBmy8mE5zjOD3MOz7MrJW99OtojBzPb/ZD/Law6tjWQuzYOlYuCJPjNlcP9Z/ldiXPcH
        xEzJGpKARuMah55zayqGS2BlV8NbYak=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-7m6vDhoLPzWY1qLcugopFA-1; Mon, 03 Aug 2020 17:25:46 -0400
X-MC-Unique: 7m6vDhoLPzWY1qLcugopFA-1
Received: by mail-ed1-f69.google.com with SMTP id b23so11208665edj.14
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Tk3Rs2qegFZypVO27BFx2r1W0ZQxCF8/+L4irxiO1hU=;
        b=YeM54ZxwnnB+rIv/M3zh3oRkc3KKSuOQKeE2fVotigvJMUG+XBptiC6Jq9NyOQm7mD
         Dnlk3/9hAx/QeHUyOSc9z3j2PLgITV3PWVGo3qY1fNLaHHEtiZzqrWgbTWPzOAOB9oyz
         BoKO4lBMbpGVPU5uWsZkx6lhDVdiidz2O3LxSSDSXKnpunJb8mHw3NtVBZL2f2NZ51VR
         uKxJ6gKLpXJ3Q58kZ4SaMPZ2Ms71xad2xyPR0Z5BFig4ApfIJKcx3EuPVJ2PBhp9I+KQ
         DbYwJZyaPVfOZccBzoKdUw9xoY77AmCqVDwK6O7lvsUNShiL6bw1xvIdJpwTqiXKyWvp
         HG+g==
X-Gm-Message-State: AOAM530sZovFwg/GydQmuy1m6viLRVWLFz1htgdeao8wJntVLbJt5hKZ
        GlOGiQA0e1wV9ZOoCrqCssEIQXZvI3frsuyfw4TQdUG7KlIbl6/XzywhVTTOTqHOMKAYD8WCehS
        S1Z35ipLLO9At0o3UGuVYyi2N
X-Received: by 2002:a05:6402:1c88:: with SMTP id cy8mr17907694edb.24.1596489945577;
        Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIzMUK8S+nJcTcQT4uN8ACgajCm5UUzF876hPGAe/y0hA1rXHhbvCvLJ2m4UbiIBnQqAQZqA==
X-Received: by 2002:a05:6402:1c88:: with SMTP id cy8mr17907686edb.24.1596489945433;
        Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
        by smtp.gmail.com with ESMTPSA id i5sm3342356edt.52.2020.08.03.14.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 14:25:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 01/24] virtio_balloon: fix sparse warning
Date:   Mon, 3 Aug 2020 23:25:44 +0200
Message-Id: <D9D808BB-4A2F-459D-8E2C-CC0C6E0D5C99@redhat.com>
References: <20200803205814.540410-2-mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <20200803205814.540410-2-mst@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.08.2020 um 22:58 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFballoon uses virtio32_to_cpu instead of cpu_to_virtio32
> to convert a native endian number to virtio.
> No practical difference but makes sparse warn.
> Fix it up.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I think I acked this one already.

Acked-by: David Hildenbrand <david@redhat.com>

> ---
> drivers/virtio/virtio_balloon.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ballo=
on.c
> index 54fd989f9353..8bc1704ffdf3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -600,7 +600,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb=
)
>    while (virtqueue_get_buf(vq, &unused))
>        ;
>=20
> -    vb->cmd_id_active =3D virtio32_to_cpu(vb->vdev,
> +    vb->cmd_id_active =3D cpu_to_virtio32(vb->vdev,
>                    virtio_balloon_cmd_id_received(vb));
>    sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
>    err =3D virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL=
);
> --=20
> MST
>=20

