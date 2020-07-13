Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D63C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223782089D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jDDqNQnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGMXuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGMXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:50:22 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:50:21 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id m18so2804149vkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgQxQmARP/WE6n3KhyJoHJScnBfxrcZWoBTb7IbtaYk=;
        b=jDDqNQnukw3/jTvoDdQxsgPYnc09gQPyF5K0qy/UhVucw3DS9HxKg1SYyelotW/K45
         qOdrLfSboMjsvxgycfLXv3JBl7ukD1KxhYZmxYKsBHwjy1VHnLMuAyhSCnrgetyJ8AY4
         56EPZUh/dh58M0HU25ec9t3lMoR89BBrVJ2cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgQxQmARP/WE6n3KhyJoHJScnBfxrcZWoBTb7IbtaYk=;
        b=r9HbdvtIwcB8OX6Ja45Z6cYRAQkXKBWZ9TLyfc5Dp7agXULVj+vs/U8vcddD8HMLI1
         XQ0zF6YnP/ix1daf2rnTWlnL+yholC+L/Zr0ISNm/y2e1fsennipzECAPLgb4x7dkV3W
         IiZ1EASAmf8fS+8ZoEJHS3JUA2DWJG9JN/rwyB8wo60IEpROSJ/pRRtRREzPXv3NG+Hz
         NHyiD9Sn2gGF4oxcZs4r2acBNXIzJ/KaLG+rFlhVMO15OjEZjhFdhMca4GKxK8VAO+OW
         6DaGbsFBy+CJQmV0/xf0FRa2GbT2xc72hy8HJxwTYD3gm7mXly7DOQiAKwLmSxaahOXt
         SQEg==
X-Gm-Message-State: AOAM533NfUtp3OuzPzpr4G6wdeJ7dwhGxSAUqyXNgYVwpoR0WLZG5VaD
        6CPyWcsU5anaQWcZVPXegt0SkEvAjBg=
X-Google-Smtp-Source: ABdhPJzb6fEv+AKlZLY7qIpxokamgJsgRY/JQgvVBjHdZ5g87fSCJDa47VpQjg6rEzB6ySsIF4P+hg==
X-Received: by 2002:a1f:4d41:: with SMTP id a62mr1851884vkb.41.1594684220808;
        Mon, 13 Jul 2020 16:50:20 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id x201sm1956061vsc.27.2020.07.13.16.50.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 16:50:19 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id h18so4859966uao.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:50:18 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr1803461uav.0.1594684217995;
 Mon, 13 Jul 2020 16:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200710230224.2265647-1-dianders@chromium.org>
 <CAL_JsqKC5WtHb-coMCxMTDJ7CJcjVXcAxDT4J9N-Xyr=0uuURA@mail.gmail.com>
 <CAD=FV=XWKoTd_t2uRGpw3oa0Nij2EPeAJpOHhUipXFW07JN2qw@mail.gmail.com> <CAL_JsqLJM5nwNSdugMBLDVtjP97dikCm_AiHjnDs1jqBOFoaaQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLJM5nwNSdugMBLDVtjP97dikCm_AiHjnDs1jqBOFoaaQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 16:50:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UP0AHWr22U69TKcwwAefPCYMsfzymobczqmrdB6BOOhA@mail.gmail.com>
Message-ID: <CAD=FV=UP0AHWr22U69TKcwwAefPCYMsfzymobczqmrdB6BOOhA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/msm: Avoid possible infinite probe deferral and
 speed booting
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 13, 2020 at 1:25 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 9:08 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 13, 2020 at 7:11 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 5:02 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > I found that if I ever had a little mistake in my kernel config,
> > > > or device tree, or graphics driver that my system would sit in a loop
> > > > at bootup trying again and again and again.  An example log was:
> > >
> > > Why do we care about optimizing the error case?
> >
> > It actually results in a _fully_ infinite loop.  That is: if anything
> > small causes a component of DRM to fail to probe then the whole system
> > doesn't boot because it just loops trying to probe over and over
> > again.  The messages I put in the commit message are printed over and
> > over and over again.
>
> Sounds like a bug as that's not what should happen.
>
> If you defer during boot (initcalls), then you'll be on the deferred
> list until late_initcall and everything is retried. After
> late_initcall, only devices getting added should trigger probing. But
> maybe the adding and then removing a device is causing a re-trigger.

Right, I'm nearly certain that the adding and then removing is causing
a re-trigger.  I believe the loop would happen for any case where we
have a probe function that:

1. Adds devices.
2. After adding devices it decides that it needs to defer.
3. Removes the devices it added.
4. Return -EPROBE_DEFER from its probe function.

Specifically from what I know about how -EPROBE_DEFER works I'm not
sure how it wouldn't cause an infinite loop in that case.

Perhaps the missing part of my explanation, though, is why it never
gets out of this infinite loop.  In my case I purposely made the
bridge chip "ti-sn65dsi86.c" return an error (-EINVAL) in its probe
every time.  Obviously I wasn't going to get a display up like this,
but I just wanted to not loop forever at bootup.  I tracked down
exactly why we get an - EPROBE_DEFER over and over in this case.

You can see it in msm_dsi_host_register().  If some components haven't
shown up when that function runs it will _always_ return
-EPROBE_DEFER.

In my case, since I caused the bridge to fail to probe, those
components will _never_ show up.  That means that
msm_dsi_host_register() will _always_ return -EPROBE_DEFER.

