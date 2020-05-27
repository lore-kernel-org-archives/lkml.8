Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC08C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D020873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbgE0OZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:25:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbgE0OZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:25:51 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MI59b-1jpjMv1eZb-00F9rM; Wed, 27 May 2020 16:25:50 +0200
Received: by mail-qv1-f46.google.com with SMTP id f89so11225959qva.3;
        Wed, 27 May 2020 07:25:50 -0700 (PDT)
X-Gm-Message-State: AOAM530J/ckRqqA+V6QbZ5aZ9lO5J2vW4CTdKt1ErPkbJivtgRc2Dljd
        fJf4llLUCeE4D9RTvWWwzk7NfK4WVOoTsZQZo00=
X-Google-Smtp-Source: ABdhPJwTzla3NmSa1mJK6JbiU0wve0aQ7njgHCnP8j6rCZASppCyhQtlSLcn6p/n68/fn2r6wcYO8Ty/YjpZHB8wRVo=
X-Received: by 2002:ad4:58cb:: with SMTP id dh11mr23498548qvb.211.1590589549159;
 Wed, 27 May 2020 07:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134320.869042-1-arnd@arndb.de>
In-Reply-To: <20200527134320.869042-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 16:25:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TrR3qkKgY78D0VybG3H1B6AauzTiZ0=jP57QM5MkjTw@mail.gmail.com>
Message-ID: <CAK8P3a1TrR3qkKgY78D0VybG3H1B6AauzTiZ0=jP57QM5MkjTw@mail.gmail.com>
Subject: Re: [PATCH] usb: ehci: add struct entry for broadcom insnreg
To:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        USB list <linux-usb@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:uts/YM7wttCkfCQrBQhdtEzZfRPw12bbrftZwZGM5czYIh046gG
 RjXCIuXDApEjSnuudi0XLYIaZ4DPVGYCmPQw52r2moG15Ncag6iPgazy/VBMkywr/bMlsSA
 +skUApKQlUhpn6WlzZXT4d0Lpk1GiBl4SU4DO6E+EGa+EMxa5TkVdgiubRnl0gXusfVmt4y
 RgA5XkBYeR4qLYPCVTNYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O40RoDwja6E=:uts8v7j/FtLB5w2RaALHMq
 OOCcocy4njfhO7PmN8l6Ovfm1kGQ3xejRvMRZExVC5BnfZN/svALzWO/MjymjWsfVqUsubBBY
 R8mzn4QHSQTTuqd1YHk24D3VsGJMMQOfO6fFrAGVyB0GQyipKp3ipeQGbOSQQque+IUZ70hNT
 oHtVKczXiKkH4UZ0am9AMNEu2/HMDGkLGCLpsZrvw8FGJqgPgyC4/56/v0NyyH6ok7ZZ8Zci+
 B98diH1R3RSNWTJbFYaX/hvZFkkwUSuD5lx2xkeNc7ZCO5yzCfLruWFlNkHxya7D46wZsblZa
 dCQ7m7HoLebhee7sREwKOpFrB7+e4cvcLubLUM42Qz4XyygbFCR0JYKJhpnHII+yYyTgEYOOp
 /tjzt5Nf9kmGEiq7IgDsB7dIgQH7Jksb4W8Kwez32+FkK3cSBFuq4RlU7yqnDOAwg7P41RKPY
 gjNq4u9c6Oh8HG1ifEYnwWWpM/0LrD3teMU7R93LDv7erMbFIVZHCF5/k0C51b9Sve15HMkdi
 mq3Sk0YAHzQh6o2yDeW4o97QM0B4EGfGpSrAbX+QbpVVR5wi7VbZfXrs5G/QfJ0mQ16rHzxqH
 qsE3YHD9ZKhN49sW98b90umQ4YtCBVuRiLpsph6M5w2nBVZb7X5ZZi3D7N6qum18gfgMvVYK5
 v8niRf6lutiP+3FxmOBWdpoeH5aNYarsN2KOkCa3LmTsEZZpXIyqRm0+yMTCyL9ofrZ48kmyz
 wS1n6+AX7DTc+NcuLCLuAbui0fHREr9Fu2oYd0Q+lZBjs4z4VTLn6icyiSRQ1gAXdoAvbZQU4
 G4WMtGd1kZgxa/lO46vrS2eSeuvyhvwzJFGPlMipmsv4IgoI+w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 3:43 PM Arnd Bergmann <arnd@arndb.de> wrote:

>
> Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
> Fixes: 88aa39691cea ("usb: ehci: avoid gcc-10 zero-length-bounds warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Please disregard this submission, I just noticed that the 88aa39691cea
commit I referenced is one in my local tree, not in linux-next. I'll make
sure they are both good and then resubmit them as a series or a combined
patch.

        Arnd
