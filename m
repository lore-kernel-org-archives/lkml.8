Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D3D20897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="K1NuNPjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgE2W2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2W2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:28:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34470C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:28:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n15so522938pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY4yj9c52oXZ2jWS1wKDWOQi2s1UaHS96yM6OzNUtkQ=;
        b=K1NuNPjgow6uSw+YTDTgFTw1YZCCGa3PWnxcKw9xJSNMVu5gT76WtnwBNVpum8llTI
         CIvg+UUtsESCCaRi6wPmxp/nfgtR7gA8SMW9N4432o1sn5QDKT168OsWWhZxQgN/n5tZ
         Av09LwWkvdcLCaTsznEQfcFK+2LymblRcx+rd6yK4qG8maaIOALFPoqCxETQyPU7V6LX
         mA1HGUmme6EF31wu2ODcY1UTpYjfJvza5F8xxZfOA2lOx53XL34mLnzSN9cOSf7r/zRJ
         Hc8b37+oaKCdAAvMSTsx66xxwe24QTA16bobPojqDjif5ez8mWN4i1lDMbcReLVY6m7z
         5cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY4yj9c52oXZ2jWS1wKDWOQi2s1UaHS96yM6OzNUtkQ=;
        b=o7S4dYhqU6pbti1lfSERRHyrHi4Lglic/gXBHQmBy49tIFPN9llKQtzhyYk3G1We6+
         vF9y7x9AYzVQOtms4cwFbDH+E7N6tSFzrSsqJIDuDaOqozezGm/EUyPJY4usaJ+vfjPc
         4CCe3/6D/2NchFrQ1z7XaZafyEZOT0BQn6Gp17lrLISUtuI5rLZkVX43ingRtdHOgOvx
         ftCHnemzyLsYELeUBglA7MMj9+32/A6HEDbh3UxQfSt8HROyApgnWOn1MnDhXz9WSiMx
         ZYs+BLLCMSN9FUOvYkWpjlf1oujm4w/KV382h1H9yR4bF8QOrgBoXDO9iud/85ZHn6or
         lwpQ==
X-Gm-Message-State: AOAM531ERleYKrhn+ZtOscBKQ71GN6gPk5nfzDlb+XVTZydBdLMT2ft3
        wwcZP2NhG9kArd4FK37ywdsM00cGQzzupxv9EeCbTA==
X-Google-Smtp-Source: ABdhPJypYCEj58QUBMMWF8HLNAkwydZlcTVlbef1RmaxQLKbAxhCK9jmVIFdYzld+qcFnxYeGlu+V9Mh9X9aFB6fgIs=
X-Received: by 2002:a65:40c3:: with SMTP id u3mr10617456pgp.305.1590791327745;
 Fri, 29 May 2020 15:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <11459cde-7f57-c95b-8cac-4301f0a2390e@gmail.com> <9d75a67b-87f0-161c-02d7-c9fc4efe97e7@intel.com>
In-Reply-To: <9d75a67b-87f0-161c-02d7-c9fc4efe97e7@intel.com>
From:   Tri Vo <trong@android.com>
Date:   Fri, 29 May 2020 15:28:32 -0700
Message-ID: <CANA+-vBURc0ivB=UHXK5Xg_tVJOV_h9Uz_Ke4ZG3Gu_sMhfTvQ@mail.gmail.com>
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

On Fri, May 29, 2020 at 9:51 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 5/28/2020 10:46 PM, Florian Fainelli wrote:
> > Hi,
> >
> > Commit c8377adfa78103be5380200eb9dab764d7ca890e ("PM / wakeup: Show
> > wakeup sources stats in sysfs") is causing some of our tests to fail
> > because /sys/class/net/*/device/power/wakeup_count is now 0, despite
> > /sys/kernel/debug/wakeup_sources clearly indicating that the Ethernet
> > device was responsible for system wake-up.
> >
> > What's more in looking at /sys/class/wakekup/wakeup2/event_count, we
> > have the number of Wake-on-LAN wakeups recorded properly, but
> > wakeup_count is desperately 0, why is that?
>
> I need to look at that commit in detail to find out what is going on.

It would be helpful to see the contents of
/sys/kernel/debug/wakeup_sources, /sys/class/net/*/device/power/*, and
/sys/class/wakekup/* corresponding to the device in question. The
values in these files are queried from the same struct wakeup_source.
So it's odd if wakeup_count diverges.
