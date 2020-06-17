Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41ED421548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKgCZEiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFQW6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:58:12 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB21C06174E;
        Wed, 17 Jun 2020 15:58:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 190so2402456vsr.9;
        Wed, 17 Jun 2020 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BG8boI9i4hvxy73OVw5syqVlITws7pDbDreExM7+Kyo=;
        b=ZKgCZEiHMPZlSK79v7B/RMDzy040q5vp1nhxswINjnkURubO6rXmOwwemoApYwNZaK
         EsPjIxaS1G4sh/02VtRKbMjPNMsqgcw1+An/4Z+1uXqBAUUMngu08xFDx0sfygVM01l1
         VcDM9N9GJPiH/v5WRXOg9vXZuLg5mnU43Es+LZhzbUjDg51T36H9eSfSj8JqmZeWSU2N
         VD//N4VedeVYvtuzoAJsHv8a5K9mRXZ1tCrzzrCz1Bxib5rQXS0nhgtsNmol+NJDXe87
         3G+bC5FD6szi4kWfpSdMvV+W3cfUYVRLhW/5ULXvTeXgzKA6HD+5tmlI2ch7VQDYYRMy
         sW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BG8boI9i4hvxy73OVw5syqVlITws7pDbDreExM7+Kyo=;
        b=IUDHtLZgSeW5MaL459VKysrEt47j6uj5NpguMSuOhkikvKWgBgAobF8+33PPPttLsY
         174XjoPl7mUa/FKQsZrblM98paZpJEr3+WsUpISL4jiYKmOakfsN/9wm8xV4OHLBbdoG
         Tt/kqbbiT76ZD9FyzmavGlPgDYVeb4ltw434cZlbGgiEWP7JIZqyfOTx3Jt6NLWhprXm
         cSdU4BScGEH7TOsqtgyVB5MrnsPdDKn4PnVzXAaGSnTpGLEnap5lKWiTngs2OslJU9SL
         I1qDVqq5S3tJbqootmeRVWEVm2TB3bsVcFTQ/r3Jh+SK8VU4LI3eJmHloJQ34d/JyIf5
         4KTg==
X-Gm-Message-State: AOAM532C4VWddImH9xOC1QAqi/+0wIWwdJMGGv9MDwdUi9Pn12/oBSkA
        dDu8qYqgUEzZUwBX16oeeNNVPry2ilcwXNYXETvqRwNy
X-Google-Smtp-Source: ABdhPJyTTrUyU+lUfy7Sq7wK2lb3CJJlPFJQKtPnu5d8YcLZ8fbmu955dgpPrZaGeqJixmn5TDBsbtARuet4ERxgAL4=
X-Received: by 2002:a67:fc17:: with SMTP id o23mr1342081vsq.92.1592434691199;
 Wed, 17 Jun 2020 15:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-23-jim.cromie@gmail.com>
 <dddfef643fc5bef1ff440f18c3dd12f586195a7c.camel@perches.com>
In-Reply-To: <dddfef643fc5bef1ff440f18c3dd12f586195a7c.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Wed, 17 Jun 2020 16:57:45 -0600
Message-ID: <CAJfuBxzG_VkZ_g1c7E1z-fGyeg_Q0ngWRazLF2PDy9Nb0U4HzA@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Joe Perches <joe@perches.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 4:13 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-06-17 at 10:25 -0600, Jim Cromie wrote:
> > 1. Add a user-flag [u] which works like the [pfmlt] flags, but has no
> > effect on callsite behavior; it allows incremental marking of
> > arbitrary sets of callsites.
> >
> > 2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
> > And in ddebug_read_flags():
> >    current code does: [pfmltu_] -> flags
> >    copy it to:                [PFMLTU_] -> mask
> >
> > also disallow both of a pair: ie no 'pP', no true & false.
> >
> > 3. Add filtering ops into ddebug_change(), right after all the
> > callsite-property selections are complete.  These filter on the
> > callsite's current flagstate before applying modflags.
> >
> > Why ?
> >
> > The u-flag & filter flags
> >
> > The 'u' flag lets the user assemble an arbitary set of callsites.
> > Then using filter flags, user can activate the 'u' callsite set.
> >
> >   #> echo 'file foo.c +u; file bar.c +u' > control   # and repeat
> >   #> echo 'u+p' > control
> >
> > Of course, you can continue to just activate your set without ever
> > marking it 1st, but you could trivially add the markup as you go, then
> > be able to use it as a constraint later, to undo or modify your set.
>
> Does this set selection also allow for selection by
> increasing decimal level?
>
> Can sites be enabled for a value less than x?
>
>

no, theres no levels added here.
that would be a variation on the WIP pr-class patch in v2, dropped from v3

legacy dyndbg - select on RO callsite info only - file, module, func, line.
    flag state is write only.
filterflags -   additionally select on callsite's flagstate, ie
reading the current flagstate

please look at the export patch 15/21
for how I now think levels, and drm.debug=0x03 can be done.
