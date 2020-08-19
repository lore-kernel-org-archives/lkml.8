Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81347C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0952245C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClvOFhNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHSUxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHSUxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:53:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6989C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:53:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so19229787edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yURW+RhXhM6HORTjXkKSgQ53bgRFtFp91lB5i7mxn+g=;
        b=ClvOFhNc+ACUifuBlboiQkqrobYqpacCnHu7v3XdDk8dq8BXqPNDXHBIFYXL/Njnv1
         pKmzegL5r+l0jJlU6LBfCWmHXHjbMpABneK/fwX9gEMl9agl8Kfz78LfNUB+EfiPGibw
         7WoN8sLZ0rl1NIbGwMapqyHNPoifyUa5hJXmOEZ1bqtQZCXFtW08sm+DcUfL/9lLpNQm
         HZwDtA8ghS59OR6/nlz0iGMfjd+x2CbzYMh0VQBPNRzfAf94fqRTL5w87YgSzXiMIbCJ
         XRq+l6HlxX+hAQJ5Ue7VOKfUQnXKsa65FVsMNh8PH+WCo800O/kKC2Y8iKmJUcbLrML6
         nKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yURW+RhXhM6HORTjXkKSgQ53bgRFtFp91lB5i7mxn+g=;
        b=X/UPUyTz50Ph2v+iUjXpuDm6BYstk7kFQYpqR2m/BnuOTwUpIKMvYO/m+nmArQ9pxW
         5AtRx/xbqK3dGDmXq3L58wfKO6pGQoB3cBEPxTxcWBwJLQuMDDkR5jDAGc2ydCmWJ/r8
         R7tnCbdwX5kbXCMTMosyhMovTMwyE9SXoLgVvGjK/K06wLjNg5bWZfrW9B9/qKepAaOo
         h/o20C1gAIt3JWMLvP/Jeldrvi8Lsq/mRLuS0J3L+8gWoQjEGpknycFjAtiQn6/b78R1
         CDVBBMKl16j/GHe2tnFBr1LIcNs7URH3f6aV/tsPLafyp8nw7VBcDyPByzYOqZEL+zBJ
         CNuQ==
X-Gm-Message-State: AOAM533tBlIBcjV7od9SKPzPFCDu80K9XQe+1opmX7rksCep8Bga8uxD
        Qkm3c2eCaCPVYKsJdJw5PTJlW0WyYEHdx6OkqjbcYQ==
X-Google-Smtp-Source: ABdhPJxXeJOrPzuQ4CNx6Zbbm6KIhsWIhHxaw5bm0OeOMOk+S5rXn6VbZKbg92MA2Zq9yw6Y8cJeKoYnuKzWm5SDlj0=
X-Received: by 2002:a05:6402:1a23:: with SMTP id be3mr27250037edb.138.1597870391176;
 Wed, 19 Aug 2020 13:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200808095030.13368-1-kpark3469@gmail.com> <20200819132630.7b26964cc8946189ab5b1a70@linux-foundation.org>
In-Reply-To: <20200819132630.7b26964cc8946189ab5b1a70@linux-foundation.org>
From:   Thomas Garnier <thgarnie@google.com>
Date:   Wed, 19 Aug 2020 13:52:59 -0700
Message-ID: <CAJcbSZFLcC1j8PLb3-EJWY6xSGDph=Pz5UNes3XjEUSoeSkNZw@mail.gmail.com>
Subject: Re: [PATCH] mm: slub: re-initialize randomized freelist sequence in calculate_sizes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kpark3469@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        keun-o.park@digital14.com, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I am not super familiar with the sysfs setup here but the random
sequence should work as expected. One minor comment below.

Reviewed-by: Thomas Garnier <thgarnie@chromium.org>

