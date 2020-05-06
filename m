Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BEC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7320757
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6UjhI/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEFL7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgEFL7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:59:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC127C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 04:59:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b6so1505539qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neznKY+6L7BaBR2xiVWj7fZLdLOn94ic/5ND5jWNOV8=;
        b=J6UjhI/28MkQDKrElawqDLFvNjIPGwSYYsG8Aoemsd9fEx3GNLlG47RA2u6ou0J/rs
         NHsiEqGaY88mpPCphTpyRTOzbmlwi8wLCKudpWSI0/AAstuUUu3YE4IhPOBGNBqctn9I
         GnID4U67Zv5eeB90GzeNa9VStxLc8sFHnvysC8IzkgFU+xlLhzL9NI/DPX2XbogB/USg
         qp6YX4ck1pMX1s3ABP7qYSqTd2yu3CFWCx7bc3PS+pZmUjjwRYkl73EBXOfRkQVxRHZi
         +l3u2SE06e8nTuTIIO+QZxnliJbYGKhINWImIS2yfl0SIiTPWWk/6t2ilHJot7Um9a3h
         Grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neznKY+6L7BaBR2xiVWj7fZLdLOn94ic/5ND5jWNOV8=;
        b=JPahRS+VzJM1pm9xc0QkbAsD2lYk3HIaFfyVP7FYtiJ/8BU9rHXohKbR3/fZF5EwOi
         Hz9PFIc6UUYiU05VkPxhRBglNgopX5TKtj6v2T+DYjatHDViqQ2F6Chok+gLkyEYXDri
         TeuP+YX42kavNOYIdjtdpL1euEzymKJkoj6IyH84FquHQP1WK5uBsjm9EYQOkYvB+3Ez
         3AkJnBMUC5/dIuHu2/wRCFEd8Uw+5lBiALTD8V9T80Xo83fZFssgHV50omznCVmPVzlx
         huCHPtmMLoHOg3ZBXBzpZEYIz8LHny9yFloLrU9awRTJ8ll/PXm9hribv/OWCoxzYw+K
         0sgA==
X-Gm-Message-State: AGi0PuZB4uov4qCwgn2BoiXgs6ON7sZbSc1G52WGFpbi1AmKMlEhkdiC
        dmjR2jee3WtkNmGSkajk7E+3X86UR+I0C1aNKs3kmw==
X-Google-Smtp-Source: APiQypLCyhwy4xeYR/ap4IO8+wbSeKhUU5bj5JplBLuYph80r5E3xUUstFJ5CWj+N+pPS5KniIAkDkCp8xq4rdDPk7A=
X-Received: by 2002:a37:4b0c:: with SMTP id y12mr8038443qka.43.1588766386312;
 Wed, 06 May 2020 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200506052155.14515-1-walter-zh.wu@mediatek.com>
 <CACT4Y+ajKJpwNXd1V17bOT_ZShXm8h2eepxx_g4hAqk78SxCDA@mail.gmail.com> <1588766193.23664.28.camel@mtksdccf07>
