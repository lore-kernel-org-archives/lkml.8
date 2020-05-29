Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A747C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA706207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="li4jMeUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgE2XO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2XO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:14:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E17C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:14:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so2128328pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPr8asu5RQmapnjgVXwOuozq1q1QJxaHep1g30tt+VM=;
        b=li4jMeUWXGLRkSFikYAvwf0WNPu5MVE76w55KYQ7XvZLUzWC/BV4qYy8A6rtU1fDb+
         B59TWa/T+f6jsc4S145Zu9HKOP2S9u7EmGSWymEzWceglF/lCOlS2jBZvUjDSryL0GA4
         OppX/KOuKYle+ZX/DyTH2pkb2oCq2DFYGmyGXDp8eIZzN1YyzuEPBj/R3b1aI+cn4svA
         5CkmzKlHTXHDWVXVHFCzaemUdZGPi2mz4UkiZRJH4gww+ewQqN78hmY/N/cVXoZDK5aA
         K3MWmqxZxI15R3I9iSJRGLLJCPcJo/1rWoF1YCkv5ae8r5W/4dCXv+bLTghf5FoA9Ohx
         yLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPr8asu5RQmapnjgVXwOuozq1q1QJxaHep1g30tt+VM=;
        b=LxNsWeiNtUAGzoll6+8EWcKk2XhS0ukNeX8iaiDUITDuNfRRP6q3YARkp/X7Il5ahx
         rpMRcjJX1y4Mr8xBr++4OfadJwf9RIxX/focd8vug5uhKW1/bpO1cT8cTtGCRH0vm0hd
         YP+jAMWsPR4Ztntg+2T0/RfZoC5boqruFzyTRL3dTiJK8CIumeycUZmuduNirF4FNxAJ
         w7vG4fzwyswGfN16wrp1Mss/looic0kUooQqfYphuH76bWl06yNgYu9Cmzz4oSLM/+HT
         aQjMOq/0mdhA0sT3lbNkiHLc5KaJdGlC84JbJfSwQ7n8cDdH/2fhdzD2hhsS8vF0q09n
         X43A==
X-Gm-Message-State: AOAM531h6J0djZBwuiD/C9jttETsLvr2ZtJiQVs3114xCL6M4CG5IjCP
        lpQ9y0MdSXzqXaxOK8PGzcWP3Yikeuw0E3j5xuQqcQ==
X-Google-Smtp-Source: ABdhPJwDxSYQHvm4WBpzPm4WL5x9vkrWE9o0HlEh2HHK3BBhVzy4nDUlGtjTJDjgvLJU+nKFp7wOJtqvI/kal8OM+a4=
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr12260075pjr.19.1590794065789;
 Fri, 29 May 2020 16:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com>
 <9d75a67b-87f0-161c-02d7-c9fc4efe97e7@intel.com> <CANA+-vBURc0ivB=UHXK5Xg_tVJOV_h9Uz_Ke4ZG3Gu_sMhfTvQ@mail.gmail.com>
 <78faec4a-bf98-a731-b505-a1ccfb6e4557@gmail.com>
