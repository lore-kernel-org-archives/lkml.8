Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B132AC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B70E2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AAfF9D4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFKNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:13:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51846 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgCFKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:13:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id a132so1727311wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vDIlGX0meuTJ9u7QAn+s4nQf3ELnqI9FgEEknuOygI=;
        b=AAfF9D4sZdaDyHWigxkTcwEDeh5nBGLUDWGgd5LZtuAzONxa2cPUAHBORz22PRi9lz
         Pl3EcbK0XCqqaO2WaOwCIqPFhQ07s9kLBSdp/V4UP4Xu6nzdPF7txuYTxYXhFyPwwxDJ
         8ay6PSuPsESmDluAoK+L41ohhu0BOEi+SKVh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/vDIlGX0meuTJ9u7QAn+s4nQf3ELnqI9FgEEknuOygI=;
        b=HZgIJJaHu22+n+NBrIKihlleanaTm4Zn5jmCszVEJhw3p2NpU+Xdsl4C3UxyMJJJ2/
         0YEabz9w38BRUrgPE+nrkVyywdEvsgyzvukOhNoSryTFxkRyKgnArF3rws4Wubui8b11
         AQonQw/fDVYZMhGQztwPC85XS4KAIMVxzrl2hiXlqFJDXWF80DIYDMbmGFXRDTPbY2Ue
         zyu04zMbdXjwm4yQiRe8dFWcMlAtO986PAROFh38P97vt4aFKSlfOUkLvhoOf46gzC8q
         /bRlZP0hlK76szw+nJlrrdFdwhvWWhK/aFOw75M4gmt9+YS5GoKqsVT+o5FGHUDOsfvG
         B+PQ==
X-Gm-Message-State: ANhLgQ3QBvNH3aivM8pyaYvKInWC8A2Vc6EKo57Cx9b6pZuTpEfq9cxI
        fQevwZPyACQFmPGB2yVfzVMRBg==
X-Google-Smtp-Source: ADFU+vt7yOW1im8q9ywyGWVPyTSOpVuRYwEPRoCyv4+cUol7N1/VZo0VFbhdrlnn8cytwSvI5VFNdA==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr3334559wmy.104.1583489611295;
        Fri, 06 Mar 2020 02:13:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 19sm14643940wma.3.2020.03.06.02.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:13:30 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:13:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Starkey <brian.starkey@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifier definitions for describing
 Amlogic Video Framebuffer Compression
Message-ID: <20200306101328.GR2363188@phenom.ffwll.local>
Mail-Followup-To: Pekka Paalanen <ppaalanen@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200221090845.7397-1-narmstrong@baylibre.com>
 <20200221090845.7397-2-narmstrong@baylibre.com>
 <20200303121029.5532669d@eldfell.localdomain>
 <20200303105325.bn4sob6yrdf5mwrh@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uFgQGrnEkXyac15Wz8Opg43RTa=5cX0nN5=E_omb8oY8Q@mail.gmail.com>
 <20200303152541.68ab6f3d@eldfell.localdomain>
 <20200303173332.1c6daa09@eldfell.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303173332.1c6daa09@eldfell.localdomain>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 05:33:32PM +0200, Pekka Paalanen wrote:
