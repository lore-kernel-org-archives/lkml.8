Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8D2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585362229;
	bh=9SyyNJQ551wcLPZuze7Msf9nptXknPKp7+kLiUy5mNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W80T0DaavZMCaFb79XBdpNQ/zjLSysX02VDVy8y1CH6+RfEttwifLMQ4ewqkmEton
	 JsNhLQowjFve47WM6Lff0dH5RoWvLGN9qKLWwfBubESSOXKFeJPcvlO46j7B43Rq8k
	 efiAMkLd8PX3Zk40nPe62NEfPFdRajBru0g37mBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgC1CXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgC1CXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 22:23:46 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E589720787;
        Sat, 28 Mar 2020 02:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585362226;
        bh=9SyyNJQ551wcLPZuze7Msf9nptXknPKp7+kLiUy5mNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OA9bzh2hvCOeM5UktIFR7/hwpiRQUAL209ENdzPc/ovDV1FSlFZJAVrPU5iZTyPE8
         Dt8svm+XgdKVRrMd0UWXYJBUM6k+jH7yyS2GFaNYxX44XPJIRXPykpdOgC6CRSxUoB
         2WQq2SjMVEAZIURBCCBvdfbd8RFXhlD0Ryo9Bqdg=
Received: by mail-qk1-f182.google.com with SMTP id d11so13037259qko.3;
        Fri, 27 Mar 2020 19:23:45 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0ThBrwIZQf+JXX+H05WCq4X3NBwWMz7UGXluadIkEbxEKri6Rh
        OJbUyzQxfQT+uy0x+nU4I8QXINwIjaNoIqyRSg==
X-Google-Smtp-Source: ADFU+vvtX7zCw9efC6XfKe33KfCp+spF2jPIpj0KYLSwK2zxx76WAsVXS1fMj8C04Y6nBp+ZNKzRDwKPKAONixt0M04=
X-Received: by 2002:a37:aa92:: with SMTP id t140mr2105160qke.119.1585362224945;
 Fri, 27 Mar 2020 19:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <158460766637.28353.11325960928759668587.tip-bot2@tip-bot2>
 <20200324175955.GA16972@arm.com> <CAGETcx8Qhy3y66vJyi8kRvg1+hXf-goDvyty-bsG5qFrA-CKgg@mail.gmail.com>
 <CAGETcx80wvGnS0-MwJ9M9RR9Mny0jmmep+JfwaUJUOR2bfJYsQ@mail.gmail.com>
 <87lfnoxg2a.fsf@nanos.tec.linutronix.de> <CAGETcx_3GSKmSveiGrM2vQp=q57iZYc0T4ELMY7Zw8UwzPEnYA@mail.gmail.com>
 <87imirxv57.fsf@nanos.tec.linutronix.de> <CAL_JsqLas2mi-kTrEY=9vnopU57qwJNDtvui0erMghfG4-pOZw@mail.gmail.com>
 <CAGETcx_MC7weVSYF9CpWt_5Otf3G1Hd75Z8_0LcN0SS42UDyJw@mail.gmail.com>
In-Reply-To: <CAGETcx_MC7weVSYF9CpWt_5Otf3G1Hd75Z8_0LcN0SS42UDyJw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Mar 2020 20:23:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoyAJuKaYayStiTNKqDJhfHfXFzqMiCmX9_2YmAoPcMA@mail.gmail.com>
Message-ID: <CAL_JsqJoyAJuKaYayStiTNKqDJhfHfXFzqMiCmX9_2YmAoPcMA@mail.gmail.com>
Subject: Re: [tip: timers/core] clocksource/drivers/timer-probe: Avoid
 creating dead devices