In-Reply-To: <78faec4a-bf98-a731-b505-a1ccfb6e4557@gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Fri, 29 May 2020 16:14:09 -0700
Message-ID: <CANA+-vCDrE7Kmr3XspSCwCue1ic4tKyW=FuXS7PhsK0581_+Mg@mail.gmail.com>
Subject: Re: Regression with PM / wakeup: Show wakeup sources stats in sysfs"
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 3:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 5/29/20 3:28 PM, Tri Vo wrote:
> > On Fri, May 29, 2020 at 9:51 AM Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> >>
> >> On 5/28/2020 10:46 PM, Florian Fainelli wrote:
> >>> Hi,
> >>>
> >>> Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
> >>> wakeup sources stats in sysfs") is causing some of our tests to fail
> >>> because /sys/class/net/*/device/power/wakeup_count is now 0, despite
> >>> /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
> >>> device was responsible for system wake-up.
> >>>
> >>> What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
> >>> have the number of Wake-on-LAN wakeups recorded properly, but
> >>> wakeup_count is desperately 0, why is that?
> >>
> >> I need to look at that commit in detail to find out what is going on.
> >
> > It would be helpful to see the contents of
> > /sys/kernel/debug/wakeup_sources, /sys/class/net/*/device/power/*, and
> > /sys/class/wakekup/* corresponding to the device in question. The
> > values in these files are queried from the same struct wakeup_source.
> > So it's odd if wakeup_count diverges.
>
> Most certainly, below is the information you want, the two cat
> /s/k/d/wakeup_sources were done before Wake-on-LAN and after waking-up
> from LAN. /sys/class/wakeup/wakeup2 maps to the Ethernet device.
>
> The Ethernet device calls pm_wakeup_event() against the struct device
> that is embedded in the platform_device that it was probed with. I will
> try to debug this myself over the weekend, time permitting.
>
>
> # ethtool -s eth0 wol g
> # cat /sys/kernel/debug/wakeup_sources
> name            active_count    event_count     wakeup_count
> expire_count    active_since    total_time      max_time        last_changep
> revent_suspend_time
> 47d580000.ethernet      0               0               0
> 0               0               0               0               0  0
> alarmtimer      0               0               0               0
>         0               0               0               0          0
> 47c408400.waketimer     2               2               0
> 0               0               0               0               6144
> 1               0
> # pml -w20
> [ 3449.937142] brcm-waketimer 47c408400.waketimer: Using sysfs
> attributes, consider using 'rtcwake'
> Pass 1 out of 1, mode=none, tp_al[ 3449.952654] PM: suspend entry (shallow)
> l=1, cycle_tp=, sleep=, [ 3449.959004] Filesystems sync: 0.000 seconds
> wakeup_time=20
> [ 3449.965984] Freezing user space processes ... (elapsed 0.001 seconds)
> done.
> [ 3449.974087] OOM killer disabled.
> [ 3449.977316] Freezing remaining freezable tasks ... (elapsed 0.006
> seconds) done.
> [ 3449.991114] printk: Suspending console(s) (use no_console_suspend to
> debug)
> AMS: System is entering S2...
> [ 3450.022381] bcmgenet 47d580000.ethernet eth0: Link is Down
> [ 3450.048340] Disabling non-boot CPUs ...
> [ 3450.049344] CPU1: shutdown
> [ 3450.050393] psci: CPU1 killed (polled 1 ms)
> [ 3450.051332] Enabling non-boot CPUs ...
> [ 3450.051712] Detected PIPT I-cache on CPU1
> [ 3450.051812] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
> [ 3450.052435] CPU1 is up
> [ 3450.683588] bcmgenet 47d580000.ethernet eth0: Link is Up - 1Gbps/Full
> - flow control rx/tx
> [ 3450.729677] OOM killer enabled.
> [ 3450.732908] Restarting tasks ... done.
> [ 3450.738539] PM: suspend exit
> ------------------------------
> [ 3450.744239] brcm-waketimer 47c408400.waketimer: Using sysfs
> attributes, consider using 'rtcwake'
> # cat /sys/kernel/debug/wakeup_sources
> name            active_count    event_count     wakeup_count
> expire_count    active_since    total_time      max_time        last_changep
> revent_suspend_time
> 47d580000.ethernet      1               1               0
> 0               0               0               0               3450
> 054             0
> alarmtimer      0               0               0               0
>         0               0               0               0          0
> 47c408400.waketimer     2               2               0
> 0               0               0               0               6144
> 1               0
> # cat /sys/class/net/*/device/power/*
> cat: read error: Input/output error
> auto
> 0
> unsupported
> 0
> enabled
> 0
> 0
> 1
> 0
> 0
> 3450054
> 0
> 0

UUIC, 47d580000.ethernet is the device of interest here. It's
wakeup_count was 0 before wake up, and we expect it to be 1 after wake
up. One of the files you cat'ed here has a 1 in it. I can't tell which
value corresponds to which file though, but I suspect that's
wakeup_count.

> # ls -l /sys/class/net/eth0/device/
> driver/          net/             subsystem/       wakeup/
> driver_override  of_node/         uevent
> modalias         power/           unimac-mdio.0/
> # ls -l /sys/class/net/eth0/device/power/wakeup
> wakeup                wakeup_active_count   wakeup_last_time_ms
> wakeup_abort_count    wakeup_count          wakeup_max_time_ms
> wakeup_active         wakeup_expire_count   wakeup_total_time_ms
> # ls -l /sys/class/net/eth0/device/power/wakeup^C
> # ls -l /sys/class/wakeup/wakeup
> wakeup0/ wakeup1/ wakeup2/
> # ls -l /sys/class/wakeup/wakeup2/
> total 0
> -r--r--r--    1 root     root          4096 Jan  1 00:59 active_count
> -r--r--r--    1 root     root          4096 Jan  1 00:59 active_time_ms
> lrwxrwxrwx    1 root     root             0 Jan  1 00:59 device ->
> ../../../47d580000.ethernet
> -r--r--r--    1 root     root          4096 Jan  1 00:59 event_count
> -r--r--r--    1 root     root          4096 Jan  1 00:59 expire_count
> -r--r--r--    1 root     root          4096 Jan  1 00:59 last_change_ms
> -r--r--r--    1 root     root          4096 Jan  1 00:59 max_time_ms
> -r--r--r--    1 root     root          4096 Jan  1 00:59 name
> -r--r--r--    1 root     root          4096 Jan  1 00:59
> prevent_suspend_time_ms
> lrwxrwxrwx    1 root     root             0 Jan  1 00:59 subsystem ->
> ../../../../../../class/wakeup
> -r--r--r--    1 root     root          4096 Jan  1 00:59 total_time_ms
> -rw-r--r--    1 root     root          4096 Jan  1 00:59 uevent
> -r--r--r--    1 root     root          4096 Jan  1 00:59 wakeup_count
> # cat /sys/class/wakeup/wakeup2/*
> 1
> 0
> cat: read error: Is a directory
> 1
> 0
> 3450054
> 0
> 47d580000.ethernet
> 0
> cat: read error: Is a directory
> 0
> 0
> #
>
> --
> Florian
