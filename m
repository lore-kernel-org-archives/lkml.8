Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B220732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSW97pG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgFVSUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgFVSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:20:05 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:20:04 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v25so5947221uau.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOfB1nD8xx8DwSEkMEHETyPoMUDPxJH6rW8d8vmvj7g=;
        b=QSW97pG8vKEMRrIFP/MZcbLbVB5ajm7JcOiFU2DS8RJcn9p4CptzJ/k4gUbnhVRAfC
         YQPpcIqrU2BrEkoj3Mp+vOAH8UvXUWNhOoP5ACUXjjC6ZVNUL/MAAYQ9QjAOMlzqxDR2
         iFYofoSYZmF6XI8uMpd5iH9mUYhm0/0uuKNRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOfB1nD8xx8DwSEkMEHETyPoMUDPxJH6rW8d8vmvj7g=;
        b=sKoQ9G7uIUv8gGE+lPHkS/ZCV/fDDadTr/hqE+PBmJuLdO/aTXgZgAWOwopj5azd3A
         cWlXNGKZ/J43KVBBDfl4rWP8IR5GpG5O6NbbQ7hWkmUGGeuHoGo8xPyIg5Xk1ReaBkE9
         LdZGtDZfkLgnZULpDVFJ5CqYkJdfZEjIJdZEovq+CdDSgXAJPu/pSpSCw/eLEkMChVeZ
         YzIthWgHDBqu3iDOXm5yRFiJspjQYbRRp4vYf6R22H167bukfcbisu8OlZqyCH7u/7/J
         ZxGDHgoopYP0tFrq13KIkQ9H6bBm9peP4KqvaqTov7A2+geppTKbG5iFp8n0EifXDx+P
         gH+w==
X-Gm-Message-State: AOAM530m5lCqE4CoVghRwwMOLsPXJ8h+W6QtB1nEqolDvTILqlaPwxKI
        LxJdpLJROpMG9MzQiQQrlS66BOlsVjw=
X-Google-Smtp-Source: ABdhPJyt9NUz7yI7/BFh00AlXMm/hg65uAZu9cOr3rKWTV2Jq0sWuZjwrvWKMOrw7lpXNdvGhpH4rQ==
X-Received: by 2002:ab0:21c5:: with SMTP id u5mr12393355uan.101.1592850003522;
        Mon, 22 Jun 2020 11:20:03 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id k23sm1156724vkn.24.2020.06.22.11.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 11:20:02 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id i8so5939430uak.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:20:02 -0700 (PDT)
X-Received: by 2002:ab0:7488:: with SMTP id n8mr12114670uap.8.1592850001793;
 Mon, 22 Jun 2020 11:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com> <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com> <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
 <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com> <20200619153146.vaizbj7muy52zvbd@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200619153146.vaizbj7muy52zvbd@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jun 2020 11:19:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0YCS69uErFnY-cF_v44mDfAe4AWa+K+U6mQR+TNLkww@mail.gmail.com>
Message-ID: <CAD=FV=V0YCS69uErFnY-cF_v44mDfAe4AWa+K+U6mQR+TNLkww@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 19, 2020 at 8:31 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Doug,
>
> On 06/18/20 14:31, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 12, 2020 at 5:34 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 06/12/20 10:24, Quentin Perret wrote:
> > > > +CC Qais [FYI]
> > >
> > > Thanks for the CC.
> > >
> > > >
> > > > On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> > > > > Hrm.  I guess my first instinct is to say that we still want this
> > > > > patch even if we have something that is applied more globally.
> > > >
> > > > Fair enough.
> > > >
> > > > > Specifically it sounds as if the patch you point at is suggesting that
> > > > > we'd tweak the boost value to something other than max but we'd still
> > > > > have a boost value.  In the case of cros_ec_spi I don't believe we
> > > > > need any boost value at all, so my patch would still be useful.  The
> > > > > computational needs of cros_ec_spi are very modest and it can do its
> > > > > work at lower CPU frequencies just fine.  It just can't be interrupted
> > > > > for large swaths of time.
> > > > >
> > > > >
> > > > > > IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?
> > > > >
> > > > > I'm not totally a fan, but I'm definitely not an expert in this area
> > > > > (I've also only read the patch description and not the patch or the
> > > > > whole thread).  I really don't want yet another value that I need to
> > > > > tune from board to board.  Even worse, this tuning value isn't
> > > > > board-specific but a combination of board and software specific.  By
> > > > > this, I'd imagine a scenario where you're using a real-time task to
> > > > > get audio decoding done within a certain latency.  I guess you'd tune
> > > > > this value to make sure that you can get all your audio decoding done
> > > > > in time but also not burn extra power.  Now, imagine that the OS
> > > > > upgrades and the audio task suddenly has to decode more complex
> > > > > streams.  You've got to go across all of your boards and re-tune every
> > > > > one?  ...or, nobody thinks about it and older boards start getting
> > > > > stuttery audio?  Perhaps the opposite happens and someone comes up
> > > > > with a newer lower-cpu-intensive codec and you could save power.
> > > > > Sounds like a bit of a nightmare.
> > >
> > > Generally I would expect this global tunable to be part of a vendor's SoC BSP.
> >
> > I think I'm coming at this from a very different world than the one
> > you're thinking of.  The concept of a BSP makes me think of a SoC
> > vendor providing a drop of Linux with all their own weird hacks in it
> > that only ever works on that one SoC and will never, ever, ever be
> > updated.  5 years down the road if a software update is needed
> > (security fix?) some poor soul will be in charge of tracking down the
> > exact ancient code base that was used to build the original kernel,
> > making the tweak, and building a new kernel.  ;-)
> >
> > In the world of Chrome OS we try very very hard to build everything
> > from a clean code base and are trying hard to stay even closer to
> > upstream and away from per-device weirdness...
>
> Hmm I thought OEMs who ship stuff that are based on Chrome OS would have to do
> the final tuning here, which would be based on the recommendation of the SoC
> vendor. And I'm being overly generic here to think not only SoC from Intel
> which traditionally they have been treated in different ways.
>
> I think you provide a generic stack for OEMs, no?

