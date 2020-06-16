Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8125520739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nShA9M8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFPFry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:47:54 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D61C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:47:54 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id p187so4526345vkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kNv3/nwhWtlNUH7eRCq8sD+149stMVa1OEvvQPeJOQ=;
        b=nShA9M8oAP/uXZ3i7WEsOeiZdmR5e8n7b6wJ8Te/MvwEuS0+sHy0LMh2ZE4+kWUzDW
         vA24FMrFKn+LS6KceSsoH+Bj41BURuoRyN+M2w6cSR7asNh/JsQNUJsGC7JKXFmk1QhQ
         vxcciKqzLEnGrx6DqcLLSlkgp434ALIJNb87doNgWvVf9/p1bwKlERUcmbsU4mlowAgU
         8X8aaO6ix3H264mZ2nJaNYMLCZzrxmi5SVGg+vKAPPp/hXUsJ6b8Bz9yTjcI8TqbAXEW
         rDZmQd6NTH6WqxRcuWDswiLXY1aqItGyTuzPxClYLdD7s8luJ+Qn7aDejjnArfMawUt0
         z+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kNv3/nwhWtlNUH7eRCq8sD+149stMVa1OEvvQPeJOQ=;
        b=ZbuB3s41BF2Lnwkhf3eRhNxuWMl3SAegshiQsJW67cAOajYRO9snpXv4RYPxY3J7yW
         L8cRS040AS2ocwAwVViXU3mAyxBLAqRSEDgyAQYKlwLEGE1hXPStC88Q2qiEtQGEWbUr
         t3YXomIsVVz7PTq9pZnmg01c8ycb3q0Sa8m/rMpsLVWxsEqTvktnFm9NUomucKDLnGpD
         GHcEn7MO8RYo+5XAtgRv5+OJI0LqkoudNSU/84L7XOd8rtKRd+Zmu9f0C131XQ3XyMya
         7lRWKzb4OsQiEjCuacsOpuUzNekUZAuJvmRQJLtMfCEWUhl7AQ+jfXMOx5qmWkBiub2a
         +aEw==
X-Gm-Message-State: AOAM533LDkXoUJ9pQnVmURRfBmPxm2Ftg0x0AlbZrfG3cUjaCCCTexJN
        w4pfwLUNgN1dcDGMOc7X+BcU2yW1ZysvOnMrBUk=
X-Google-Smtp-Source: ABdhPJy9zxXa0PjkdebOP0XF+RKHUOaJqt0UzFwit5ma2mJUaqVhdM7yQaCj9ZVm7iOZoJxgYCfzN19pPRIN0OHjaR4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr379210vkd.93.1592286473111;
 Mon, 15 Jun 2020 22:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-14-jim.cromie@gmail.com> <20200615151414.GI31238@alley>
In-Reply-To: <20200615151414.GI31238@alley>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 23:47:26 -0600
Message-ID: <CAJfuBxyTsrsyMZFhET3yxM1APobY98ykBLuQ2LEhHKsOYtyjEg@mail.gmail.com>
Subject: Re: [PATCH v2 13/24] dyndbg: combine flags & mask into a struct, use that
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:14 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:27, Jim Cromie wrote:
> > combine flags & mask into a struct, and replace those 2 parameters in
> > 3 functions: ddebug_change, ddebug_parse_flags, ddebug_read_flags,
> > altering the derefs in them accordingly.
> >
> > This simplifies the 3 function sigs, preparing for more changes.
> > We dont yet need mask from ddebug_read_flags, but will soon.
> > ---
> >  lib/dynamic_debug.c | 46 +++++++++++++++++++++++----------------------
> >  1 file changed, 24 insertions(+), 22 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 93c627e9c094..8dc073a6e8a4 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -62,6 +62,11 @@ struct ddebug_iter {
> >       unsigned int idx;
> >  };
> >
> > +struct flagsettings {
>
> Please. use underscore to help with parsing such a long names.
> I mean use: flags_settings.
>

ok

> > +     unsigned int flags;
> > +     unsigned int mask;
> > +};
>
> static int ddebug_change(const struct ddebug_query *query,
> > -                     unsigned int pflags, unsigned int mask)
> > +                      struct flagsettings *mods)
>
> > -static int ddebug_read_flags(const char *str, unsigned int *flags)
> > +static int ddebug_read_flags(const char *str, struct flagsettings *f)
>
> > -static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
> > -                            unsigned int *maskp)
> > +static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
>
> What "mods" stands for, please?
>

modifying_flags, or modifiers.
the original flags & mask bundled together
ie the pfmlt in
   echo +pfmlt > control

> I have to say that using a parameter called "mods" in a function
> called parse_flags() is inconsistent and confusing.
>

does the above help ?
I could go with modifying_flags
keep in mind the name has to suit all + - = operations

I'll review all the new names. I recall you didnt like filterflags either,
so I wasnt sufficently clear there either.
Im mulling a better explanation.






> Best Regards,
> Petr
