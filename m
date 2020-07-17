Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA832176B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoSWTAR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGQC4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgGQC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:56:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E834CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:56:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so4671597pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycpeByrSD5RMyRdQnWJnhFE9I3WTCAfCVd56pWwRo2Y=;
        b=SoSWTAR3KiMn2Ekxl7uSMerfvwgkPm3vkEWo+GJ1sGrExI6n6+bk7LqAwVV8dqL57e
         vXaPsLbI71c9U9PvPfnrc99Gk16289V4eqM19I0hyxAK/fY1KIygwfKYsbug9kjWdvpJ
         G+NOeI+TMBCMz32bwRP88aovy0Pz135eWKBPofhbGNdP+5bJjurnrmdClaNMxHKJBpz7
         wjdT876Gnccsj1MqHcgKI59UC5TV9TMpq0QOFBtQ8Dsxc0lVX/GyiYeQ7nvxHtBZpZZ7
         vWADfeQKLDDL7+RzgKwC3TCjywp6rKmxPWoL6C9kXAg1GFZJ3huWdMoqf934y8K4NwA2
         jFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycpeByrSD5RMyRdQnWJnhFE9I3WTCAfCVd56pWwRo2Y=;
        b=ATa6o4XVKUMrEr9JFxwxQMA3j7XvJ2Dy5dHb+RAb6QYZkNbq7csPHxSewpmz/4TMyl
         RY5ckEMSjbcNi88s/8VOpwVdG7kkQSUgX8EyAGe5lx39OvJdkw4lVxEw1ADsf+HVuuq+
         Tqh3CgzMFrFuK6LQh2Y1HbKDKfqkfMxFCSwDyMkOr/kvPaD2DEFbwLt7vS7tYdvxIZQX
         yOEAEoeyerzQMUCR3p1tgnsY3NxSsx8RSdV2Ss3gSeiUOcKTap8MO2pOIDx7ZI9QgvWJ
         Cfs6UhwSY/A0HiPXPB/aBP1HoZzPLCe6+Ok4k4Z5BU8Do42WxPGuk0J/GF2/3BZs4ATF
         1v6w==
X-Gm-Message-State: AOAM532yl0wnpZzc8eop92/rX9+B3KpNVoxyg1Cc1AOIvSMTlGUxY7xN
        +hP6nc5iuOU127Ddy4H0rHPTy4LPsWpSbI8kI1Ej2cxA8zQ=
X-Google-Smtp-Source: ABdhPJzxlbwKW0xJZyoE1jcHXCzjv18wNr9b8lRvvqkLTEXcLUnV2xUMcLcT8FlRoDcERASnQT+eLhFCH9HXvw2R4GM=
X-Received: by 2002:a62:8c54:: with SMTP id m81mr6042843pfd.215.1594954562969;
 Thu, 16 Jul 2020 19:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200411045918.179455-1-saravanak@google.com> <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
 <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
 <20200429102832.4eee22b4@why> <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
 <5b605bd46d3ef213c7ec82d02967e4bb@kernel.org> <CAGETcx9kYKOEAmLbJzmOucR2Z4qy9PCY2=UCYdYTJWTL=BeZNQ@mail.gmail.com>
 <d17908a4313ed0f5ccfa8265611738b2@kernel.org>