I haven't dug through all the DRM code enough, but it doesn't
necessarily seem like the wrong behavior.  If the bridge driver or a
panel was a module then (presumably) they could show up later and so
it should be OK for it to defer, right?

So with all that, it doesn't really feel like this is a bug so much as
it's an unsupported use case.  The current deferral logic simply can't
handle the case we're throwing at it.  You cannot return -EPROBE_DEFER
if your probe function adds devices each time through the probe
function.

Assuming all the above makes sense, that means we're stuck with:

a) This patch series, which makes us not add devices.

b) Some other patch series which rearchitects the MSM graphics stack
to not return -EPROBE_DEFER in this case.

c) Smarten up the deferral system to somehow detect this loop.  I'm
really not sure how to do this.  You'd have to somehow know that you
keep adding the same devices over and over again and they didn't get
us out of the deferral loop last time and so you should eventually
give up.


> > > >   msm ae00000.mdss: bound ae01000.mdp (ops 0xffffffe596e951f8)
> > > >   msm_dsi ae94000.dsi: ae94000.dsi supply gdsc not found, using dummy regulator
> > > >   msm_dsi_manager_register: failed to register mipi dsi host for DSI 0
> > > >   [drm:ti_sn_bridge_probe] *ERROR* could not find any panel node
> > > >   ...
> > > >
> > > > I finally tracked it down where this was happening:
> > > >   - msm_pdev_probe() is called.
> > > >   - msm_pdev_probe() registers drivers.  Registering drivers kicks
> > > >     off processing of probe deferrals.
> > > >   - component_master_add_with_match() could return -EPROBE_DEFER.
> > > >     making msm_pdev_probe() return -EPROBE_DEFER.
> > > >   - When msm_pdev_probe() returned the processing of probe deferrals
> > > >     happens.
> > > >   - Loop back to the start.
> > > >
> > > > It looks like we can fix this by marking "mdss" as a "simple-bus".
> > > > I have no idea if people consider this the right thing to do or a
> > > > hack.  Hopefully it's the right thing to do.  :-)
> > >
> > > It's a simple test. Do the child devices have any dependency on the
> > > parent to probe and/or function? If so, not a simple-bus.
> >
> > Great!  You can see in the earlier patch in the series that the very
> > first thing that happens when the parent device probes is that it
> > calls devm_of_platform_populate().  That means no dependencies, right?
>
> It should. But then I reviewed the MDSS binding today and it looks
> like the MDSS is the interrupt parent for at least some child devices?

Hrm.  How does that work?  Let's see...

...ah, I believe it works because we don't try to grab interrupts in
the probe path of our sub-components.  That means we probe them just
fine without the parent.  I guess it has to be like this because
otherwise we end up with circular dependencies.

So there is a dependency of the child on the parent and of the parent
on the child (the parent won't really probe until the children do).
No idea if this means that the whole thing was architected in a
non-optimal way or if it's just really hard to fit the DRM Component
model into the Linux Driver model (or both).  Where does that leave us
about whether "simple-bus" is OK, though?



> >  So that means it's fine/correct to add "simple-bus" here?
> >
> >
> > > > Once I do this I notice that my boot gets marginally faster (you
> > > > don't need to probe the sub devices over and over) and also if I
> > >
> > > Can you quantify that?
> >
> > I'd say < 100 us.  I can try to quantify more if needed, but it wasn't
> > the point of this patch.
> >
> >
> > > Have you run with devlinks enabled. You need a command line option to
> > > enable. That too should reduce deferred probes.
> >
> > Ah, good idea!  I will try it.  However, even with devlinks, if there
> > is any chance of deferred probes then we need a fix like this.  The
> > point of the patch isn't about speeding things up but about avoiding
> > an infinite loop at bootup due to a small bug.
>
> I think a deferred probe would only happen if there's a dependency we
> don't track (but we're tracking about everything that's common). But
> if there's some error, I'm not sure what would happen. Seems like a
> good test case. :)

Maybe now that I've pointed at msm_dsi_host_register() it will help
clarify.  I don't know a ton about the MSM DRM world (mostly I just
jumped in here because I was sick of getting stuck in this infinite
loop), but I'm not sure how we can get around the problems.

I guess in my specific case we could maybe determine that the bridge
chip returned -EINVAL and thus would never probe, but what about if I
put the bridge chip driver in a loadable kernel module?

My device links knowledge is super weak (and I'm currently mostly
focused on the slightly older 5.4 kernel if that matters) but are you
saying that the system should just know which device would eventually
provide the bridge/panel and would know not to probe the main DRM
driver until after it probes?


> > > > have a problem it doesn't loop forever (on my system it still
> > > > gets upset about some stuck clocks in that case, but at least I
> > > > can boot up).
> > >
> > > Deferred probe only runs when a device is added, so it's not like it
> > > is continually running.
> >
> > If you don't mind looking at the code patch, see:
> >
> > https://lore.kernel.org/r/20200710160131.4.I358ea82de218ea5f4406572ade23f5e121297555@changeid/
> >
> > Specifically you can see that each time we try to probe we were
> > calling of_platform_populate().  That appeared to be enough to trigger
> > things.
>
> Like I said, sounds like a bug. Even if 'simple-bus' is the
> appropriate thing to do here, it should be fixed or at least
> understood.
>
> Rob
