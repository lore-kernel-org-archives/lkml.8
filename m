Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3BA20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdFtAI6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQSIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:08:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34635 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgCQSIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:08:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so22662970otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sfwugi6An/fi/osCjU0QeDUVcWXSKzOgIgxwrv+rhNw=;
        b=hdFtAI6b+IUmHnmZWLGG8BqISIZJvsSfumgfsTaK2jxBTXuFDF+73AK/HuJSQS0EC8
         aoBG3g+8oEaJY/A+lNApbf8umn0mm7xqsTlN6kouAgHBqLEnpWOaIUVjMZYCtvG7fhtu
         RSkNvPVb6Xa+q8jc2Tl11TdIMDbPpi+qPPvUAfZOISRKwMqpgm1uf9PLncN46caEFY//
         HyV4Ru7KmIkDKu1To2nMOMRie50/17qyqjRoWmfIewAx50Fqz6qwqPSuqQcT+BjYWJ+O
         HFfdyDPt/poeHWcBanem/vW7+SWCUcs3bHk8xAcfMPmyPEFGtxGASX9yQLYLUfkkSOuz
         y+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sfwugi6An/fi/osCjU0QeDUVcWXSKzOgIgxwrv+rhNw=;
        b=UgirQbbpFDeHjrOVfUB2uUZ2bIByMWbqrhkmJc5E3FVSnxV8VShkKoTmv4ZuInVHdY
         +KLMXl78bScD3WyI7bZIes2VAGz4rAREDkG7fyK17Dt5jEQKLcL4zgcat1OzSHGDf+7Q
         DJT9eQYvXwO+KSdYuB3A+VeGENJ4h9maxpfVJ2/Q6YGdwGROx9SK9n4z5BG46LyQQJ09
         nMR1KxWj49Qf34O4XaVuXH+nGI85LSpPn3n4vYU+r6RUCA8IJ7XTHYa3IPzAhN3p47d9
         8KMOxBLjNB1WdVfkiHiIF4tpJDYt5FjS6Aqepz9UfhRp3nEpN1xcXYc5pHZA0pJUScwk
         CsUg==
X-Gm-Message-State: ANhLgQ39Hc85WKohWxODOofF6R2kmtxe9w+x6hxbnPnZLXQsZ7oS+g11
        rWmpZhzGeZKim6RUXPlaxtvDHvcaVt75iyZDxXH7suu98+w=
X-Google-Smtp-Source: ADFU+vv8pF7LvW3WxACr0Hp5e7pjZbzQKdBy3RF0RHu/v4bwIMByR8gB7aKTXqnzH0NwP/vtLmPZYgwW2jZLPy6TOmQ=
X-Received: by 2002:a9d:1eea:: with SMTP id n97mr436878otn.139.1584468520683;
 Tue, 17 Mar 2020 11:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com> <f9f3afa0-f0a7-6cff-2e57-e4e448a81a90@linaro.org>
 <CAGETcx_VV+NUALO=9PS5id7Jz0yLjG=T4FsC=J4PjuQ-rGcd9A@mail.gmail.com>
 <CAGETcx_Y7TroxBGsD0ssG8X+iZawoMVnqVPbEOJwR2Wmv=0Kxw@mail.gmail.com>
 <814e5b06-dde9-f59a-735a-39d7e41efc67@linaro.org> <CAGETcx9Nq7OQPNv5sha3Yy_QmPzP-32jjMVqaczbE4NkjdmWXA@mail.gmail.com>
 <897866cb-f059-d15f-62f5-9ee2688dded0@linaro.org> <CAGETcx-i5ows0bh_gRao5jV7GZtsNJ+0u8tC+w8E0YLxd7U94w@mail.gmail.com>
 <73509a5b-7bb2-fae5-9bd1-cb809a5b67e8@linaro.org> <CAGETcx-UAjWhtDMoTaLX-2HwXWq-3aAi9FcwszEJ1-YKcekqmQ@mail.gmail.com>
 <5e70b653.1c69fb81.b03d8.d2bbSMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <5e70b653.1c69fb81.b03d8.d2bbSMTPIN_ADDED_MISSING@mx.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 17 Mar 2020 11:08:04 -0700