In-Reply-To: <1588766193.23664.28.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 May 2020 13:59:34 +0200
Message-ID: <CACT4Y+bOxe+Y8BuzC=0k6rmkDiJ7PBnVcsY=jzZe1trVj476fg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kasan: record and print the free track
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 1:56 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Wed, 2020-05-06 at 11:50 +0200, Dmitry Vyukov wrote:
> > On Wed, May 6, 2020 at 7:22 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
> > > We add new KASAN_RCU_STACK_RECORD configuration option. It will move
> > > free track from slub meta-data (struct kasan_alloc_meta) into freed object.
> > > Because we hope this options doesn't enlarge slub meta-data size.
> > >
> > > This option doesn't enlarge struct kasan_alloc_meta size.
> > > - add two call_rcu() call stack into kasan_alloc_meta, size is 8 bytes.
> > > - remove free track from kasan_alloc_meta, size is 8 bytes.
> > >
> > > This option is only suitable for generic KASAN, because we move free track
> > > into the freed object, so free track is valid information only when it
> > > exists in quarantine. If the object is in-use state, then the KASAN report
> > > doesn't print call_rcu() free track information.
> > >
> > > [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > ---
> > >  mm/kasan/common.c | 10 +++++++++-
> > >  mm/kasan/report.c | 24 +++++++++++++++++++++---
> > >  2 files changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 32d422bdf127..13ec03e225a7 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -321,8 +321,15 @@ void kasan_record_callrcu(void *addr)
> > >                 /* record last call_rcu() call stack */
> > >                 alloc_info->rcu_free_stack[1] = save_stack(GFP_NOWAIT);
> > >  }
> > > -#endif
> > >
> > > +static void kasan_set_free_info(struct kmem_cache *cache,
> > > +               void *object, u8 tag)
> > > +{
> > > +       /* store free track into freed object */
> > > +       set_track((struct kasan_track *)(object + BYTES_PER_WORD), GFP_NOWAIT);
> > > +}
> > > +
> > > +#else
> > >  static void kasan_set_free_info(struct kmem_cache *cache,
> > >                 void *object, u8 tag)
> > >  {
> > > @@ -339,6 +346,7 @@ static void kasan_set_free_info(struct kmem_cache *cache,
> > >
> > >         set_track(&alloc_meta->free_track[idx], GFP_NOWAIT);
> > >  }
> > > +#endif
> > >
> > >  void kasan_poison_slab(struct page *page)
> > >  {
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 7aaccc70b65b..f2b0c6b9dffa 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -175,8 +175,23 @@ static void kasan_print_rcu_free_stack(struct kasan_alloc_meta *alloc_info)
> > >         print_track(&free_track, "Last call_rcu() call stack", true);
> > >         pr_err("\n");
> > >  }
> > > -#endif
> > >
> > > +static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> > > +               void *object, u8 tag, const void *addr)
> > > +{
> > > +       u8 *shadow_addr = (u8 *)kasan_mem_to_shadow(addr);
> > > +
> > > +       /*
> > > +        * Only the freed object can get free track,
> > > +        * because free track information is stored to freed object.
> > > +        */
> > > +       if (*shadow_addr == KASAN_KMALLOC_FREE)
> > > +               return (struct kasan_track *)(object + BYTES_PER_WORD);
> >
> > Humm... the other patch defines BYTES_PER_WORD as 4... I would assume
> > seeing 8 (or sizeof(long)) here. Why 4?
> It should be a pointer size, maybe sizeof(long) makes more sense.
>
> > Have you tested all 4 modes (RCU/no-RCU x SLAB/SLUB)? As far as I
> > remember one of the allocators stored something in the object.
> Good question, I only tested in RCU x SLUB, would you tell mew how do
> no-RCU? I will test them in v2 pathset.

I meant with CONFIG_KASAN_RCU_STACK_RECORD=y and with
CONFIG_KASAN_RCU_STACK_RECORD not set.
But if we drop CONFIG_KASAN_RCU_STACK_RECORD config, then it halves
the number of configurations to test ;)


> >
> > Also, does this work with objects with ctors and slabs destroyed by
> > rcu? kasan_track may smash other things in these cases.
> > Have you looked at the KASAN implementation when free_track was
> > removed? That may have useful details :)
> Set free_track before put into quarantine, free_track should not have to
> be removed, it only have to overwirte itself.
>
> >
> >
> > > +       else
> > > +               return NULL;
> > > +}
> > > +
> > > +#else
> > >  static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> > >                 void *object, u8 tag, const void *addr)
> > >  {
> > > @@ -196,6 +211,7 @@ static struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> > >
> > >         return &alloc_meta->free_track[i];
> > >  }
> > > +#endif
> > >
> > >  static void describe_object(struct kmem_cache *cache, void *object,
> > >                                 const void *addr, u8 tag)
> > > @@ -208,8 +224,10 @@ static void describe_object(struct kmem_cache *cache, void *object,
> > >                 print_track(&alloc_info->alloc_track, "Allocated", false);
> > >                 pr_err("\n");
> > >                 free_track = kasan_get_free_track(cache, object, tag, addr);
> > > -               print_track(free_track, "Freed", false);
> > > -               pr_err("\n");
> > > +               if (free_track) {
> > > +                       print_track(free_track, "Freed", false);
> > > +                       pr_err("\n");
> > > +               }
> > >  #ifdef CONFIG_KASAN_RCU_STACK_RECORD
> > >                 kasan_print_rcu_free_stack(alloc_info);
> > >  #endif
> > > --
> > > 2.18.0
