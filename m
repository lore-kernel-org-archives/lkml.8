Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248452087F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgAJVTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:19:22 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgAJVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:19:21 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplsZ-1jSdpa14qT-00qE03; Fri, 10 Jan 2020 22:19:19 +0100
Received: by mail-qv1-f54.google.com with SMTP id f16so1449510qvi.4;
        Fri, 10 Jan 2020 13:19:18 -0800 (PST)
X-Gm-Message-State: APjAAAUsiOC3zMk2r9ujyEeH7EJWUFQTL0WU0yjWHHv4gBBQLKqi7zah
        j8rwVa9NubjxDLQnas1jidLsejCmdkFbLG3Xo4o=
X-Google-Smtp-Source: APXvYqy5wK+vC56zRznB04eTpDqAV2gRHUPdTKAUyVibf04636DjVPhWfvPInsakKLRo+OHcoYq8S5W/7bReST6sQSI=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr659084qvp.210.1578691158090;
 Fri, 10 Jan 2020 13:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20200110204903.3495832-1-arnd@arndb.de> <20200110210512.GB30412@brightrain.aerifal.cx>
In-Reply-To: <20200110210512.GB30412@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 22:19:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VONV2Z6rs=xpntJyzfX4W7YijqCFr-f-PNMm3g4zRyA@mail.gmail.com>
Message-ID: <CAK8P3a2VONV2Z6rs=xpntJyzfX4W7YijqCFr-f-PNMm3g4zRyA@mail.gmail.com>
Subject: Re: [PATCH] hcidump: add support for time64 based libc
To:     Rich Felker <dalias@libc.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Guy Harris <guy@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rtxui59CJ5xuEVT6IirkewdYJ7AP5pwb7Pe29/I0bQq1eMa0zXj
 TOVEzomIhUv5IEoFBkKp5JjUKFDxXFYICB5piVOwZehCvgCpa7Szd8+Mk5/ev4V4Cl6eevx
 Ux8HVlO/ZQtB71ovIuaD+wafZ3FbY/G1GMPfeyRq0kH4eYxV25z31E6rmcYJ/sVPD2oVhdX
 cqSYnhpqClVhkiaB7GZWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IF74hMw5nu8=:96J0uBuMxqSGP4jmpKoAst
 dduSvTRltq/MIg0WBHdgXJhwalbHP2bnKgiezFiokMhi6mDs+Snw67js2ZJEbh9VjVInAUP7q
 N+sDPYPUkPBYdfRgTdX3UXnw181Ev2xNtVodHGrqPZ5uDlVWPNFcJL0sZh7PuPjepgonw5HDZ
 R2w7k1j5Zu9YR4YZtVElfBmrV6okQkfm73v4GtEzfwgomNeJZ9cQOIiacnQUvIJiILE3EmORm
 LDtDlS61EAqDt0+vT67l/ssb+MOZlK0i1WlChd+QKM6Z+5nbiUhWosdcK9G9EjGH1az6cTZ5m
 K8nWoZrqU/1QVHrMkFDzkPS5IfNTU8k8surZpc2ceodwT9zHFgXgj1wnxq2XOf5xQteJuNn2V
 b152sj3Og4SWiOa18A727gMJfi2ZD1N2KcRmhLKUJCAAj2W5ckZzSmng9UD8bFKSjIMrKCEfy
 QeNRaPfQ4u1D1Riic1GGGQPzyfzoqhrOdLPpQqJO/9xCiHfSlNMrg+jaDE0FzeeUcVgxWkRYJ
 HYzajBWGW5B9ZhzRxvMjrUXXmK6aolTlAZJIY5jplPV31YABb+b1FBT7Q+vwwWwSDrfBJmiUf
 O5SfbNUyqiLb2EfDToEXbD6EJp8Ryc65Qq+Gx3UQXEgyj/52+eLGk/Ek4VCQ0Xt/6gKQmPbg/
 84CHjS/HuBRbMfEfoXQvcJk+LS8/o1gGOKEyKF+ZH/CNEOpgl4GIi2R2cOSWzEGbwah2A0nWS
 LRtqN7COPGWAKq2oNEMNl0KB2CIZWlfcNhkppXQrh+qsfVS9wghG6CgIhTW7xCw/BRKhFAHvW
 iHZhexlJXHrrjFhUK0lu6OaVp84xl/OQ2/It/jekItGB1YCw1hk4SoCfqASo6GoiZS0B9ZI7F
 PO2c90vv4PkHHOv72eug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:05 PM Rich Felker <dalias@libc.org> wrote:
>
> On Fri, Jan 10, 2020 at 09:49:03PM +0100, Arnd Bergmann wrote:
> > musl is moving to a default of 64-bit time_t on all architectures,
> > glibc will follow later. This breaks reading timestamps through cmsg
> > data with the HCI_TIME_STAMP socket option.
> >
> > Change both copies of hcidump to work on all architectures.  This also
> > fixes x32, which has never worked, and carefully avoids breaking sparc64,
> > which is another special case.
>
> Won't it be broken on rv32 though? Based on my (albeit perhaps
> incomplete) reading of the thread, I think use of HCI_TIME_STAMP
> should just be dropped entirely in favor of using SO_TIMESTAMPNS -- my
> understanding was that it works with bluetooth sockets too.

All 32-bit architectures use old_timeval32 timestamps in the kernel
here, even rv32 and x32. As a rule, we keep the types bug-for-bug
compatible between architectures and fix them all at the same time.

Changing hcidump to SO_TIMESTAMPNS would work as well, but
that is a much bigger change and I don't know how to test that.

     Arnd
