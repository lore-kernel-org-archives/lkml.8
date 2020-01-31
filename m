Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40090C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D8215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeDt22Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgAaSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:18:57 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36097 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgAaSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:18:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so5544618lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQB69rHX1wLUOB6ckxnewaTIywwOUniSjsLx2ZdmZVU=;
        b=jeDt22Y76Yhwn3Q8wYjH9uJcoKEH0QuY429dXNFN7HruLwWlRqVzXUK751j8JOdxjq
         FULXCK2DPDMD9GR+VdOs4vb/InZZFXbIn0Y73jMsCQBUw7xAQd1SkBJu2EwklkEOxiS6
         0USCMPOp279Gx/SIRygdYahxOnYgQuJqKQthJwCpA/S0Ut4VeHIr5/WrT9o9OQprpORe
         xvfqMAcldi7yr298nGsS9k0ykRUMQSUO57pZwZ78QXiR6+6BSTCvE6Xxau6WzzcN/2UD
         6y+X9NEM5Z/eaynqJL6QbY4sQN5sJ43ZQ4BOe/ZqUspMnrtQZJNJlhlFTMDfeKCP2/+H
         d7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQB69rHX1wLUOB6ckxnewaTIywwOUniSjsLx2ZdmZVU=;
        b=Cj2QrchkBQw2MddRZzq4FUCB36pP7mxXHLdE0cK32FklgtL9Dej1Q78y1swftFjcHL
         8MiOed1UU/tic+10Xi/F0wUFA/Yz3dVUoaBxerdIcKg1SPLLotav1/KfrU15G1TRGqBA
         h9pnx60jMuyyvDwHZhI+RX/kJYCuwOE7AhTSnC//jlozaZnYv31qKgDhOm52Ok5i1VX+
         omt3GCli/mkc6a04JeE9HVCIk4XgI9FTpZFCnHjuzQF4RCtGsgvdZh/l4XdV6GwqI1Lm
         fBEES64FUpIKm1Z4kfGIdXbvZTrcmri1XOL15j3eyuwpIXhtdIghTPQ7mjn+neZryMJE
         Biew==
X-Gm-Message-State: APjAAAVlwOHdsJH98hBKNz5dXmhpiu+pEzwGFPUU+IlFp1kzHgePi47x
        HWdCdBwyKZfEXMk3/As4EU81tEARbGtRdI+n9hCFLvSBCoiF5A==
X-Google-Smtp-Source: APXvYqyq/YfoE0oFSPYzEyKRSgA8t1DxpbDmSXNnWAWmVKZvjNNBuUx80heTPOUQbSjAkXy16oEV7Acsq2nO+E63ABI=
X-Received: by 2002:a5d:6692:: with SMTP id l18mr12918211wru.382.1580494315839;
 Fri, 31 Jan 2020 10:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
 <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com> <1580436306.11126.16.camel@mtksdccf07>
In-Reply-To: <1580436306.11126.16.camel@mtksdccf07>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 31 Jan 2020 19:11:44 +0100
Message-ID: <CAG_fn=X2V0nL=+s38bDbS3UXf2_i61tSevd8vzkV-ZKY=7MHvw@mail.gmail.com>
Subject: Re: [PATCH v3] lib/stackdepot: Fix global out-of-bounds in stackdepot
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 3:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Thu, 2020-01-30 at 13:03 +0100, Alexander Potapenko wrote:
> > On Thu, Jan 30, 2020 at 7:44 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > Hi Walter,
> >
> > > If the depot_index = STACK_ALLOC_MAX_SLABS - 2 and next_slab_inited = 0,
> > > then it will cause array out-of-bounds access, so that we should modify
> > > the detection to avoid this array out-of-bounds bug.
> > >
> > > Assume depot_index = STACK_ALLOC_MAX_SLABS - 3
> > > Consider following call flow sequence:
> > >
> > > stack_depot_save()
> > >    depot_alloc_stack()
> > >       if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) //pass
> > >       depot_index++  //depot_index = STACK_ALLOC_MAX_SLABS - 2
> > >       if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) //enter
> > >          smp_store_release(&next_slab_inited, 0); //next_slab_inited = 0
> > >       init_stack_slab()
> > >          if (stack_slabs[depot_index] == NULL) //enter and exit
> > >
> > > stack_depot_save()
> > >    depot_alloc_stack()
> > >       if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) //pass
> > >       depot_index++  //depot_index = STACK_ALLOC_MAX_SLABS - 1
> > >       init_stack_slab(&prealloc)
> > >          stack_slabs[depot_index + 1]  //here get global out-of-bounds
> > >
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > ---
> > > changes in v2:
> > > modify call flow sequence and preconditon
> > >
> > > changes in v3:
> > > add some reviewers
> > > ---
> > >  lib/stackdepot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index ed717dd08ff3..7e8a15e41600 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -106,7 +106,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
> > >         required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
> > >
> > >         if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
> > > -               if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
> > > +               if (unlikely(depot_index + 2 >= STACK_ALLOC_MAX_SLABS)) {

This again means stack_slabs[STACK_ALLOC_MAX_SLABS - 2] gets
initialized, but stack_slabs[STACK_ALLOC_MAX_SLABS - 1] doesn't,
because we'll be bailing out from init_stack_slab() from now on.
Does this patch actually fix the problem (do you have a reliable reproducer?)
This addition of 2 is also counterintuitive, I don't think further
readers will understand the logic behind it.

What if we just check that depot_index + 1 is a valid index before accessing it?

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2e7d2232ed3c..c2e6ff18d716 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -106,7 +106,9 @@ static bool init_stack_slab(void **prealloc)
        if (stack_slabs[depot_index] == NULL) {
                stack_slabs[depot_index] = *prealloc;
        } else {
-               stack_slabs[depot_index + 1] = *prealloc;
+               /* If this is the last depot slab, do not touch the next one. */
+               if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
+                       stack_slabs[depot_index + 1] = *prealloc;
                /*
                 * This smp_store_release pairs with smp_load_acquire() from
                 * |next_slab_inited| above and in stack_depot_save().
