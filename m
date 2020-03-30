Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA9C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F50E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iK+mvsHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgC3SmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:42:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38126 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgC3SmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:42:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so16649180oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMsXSbAs23J4I+WSSJ1Kd7A3MYfRXPuuAKW5ma32u/I=;
        b=iK+mvsHDPS4OGPtKBhNUq8BDbqZv2bYZ0L0DQw/gj5t33XpHM9/YA31DtZAD4rBMeP
         1t8tFJ2WveKx5dFYrefqwMcbo4CSa/Y9MMF/ncPsQjG3b0p4phy6U3yL5Si/Ah1Fn43a
         AJumYtdIg8ZPcCb3dK0nTr9VOGbQ1DaIPozIHo2ToTVkOLBstZ4z4tftDP7S9Y2rqnz0
         hs04gOoEn5GnU6PG+pjcCeLrAkx7tSvFA+MZ2l96TcgZ8PeEf+06kP8UphWexpVJSBuO
         jkl0hUv+2xfXwpxlu3Wfk3jNKjnyn20X/cuvPzxZQ3BU/DytfJ5qlBgwDGBHLMxSKP26
         jPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMsXSbAs23J4I+WSSJ1Kd7A3MYfRXPuuAKW5ma32u/I=;
        b=QprUP1W82RKy7sfk6mh4rVpnU6rDLyLNJFnF1crB7z80Dv/12benWASfu1m+Jxbu65
         YQkz0+mRXJYOWgnGfJMe3S0NvEleavlBosYszL7XX+0i7AZQxKODm+InwrCaaBZhDaTp
         Qwz7J7Q4ER4m5Lg2mQ/cRSTJageyMBD+yv4A+G+57dF7n+OsiWAjl4W6hQHJI3xaZwUU
         XOatKWBMWEAt8McwHmNjlqduetEImn9Lct73uhc+9SX8xV+Gpd+5kQWVkV0KNL3HvEHa
         eSX7Fv2iHIuBHpNSx1o8BST3vwYy1U8jj2TMt2jZLZMKkmRMmdtCV9pyiE2AlEDMAzcc
         mNoQ==
X-Gm-Message-State: ANhLgQ0k7Ba+Rr8Hw/PKZrKcH88lq/gNdnLGTj8AD7Ij10QXjooQAS+a
        q0bZIwbLaWK/vPJ9iCdy03GBxhIDMOv+BAwBV55Ntw==
X-Google-Smtp-Source: ADFU+vu8a0aFSp1Bsc6H0PWmUghHP16f0fOcxJ31iseInDunbVcIAiBxYijOxAbVRtDSEW4QOHql9nkcF2nT/W/I+MY=
X-Received: by 2002:aca:f541:: with SMTP id t62mr548350oih.172.1585593721353;
 Mon, 30 Mar 2020 11:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200321210305.28937-1-saravanak@google.com> <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
 <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com> <20200327152144.GA2996253@kroah.com>
 <CAGETcx-J+TP+0NsOe75Uu3Q8K6=qYja6eDbjNH2764QV53=nMA@mail.gmail.com> <4f3326c2-186d-2853-fcb6-1210d67a836f@samsung.com>
In-Reply-To: <4f3326c2-186d-2853-fcb6-1210d67a836f@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 30 Mar 2020 11:41:25 -0700
Message-ID: <CAGETcx9nhF4hjs6BQ21Ees4LJLM7kENj6Ja619Sonjvvt1o7wA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 11:20 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 2020-03-27 19:30, Saravana Kannan wrote:
> > On Fri, Mar 27, 2020 at 8:21 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Fri, Mar 27, 2020 at 11:25:48AM +0100, Marek Szyprowski wrote:
> >>> On 2020-03-21 22:03, Saravana Kannan wrote:
> >>>> Set fw_devlink to "permissive" behavior by default so that device links
> >>>> are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
> >>>> firmware.
> >>>>
> >>>> This ensures suppliers get their sync_state() calls only after all their
> >>>> consumers have probed successfully. Without this, suppliers will get
> >>>> their sync_state() calls at late_initcall_sync() even if their consuer
> >>>>
> >>>> Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
> >>>> that needs more testing as it's known to break some corner case
> >>>> drivers/platforms.
> >>>>
> >>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>>> Cc: devicetree@vger.kernel.org
> >>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>> This patch has just landed in linux-next 20200326. Sadly it breaks
> >>> booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit
> >>> mode. There is no warning nor panic message, just a silent freeze. The
> >>> last message shown on the earlycon is:
> >>>
> >>> [    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
> > Marek,
> >
> > Any chance you could get me a stack trace for when it's stuck? That'd
> > be super helpful and I'd really appreciate it. Is it working fine on
> > other variants of Raspberry?
>
> I have no access to other variants of Raspberry board.
>
> The issue seems to be related to bcm2835aux_serial_driver. I've added
> "initcall_debug" and "ignore_loglevel" to kernel cmdline and I got the
> following log:
>
> [    4.595353] calling  exar_pci_driver_init+0x0/0x30 @ 1
> [    4.600597] initcall exar_pci_driver_init+0x0/0x30 returned 0 after
> 44 usecs
> [    4.607747] calling  bcm2835aux_serial_driver_init+0x0/0x28 @ 1
>
> The with some debug printk calls I've found that the clock lookup fails
> with -517 (-EPROBE_DEFER) in bcm2835aux_serial_driver:
> https://elixir.bootlin.com/linux/v5.6/source/drivers/tty/serial/8250/8250_bcm2835aux.c#L52
>
> Without this patch, the lookup works fine.
>
> Please let me know if you need more information. The kernel cmdline I've
> use is: "8250.nr_uarts=1 console=ttyS0,115200n8
> earlycon=uart8250,mmio32,0x3f215040 root=/dev/mmcblk0p2 rootwait rw",
> kernel is compiled with bcm2835_defconfig, booted on Raspberry Pi3b+
> with arch/arm/boot/dts/bcm2837-rpi-3-b.dtb

Thanks for the details! I think it gave me an idea of what might be
going wrong here.

-Saravana
