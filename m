Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A61C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AC2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITjU0Iqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgFOHZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgFOHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:25:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D231C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so14803092qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xho6qyVeexXYA3wm+wd4bvhMpPUxi3GFns+ObYF/cv4=;
        b=ITjU0Iqb2xbgvV8fsTzj2XBjV3w/Y5c9TvXyiFr3rgcx0eCK6gauD6dUmDpD+jI0fE
         0yhvcgmaCKMDfwZAX9ndCZcWZeKR6Q187szmkAIMVSpyniilg5pt3yIetv8kDIE/o6/K
         GQkDWS3zsFIDBTpoMoy/eRLu9DXOny3LRRgWaB56r/KzIEI9MFRbgbNlTdWujFH019Rv
         +Ki/BeUpxpmSG1nKlpqiuINQmCUO4Gm5jkPMBJ8PYW2AXZo8EhB+UOYt3BFnQWoSSiBD
         GGCrimL4Dc09BSE/mZQzUIji4YIBR5CQvAUXUzVkMwOpyHCa/+HnVFuGxowtx6bWqKzX
         aASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xho6qyVeexXYA3wm+wd4bvhMpPUxi3GFns+ObYF/cv4=;
        b=cP1keYqpRTD5Rf4iEVeQ2G6Oij52e1ZZuggk6wtQi77pQ6R22EGyvGuwAmuBRKkGtF
         EZiw6WvAAT7QIsxMFxUMAPBSHfIWpZy6v8S1pMIUyaVs4t2qto53CoKrGv5KShuNRB+Z
         LqvKDXPi+Gj8sk+/i4K2fWJl+XiaaFXS2WwCHGQc2tl8iJZiNNVS9bC2YLR/w39sa3v1
         OfiZrC5WnwvLA7TNdqCD3LAQSw8RYUu6TrSAT/IacSnd70vOK+5hk7IkBNwtEJZSxDcd
         j6o7HIL/w35ZnHcHDqoyo+cI89ply3+YX4xgnDgfHpnAGDLu9A4R03vA9+eqIIkG2s7a
         gEog==
X-Gm-Message-State: AOAM530EG/U++95+UM9tIbfIQCKtPbL3i0JHoDnhfOBGQs4fBuRT7bfp
        SsyTwM0W0jBdDU9BXt09L/DE3tEdX7NUAQ9qXCw=
X-Google-Smtp-Source: ABdhPJyQ1DPgJZRSejZYsMilYn66nlMcBpuWoODr2xR0F92SFOCmDp/xGQ8J95NknBu8PiX5WmYpFj4pOSDsyXCI02s=
X-Received: by 2002:a37:624a:: with SMTP id w71mr14325231qkb.452.1592205913355;
 Mon, 15 Jun 2020 00:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-4-songmuchun@bytedance.com> <CAAmzW4N1DRBxsMAX2a_jxUW10vOwW1VsGj8ztuvvWT4NB3Ocnw@mail.gmail.com>
 <CAMZfGtUQ+0w=n9YSQjQc1uwJFJrvtfj=rcTnNYnewCPiHmDLEw@mail.gmail.com>
In-Reply-To: <CAMZfGtUQ+0w=n9YSQjQc1uwJFJrvtfj=rcTnNYnewCPiHmDLEw@mail.gmail.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 15 Jun 2020 16:25:02 +0900
Message-ID: <CAAmzW4N=Rq5qc60DA9-ombrzOxaKEnKUFXM6_DJfq=5bCRdO=g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] mm/slub: Fix release all resources
 used by a slab cache
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

2020=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:41, M=
uchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jun 15, 2020 at 2:23 PM Joonsoo Kim <js1304@gmail.com> wrote:
> >
> > 2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:3=
9, Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > The function of __kmem_cache_shutdown() is that release all resources
> > > used by the slab cache, while currently it stop release resources whe=
n
> > > the preceding node is not empty.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/slub.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index b73505df3de2..4e477ef0f2b9 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -3839,6 +3839,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
> > >   */
> > >  int __kmem_cache_shutdown(struct kmem_cache *s)
> > >  {
> > > +       int ret =3D 0;
> > >         int node;
> > >         struct kmem_cache_node *n;
> > >
> > > @@ -3846,11 +3847,11 @@ int __kmem_cache_shutdown(struct kmem_cache *=
s)
> > >         /* Attempt to free all objects */
> > >         for_each_kmem_cache_node(s, node, n) {
> > >                 free_partial(s, n);
> > > -               if (node_nr_slabs(n))
> > > -                       return 1;
> > > +               if (!ret && node_nr_slabs(n))
> > > +                       ret =3D 1;
> > >         }
> >
> > I don't think that this is an improvement.
> >
> > If the shutdown condition isn't met, we don't need to process further.
> > Just 'return 1' looks okay to me.
> >
> > And, with this change, sysfs_slab_remove() is called even if the
> > shutdown is failed.
> > It's better not to have side effects when failing.
>
> If someone calls __kmem_cache_shutdown, he may want to release
> resources used by the slab cache as much as possible. If we continue,
> we may release more pages. From this point, is it an improvement?

My opinion is not strong but I still think that it's not useful enough
to complicate
the code.

If shutdown is failed, it implies there are some bugs and someone should fi=
x it.
Releasing more resources would mitigate the resource problem but doesn't
change the situation that someone should fix it soon.

Anyway, I don't object more if you don't agree with my opinion. In that cas=
e,
please fix not to call sysfs_slab_remove() when ret is 1.

Thanks.
