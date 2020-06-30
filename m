Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0361A20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbgF3OZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:25:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgF3OZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:25:14 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ml72g-1j7LbY1mKS-00lSoo for <linux-kernel@vger.kernel.org>; Tue, 30 Jun
 2020 16:25:12 +0200
Received: by mail-qk1-f173.google.com with SMTP id r22so18676249qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:25:12 -0700 (PDT)
X-Gm-Message-State: AOAM531h27p37htckVaypHqhr8pfW4I1eo0DH+423UiCcR1uz2a7/nFQ
        7cmldN/A/Ys5BvqBCvW9i5DoBiitJWdMie1H2tc=
X-Google-Smtp-Source: ABdhPJzHWKiGJ1Z0Mreyo7yGeI+Q9qFWTvwyJHytFzy4UQg0uSNSyGgbvwWjVBM3TG3sQ7QDIn1fFb0Pz+SHH+m33CM=
X-Received: by 2002:a37:b484:: with SMTP id d126mr20249897qkf.394.1593527111290;
 Tue, 30 Jun 2020 07:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <20200630085641.GD637809@kroah.com> <CAD2FfiHHb=yA6MRsw2rPyJinthhFPNH2k6sLbthxcYVVaX5Mig@mail.gmail.com>
In-Reply-To: <CAD2FfiHHb=yA6MRsw2rPyJinthhFPNH2k6sLbthxcYVVaX5Mig@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 16:24:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1t5t1FV=c=gg9LJZccVKSgU4QkjF8FCK_ReHEQh4zeAQ@mail.gmail.com>
Message-ID: <CAK8P3a1t5t1FV=c=gg9LJZccVKSgU4QkjF8FCK_ReHEQh4zeAQ@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MqOyAIpgFYMrb5ombJLrrvqUBVvK89ETVRvGrbFvdxTihFILLSs
 EYDRnhOOqH4Lgvs4vBvqgGJ0bFapdRr7EMMFoKpSmVf77RhcI/nCqsU6+2eu8v8xCtWx8wI
 +E6gsuWz5Bjj5W1qQ+bzYThWciCseMoRhiFuBob+FLKxnJyyW12Hfr2imO861YtDrmmWCiw
 Bct+PpmQ1CBNo0UTiSk5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mUk2zHr6dFs=:scqvBwtKaKszBeNQFqNqjj
 /d37aRKfCXwuQ/WqvsaVJFzK6IHcC3x+CLsKNeyRClYeB3FgMWM2zS9GrMKZuwUnm+2FpyvyP
 lJeqWPwiQpBjy+uoB/28k7CYZw10/BmwnG29mzAW8/6oR8rPYbVMkX7D9th4posRb2DDedFY5
 OkX5BZ0IZEo7ibmEW7iJwzjtoA/ybefEvdnDmO2PynVaQoNqMBxyM41py+h2VfXDKxEhcUFxW
 4ZunkuBFI6gems2Uo7ZnICKd27wuPvYtBdRpPFyuwqVuQphVbjiCnNo7KRFSOLsoNgaEkm9K3
 5icvNLybnLegs2LvigGsZt8mYKsayBoEIC1Wi3Dg75mvL056EqI5l0sJyFHTfJLVc4iZWlmTS
 GjNqSAuwyl2Lg0F82C4Mu6zMeuAG+NqpS9h9lbk6ZS8n9wFJbZfQCqWLzVnGifr6JEK4PaNj4
 Cqo6PVXLvmbBjNmDt662HLwam/1B002ircNXHIdf6JB1AhBhsroxeuvUsG2OhynJ6hdHUeC2j
 xrPYE0nBsRXJ+0mdrNAcjhwSQiajoq0H2Punu3PvLnAy5NPDF1E14MBUsn5twS9CIewNZ5gc4
 pAtkKETMQH4lDqaEgt9a/dWMoKhinXKYzGY63lB8qsZU6G9/7r3K+L3Z+4zj2w9AIPNzL7N61
 YPpH5QyK6Z4WOnqE2qH0lvMKDOTfCSLEvzp3gIw6lW5zuuIZebTK1QNMgrn2wWCggCZDVhHPN
 elxHrW1LIYFCSWouMu3iSSQngiT3ZD+ofIdVrOzkXhM9AgBM2TS0aqVQVHdTycwIu9ECn5BFJ
 VJ/uz+yOkLsaDddiNh+dlWX5O9J4IU3vlfeRETzJaUDoGvBkC7OUvj26rawNYkIP9xa2JXQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 3:57 PM Richard Hughes <hughsient@gmail.com> wrote:
>
> On Tue, 30 Jun 2020 at 09:56, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Again, which makes it seem like securityfs is not the thing for this, as
> > it describes the hardware, not a security model which is what securityfs
> > has been for in the past, right?
>
> It describes the hardware platform. From a fwupd perspective I don't
> mind if the BC attributes are read from securityfs, sysfs or even read
> from an offset in a file from /proc... I guess sysfs makes sense if
> securityfs is defined for things like the LSM or lockdown status,
> although I also thought sysfs was for devices *in* the platform, not
> the platform itself. I guess exposing the platform registers in sysfs
> is no more weird than exposing things like the mei device and rfkill.

Why does fwupd care about the platform then? If these are
register values that relate to the flash device and that device is
what the firmware update gets written to, shouldn't it just use
an interface from that device?

       Arnd