No, that's the Android way.  The only way Chrome OS can ship updates
for the whole fleet every ~6 weeks and support it for so many years is
that all the builds and updates happen on Google servers.  The only
way Google can maintain this is to not have a separate kernel code
base for every single variant of every single board.


> Generally for RT tasks, Linux always required an admin to do the tuning. And to
> provide an automatic solution that fits all is not easy to happen, because what
> ultimately is important for userspace, is only known by the userspace.
>
> This is an interesting problem for me personally that I have been trying to
> look at in my free time. On general purpose systems, it's hard to reason about
> what's important because, as you say, you distribute something that should
> target a wide range of platforms. And sometimes the end user (like a person
> installing Ubuntu Desktop on their laptop), have no clue what a driver is even
> to pick the right tuning for all RT tasks in their system.
>
> But this problem already exists and catching up with this will need more work
> from both distros and maybe kernel. I can't see a possible situation where the
> kernel can do all the tuning without userspace providing more info anyway.
>
> The per-device weirdness you're talking about is just how the way goes in
> a world where there are many SoCs that are created to target different budgets
> and use cases.

I think it's sane for the OS to do very high level tuning, like "this
platform has an underpowered CPU and being fast is more important than
battery life, so error on the side of running fast" or "this platform
has a fast SSD so tune disk algorithms appropriately".  ...but picking
specific values gets tricky.


> So I don't see the 2 worlds (laptops/mobile) really different, they just
> traditionally started differently where such variations in SoC didn't exist
> that much. But there are more Arm based SoCs that are targetting laptop markets
> now.. So you never know when they will be dealing with the same variations the
> mobile world sees today.

The slowest laptop we currently support is a Quad-core A17 running at
~1.8 GHz.  On that CPU the cros_ec thread needs to be realtime (so it
doesn't get interrupted) but doesn't need any particular CPU speed.

That being said, that does remind me that on that laptop we did give
up and end up with a hack to set a minimum CPU speed when USB audio
was happening.  That CPU has dwc2 for its USB controller and it's
utterly important to service interrupts in < 125 us when USB audio is
going on.  So in that case, yes, I was forced to do tuning and pick a
specific value.


> > > People tend to think of the flagship SoCs which are powerful, but if you
> > > consider the low and medium end devices there's a massive spectrum over there
> > > that this range is trying to cover.
> >
> > Yeah, perhaps you're right.  When thinking about a laptop it's almost
> > always a fairly powerful device and things could certainly be
> > different for very low end chips trying to run Linux.
>
> I think there are low end laptops in the market that barely have enough grunt
> to do work. So not all laptops are fairly powerful.
>
> >
> >
> > > I would expect older boards init script to be separate for newer boards init
> > > script. The OS by default boosts all RT tasks unless a platform specific script
> > > overrides that. So I can't see how an OS upgrade would affect older boards.
> >
> > In the Chrome OS world I'm part of, the people supporting the boards
> > are not always the people adding new whizbang features.  We get new
> > versions of the OS every 6 weeks and those new versions may change the
> > way things work pretty significantly.  We ship those new versions off
> > to all boards.  Certainly they undergo testing, but there are a lot of
> > boards and if something is not tuned as well as it was when the device
> > first shipped it's likely nobody will really notice.  This is my bias
> > against needing per-board tuning.
>
> Apologies for my lack knowledge about the exact process in Chrome OS. In my
> head, I think what you do is like what Android and other distros do. Provide
> a software stack that can be used on any platform. On Android OEMs do have to
> do the tuning (with a help from SoC vendor usually). Not many laptops ship with
> Linux as their default OS, but this is an increasing trend and LWN did write
> something recently about the demand is increasing for Linux based laptops.
>
>
> I thought Chrome OS is the same, where an OEM will take your deliverables and
> do the final integration.
>
> So I agree at your level it might be hard to reason about the full spectrum.
> But I thought the OEMs that wants to ship Chrome OS will need to look at init
> scripts, drivers etc to ensure their laptop is competitive.
>
> >
> >
> > > This knob still allows you to disable the max boosting and use the per-task
> > > uclamp interface to boost only those tasks you care about. AFAIK this is
> > > already done in a hacky way in android devices via special vendors provisions.
> >
> > Yeah.  I don't think I have enough skin in the game to really say one
> > way or the other what the API should be so I'll probably stay off the
> > other, bigger thread and let others decide what the best API should
> > be.  For Chrome OS I'd probably advocate just disabling the default
> > boost but even there I'd be willing to defer to the folks doing the
> > actual work.
>
> Yes I appreciate the challenges you have. I think for most users disabling is
> good enough for them as RT tasks could end up causing a lot of power to be
> wasted unnecessarily. But if someone wants to take the extra mile and squeeze
> the best compromise, they can :)

Yeah, thinking about the USB audio hack we ended up with makes me
understand that sometimes on lower-end systems you are forced to do
tuning even if it's annoying.

-Doug