On Wed, Aug 19, 2020 at 1:26 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
>
> (cc Thomas and linux-mm)
>
> On Sat,  8 Aug 2020 13:50:30 +0400 kpark3469@gmail.com wrote:
>
> > From: Sahara <keun-o.park@digital14.com>
> >
> > Slab cache flags are exported to sysfs and are allowed to get modified
> > from userspace. Some of those may call calculate_sizes function because
> > the changed flag can take an effect on slab object size and layout,
> > which means kmem_cache may have different order and objects.
> > The freelist pointer corruption occurs if some slab flags are modified
> > while CONFIG_SLAB_FREELIST_RANDOM is turned on.
> >
> >  $ echo 0 > /sys/kernel/slab/zs_handle/store_user
> >  $ echo 0 > /sys/kernel/slab/zspage/store_user
> >  $ mkswap /dev/block/zram0
> >  $ swapon /dev/block/zram0 -p 32758
> >
> >  =============================================================================
> >  BUG zs_handle (Not tainted): Freepointer corrupt
> >  -----------------------------------------------------------------------------
> >
> >  Disabling lock debugging due to kernel taint
> >  INFO: Slab 0xffffffbf29603600 objects=102 used=102 fp=0x0000000000000000 flags=0x0200
> >  INFO: Object 0xffffffca580d8d78 @offset=3448 fp=0xffffffca580d8ed0
> >
> >  Redzone 00000000f3cddd6c: bb bb bb bb bb bb bb bb                          ........
> >  Object 0000000082d5d74e: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
> >  Redzone 000000008fd80359: bb bb bb bb bb bb bb bb                          ........
> >  Padding 00000000c7f56047: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> >
> > In this example, an Android device tries to use zram as a swap and to
> > turn off store_user in order to reduce the slub object size.
> > When calculate_sizes is called in kmem_cache_open, size, order and
> > objects for zs_handle is:
> >  size:360, order:0, objects:22
> > However, if the SLAB_STORE_USER bit is cleared in store_user_store:
> >  size: 56, order:1, objects:73
> >
> > All the size, order, and objects is changed by calculate_sizes(), but
> > the size of the random_seq array is still old value(22). As a result,
> > out-of-bound array access can occur at shuffle_freelist() when slab
> > allocation is requested.
> >
> > This patch fixes the problem by re-allocating the random_seq array
> > with re-calculated correct objects value.
> >
> > Fixes: 210e7a43fa905 ("mm: SLUB freelist randomization")
> > Reported-by: Ari-Pekka Verta <ari-pekka.verta@digital14.com>
> > Reported-by: Timo Simola <timo.simola@digital14.com>
> > Signed-off-by: Sahara <keun-o.park@digital14.com>
> > ---
> >  mm/slub.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index f226d66408ee..be1e4d6682b8 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3704,7 +3704,22 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
> >       if (oo_objects(s->oo) > oo_objects(s->max))
> >               s->max = s->oo;
> >
> > -     return !!oo_objects(s->oo);
> > +     if (!oo_objects(s->oo))
> > +             return 0;
> > +
> > +     /*
> > +      * Initialize the pre-computed randomized freelist if slab is up.
> > +      * If the randomized freelist random_seq is already initialized,
> > +      * free and re-initialize it with re-calculated value.
> > +      */
> > +     if (slab_state >= UP) {
> > +             if (s->random_seq)
> > +                     cache_random_seq_destroy(s);

kfree(NULL) is a noop, so you don't need to check s->random_seq.

> > +             if (init_cache_random_seq(s))
> > +                     return 0;
> > +     }
> > +
> > +     return 1;
> >  }
> >
> >  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> > @@ -3748,12 +3763,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >       s->remote_node_defrag_ratio = 1000;
> >  #endif
> >
> > -     /* Initialize the pre-computed randomized freelist if slab is up */
> > -     if (slab_state >= UP) {
> > -             if (init_cache_random_seq(s))
> > -                     goto error;
> > -     }
> > -
> >       if (!init_kmem_cache_nodes(s))
> >               goto error;
> >
> > --
> > 2.17.1



--
Thomas
