Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EAC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8A620661
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 05:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1jqTubd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBXFtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:49:50 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35986 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXFtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:49:50 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so6720477iln.3;
        Sun, 23 Feb 2020 21:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lY477fOyMq1q33AocdUo5Q0TUJqq9Md6rNGg2za8EE=;
        b=s1jqTubdky1rvJE1VzZdSrkQdnbJhf7/AS1HDlM0stq5HQi88ofA5b7QhrexYrycjD
         8RV4Xp23wk4MGhFSKuu6pTcr+i4FRRLgWuViYPEfHsIBwSKeyqcHKoBDp9R6qRPSn6iH
         MSvT4drDFSIWPW5NGHdn+/LFotJgqLN6XiINJtgkPc5IAJiX5ifvIOYX0X5x0uE51XGF
         +4eluDwp13rawmI3HvVZrfALBMO707xp1mnCIm6gWCRKj1gx1iBko9Cei70VyfSESeSM
         uVghwaqmljkv3K4bmYw8F7L5H8UyxBSNVOPvTqx66oWCT+dK8E25lubaGEi5TrCXCJpm
         T9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lY477fOyMq1q33AocdUo5Q0TUJqq9Md6rNGg2za8EE=;
        b=H/BoiDNNKNf+aRIq/KjuIHQJO1aVVKvzvHx25rdwH9qj17gxbmIw2kpmVWHT3jqeBr
         WuDs4sWjxYe9usk/eJJ0dOP6cTOv/iw9wrlKEy6TG6HOzvciohqtWPLWS+ENoggfugse
         HhL5CmDHdKh6OKxi/75hC1O7JQe0q2O4GINhlLqHKAMQAlX2zyBgG+kx4/etGXRA2h02
         fGAlBAHT4aUxpOzcD05ooq3Dh9Dw5HqgnbAvtkyaK48LVpdP/vz6K4d0kfHS62ncMARX
         NB7FgwCSc9e/pkj7GUov6oWgKXOGOfODVzD1Vf9w63dmUJt4G2LTWDjcrAY4O4Qb9f8Z
         YIbw==
X-Gm-Message-State: APjAAAVtUzTHudzepo/R67wpFe16sEF+xT38AEeRH9q+fDlLQVZyAk/J
        xutz+lq6/feA5ZnrOrLIMV7TNvHcZzDw8+lsedDJdk1j
X-Google-Smtp-Source: APXvYqwMB5S+cg1wqmxDqgClIocSahfleSU/C//nzCiqKf+hfu0p+G7QBof53DaOqgFzqnvi3H6GZJ+5IkmK+CSLuB4=
X-Received: by 2002:a92:9fdd:: with SMTP id z90mr59039789ilk.6.1582523387848;
 Sun, 23 Feb 2020 21:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20200212120237.1332-1-linux.amoon@gmail.com> <20200213101744.GA11087@kozik-lap>
 <CANAwSgR+PFiE0=FEhDY__FDx+470pe0OsbUXcSG64JDuG++ccQ@mail.gmail.com> <20200213154314.GA7215@kozik-lap>
In-Reply-To: <20200213154314.GA7215@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 24 Feb 2020 11:19:36 +0530
Message-ID: <CANAwSgS7k9sPZ6=WAVVsNUydRS_rfCa4itRvUExQBcQGuPqoDw@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Add FSYS2 power domain for MMC driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 13 Feb 2020 at 21:13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Feb 13, 2020 at 06:58:51PM +0530, Anand Moon wrote:
> > hi Krzysztof,
> >
> > On Thu, 13 Feb 2020 at 15:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, Feb 12, 2020 at 12:02:35PM +0000, Anand Moon wrote:
> > > > This patches add the power domain for MMC driver,
> > > > but somehow the suspend/resume feature is broken
> > > > so any input on how to fix this.
> > >
> > > I think S2R was working on XU3-family after Marek's fixes, so you mean
> > > that these patches break it?
> > >
> > Yes I my testing mmc driver failed to come up after suspend.
>
> Patches breaking systems should be clearly marked as work in progress,
> e.g.  by using RFC instead of PATCH in the title.
>
> This patchset cannot be applied.
>
Ok

> You probably have to figure out some missing dependencies, e.g. in
> clocks/power domains/pinctrl.
>
I have tried to add some more missing code, but this FSYS2 power domain
power off during suspend and their is no resume after this. Do know why.

[root@alarm ~]# echo N | sudo tee /sys/module/printk/parameters/console_suspend
N
[root@alarm ~]# echo 1 > /sys/power/pm_debug_messages
[root@alarm ~]# time rtcwake -s 60 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Mon Feb 24 05:18:02 2020
[   81.955425] PM: suspend entry (deep)
[   81.961793] Filesystems sync: 0.003 seconds
[   81.978051] Freezing user space processes ... (elapsed 0.009 seconds) done.
[   81.993635] OOM killer disabled.
[   81.996531] Freezing remaining freezable tasks ... (elapsed 0.002
seconds) done.
[   82.229718] wake enabled for irq 160
[   82.445441] wake enabled for irq 164
[   82.461752] samsung-pinctrl 13400000.pinctrl: Setting external
wakeup interrupt mask: 0xffffffe7
[   82.481095] Disabling non-boot CPUs ...

My observation, all the device get suspended and USB device come alive
after resume.
since mmc device is in sill in suspended state it dose not resume.

So can we stop the FSYS2 power domain to getting disabled during suspend.
Or is their any other thing I am missing.
How to enable more debug print for power management ?
How can I debug future ?

-Anand