Message-ID: <CAGETcx9-TB3XWFvU0ME+eCTyJVs7a_ExD-5Dvm9VVvB=UkkMWg@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 4:36 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Saravana, Daniel,
>
>
> Le lun. 16 mars 2020 =C3=A0 11:15, Saravana Kannan <saravanak@google.com>=
 a
> =C3=A9crit :
> > On Mon, Mar 16, 2020 at 11:07 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>  On 16/03/2020 18:49, Saravana Kannan wrote:
> >>  > On Mon, Mar 16, 2020 at 7:57 AM Daniel Lezcano
> >>  > <daniel.lezcano@linaro.org> wrote:
> >>  >>
> >>  >> On 08/03/2020 06:53, Saravana Kannan wrote:
> >>  >>> On Wed, Mar 4, 2020 at 11:56 AM Daniel Lezcano
> >>  >>> <daniel.lezcano@linaro.org> wrote:
> >>  >>>>
> >>  >>>> On 04/03/2020 20:30, Saravana Kannan wrote:
> >>  >>>>> On Thu, Feb 27, 2020 at 1:22 PM Saravana Kannan
> >> <saravanak@google.com> wrote:
> >>  >>>>>>
> >>  >>>>>> On Thu, Feb 27, 2020 at 1:06 AM Daniel Lezcano
> >>  >>>>>> <daniel.lezcano@linaro.org> wrote:
> >>  >>>>>>>
> >>  >>>>>>> On 11/01/2020 06:21, Saravana Kannan wrote:
> >>  >>>>>>>> Timer initialization is done during early boot way before
> >> the driver
> >>  >>>>>>>> core starts processing devices and drivers. Timers
> >> initialized during
> >>  >>>>>>>> this early boot period don't really need or use a struct
> >> device.
> >>  >>>>>>>>
> >>  >>>>>>>> However, for timers represented as device tree nodes, the
> >> struct devices
> >>  >>>>>>>> are still created and sit around unused and wasting
> >> memory. This change
> >>  >>>>>>>> avoid this by marking the device tree nodes as "populated"
> >> if the
> >>  >>>>>>>> corresponding timer is successfully initialized.
> >>  >>>>
> >>  >>>> TBH, I'm missing the rational with the explanation and the
> >> code. Can you
> >>  >>>> elaborate or rephrase it?
> >>  >>>
> >>  >>> Ok, let me start from the top.
> >>  >>>
> >>  >>> When the kernel boots, timer_probe() is called (via
> >> time_init()) way
> >>  >>> before any of the initcalls are called in do_initcalls().
> >>  >>>
> >>  >>> In systems with CONFIG_OF, of_platform_default_populate_init()
> >> gets
> >>  >>> called at arch_initcall_sync() level.
> >>  >>> of_platform_default_populate_init() is what kicks off creating
> >>  >>> platform devices from device nodes in DT. However, if the struct
> >>  >>> device_node that corresponds to a device node in DT has
> >> OF_POPULATED
> >>  >>> flag set, a platform device is NOT created for it (because it's
> >>  >>> considered already "populated"/taken care of).
> >>  >>>
> >>  >>> When a timer driver registers using TIMER_OF_DECLARE(), the
> >> driver's
> >>  >>> init code is called from timer_probe() on the struct
> >> device_node that
> >>  >>> corresponds to the timer device node. At this point the timer is
> >>  >>> already "probed". If you don't mark this device node with
> >>  >>> OF_POPULATED, at arch_initcall_sync() it's going to have a
> >> pointless
> >>  >>> struct platform_device created that's just using up memory and
> >>  >>> pointless.
> >>  >>>
> >>  >>> So my patch sets the OF_POPULATED flag for all timer
> >> device_node's
> >>  >>> that are successfully probed from timer_probe().
> >>  >>>
> >>  >>> If a timer driver doesn't use TIMER_OF_DECLARE() and just
> >> registers as
> >>  >>> a platform device, the driver init function won't be called from
> >>  >>> timer_probe() and it's corresponding devices won't have
> >> OF_POPULATED
> >>  >>> set in their device_node. So platform_devices will be created
> >> for them
> >>  >>> and they'll probe as normal platform devices. This is why my
> >> change
> >>  >>> doesn't break drivers/clocksource/ingenic-timer.c.
> >>  >>>
> >>  >>> Btw, this is no different from what irqchip does with
> >> IRQCHIP_DECLARE.
> >>  >>>
> >>  >>> Hope that clears it up.
> >>  >>
> >>  >> Yes, thanks for the explanation.
> >>  >>
> >>  >> Why not just set the OF_POPULATED if the probe succeeds?
> >>  >>
> >>  >> Like:
> >>  >>
> >>  >> diff --git a/drivers/clocksource/timer-probe.c
> >>  >> b/drivers/clocksource/timer-probe.c
> >>  >> index ee9574da53c0..f290639ff824 100644
> >>  >> --- a/drivers/clocksource/timer-probe.c
> >>  >> +++ b/drivers/clocksource/timer-probe.c
> >>  >> @@ -35,6 +35,7 @@ void __init timer_probe(void)
> >>  >>                         continue;
> >>  >>                 }
> >>  >>
> >>  >> +               of_node_set_flag(np, OF_POPULATED);
> >>  >>                 timers++;
> >>  >>         }
> >>  >>
> >>  >> instead of setting the flag and clearing it in case of failure?
> >>  >
> >>  > Looking at IRQ framework which first did it the way you suggested
> >> and
> >>  > then changed it to the way I did it, it looks like it allows for
> >>  > drivers that need to split the initialization between early init
> >> (not
> >>  > just error out, but init partly) and later driver probe. See [1].
> >>  >
> >>  > Also, most of the other frameworks that set OF_POPULATED, set it
> >>  > before calling the initialization function for the device. Maybe
> >> it's
> >>  > to make sure the device node data "looks the same" whether a
> >> device is
> >>  > initialized during early init or during normal device probe
> >> (since the
> >>  > OF_POPULATED is set before the probe is called) -- i.e. have
> >>  > OF_POPULATED  set before the device initialization code is
> >> actually
> >>  > run?
> >>  >
> >>  > Honestly I don't have a strong opinion either way, but I lean
> >> towards
> >>  > following what IRQ does.
> >>
> >>  Thanks for the pointer. Indeed it is to catch situation where the
> >> driver
> >>  is clearing the flag like:
> >>
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/clocksource/ingenic-timer.c#n245
> >>
> >>  But I'm not able to figure out why it is cleared here :/
> >
> > I think I know what's going on. He wants to implement PM support for
> > this timer. But PM support is tied to devices. So, clearing out the
> > flag allows creating the device which then hooks into PM ops.
>
> That's correct - the OF_POPULATED flag is cleared so that the driver
> will probe as a platform_device. When I did write the driver this was
> required or the platform_device would not probe.

Interesting. I went and looked at the kernel when your patch merged.
As far as I can tell, you shouldn't have needed to clear OF_POPULATED
because the timer framework never set OF_POPULATED even back then.

If this driver was based in drivers/irqchip/irq-ingenic-tcu.c and you
were initially just trying to get it to create a device, then you'd
have needed to clear OF_POPULATED because IRQ chip framework does set
the flag.

In any case, it's good that you cleared it -- it'll continue to work
with my patch.

Daniel,

Looks like this answers all the concerns you had. I also checked every
driver in drivers/clocksource that had the word "probe" in it to make
sure it won't need any updates to ingenic-timer.c. Can we merge this?

Thanks,
Saravana

>
> -Paul
>
> > Although, it looks like the driver assumes the timer framework was
> > setting the OF_POPULATED flag.
> >
> > -Saravana
> >
> >>
> >>  Paul?
> >>
> >>
> >>  --
> >>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or
> >> ARM SoCs
> >>
> >>  Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >>  <http://twitter.com/#!/linaroorg> Twitter |
> >>  <http://www.linaro.org/linaro-blog/> Blog
> >>
>
>
