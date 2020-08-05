Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E79DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B37206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zpVZXiTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgHETUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgHERsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:48:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B210C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:48:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so35664511qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8SDbLijbQZbWGypmj2TRMxsFz9ReijxHmpVUeM/fIc=;
        b=zpVZXiTWfoCgikALeecwe2WeBbjwJYJ1YBxnpb330Cep2am51yyu1rn8Jfs+OHNBA8
         jnOluEFZr5d36i646rcPYpZvMJoX+aOX7y+88qovUDAteNekmYzX+4VdxK+dpYRBNrs3
         pSte05YDaOeoy4L5DOt7kYoBIzKh+ED2VT8ytRmJw/B/Fvu8YjPbeYDHP2sqFIe9JVkV
         Do6yqWx/R/1EKC2ACz1UyhpsRdjR1bof2wmPA+OSiP3OAM4VW39IW7x8gNXSxSajcrN2
         v1jyJ/ZqjmM8t4EiAjdpUQPetivujOEKO3yBW6RuHF1NwGKT/Uh6C6RWjR205gxohh5/
         lCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8SDbLijbQZbWGypmj2TRMxsFz9ReijxHmpVUeM/fIc=;
        b=jn2pOGxjvbY8CGcshIldhrsxWxBylBAPAkRyF/7/n94q+IdFNelOpLSpYO0RltE7Rq
         +IBdP24jy4bfrMNe/jTNvMQwXKi+8SAuLqudJwnmXePJ2At+zUDf/wQN9ibeNi9XUi7/
         y8hg75CMrVSlk7ILfTgcatqpm4mBd4X5WZ/y78QLCrb1UXr6udyzU/T0FVqGhjyjfePt
         LIMKajRucOvoGL+5LA245ucSBcFrAbBzaGVrb174AlMWv1Y2eDwsJsl1JGelHrGoupUJ
         5AmqQaPAJFS7m1Gm9YZtkMPHodlwEp0mng2gXJvt+8IDowoUUoH7MG5mtxXZaO6KyCSd
         1ROw==
X-Gm-Message-State: AOAM530kihPzsGlj8Zz06VFiiU2PivjxdQim4aUlvp2IDAVMJAcTOIse
        1SG9NyjxhcXs62jIZbz7/lQkaInjdVWa0AxrvSJqrg==
X-Google-Smtp-Source: ABdhPJxIv17WhN4iwentpctBBr2GjiUzc/lct6DN+CTnKQkJtXypfEZqdXr6fyMdqfypTUtLg8+W4rWERToBOrIgGaY=
X-Received: by 2002:a05:620a:12ef:: with SMTP id f15mr4696171qkl.120.1596649688730;
 Wed, 05 Aug 2020 10:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200725041955.9985-1-warthog618@gmail.com> <20200725041955.9985-3-warthog618@gmail.com>
 <CAMpxmJXocdDTvC7_76UwZ9FONn86p0MjZtorRKTR5bxN7PJy6g@mail.gmail.com> <20200805051853.GA122005@sol>
In-Reply-To: <20200805051853.GA122005@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 5 Aug 2020 19:47:57 +0200
Message-ID: <CAMpxmJWWmBULX+RdqN3nyXFO4M9sbu2Q6i11UJMiKxomVDr47g@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] gpio: uapi: define uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:19 AM Kent Gibson <warthog618@gmail.com> wrote:
>

[snip]

> > >
> > > +/*
> > > + * Maximum number of requested lines.
> > > + *
> > > + * Must be a multiple of 8 to ensure 32/64-bit alignment of structs.
> > > + */
> > > +#define GPIOLINES_MAX 64
> > > +
> > > +/* The number of __u64 required for a bitmap for GPIOLINES_MAX lines */
> > > +#define GPIOLINES_BITMAP_SIZE  __KERNEL_DIV_ROUND_UP(GPIOLINES_MAX, 64)
> > > +
> >
> > In what circumstances can this be different than 1? It's worth
> > documenting here I suppose.
> >
>
> In terms of the API definition, GPIOLINES_MAX can be anything you want
> and the definitions are still valid.  In practice in the mainline kernel
> it would always be 1 for ABI compatibility.
>
> Chiselling GPIOLINES_MAX <= 64 into stone could simplify things a bit,
> as all the bitmaps reduce to a single __u64.  Would you prefer that?
>

