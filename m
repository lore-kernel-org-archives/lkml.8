Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D386A206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p42wFVUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgHNOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgHNOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:18:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35FC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 07:18:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so8057177wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bfiTvnSbLLzZZvj+Mn4ylpurNrOXymT6DZIfnlv7XiA=;
        b=p42wFVUcVKu014Mhy9uhACdRHC5jy9uVKINioDebtvReEPqdZMzjXhnl3mEvKv0eT/
         XVRVTESOZtd9Vv3IuAinZiGvcAk/7PsKj9NR7dB+VYfB5GXIfaNiGa6F1OAzFUhNUcAQ
         Uz65kxFaHXRxP4eQ4XNuWvrTQIULuiRV0xT+PYSdKCukeKKgYmHjdMrUowjK9KhuZh7H
         mos4ncQ7btSiCiMPKCwTNnWj/rR0ekWaXObsDyojZiAtBD4R6r8TNw7PV2L5XEXi11+J
         1VoxwtOPDnMqCLyN1rt01thIRPQ8stN3RCgkc5N8DQVK+O9Msz6HCN//HPQ1EM14aODx
         gNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bfiTvnSbLLzZZvj+Mn4ylpurNrOXymT6DZIfnlv7XiA=;
        b=m7DrXJhV4Jo6N88U9aIwKw9Cj3M6ZfRC6YIZxyHBTQYQbgPu10+HsXeGIXXEvxOm1+
         ZLXmryZdZrq6gtovQiXWlZQhyEjKUXvexFxGIUy1jj9FrsoezDgZKD2ErAUSVLeqhyRv
         oi85dVmbPLH4NN/811jqgsNwojn0CetXTOep3SFxra9VAcP1Dgzp5dU2xjuqbxN04Xes
         bXREty2eymLC5509xBfHIHp2ZG5jALBDNyXPMVRF62VXbgjk48day9Mwjmj0QYNAfgEU
         uQ/Lqg/ke35TPdggXOH7toxcDQ/y6YLrh4nXC15yCAMmJSNthRdQ34mpBGRzbltmDIWX
         tV9g==
X-Gm-Message-State: AOAM531lyOBeZGWZqKJ1zzEYZZKp+ptF7swKVhsKDnJH4fiKB3IQO185
        XuXHvNU3r9wx5iIdUcGq/YMxHw==
X-Google-Smtp-Source: ABdhPJz1PenZIWlEwrjEEwQBMvLPskgCjlbD5qrmUvskmXCypEjlTaRErSq72jWhOVBWqTy9uvsW5g==
X-Received: by 2002:a05:600c:25cc:: with SMTP id 12mr2720135wml.120.1597414705416;
        Fri, 14 Aug 2020 07:18:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o2sm15227863wrj.21.2020.08.14.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:18:24 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:18:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
Message-ID: <20200814141822.opahh33nfc5yodkb@holly.lan>
References: <20200811135801.GA416071@kroah.com>
 <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com>
 <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
 <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
 <20200813101703.566thqmnc2d7cb3n@holly.lan>
 <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPd-fcDkYNk1KrjYwD=FH3FBvjDGEoxCBBN9CRidoVXbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 05:36:36PM +0530, Sumit Garg wrote:
> On Thu, 13 Aug 2020 at 15:47, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Aug 13, 2020 at 02:55:12PM +0530, Sumit Garg wrote:
> > > On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
> > > > On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> > > > > One
> > > > > last worry is that I assume that most people testing (and even
> > > > > automated testing labs) will either always enable NMI or won't enable
> > > > > NMI.  That means that everyone will be only testing one codepath or
> > > > > the other and (given the complexity) the non-tested codepath will
> > > > > break.
> > > > >
> > >
> > > The current patch-set only makes this NMI to work when debugger (kgdb)
> > > is enabled which I think is mostly suitable for development
> > > environments. So most people testing will involve existing IRQ mode
> > > only.
> > >
> > > However, it's very much possible to make NMI mode as default for a
> > > particular serial driver if the underlying irqchip supports it but it
> > > depends if we really see any production level usage of NMI debug
> > > feature.
> >
> > The effect of this patch is not to make kgdb work from NMI it is to make
> > (some) SysRqs work from NMI. I think that only allowing it to deploy for
> > kgdb users is a mistake.
> >
> > Having it deploy automatically for kgdb users might be OK but it seems
> > sensible to make this feature available for other users too.
> 
> I think I wasn't clear enough in my prior reply. Actually I meant to
> say that this patch-set enables NMI support for a particular serial
> driver via ".poll_init()" interface and the only current user of that
> interface is kgdb.
> 
> So if there are other users interested in this feature, they can use
> ".poll_init()" interface as well to enable it.

Huh?

We appear to speaking interchangably about users (people who sit in
front of the machine and want a stack trace) and sub-systems ;-).

I don't think other SysRq commands have quite such a direct relationship
between the sub-system and the sysrq command. For example who are you
expecting to call .poll_init() if a user wants to use the SysRq to
provoke a stack trace?


Daniel.