To:     Saravana Kannan <saravanak@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tip-commits@vger.kernel.org, x86 <x86@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Mar 26, 2020 at 8:02 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Mar 26, 2020 at 4:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Saravana Kannan <saravanak@google.com> writes:
> > > > On Wed, Mar 25, 2020 at 2:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > >> Saravana Kannan <saravanak@google.com> writes:
> > > >> > On Tue, Mar 24, 2020 at 11:34 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >> > I took a closer look. So two different drivers [1] [2] are saying they
> > > >> > know how to handle "arm,vexpress-sysreg" and are expecting to run at
> > > >> > the same time. That seems a bit unusual to me. I wonder if this is a
> > > >> > violation of the device-driver model because this expectation would
> > > >> > never be allowed if these device drivers were actual drivers
> > > >> > registered with driver-core. But that's a discussion for another time.
> > > >> >
> > > >> > To fix this issue you are facing, this patch should work:
> > > >> > https://lore.kernel.org/lkml/20200324195302.203115-1-saravanak@google.com/T/#u
> > > >>
> > > >> Sorry, that's not a fix. That's a crude hack.
> > > >
> > > > If device nodes are being handled by drivers without binding a driver
> > > > to struct devices, then not setting OF_POPULATED is wrong. So the
> > > > original patch sets it. There are also very valid reasons for allowing
> > > > OF_POPULATED to be cleared by a driver as discussed here [1].
> > > >
> > > > The approach of the original patch (setting the flag and letting the
> > > > driver sometimes clear it) is also followed by many other frameworks
> > > > like irq, clk, i2c, etc. Even ingenic-timer.c already does it for the
> > > > exact same reason.
> > > >
> > > > So, why is the vexpress fix a crude hack?
> > >
> > > If it's the right thing to do and accepted by the DT folks, then the
> > > changelog should provide a proper explanation for it. The one you
> > > provided just baffles me. Plus the clearing of the flag really needs a
> > > big fat comment.
> >
> > IMO, commit 4f41fe386a946 should be reverted and be done with it.
> > There's no way the timer core can know whether a specific node should
> > be scanned or not. If you really want to avoid a struct device, then
> > set OF_POPULATED in specific timer drivers. But I'd rather not see
> > more places mucking with OF_POPULATED. It's really only bus code that
> > should be touching it.
>
> Since most drivers don't need the struct device, my patch sets the
> flag in the timer core. And for the few exception cases where the
> device is needed, we can clear the flag in the driver. That'll reduce
> the number of places mucking with OF_POPULATED.
>
> Does this seem okay to you?

No. Like I said, I prefer fewer cases of these flags being mucked with.

There are some other ways to solve this. Add a new "ignore" flag. That
would be somewhat better as OF_POPULATED is not necessarily static
(overlays!). Another way would be changing 'status' property to
something other than 'okay'.

> > Is having a struct device really a problem? If we want to save memory
> > usage, I have some ideas that would save much more than 1 or 2 struct
> > devices.
>
> Keep in mind that struct devices cost more than one struct device of
> memory. They also create a bunch of sysfs nodes, uevents, etc.

Having the device in sysfs could be argued to be a feature.

How much memory would we be saving? Is this really the biggest problem
we have for something that's been this way for at least 10 years now.

> > > It still does not make any sense to me.
> > >
> > > arm,vexpress-sysreg is a MFD device, so can the ARM people please
> > > explain, why the sched clock part is not just another MFD sub-device or
> > > simply has it's own DT match?
> >
> > The issue is DT nodes and Linux drivers aren't necessarily 1-1. That
> > would be nice, but hardware is messy and DT doesn't abstract that
> > away. If we tried to always make things 1-1, then if/when the Linux
> > driver structure changes we'd have to change the DT.
>
> I agree with this. I'm definitely not asking to create a node just
> because we want another struct device.
>
> > If we decided to
> > add a node now, we'd still have to support the old DT for backwards
> > compatibility.
>
> Right, I agree it's too late to fix this DT for vexpress-sysreg now.
>
> > We also have to consider the structure for another OS
> > may be different.
> >
> > Generally, if I see a node with a compatible only it gets NAKed as
> > that's a sure sign of someone just trying to bind a driver and not
> > describing the h/w. We only do MFD sub-devices if those devices
> > provide or consume other DT resources.
>
> If we have a timer MFD, it'd technically consume a fixed-clock and not
> be empty. vexpress-sysreg just assumes the clock is 24 MHz right now.

Possibly. Depends if only the timer uses the clock or all the other
functions use the clock.

If only someone had said the clock should be in DT [1].

> My point about the vexpress DT nodes being weird is not about Linux
> devices, rather it's that:
> 1. It's already a MFD
> 2. Most of the functions are separated clearly into their functional
> device nodes
> 3. However, the timer functionality is combined with the parent MFD
> device when the parent MFD device implements a completely separate
> function (gpio?). Why?

Looking at the history, it doesn't look like this got much review and
it would look a bit different if we were starting over. In any case, a
node for just a counter register seems like overkill. I often get
these MFD or system controller bindings piecemeal, so it's hard to
make any intelligent design decisions.

Actually, the fact that sched clock support was added later on without
doing a DT change was probably the main thing this binding got right.

> If one wants to split out the functions, do it fully. If one wants it
> all under one mega driver (ugh!) then combine it all. Going halfway
> causes these weird issues. That's my complaint about how the DT layout
> is for this device.

It's not how the binding is split, but that the functions are split
between a non-driver thing and driver things.

> Having said all that, I'd rather manipulate the OF_POPULATED flag than
> break DT backward compatibility at this point.
>
> But in general, I think we should try to reject two separate drivers
> claiming to be compatible with the same device and expecting to work
> at the same time. That's just weird.

If we had 2 proper drivers, we wouldn't be having this conversation.
It's not a problem to have multiple child drivers for a single DT node
when everything is a proper driver. We do that all the time.

Rob

[1] https://lkml.org/lkml/2014/4/16/422
