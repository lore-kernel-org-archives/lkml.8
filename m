Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25403C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F068020739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="oNj8hWZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgFOGl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOGl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:41:56 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA2C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:41:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so14252335ilq.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bK0Qp6h6dwfemWmyvHsC+Wip59HhIpavOmMER/ZWjbw=;
        b=oNj8hWZtqPfHdMws2rjs6Zk9srH9hbdHfv4lMssnWJONTrkBSWKZ/qkpqhTrc0kG2X
         KpMM55sKx6/MSq9CpAj3L6i1BnwfQnWPAWfbhvkzsIed7u+BuvCZDOA6Rk4o0aIo09rH
         DO/OIb1SuKDxpoLs6tm8UFJ5vMWJCTCTYxys2qj8r/1Zf9s/9fDYAWLCCzsZdsludgj8
         Wy7gr8hb9yBkBgEXVmAEu5FUDPaYeLzCAvguRIPcFpvViOK2gBD28JilN8FFa5EKJ2p8
         VqTnw2KN+SWWaFZrNYDtKofXfUjNfZtMYsN2IMEI7vqPpJPNw133B+5Yez8b3PNDCLhE
         4HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bK0Qp6h6dwfemWmyvHsC+Wip59HhIpavOmMER/ZWjbw=;
        b=bjp1jp81UG2T6SCuDuvKNDUscgrx3qcwzceOgnNBGJjLGrMGEgML5+EooGWupLsZXc
         ZR8fvz0qcltpV5k/Q2vJRVsuAeEmoraqa+tnVRcTfB0cvvcsZTfsEiQgMOZX+GMoK4Me
         VFahEVi9Io2LSEYsCxcGoA3bMdyh0EHRNkr0nx2QODZ8ivdICKFjrcrbKL91gn7cEOwQ
         aCI6mBDzzrRXLvyA7GmfOHM2tgc6rvrmBQfVEeqFjxgj7dJGbMprfnlxQ+cy6ZnXQOdo
         FvydpDUXbA6wvEG+c043zN/L4RcujXKlHS2YMIqXq9Q7n3rNHdDF/EiT01UVrBh6JniS
         +aCA==
X-Gm-Message-State: AOAM532kTf8/o9vx2iIcRJ0yl786pZjfrKQEtBBU9Y3XYqSF5hhhyNlH
        YT6wdQu0aVfoafm9BPp1Xml6U0r7ZqbYnBtaTqmJsQ==
X-Google-Smtp-Source: ABdhPJzlI9S3kYF9RYQ4+SUFFVK1+FFHn0zDGsj9Q8tKs+ZRaYfChlqYUW4i6u1gfiAX/mlgFULixFQDtsob/T5Ip8U=
X-Received: by 2002:a92:d1d0:: with SMTP id u16mr24697660ilg.2.1592203315520;
 Sun, 14 Jun 2020 23:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com>
 <20200614123923.99189-4-songmuchun@bytedance.com> <CAAmzW4N1DRBxsMAX2a_jxUW10vOwW1VsGj8ztuvvWT4NB3Ocnw@mail.gmail.com>
In-Reply-To: <CAAmzW4N1DRBxsMAX2a_jxUW10vOwW1VsGj8ztuvvWT4NB3Ocnw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Jun 2020 14:41:19 +0800
Message-ID: <CAMZfGtUQ+0w=n9YSQjQc1uwJFJrvtfj=rcTnNYnewCPiHmDLEw@mail.gmail.com>
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

On Mon, Jun 15, 2020 at 2:23 PM Joonsoo Kim <js1304@gmail.com> wrote:
>
> 2020=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:39,=
 Muchun Song <songmuchun@bytedance.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > The function of __kmem_cache_shutdown() is that release all resources
> > used by the slab cache, while currently it stop release resources when
> > the preceding node is not empty.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/slub.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b73505df3de2..4e477ef0f2b9 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3839,6 +3839,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
> >   */
> >  int __kmem_cache_shutdown(struct kmem_cache *s)
> >  {
> > +       int ret =3D 0;
> >         int node;
> >         struct kmem_cache_node *n;
> >
> > @@ -3846,11 +3847,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
> >         /* Attempt to free all objects */
> >         for_each_kmem_cache_node(s, node, n) {
> >                 free_partial(s, n);
> > -               if (node_nr_slabs(n))
> > -                       return 1;
> > +               if (!ret && node_nr_slabs(n))
> > +                       ret =3D 1;
> >         }
>
> I don't think that this is an improvement.
>
> If the shutdown condition isn't met, we don't need to process further.
> Just 'return 1' looks okay to me.
>
> And, with this change, sysfs_slab_remove() is called even if the
> shutdown is failed.
> It's better not to have side effects when failing.

If someone calls __kmem_cache_shutdown, he may want to release
resources used by the slab cache as much as possible. If we continue,
we may release more pages. From this point, is it an improvement?

--=20
Yours,
Muchun