I'm not sure I follow. We need to chisel some max value in stone. Up
to that point it's been 64. We can make it more and the bitmap API
would handle it alright but if we don't, then this
__KERNEL_DIV_ROUND_UP() is unnecessary. Limiting it to 64 makes things
very simple thanks to fitting into a __u64 though. I've personally
never needed to request even half that so I guess this value's fine?

> > > +/*
> > > + * The maximum number of configuration attributes associated with a line
> > > + * request.
> > > + */
> > > +#define GPIOLINE_NUM_ATTRS_MAX 10
> > > +
> >
> > How did you choose this number? I mean: it's reasonable - just asking
> > for clarification.
> >
>
> I didn't want to constrain the possible configurations by making it too
> small, particularly allowing for future attributes, but wanted to keep the
> request size down so it can still comfortably fit on the stack.
> The gpioline_request stands at 592 bytes, which is already substantially
> larger than the 364 bytes of the v1 request, and each additional config
> attribute slot adds another 24 bytes.
>
> So 10 seemed like a happy medium.
>

Makes sense.

> > > +/**
> > > + * enum gpioline_flag_v2 - &struct gpioline_attribute.flags values
> > > + */
> > > +enum gpioline_flag_v2 {
> > > +       GPIOLINE_FLAG_V2_USED                   = 1UL << 0, /* line is not available for request */
> > > +       GPIOLINE_FLAG_V2_ACTIVE_LOW             = 1UL << 1,
> > > +       GPIOLINE_FLAG_V2_INPUT                  = 1UL << 2,
> > > +       GPIOLINE_FLAG_V2_OUTPUT                 = 1UL << 3,
> > > +       GPIOLINE_FLAG_V2_EDGE_RISING            = 1UL << 4,
> > > +       GPIOLINE_FLAG_V2_EDGE_FALLING           = 1UL << 5,
> > > +       GPIOLINE_FLAG_V2_OPEN_DRAIN             = 1UL << 6,
> > > +       GPIOLINE_FLAG_V2_OPEN_SOURCE            = 1UL << 7,
> > > +       GPIOLINE_FLAG_V2_BIAS_PULL_UP           = 1UL << 8,
> > > +       GPIOLINE_FLAG_V2_BIAS_PULL_DOWN         = 1UL << 9,
> > > +       GPIOLINE_FLAG_V2_BIAS_DISABLED          = 1UL << 10,
> > > +};
> > > +
> > > +/**
> > > + * struct gpioline_values - Values of GPIO lines
> > > + * @bits: a bitmap containing the value of the lines, set to 1 for active
> > > + * and 0 for inactive.  Note that this is the logical value, which will be
> > > + * the opposite of the physical value if the line is configured as active
> > > + * low.
> > > + */
> > > +struct gpioline_values {
> > > +       __u64 bits[GPIOLINES_BITMAP_SIZE];
> > > +};
> > > +
> >
> > We can set values only for a subset of requested lines but AFAICT we
> > can't read values of only a subset of lines. Would it be difficult to
> > remove this limitation? While reading values always succeeds - even if
> > the line is in input mode and has edge detected - I think that someone
> > may want to request the max number of lines without reading all their
> > values each time. Maybe consider merging this with struct
> > gpioline_set_values?
> >
>
> That is correct.
>
> I considered that corner case to be unlikely, as a major point of
> requesting lines together is to be able to perform collective operations
> on them as atomically as possible.  If you only want subsets then
> request them as separate subsets.
>

And yet this version implements heterogeneous config and setting edge
detection and values of subsets of requested lines. :)

> Do you have a case in mind where you would have overlapping subsets?
>

No, not really but then I also don't have a use-case for setting only
a certain subset of lines.

> Not difficult to remove the limitation - I just didn't see sufficient
> benefit.
>

Using the same structure for setting and getting values is a benefit
IMO. If it's not a difficult task, then I think it's worth adding it.

