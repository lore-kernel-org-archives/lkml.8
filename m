Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9906AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B8920823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgFEOfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:35:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFEOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:35:45 -0400
Received: from 89-64-83-87.dynamic.chello.pl (89.64.83.87) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id cd04ae1f81668864; Fri, 5 Jun 2020 16:35:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: Regression with PM / wakeup: Show wakeup sources stats in sysfs"
Date:   Fri, 05 Jun 2020 16:35:41 +0200
Message-ID: <2000507.DSekpMEVPg@kreacher>
In-Reply-To: <e0deab2b-ccc3-a457-8028-de1b9c139984@gmail.com>
References: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com> <76a613a5-a55e-32ed-de72-91e51209b443@gmail.com> <e0deab2b-ccc3-a457-8028-de1b9c139984@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 2, 2020 5:06:29 AM CEST Florian Fainelli wrote:
> 
> On 6/1/2020 6:30 PM, Florian Fainelli wrote:
> > 
> > 
> > On 5/30/2020 3:33 PM, Tri Vo wrote:
> >> On Sat, May 30, 2020 at 11:52 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>
> >>>
> >>>
> >>> On 5/29/2020 4:14 PM, Tri Vo wrote:
> >>>> On Fri, May 29, 2020 at 3:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>
> >>>>> On 5/29/20 3:28 PM, Tri Vo wrote:
> >>>>>> On Fri, May 29, 2020 at 9:51 AM Rafael J. Wysocki
> >>>>>> <rafael.j.wysocki@intel.com> wrote:
> >>>>>>>
> >>>>>>> On 5/28/2020 10:46 PM, Florian Fainelli wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
> >>>>>>>> wakeup sources stats in sysfs") is causing some of our tests to fail
> >>>>>>>> because /sys/class/net/*/device/power/wakeup_count is now 0, despite
> >>>>>>>> /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
> >>>>>>>> device was responsible for system wake-up.
> >>>>>>>>
> >>>>>>>> What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
> >>>>>>>> have the number of Wake-on-LAN wakeups recorded properly, but
> >>>>>>>> wakeup_count is desperately 0, why is that?
> >>>>>>>
> >>>>>>> I need to look at that commit in detail to find out what is going on.
> >>>>>>
> >>>>>> It would be helpful to see the contents of
> >>>>>> /sys/kernel/debug/wakeup_sources, /sys/class/net/*/device/power/*, and
> >>>>>> /sys/class/wakekup/* corresponding to the device in question. The
> >>>>>> values in these files are queried from the same struct wakeup_source.
> >>>>>> So it's odd if wakeup_count diverges.
> >>>>>
> >>>>> Most certainly, below is the information you want, the two cat
> >>>>> /s/k/d/wakeup_sources were done before Wake-on-LAN and after waking-up
> >>>>> from LAN. /sys/class/wakeup/wakeup2 maps to the Ethernet device.
> >>>>>
> >>>>> The Ethernet device calls pm_wakeup_event() against the struct device
> >>>>> that is embedded in the platform_device that it was probed with. I will
> >>>>> try to debug this myself over the weekend, time permitting.
> >>>>>
> >>>>>
> >>>>> # ethtool -s eth0 wol g
> >>>>> # cat /sys/kernel/debug/wakeup_sources
> >>>>> name            active_count    event_count     wakeup_count
> >>>>> expire_count    active_since    total_time      max_time        last_changep
> >>>>> revent_suspend_time
> >>>>> 47d580000.ethernet      0               0               0
> >>>>> 0               0               0               0               0  0
> >>>>> alarmtimer      0               0               0               0
> >>>>>         0               0               0               0          0
> >>>>> 47c408400.waketimer     2               2               0
> >>>>> 0               0               0               0               6144
> >>>>> 1               0
> >>>>> # pml -w20
> >>>>> [ 3449.937142] brcm-waketimer 47c408400.waketimer: Using sysfs
> >>>>> attributes, consider using 'rtcwake'
> >>>>> Pass 1 out of 1, mode=none, tp_al[ 3449.952654] PM: suspend entry (shallow)
> >>>>> l=1, cycle_tp=, sleep=, [ 3449.959004] Filesystems sync: 0.000 seconds
> >>>>> wakeup_time=20
> >>>>> [ 3449.965984] Freezing user space processes ... (elapsed 0.001 seconds)
> >>>>> done.
> >>>>> [ 3449.974087] OOM killer disabled.
> >>>>> [ 3449.977316] Freezing remaining freezable tasks ... (elapsed 0.006
> >>>>> seconds) done.
> >>>>> [ 3449.991114] printk: Suspending console(s) (use no_console_suspend to
> >>>>> debug)
> >>>>> AMS: System is entering S2...
> >>>>> [ 3450.022381] bcmgenet 47d580000.ethernet eth0: Link is Down
> >>>>> [ 3450.048340] Disabling non-boot CPUs ...
> >>>>> [ 3450.049344] CPU1: shutdown
> >>>>> [ 3450.050393] psci: CPU1 killed (polled 1 ms)
> >>>>> [ 3450.051332] Enabling non-boot CPUs ...
> >>>>> [ 3450.051712] Detected PIPT I-cache on CPU1
> >>>>> [ 3450.051812] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
> >>>>> [ 3450.052435] CPU1 is up
> >>>>> [ 3450.683588] bcmgenet 47d580000.ethernet eth0: Link is Up - 1Gbps/Full
> >>>>> - flow control rx/tx
> >>>>> [ 3450.729677] OOM killer enabled.
> >>>>> [ 3450.732908] Restarting tasks ... done.
> >>>>> [ 3450.738539] PM: suspend exit
> >>>>> ------------------------------
> >>>>> [ 3450.744239] brcm-waketimer 47c408400.waketimer: Using sysfs
> >>>>> attributes, consider using 'rtcwake'
> >>>>> # cat /sys/kernel/debug/wakeup_sources
> >>>>> name            active_count    event_count     wakeup_count
> >>>>> expire_count    active_since    total_time      max_time        last_changep
> >>>>> revent_suspend_time
> >>>>> 47d580000.ethernet      1               1               0
> >>>>> 0               0               0               0               3450
> >>>>> 054             0
> >>>>> alarmtimer      0               0               0               0
> >>>>>         0               0               0               0          0
> >>>>> 47c408400.waketimer     2               2               0
> >>>>> 0               0               0               0               6144
> >>>>> 1               0
> >>>>> # cat /sys/class/net/*/device/power/*
> >>>>> cat: read error: Input/output error
> >>>>> auto
> >>>>> 0
> >>>>> unsupported
> >>>>> 0
> >>>>> enabled
> >>>>> 0
> >>>>> 0
> >>>>> 1
> >>>>> 0
> >>>>> 0
> >>>>> 3450054
> >>>>> 0
> >>>>> 0
> >>>>
> >>>> UUIC, 47d580000.ethernet is the device of interest here. It's
> >>>> wakeup_count was 0 before wake up, and we expect it to be 1 after wake
> >>>> up. One of the files you cat'ed here has a 1 in it. I can't tell which
> >>>> value corresponds to which file though, but I suspect that's
> >>>> wakeup_count.
> >>>
> >>> That file is actually event_count which is not what is expected:
> >>>
> >>> # sh print.sh
> >>> /sys/class/wakeup/wakeup2/uevent:
> >>> /sys/class/wakeup/wakeup2/event_count: 1
> >>> /sys/class/wakeup/wakeup2/max_time_ms: 0
> >>> /sys/class/wakeup/wakeup2/wakeup_count: 0
> >>> /sys/class/wakeup/wakeup2/total_time_ms: 0
> >>> /sys/class/wakeup/wakeup2/expire_count: 0
> >>> /sys/class/wakeup/wakeup2/active_count: 1
> >>> /sys/class/wakeup/wakeup2/last_change_ms: 3450054
> >>> /sys/class/wakeup/wakeup2/prevent_suspend_time_ms: 0
> >>> /sys/class/wakeup/wakeup2/name: 47d580000.ethernet
> >>> /sys/class/wakeup/wakeup2/active_time_ms: 0
> >>
> >> Thanks! Although 0 is not the expected wakeup_count, both
> >> /sys/kernel/debug/wakeup_sources and /sys/class/wakeup/* are reporting
> >> the same thing. So it's probably not an issue with how these values
> >> are reported. The underlying struct wakeup_source has 0 wakeup_count
> >> recorded.
> >>
> >> How sure are you that commit c8377adfa78103be5380200eb9dab764d7ca890e
> >> introduces the regression? (That commit adds sysfs attributes to
> >> display wakeup source information, so it seems unlikely that actual
> >> wakeup event accounting is affected by it.)
> > 
> > Not anymore, it looks like my automated bisection was flawed, I will
> > restart it now and find out the offending commit when this started to
> > break. Thanks for reviewing the logs!
> 
> It was more obvious than I thought, this commit:
> 
> 2d5ed61ce9820a1fe7b076cc45c169524d767746 ("PM / wakeup: Export
> wakeup_count instead of event_count via sysfs") did change the structure
> member being displayed by the wakeup_count sysfs attribute.
> 
> The commit message and rationale does make sense, however it sounds like
> there should still be a proper differentiation between pm_wakeup_event()
> calls done from resume cycle versus non-resume cycles.

It is unfortunate that you relied on the behavior that's changed, sorry about
that.

Reverting the above commit is still an option, so please let me know if you
want me to do that.

> The sysfs description under  Documentation/ABI/testing/sysfs-devices-power
> may also need clarification.

Well, feel free to propose specific changes in there.

> One example that I can think of is the gpio_keys.c driver which calls
> pm_wakeup_event() every time a GPIO button is pressed, provided that the
> device is marked as wakeup enabled. Granted, applications can read the
> count before and after suspend and determine if the count is different
> to identify whether gpio_keys.c is responsible for wake-up, but it would
> be much

This way one can only say whether or not a key has been pressed during the
period between two consecutive wakeup_count reads.  That may not even be
related to waking up the system from sleep, though.

Thanks!