In-Reply-To: <d17908a4313ed0f5ccfa8265611738b2@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Jul 2020 19:55:26 -0700
Message-ID: <CAGETcx_SYJey=a3T_PtDJ_R2KwV=vEqNMBiKeJT5W382LNb=ew@mail.gmail.com>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 3:12 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Saravana,
>
> On 2020-05-01 21:23, Saravana Kannan wrote:
> > On Fri, May 1, 2020 at 1:48 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-04-29 20:04, Saravana Kannan wrote:
> >> > On Wed, Apr 29, 2020 at 2:28 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> [...]
> >>
> >> >> One thing though: this seems to be exclusively DT driven. Have you
> >> >> looked into how that would look like for other firmware types such as
> >> >> ACPI?
> >> >
> >> > I'm not very familiar with ACPI at all. I've just started to learn
> >> > about how it works in the past few months poking at code when I have
> >> > some time. So I haven't tried to get this to work with ACPI nor do I
> >> > think I'll be able to do that anytime in the near future. I hope that
> >> > doesn't block this from being used for DT based platforms.
> >>
> >> As long as you don't try to modularise a driver that does both DT and
> >> ACPI, you'll be safe. I'm also actively trying to discourage people
> >> from inventing custom irqchips on ACPI platforms (the spec almost
> >> forbids them, but not quite).
> >>
> >> >> Another thing is the handling of dependencies. Statically built
> >> >> irqchips are initialized in the right order based on the topology
> >> >> described in DT, and are initialized early enough that client devices
> >> >> will find their irqchip This doesn't work here, obviously.
> >> >
> >> > Yeah, I read that code thoroughly :)
> >> >
> >> >> How do you
> >> >> propose we handle these dependencies, both between irqchip drivers and
> >> >> client drivers?
> >> >
> >> > For client drivers, we don't need to do anything. The IRQ apis seem to
> >> > already handle -EPROBE_DEFER correctly in this case.
> >> >
> >> > For irqchip drivers, the easy answer can be: Load the IRQ modules
> >> > early if you make them modules.
> >>
> >> Uhuh. I'm afraid that's not a practical solution. We need to offer the
> >> same behaviour for both and not rely on the user to understand the
> >> topology of the SoC.
> >>
> >> > But in my case, I've been testing this with fw_devlink=on. The TL;DR
> >> > of "fw_devlink=on" in this context is that the IRQ devices will get
> >> > device links created based on "interrupt-parent" property. So, with
> >> > the magic of device links, these IRQ devices will probe in the right
> >> > topological order without any wasted deferred probe attempts. For
> >> > cases without fw_devlink=on, I think I can improve
> >> > platform_irqchip_probe() in my patch to check if the parent device has
> >> > probed and defer if it hasn't.
> >>
> >> Seems like an interesting option. Two things then:
> >>
> >> - Can we enforce the use of fw_devlink for modularized irqchips?
> >
> > fw_devlink doesn't have any config and it's a command line option. So
> > not sure how you can enforce that.
>
> By having a config option that forces it on if that option is selected
> by modular irqchips?

Hmmm... not a bad idea. I think this could be useful in general. I'll
look into that separately.

> More importantly, what is the drawback of having
> fw_devlink on at all times? It definitely looks like the best thing
> since sliced bread (with cheese), so what is the catch?

Lol, thanks for the compliment :) My goal is to eventually enable it by default.

But there are a few corner cases on some boards where the DT has a
cycle and if we just blindly create device links for those, some of
the devices will end up not probing. I've slowly been identifying
different corner cases and making sure we drop the "bad link" that's
causing a cycle so that all the devices still probe properly.
Hopefully I can enable it by default soon.

> >
> >> - For those irqchips that can be modularized, it is apparent that they
> >>    should have been written as platform devices the first place. Maybe
> >>    we should just do that (long term, though).
> >
> > I agree. If they can be platform devices, they should be. But when
> > those platform device drivers are built in, you'll either need:
> > 1) fw_devlink=on to enforce the topological init order
>
> That would have my preference, provided that there is no drawbacks.

Since this can't happen yet I went with option 2.

> > Or
> > 2) have a generic irqchip probe helper function that ensures that.
> > My patch with some additional checks added to platform_irqchip_probe()
> > can provide (2).
> >
> > In the short term, my patch series also makes it easier to convert
> > existing non-platform drivers into platform drivers.
> >
> > So if I fix up platform_irqchip_probe() to also do -EPROBE_DEFER to
> > enforce topology, will that make this patch acceptable?
>
> That'd be a lot better. We also need some guards for things that
> cannot be a driver (primary interrupt controllers don't have a struct
> device).

Just sent out v2 of this patch.
https://lore.kernel.org/lkml/20200717024447.3128361-1-saravanak@google.com/T/#u

-Saravana