> > > +/**
> > > + * struct gpioline_set_values - Values to set a group of GPIO lines
> > > + * @mask: a bitmap identifying the lines to set.
> > > + * @bits: a bitmap containing the value of the lines, set to 1 for active
> > > + * and 0 for inactive.  Note that this is the logical value, which will be
> > > + * the opposite of the physical value if the line is configured as active
> > > + * low.
> > > + */
> > > +struct gpioline_set_values {
> > > +       __u64 mask[GPIOLINES_BITMAP_SIZE];
> > > +       __u64 bits[GPIOLINES_BITMAP_SIZE];
> > > +};
> > > +
> > > +/**
> > > + * enum gpioline_attr_id - &struct gpioline_attribute.id values
> > > + */
> > > +enum gpioline_attr_id {
> > > +       GPIOLINE_ATTR_ID_FLAGS                  = 1,
> > > +       GPIOLINE_ATTR_ID_OUTPUT_VALUES          = 2,
> > > +       GPIOLINE_ATTR_ID_DEBOUNCE               = 3,
> > > +};
> > > +
> > > +/**
> > > + * struct gpioline_attribute - a configurable attribute of a line
> > > + * @id: attribute identifier with value from &enum gpioline_attr_id
> > > + * @padding: reserved for future use and must be zero filled
> > > + * @flags: if id is GPIOLINE_ATTR_ID_FLAGS, the flags for the GPIO line,
> > > + * with values from enum gpioline_flag_v2, such as
> > > + * GPIOLINE_FLAG_V2_ACTIVE_LOW, GPIOLINE_FLAG_V2_OUTPUT etc, OR:ed
> > > + * together.  This overrides the default flags contained in the &struct
> > > + * gpioline_config for the associated line.
> > > + * @values: if id is GPIOLINE_ATTR_ID_OUTPUT_VALUES, the values to which
> > > + * the lines will be set
> > > + * @debounce_period: if id is GPIOLINE_ATTR_ID_DEBOUNCE, the desired
> > > + * debounce period, in microseconds
> > > + */
> > > +struct gpioline_attribute {
> > > +       __u32 id;
> > > +       __u32 padding;
> > > +       union {
> > > +               __u64 flags;
> > > +               struct gpioline_values values;
> > > +               __u32 debounce_period;
> > > +       };
> > > +};
> >
> > I'm afraid that if we don't have enough padding here (at the end),
> > we'll end up wanting to add a new attribute at some point whose
> > argument won't fit. Maybe have a specific field in the union that's
> > even larger than __u64?
> >
>
> I'm satisfied with the 64-bit value restriction.
>
> I don't want to go adding another 8 bytes of pad per attribute on the
> off chance that we ever find such an attribute, and that we couldn't
> find some other solution like using the __u32 padding, or user the
> gpioline_config padding, or split it over two attributes....
>

Fair enough.

> > > +
> > > +/**
> > > + * struct gpioline_config_attribute - a configuration attribute associated
> > > + * with one or more of the requested lines.
> > > + * @mask: a bitmap identifying the lines to which the attribute applies
> > > + * @attr: the configurable attribute
> > > + */
> > > +struct gpioline_config_attribute {
> > > +       __u64 mask[GPIOLINES_BITMAP_SIZE];
> > > +       struct gpioline_attribute attr;
> > > +};
> > > +
> > > +/**
> > > + * struct gpioline_config - Configuration for GPIO lines
> > > + * @flags: flags for the GPIO lines, with values from enum
> > > + * gpioline_flag_v2, such as GPIOLINE_FLAG_V2_ACTIVE_LOW,
> > > + * GPIOLINE_FLAG_V2_OUTPUT etc, OR:ed together.  This is the default for
> > > + * all requested lines but may be overridden for particular lines using
> > > + * attrs.
> >
> > So I'm having a hard time with this. I understand that the thinking
> > behind it was: use the flags field to set all lines to INPUT by
> > default and only set certain lines to OUTPUT with attrs. This would
> > make life easier for user-space but it complicates the kernel code and
> > I also believe that any such simplification should be handled by
> > user-space libraries, not be exposed by kernel uAPI. My personal
> > preference would be to drop the flags field and only handle attributes
> > (maybe even define a special macro to set all bits in mask -
> > GPIOLINE_CONFIG_ALL_LINES or something) on a first-in-wins basis. I'm
> > open to other suggestions though.
> >
>
> I think I've addressed this elsewhere, and still think it is worthwhile
> and very low cost.  I thought it was an easy win when I added it, and
> still do.
>
> Happy to change the attrs to first-in-wins though - the validation of
> the attrs is still my biggest bugbear with this version.

Yes, I read your other reply. Ok, makes sense to have default flags
with an attribute for overrides. This just needs very explicit
documentation.

Bartosz
