Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA79C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003CE20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuLq/owq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgFOGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgFOGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:23:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB364C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:23:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g28so14754114qkl.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1aMWbf91EME1dQ55dwYmEZLJPJcrTDI7r5Xx36ru2E=;
        b=tuLq/owqSmSJaSBZ4l9Dt2wlgk2I4yQ5LI0bpu+aIXLb4ixIBhf/e44oRIk/ewJ48U
         yjPeb9jvqzG/fhWVKf5PaPKJxQ6zq3+tG2DUJCt+R78jDOIzz86TjP2gILlp7YemfrKP
         eKdf72e1cP9V3bRS4ZkVtKhI1ql2y3WQAa0NTSNRVi2DpVje9SP45YOxf47jbMN7yCiC
         Gxbj2APayCxKpGtlXV1myMKNR0ZESC1rcTVklf3hfriaWgDSvQ7qqw/J7b2EkFdhoAv/
         IOoS1rO248NufXvgqRwPhCcikLut9p+j2SUkWPVC43C3C+O83/e2P6IVnXf67xqemAUw
         dczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1aMWbf91EME1dQ55dwYmEZLJPJcrTDI7r5Xx36ru2E=;
        b=Oau01sv5U386kzTkSzbSKjKqwSBwmwSNIIaXXjTFG5YDxg3irAcST1TC3khj6DXWXT
         A9DryHe0nrZFp0xCmDzMYm7nAim5PsWaIEVS3eODktDjLRbnf5UN31Hz5h41s8iPDnEp
         b99XOVA++9PSd9NVfEUkOMSVDvGjKMRjt+NQfFcyF2Dsg3CI48ftYtGU3O8R/DasHImL
         pcXEaVg25x8kt3+racPJYJTGni1EOdF+1EpRkVzSdrKoSjmGYdTtg8zEpnXIp/6oxU1/
         QKp3NO4rP5UQu/7CXwASFhw71BgXKLz/Mwm/BVVlj7lYmK9GGjCnO9Vo03TJOBv2uQnz
         Kqsg==
X-Gm-Message-State: AOAM530Zxfsy2BJ90Wo62AGP3Mp/d2RgrEoqx8UXM2NPPAfx3VYBJU1c
        r3K0Ser1Ikcg1eBnyKCIA3NO6k4c6SvGdib//cM=
X-Google-Smtp-Source: ABdhPJzaUTyyK3ALiZGwOJyQcjCWf2aYpXazWhwu6aXNXN9yW/ORW1jLgP1ZVK7q5pBHbO8iixryxUhSXUSMbYGRN8Y=
X-Received: by 2002:a37:624a:: with SMTP id w71mr14168388qkb.452.1592202191135;
 Sun, 14 Jun 2020 23:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com> <20200614123923.99189-4-songmuchun@bytedance.com>
In-Reply-To: <20200614123923.99189-4-songmuchun@bytedance.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 15 Jun 2020 15:23:00 +0900
Message-ID: <CAAmzW4N1DRBxsMAX2a_jxUW10vOwW1VsGj8ztuvvWT4NB3Ocnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/slub: Fix release all resources used by a slab cache
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:39, M=
uchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The function of __kmem_cache_shutdown() is that release all resources
> used by the slab cache, while currently it stop release resources when
> the preceding node is not empty.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index b73505df3de2..4e477ef0f2b9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3839,6 +3839,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
>   */
>  int __kmem_cache_shutdown(struct kmem_cache *s)
>  {
> +       int ret =3D 0;
>         int node;
>         struct kmem_cache_node *n;
>
> @@ -3846,11 +3847,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>         /* Attempt to free all objects */
>         for_each_kmem_cache_node(s, node, n) {
>                 free_partial(s, n);
> -               if (node_nr_slabs(n))
> -                       return 1;
> +               if (!ret && node_nr_slabs(n))
> +                       ret =3D 1;
>         }

I don't think that this is an improvement.

If the shutdown condition isn't met, we don't need to process further.
Just 'return 1' looks okay to me.

And, with this change, sysfs_slab_remove() is called even if the
shutdown is failed.
It's better not to have side effects when failing.

Thanks.
