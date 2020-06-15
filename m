Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FC3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CC8206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="T/af5lYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgFOHvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgFOHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:50:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:50:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p20so16735545iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rst6EJ64kU6WWCXs2TxPcGzwZ7aK4wuG8DOHEM83sBQ=;
        b=T/af5lYCXK01UJwFupPnNH1kgwBEwNXYCFeXOSRoYvtP4Ks0xRfBvxrhJQtCfgus3u
         YmaSFUUkfJliKMaf/bpGANLh/TamWzfuGNgxKp0AqpoIMH17ePWI4ocRfp9e62IrqAyb
         3/HCIXM/fjc6Bi42KzRYb9AVoggk/PPzp4zDXh6vsy/M1SnL1F+0QXs60X28naC2p4sU
         n2BEh7Vatnb02z9J5koI/ECFpWHZHM2+0pkta0uuZ2dgYNgbDdjfsH97Uq3No3b2lj1t
         5h8h7QRwfonGqeyOS8/r3i83vx+kHrUhdX8fifmi8r1x57/wQqBQkTioG/stuH8ue87G
         Y6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rst6EJ64kU6WWCXs2TxPcGzwZ7aK4wuG8DOHEM83sBQ=;
        b=f2i4H2xLv3j4SpSvbl5Pti+z/WiOwhb4oG45sn9BX+vVr7D6FjP+ijRbxc6B41jMG+
         PTtqbSiig5f6ewel5GIs7OW+cTFkHEi5kPlLakNBLtSDAy7GVP/rQy0frx0H7Y0mYMa/
         aCtFAekjCnwdnE5syif+uMXrIyB5MLt66jbZ/T//E3aYh9+kd4aedibyZOgHrNhgenut
         JcRDMoJNrJztMBFMcWl7/N2MW9BX0roXtaY4hHjpEZAdHLJ0fup7NadnvUmyWmZ4ONZg
         9u/geWtsLJYCJTi/sN6vkbbhhHG8B01ylHjUdhdTHRebjBRM8l5Z5lN5AnGKTI/ng22T
         VJKw==
X-Gm-Message-State: AOAM531U0i73Squq7M2Y/0s5X/JppsxYOO/MosTaZiC0iyYmlFo//fWf
        MZwS5Bsz3YZAnkVREM4VvbcOKHW1JCaSVrICwWZGCQ==
X-Google-Smtp-Source: ABdhPJzI5BYPzBe4OBGTcgTWBbMKV9OFMgaY9GUo1gVRr78tJ5tz8uA7MBds+fzzZsB/O5LoOkAKdk8yvnXTTBgwyuA=
X-Received: by 2002:a02:cccd:: with SMTP id k13mr20666457jaq.53.1592207452602;
 Mon, 15 Jun 2020 00:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-4-songmuchun@bytedance.com> <CAAmzW4N1DRBxsMAX2a_jxUW10vOwW1VsGj8ztuvvWT4NB3Ocnw@mail.gmail.com>
 <CAMZfGtUQ+0w=n9YSQjQc1uwJFJrvtfj=rcTnNYnewCPiHmDLEw@mail.gmail.com> <CAAmzW4N=Rq5qc60DA9-ombrzOxaKEnKUFXM6_DJfq=5bCRdO=g@mail.gmail.com>
In-Reply-To: <CAAmzW4N=Rq5qc60DA9-ombrzOxaKEnKUFXM6_DJfq=5bCRdO=g@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Jun 2020 15:50:16 +0800
Message-ID: <CAMZfGtVBtRK=rA2CGGnOuTvHyXffVm7vE7m37MAMSbW8fkzjfg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] mm/slub: Fix release all resources
 used by a slab cache
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

On Mon, Jun 15, 2020 at 3:25 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 6=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 3:41,=
 Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > On Mon, Jun 15, 2020 at 2:23 PM Joonsoo Kim <js1304@gmail.com> wrote:
> > >
> > > 2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9=
:39, Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > >
> > > > The function of __kmem_cache_shutdown() is that release all resourc=
es
> > > > used by the slab cache, while currently it stop release resources w=
hen
> > > > the preceding node is not empty.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/slub.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index b73505df3de2..4e477ef0f2b9 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -3839,6 +3839,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
> > > >   */
> > > >  int __kmem_cache_shutdown(struct kmem_cache *s)
> > > >  {
> > > > +       int ret =3D 0;
> > > >         int node;
> > > >         struct kmem_cache_node *n;
> > > >
> > > > @@ -3846,11 +3847,11 @@ int __kmem_cache_shutdown(struct kmem_cache=
 *s)
> > > >         /* Attempt to free all objects */
> > > >         for_each_kmem_cache_node(s, node, n) {
> > > >                 free_partial(s, n);
> > > > -               if (node_nr_slabs(n))
> > > > -                       return 1;
> > > > +               if (!ret && node_nr_slabs(n))
> > > > +                       ret =3D 1;
> > > >         }
> > >
> > > I don't think that this is an improvement.
> > >
> > > If the shutdown condition isn't met, we don't need to process further=
.
> > > Just 'return 1' looks okay to me.
> > >
> > > And, with this change, sysfs_slab_remove() is called even if the
> > > shutdown is failed.
> > > It's better not to have side effects when failing.
> >
> > If someone calls __kmem_cache_shutdown, he may want to release
> > resources used by the slab cache as much as possible. If we continue,
> > we may release more pages. From this point, is it an improvement?
>
> My opinion is not strong but I still think that it's not useful enough
> to complicate
> the code.
>
> If shutdown is failed, it implies there are some bugs and someone should =
fix it.

Yeah, I agree with you.

> Releasing more resources would mitigate the resource problem but doesn't
> change the situation that someone should fix it soon.
>
> Anyway, I don't object more if you don't agree with my opinion. In that c=
ase,
> please fix not to call sysfs_slab_remove() when ret is 1.
>

Yeah, we should call sysfs_slab_remove only when ret is zero. Thanks very
much.

--=20
Yours,
Muchun
