Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C3AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2420738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="tQQvJJca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgFOG04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:26:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A89DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:26:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so16603234ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GKLgxaoSXCOixJadKXn8MWDjPBoGgNrgTm/UHSFd+FA=;
        b=tQQvJJcaVe+YFHkEgjLnaCG6qp5L2y7hRJx0JTHc+lzyyV52w8H529HLihDYAd24mR
         MP6xQc9SDAghYK3UOI1qz97KhEonx9E8TaOLEDRQnsxQmBmkRdgGfVmf5B3qyWKTXDPq
         exUwDZuQOWPpM895dVQfRR/NJ+r/QLTgfHDSgqvXUbpAHTTowe4LokIVAcG/duMBhunm
         r418YMngEJDRXaAUC45ASWF5ggEyUYhOjTITXnTLcTJhsYZmrzKiYiKhzn7arKaGlVDM
         YiE5EVA0bb50qNteD03ZMS6B2UgeHWDUyNyIeo8eftDy/W+2NHH+F+k/438FT2SM5EWf
         EjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GKLgxaoSXCOixJadKXn8MWDjPBoGgNrgTm/UHSFd+FA=;
        b=NLvnfhm9kd76XrVYwHpoByHrhREdva5ZJaD6SFLSh7q470lQINjpQqqYyyKUNuwiax
         NhrnrCGTkoIE3lmTo8HHktIoTI7BtWnP9n3gf1PdqPws0iTSVK3pxh04v1B29TrfpUC9
         xvN0ppFs4mpViAa7Wb/WQFKSgLpLS//tZTzAYwb4yduX96oXwAYHbWFLA+iRuWqhF2Jg
         SOF54gyuKNaJ3fiktjrNwqnm4utUU8RnqsOxNkHm8xNd7MdB6ZejGL5oA4JYvUmKLIDM
         q5StWp12HClpL0jBhPCDel18T6EUzVAshbXRn5oA9qEBKHz8DqdkwHw8Y74cqrzn4jsx
         XTlA==
X-Gm-Message-State: AOAM530W0pr2MAln+6oGMCVzjGbhSXWGign6ijP6gSZEpPBVu9yPqxAy
        Dm4ibwsYFzl4PAQ0bP8LjwRz4/DDhXet2jl91OsJyg==
X-Google-Smtp-Source: ABdhPJzIdiIvMl/cqPtTln0PWfC36OxZYbOPZXKH4EbsNWSwOZWNZCiGYns0bdXTR+mLAdZSb0Qvxrwaa5Hh6p03JnI=
X-Received: by 2002:a05:6602:2584:: with SMTP id p4mr26788694ioo.30.1592202414537;
 Sun, 14 Jun 2020 23:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-2-songmuchun@bytedance.com> <CAAmzW4Opfu7_r3UdjTKYui15u2kdwp9Y2-aje30iZ_LsQ0tHwA@mail.gmail.com>
In-Reply-To: <CAAmzW4Opfu7_r3UdjTKYui15u2kdwp9Y2-aje30iZ_LsQ0tHwA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Jun 2020 14:26:16 +0800
Message-ID: <CAMZfGtUvGEzrXTUBnrGnFzxU_L2D5_YPV_n_a2VLiPN9MeJLwA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] mm/slub: Fix slabs_node return value
 when CONFIG_SLUB_DEBUG disabled
To:     Joonsoo Kim <js1304@gmail.com>
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

On Mon, Jun 15, 2020 at 2:11 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:39,=
 Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
> > But some codes determine whether slab is empty by checking the return
> > value of slabs_node(). As you know, the result is not correct. This
> > problem can be reproduce by the follow code(and boot system with the
> > cmdline of "slub_nomerge"):
> >
> >   void *objs[32];
> >   struct kmem_cache *cache =3D kmem_cache_create("kmem-test", 128, 0,
> >                         0, 0);
> >
> >   if (cache) {
> >         int i;
> >
> >         /* Make a full slab */
> >         for (i =3D 0; i < ARRAY_SIZE(objs); i++)
> >                 objs[i] =3D kmem_cache_alloc(cache, GFP_KERNEL_ACCOUNT)=
;
> >
> >         /*
> >          * This really should fail because the slab cache still has
> >          * objects. But we did destroy the @cache because of zero
> >          * returned by slabs_node().
> >          */
> >         kmem_cache_destroy(cache);
> >   }
> >
> > To fix it, we can move the nr_slabs of kmem_cache_node out of the
> > CONFIG_SLUB_DEBUG. So we can get the corrent value returned by the
> > slabs_node().
> >
> > With this patch applied, we will get a warning message and stack
> > trace in the dmesg.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/slab.h |  2 +-
> >  mm/slub.c | 80 +++++++++++++++++++++++++++++++++----------------------=
--------
> >  2 files changed, 43 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 0b91f2a7b033..062d4542b7e2 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -619,8 +619,8 @@ struct kmem_cache_node {
> >  #ifdef CONFIG_SLUB
> >         unsigned long nr_partial;
> >         struct list_head partial;
> > -#ifdef CONFIG_SLUB_DEBUG
> >         atomic_long_t nr_slabs;
> > +#ifdef CONFIG_SLUB_DEBUG
> >         atomic_long_t total_objects;
> >         struct list_head full;
> >  #endif
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 49b5cb7da318..1a3e6a5b7287 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
>
> Hello,
>
> You also need to initialize nr_slabs in init_kmem_cache_node()
> on !CONFIG_SLUB_DEBUG.

Good catch, thanks! I will fix it in the next version.

>
> Otherwise, looks good to me.
>
> Thanks.



--=20
Yours,
Muchun
