Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2662072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdKggnTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHQFNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHQFM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:12:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C5C061389
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:12:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m15so7696649lfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wbtEbHtU9M4Jod/JrcC7BZqQ8yoT12QXGXyBKx7JXA=;
        b=AdKggnTL3w6eZGHsRkx/100sgIDTgVVJxjW/eLCKNep4uW4Yl3iMpb4KJ/hcYsaTMx
         wP8SFf2QchKBG7PVGLeRaaVoNVzX1/pwr8T4EVeDUQhCo14ZxN8K2MYSOWOlZzFkEP5M
         Ciq0EA/yuDtUAFgNLJJGqxOJZhwMMqQoYlYyHZZb4R7DlqeXWidG15ku96JwrEUYkecI
         8V6nyYxnw1wRy+xl1yfpgjlbh7n23OlsCIBXBzIFKFF4pVNcWMD2+SmoShkRxWfhxW2U
         fzykn0JV7r4VvJ1UM79GY/+iTN3SMoxwqLsYQmQmfutFRaxf0iASb0eXZ3RO9itt5p3T
         S8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wbtEbHtU9M4Jod/JrcC7BZqQ8yoT12QXGXyBKx7JXA=;
        b=VyNe8jW5Tkd9KNxwOfD1MMYf9eHi48/+GOLNx5HYjh9EaHSg6NQlqzQjiIeMFz8Kgl
         ZdVO9R6F2mjAf3yz8Bc6Lp6sLl3oc16jJopLd5dK/0Dq2DzcovHLU6ecvwQCuc8+y/xL
         y4420ATOR+BplkXaKtHz1yjPQYm+Jhe+FYwZIi9kQZhGko78joWw0CZEY7T/RthyMAXv
         oIge+T47efVi0jXaW29eM/3EWi75lmK+EmGnP6CQK7jXxUM13Wam8rNHrfptB1AjAzB6
         PLPMNGrSnx3fGASzWbbPayj+7x+TxVcsuTV7tNQ6jYfNtBhRPIOEXKMJ6l/zVUw7Itlr
         OIvg==
X-Gm-Message-State: AOAM530dOkHBNcKothz3Lv1Dt/52nPYbcLNqsRaizuQnLUiBfCgrVicC
        2/6761/Xw7JuUgEYq5eeQKZeh40ZRgnQhZDFPxH5tw==
X-Google-Smtp-Source: ABdhPJx5Xf4vEf6FrlCe2817ep57MgRm1K5c+hgJrods56LEUJS2xB8Xl7414M0vSYBeVkIvAAnFai/v6XBsFEsLoD4=
X-Received: by 2002:a19:8705:: with SMTP id j5mr6468504lfd.122.1597641177454;
 Sun, 16 Aug 2020 22:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
 <20200813101703.566thqmnc2d7cb3n@holly.lan> <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
 <20200814141822.opahh33nfc5yodkb@holly.lan>
In-Reply-To: <20200814141822.opahh33nfc5yodkb@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 17 Aug 2020 10:42:43 +0530
Message-ID: <CAFA6WYO3YmgCftr-hFdiHGHATeox9en_HZvgnAL=zhoa=OEi_w@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 at 19:48, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Aug 14, 2020 at 05:36:36PM +0530, Sumit Garg wrote:
> > On Thu, 13 Aug 2020 at 15:47, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> > > > On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > > > > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > > > One
> > > > > > last worry is that I assume that most people testing (and even
> > > > > > automated testing labs) will either always enable NMI or won't enable
> > > > > > NMI.  That means that everyone will be only testing one codepath or
> > > > > > the other and (given the complexity) the non-tested codepath will
> > > > > > break.
> > > > > >
> > > >
> > > > The current patch-set only makes this NMI to work when debugger (kgdb)
> > > > is enabled which I think is mostly suitable for development
> > > > environments. So most people testing will involve existing IRQ mode
> > > > only.
> > > >
> > > > However, it's very much possible to make NMI mode as default for a
> > > > particular serial driver if the underlying irqchip supports it but it
> > > > depends if we really see any production level usage of NMI debug
> > > > feature.
> > >
> > > The effect of this patch is not to make kgdb work from NMI it is to make
> > > (some) SysRqs work from NMI. I think that only allowing it to deploy for
> > > kgdb users is a mistake.
> > >
> > > Having it deploy automatically for kgdb users might be OK but it seems
> > > sensible to make this feature available for other users too.
> >
> > I think I wasn't clear enough in my prior reply. Actually I meant to
> > say that this patch-set enables NMI support for a particular serial
> > driver via ".poll_init()" interface and the only current user of that
> > interface is kgdb.
> >
> > So if there are other users interested in this feature, they can use
> > ".poll_init()" interface as well to enable it.
>
> Huh?
>
> We appear to speaking interchangably about users (people who sit in
> front of the machine and want a stack trace) and sub-systems ;-).
>
> I don't think other SysRq commands have quite such a direct relationship
> between the sub-system and the sysrq command. For example who are you
> expecting to call .poll_init() if a user wants to use the SysRq to
> provoke a stack trace?
>

Ah, I see. So you meant to provide a user-space interface to
dynamically enable/disable NMI debug, correct? It will require IRQ <->
NMI switching at runtime which should be doable safely.

-Sumit

>
> Daniel.
