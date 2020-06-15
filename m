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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E4620707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exFIMX22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgFOGLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFOGLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:11:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D0C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:11:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g18so11713371qtu.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EifQ9y2nKmcogMn7yhF1AlOyb5UE+7aa7f+MJo/iQBc=;
        b=exFIMX22quM2FDLvFwfvlgv4ssHRZtyRwnNYjsvzmSwTrgfZCGYABIuZqUiApY/zDn
         swGPk1p915aq6f6Rmw1SwRX/Tz0c7kOcYaATVQrxM1dBM4d5J4S/c6rTc3i2QA9Ms/gW
         VT4lpKDH1vUPTdD3Q/IQu0I+CQJDy/ECzJRfGt7JMbRB1biFYY5Hp5Rh3qFnwpQhlRi5
         95XnCnFvv1IIZD1/MZcD19M2NJNwClNdtzmyWj7gWusRF4ZwYh6hUeLKjaDiafbNfnZ6
         KAOi1nJPjB4SDhDVnbQs8FE7v3ZAKywjQDH9R+yzDu3M+L1KI77stD7fSei2hzkyiDsj
         G1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EifQ9y2nKmcogMn7yhF1AlOyb5UE+7aa7f+MJo/iQBc=;
        b=rO07IGLLxk+rR6yzg1VQpU+8m71iQ7cO3UBoN3Xq7aWdqLRlPosAijyv5aGy68+BFr
         jFMmTo5LDDO+Ho/2Q+NadCw4H4Owii9xQmZ2/pvE8xMKPfDHCU0W1orleaAbBYRhH2Sc
         ssTG4oiwHwsqFHkkx7/WLtIoKYevt5kOreDkb4HGe1pwuXe7V00UNss2JEGCIgYr0U5c
         tnRgPue/akWldMfBSdvHSNfrxRGGnkaxh5dyVU+YOSXoPDb9tw0zHxUe5tROTTnrNORZ
         AtN2H7Vw5ziWlcQx60CqPHYvSUS3TmDXY71Qi4nePD9bx9aQ1vald7n2EjsA1IZ7JmWF
         ZAUA==
X-Gm-Message-State: AOAM531TI85gGcLMuUXRnR7kYyMO3fjZhF/ZiyBdfbM6U/OQS9FXtVA4
        AgU2KsYOcyLvHLx8q0H8zn0rnEIE3H2xYKQYsTY=
X-Google-Smtp-Source: ABdhPJxT5qk+oak2tVU7SaONyWtaqZpUJ5mXozBodU35C/opvp1oYtQHqqAMeGk9bm5qX/2ArIqfcZw2SXbXbovvjig=
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr14375639qtt.65.1592201477844;
 Sun, 14 Jun 2020 23:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200614123923.99189-1-songmuchun@bytedance.com> <20200614123923.99189-2-songmuchun@bytedance.com>
In-Reply-To: <20200614123923.99189-2-songmuchun@bytedance.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 15 Jun 2020 15:11:06 +0900
Message-ID: <CAAmzW4Opfu7_r3UdjTKYui15u2kdwp9Y2-aje30iZ_LsQ0tHwA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/slub: Fix slabs_node return value when
 CONFIG_SLUB_DEBUG disabled
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
> The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
> But some codes determine whether slab is empty by checking the return
> value of slabs_node(). As you know, the result is not correct. This
> problem can be reproduce by the follow code(and boot system with the
> cmdline of "slub_nomerge"):
>
>   void *objs[32];
>   struct kmem_cache *cache =3D kmem_cache_create("kmem-test", 128, 0,
>                         0, 0);
>
>   if (cache) {
>         int i;
>
>         /* Make a full slab */
>         for (i =3D 0; i < ARRAY_SIZE(objs); i++)
>                 objs[i] =3D kmem_cache_alloc(cache, GFP_KERNEL_ACCOUNT);
>
>         /*
>          * This really should fail because the slab cache still has
>          * objects. But we did destroy the @cache because of zero
>          * returned by slabs_node().
>          */
>         kmem_cache_destroy(cache);
>   }
>
> To fix it, we can move the nr_slabs of kmem_cache_node out of the
> CONFIG_SLUB_DEBUG. So we can get the corrent value returned by the
> slabs_node().
>
> With this patch applied, we will get a warning message and stack
> trace in the dmesg.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/slab.h |  2 +-
>  mm/slub.c | 80 +++++++++++++++++++++++++++++++++------------------------=
------
>  2 files changed, 43 insertions(+), 39 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 0b91f2a7b033..062d4542b7e2 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -619,8 +619,8 @@ struct kmem_cache_node {
>  #ifdef CONFIG_SLUB
>         unsigned long nr_partial;
>         struct list_head partial;
> -#ifdef CONFIG_SLUB_DEBUG
>         atomic_long_t nr_slabs;
> +#ifdef CONFIG_SLUB_DEBUG
>         atomic_long_t total_objects;
>         struct list_head full;
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 49b5cb7da318..1a3e6a5b7287 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

Hello,

You also need to initialize nr_slabs in init_kmem_cache_node()
on !CONFIG_SLUB_DEBUG.

Otherwise, looks good to me.

Thanks.