> On Tue, 3 Mar 2020 15:25:41 +0200
> Pekka Paalanen <ppaalanen@gmail.com> wrote:
> 
> > On Tue, 3 Mar 2020 12:37:16 +0100
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> > 
> > > On Tue, Mar 3, 2020 at 11:53 AM Brian Starkey <brian.starkey@arm.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Mar 03, 2020 at 12:10:29PM +0200, Pekka Paalanen wrote:    
> > > > > On Fri, 21 Feb 2020 10:08:42 +0100
> > > > > Neil Armstrong <narmstrong@baylibre.com> wrote:
> > > > >    
> ...
> > > > > > +/*
> > > > > > + * Amlogic Video Framebuffer Compression modifiers
> > > > > > + *
> > > > > > + * Amlogic uses a proprietary lossless image compression protocol and format
> > > > > > + * for their hardware video codec accelerators, either video decoders or
> > > > > > + * video input encoders.
> > > > > > + *
> > > > > > + * It considerably reduces memory bandwidth while writing and reading
> > > > > > + * frames in memory.
> > > > > > + * Implementation details may be platform and SoC specific, and shared
> > > > > > + * between the producer and the decoder on the same platform.    
> > > > >
> > > > > Hi,
> > > > >
> > > > > after a lengthy IRC discussion on #dri-devel, this "may be platform and
> > > > > SoC specific" is a problem.
> > > > >
> > > > > It can be an issue in two ways:
> > > > >
> > > > > - If something in the data acts like a sub-modifier, then advertising
> > > > >   support for one modifier does not really tell if the data layout is
> > > > >   supported or not.
> > > > >
> > > > > - If you need to know the platform and/or SoC to be able to interpret
> > > > >   the data, it means the modifier is ill-defined and cannot be used in
> > > > >   inter-machine communication (e.g. Pipewire).
> > > > >    
> > > >
> > > > Playing devil's advocate, the comment sounds similar to
> > > > I915_FORMAT_MOD_{X,Y}_TILED:
> > > >
> > > >  * This format is highly platforms specific and not useful for cross-driver
> > > >  * sharing. It exists since on a given platform it does uniquely identify the
> > > >  * layout in a simple way for i915-specific userspace.    
> > > 
> > > Yeah which we regret now. We need to now roll out a new set of
> > > modifiers for at least some of the differences in these on the
> > > modern-ish chips (the old crap is pretty much lost cause anyway).
> > > 
> > > This was kinda a nasty hack to smooth things over since we have epic
> > > amounts of userspace, but it's really not a great idea (and no one
> > > else really has epic amounts of existing userspace that uses tiling
> > > flags everywhere, this is all new code).
> > > -Daniel
> > >   
> > > > Isn't the statement that this for sharing between producer and decoder
> > > > _on the same platform_ a similar clause with the same effect?
> > > >
> > > > What advantage is there to exposing the gory details? For Arm AFBC
> > > > it's necessary because IP on the SoC can be (likely to be) from
> > > > different vendors with different capabilities.
> > > >
> > > > If this is only for talking between Amlogic IP on the same SoC, and
> > > > those devices support all the same "flavours", I don't see what is
> > > > gained by making userspace care about internals.    
> > > 
> > > The trouble is if you mix&match IP cores, and one of them supports
> > > flavours A, B, C and the other C, D, E. But all you have is a single
> > > magic modifier for "whatever the flavour is that soc prefers". So
> > > someone gets to stuff this in DT.
> > > 
> > > Also eventually, maybe, perhaps ARM does grow up into the
> > > client/server space with add-on pcie graphics, and at least for client
> > > you very often end up with integrated + add-in pcie gpu. At that point
> > > you really can't have magic per-soc modifiers anymore.  
> > 
> > Hi,
> > 
> > I also heard that Pipewire will copy buffers and modifiers verbatim
> > from one machine to another when streaming across network, assuming
> > that the same modifier means the same thing on all machines.[Citation needed]
> > 
> > If that is something that must not be done with DRM modifiers, then
> > please contact them and document that.
> 
> Sorry, it's waypipe, not pipewire:
> https://gitlab.freedesktop.org/mstoeckl/waypipe/

I do think this is very much something we want to make possible. They
might pick a silly modifier (compression modifiers only compress bw, by
necessity the lossless ones have to increase storage space so kinda dumb
thing to push over the network if you don't add .xz or whatever on top).

I'm also hoping that intel's modifiers are definitely the one and only
that we ever screwed up, and we should be getting those fixed in the near
future too.

So maybe what we should do instead is add a comment to the modifier docs
that this stuff _is_ supposed to be transferrable over networks and work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
