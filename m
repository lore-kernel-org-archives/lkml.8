Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B9C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C1620721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKGNNJxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBCKan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:30:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:30:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so15182331wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD9fba3D0HqXgOSqJlLFz2muhY16h6Gr+BwVuHnFIv4=;
        b=UKGNNJxPihSVdDnyfCzDlB+1MVddilSdG2GMCVkiCGZL6D4AXhN/Byg8SWyWW/bnPv
         ZhR3DWnYrfYRCjJom/Sh/JFBZ7Iwl4epixB/18DbnkFz7yPe8kl55ww3eOTntukb3ppn
         DJMyUvrIU12QGoinWcbsJ/q0VJC88l8j9qeBE7MvLq2Yj6xHtWBYBAQYNNlPMKQf8Nd5
         EqLLTWtOUfsnFNR7Kr+L3uZvlKVeimHI/QULdJTHLV8iEpdDqj4VDcz3s7vCA2nKdmiV
         f+EQ9zpHVS6KalEcfPgv8DBDc6jw7fnqqMZlQjLHwj9n0GfXXn0NPvHjPnaM1pSMxGxT
         XLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD9fba3D0HqXgOSqJlLFz2muhY16h6Gr+BwVuHnFIv4=;
        b=E//25EmqGvSZshvoR8k91dQjBWYvNzKKQzw6/9sDk0nJy+jNWVfTcwvgGcHhezziKX
         iDef3q4USOTRFnMn1IBsNpenINjpjNnrFPxeRnr4cSlKcxopXUut2TfXhpzQqROC2MUJ
         1QliENmIyoDyH6sZ4+SclolNksRGKSeLm/WRnICMdMHUB2LYLJVc3N/WQ3nBWlGOIvWA
         Gt+fxjzzG9DKcv9KzDC6b/GOCspqms5AxeubScuPz9gOz2tFrlWOOJGhOXM1NSFpmCPs
         OwX0m8Y7gAvFtKafycEnlWs2NZT+ZPHMSlmADJoyfPXP2MwiePAW87EO3s0iZ7Kni8QH
         2byQ==
X-Gm-Message-State: APjAAAX+p4sWpzYQb7bZkof4JGNslxPwG9foN0kF1wBgPI0qHedWMsBt
        jbPCGIzcRYhuVuPpkcFn7boNLiFAuBjQSTvF1uVYERCiTN8=
X-Google-Smtp-Source: APXvYqxNx7Z0KIvo/FhK4eHPDW3mZ84bqAFnEzCbf8Hd0g8df+eNawGKBotlJvsxIVfVYaHjsPN4BUWk/DfxFPRlw6I=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr27326507wme.37.1580725840251;
 Mon, 03 Feb 2020 02:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
 <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com>
 <1580436306.11126.16.camel@mtksdccf07> <CAG_fn=X2V0nL=+s38bDbS3UXf2_i61tSevd8vzkV-ZKY=7MHvw@mail.gmail.com>
 <1580695544.17006.7.camel@mtksdccf07>
In-Reply-To: <1580695544.17006.7.camel@mtksdccf07>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 3 Feb 2020 11:30:28 +0100
Message-ID: <CAG_fn=UHhZB-2JBdSBAbuNjBZwVwrzhqQvR1nHb+XOqUEvLMsw@mail.gmail.com>
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

On Mon, Feb 3, 2020 at 3:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Fri, 2020-01-31 at 19:11 +0100, Alexander Potapenko wrote:
> > On Fri, Jan 31, 2020 at 3:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > >
> > > On Thu, 2020-01-30 at 13:03 +0100, Alexander Potapenko wrote:
> > > > On Thu, Jan 30, 2020 at 7:44 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > >
> > > > Hi Walter,
> > > >
> > > > > If the depot_index = STACK_ALLOC_MAX_SLABS - 2 and next_slab_inited = 0,
> > > > > then it will cause array out-of-bounds access, so that we should modify
> > > > > the detection to avoid this array out-of-bounds bug.
> > > > >
> > > > > Assume depot_index = STACK_ALLOC_MAX_SLABS - 3
> > > > > Consider following call flow sequence:
> > > > >
> > > > > stack_depot_save()
> > > > >    depot_alloc_stack()
> > > > >       if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) //pass
> > > > >       depot_index++  //depot_index = STACK_ALLOC_MAX_SLABS - 2
> > > > >       if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) //enter
> > > > >          smp_store_release(&next_slab_inited, 0); //next_slab_inited = 0
> > > > >       init_stack_slab()
> > > > >          if (stack_slabs[depot_index] == NULL) //enter and exit
> > > > >
> > > > > stack_depot_save()
> > > > >    depot_alloc_stack()
> > > > >       if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) //pass
> > > > >       depot_index++  //depot_index = STACK_ALLOC_MAX_SLABS - 1
> > > > >       init_stack_slab(&prealloc)
> > > > >          stack_slabs[depot_index + 1]  //here get global out-of-bounds
> > > > >
> > > > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Alexander Potapenko <glider@google.com>
> > > > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > > ---
> > > > > changes in v2:
> > > > > modify call flow sequence and preconditon
> > > > >
> > > > > changes in v3:
> > > > > add some reviewers
> > > > > ---
> > > > >  lib/stackdepot.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > > > index ed717dd08ff3..7e8a15e41600 100644
> > > > > --- a/lib/stackdepot.c
> > > > > +++ b/lib/stackdepot.c
> > > > > @@ -106,7 +106,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
> > > > >         required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
> > > > >
> > > > >         if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
> > > > > -               if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
> > > > > +               if (unlikely(depot_index + 2 >= STACK_ALLOC_MAX_SLABS)) {
> >
> > This again means stack_slabs[STACK_ALLOC_MAX_SLABS - 2] gets
> > initialized, but stack_slabs[STACK_ALLOC_MAX_SLABS - 1] doesn't,
> > because we'll be bailing out from init_stack_slab() from now on.
> > Does this patch actually fix the problem (do you have a reliable reproducer?)
> We get it by reviewing code, because Kasan doesn't scan it and we catch
> another bug internally, we found it unintentionally.
>
> > This addition of 2 is also counterintuitive, I don't think further
> > readers will understand the logic behind it.
> >
> Yes
>
> > What if we just check that depot_index + 1 is a valid index before accessing it?
> >
> It should fix the problem, do you want to send this patch?

I've sent the patch. Thanks for the report!
