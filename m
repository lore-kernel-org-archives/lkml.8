Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050AFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0E0208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGQOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:41:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgGQOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:40:59 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MmlbE-1kfvQq0NU6-00jon7 for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 16:40:58 +0200
Received: by mail-qk1-f182.google.com with SMTP id b4so8918378qkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:40:57 -0700 (PDT)
X-Gm-Message-State: AOAM531NlNprPR37VEVuovgsBIYHdKec0J3ZyaHuQxisdN97wzGQ/FDG
        J+zSN3lwRTFFcgLZGldopN+oM90FcEEVZ57gRQg=
X-Google-Smtp-Source: ABdhPJxIcF8vwnp0qlWkBZ2jacN8S+e8ZPeTj18xeEiqZH6jYoetb6kHP1NbTFSYs+6r9g0cHu9TmhJ++ld0ikNWcvo=
X-Received: by 2002:a37:385:: with SMTP id 127mr1501317qkd.3.1594996856943;
 Fri, 17 Jul 2020 07:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com> <20200717062841.GA3238569@kroah.com>
In-Reply-To: <20200717062841.GA3238569@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 16:40:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yy7YyeJH5k40yAXb23y9siBnfuqixb76t3BK9Xh=uXQ@mail.gmail.com>
Message-ID: <CAK8P3a1yy7YyeJH5k40yAXb23y9siBnfuqixb76t3BK9Xh=uXQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jmBE62IGclXB5niXcc5j3HwVyA0Ygawm+0CTDTm+b/DcRL/2HZC
 PTx6xLD+KZjGzfRIE70+JBS42t2yKnKk/avo08NmWVCs6XqOBLLdT3YLXcQS+F2m7ktLxas
 l6/zHyDlhPpjYj2zht0IoUPY1ijoaUwcuMvSuCqwcSvb5g+ks1Wsk2uhPj/1AXkjYxMICeJ
 JTlD5Q7x/qOf4VtfbFpkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l6e3i/+zxio=:y1bg0rJYMvqub2Qs0cH8um
 VBMZ3FzeJ4EjPV0KjwSe22WfNlc8VWPhI2LCgqwP4yVFCuscdmNN65uQgJPoIYAYHbKPqLhI4
 2SxWfYAaGDfBUc9mwBrcZY0dTd3LPeh4RTYB+YtYLYnPhGNlsZS2NaPt4ei3mZQKPJ6vWu/aF
 yYMnewC1qhv65xRa0BPE6zl4q1BzsQVNsoT7s90AtE3CHUV0+zsN5BUuzv8XwyOjkWQD/0Ewb
 Rph5zRmgW0qBRxQUhr5OWOnsGW1aibuGCS9McMrWtZiOUBie1QonFEc0j5O+WHB32pHW3CAqO
 hH0PM828zC+ueXE94zg5UuSJywMftm0e3uYpjdGQichkU56hgwPVzH3RIT+ZklWwzThB3roZ/
 o7k/9+cRahyNaF7YoySHRRmYrmm0OZKKjGjH3a8DbW/uk+p55suQbp61bt1cYjle84TaPkoPQ
 GczUc0kZk6wqwqQMSynP056qcmRF/JlyZ0USEtIDHa0Kqas2PITHypvZi9IfhcSsvDUUgf87X
 tDn9+PbNM5pcC7EEY8IjBfvuYOWtj/dSHILL9fdN8sGPBJrA4RB1K8ojl/aNjC2aE3y27+uMY
 T3RsQpFW+bt5q+i2CS0L03qpYBb1iTI2YRhwEs0roi1F9GlkvRdvLBx10buGJriw2NkZ3mPS/
 uPsUy3DHYqCD5RM/8qCDaa41cMRjDH0lYJOMIGhfS/zeDYWfa+l/nwzzbujySGKUD536wmMp+
 oiurU5+8Cq6DjBduECBCaSH+xLMlwPvY2D/DWVNTIFBCmSSvemZQK24ocJZOnfChafE7LXflY
 9uXqmG8LAbLFoS0DBaNgMuWu86MFoMi8VXe+mNIa/7xEJWInWegg6yBli7QS/zu/ofBHujWjb
 LKSTcSY9d30CQZYUB+oYqsDWejAEFmIzYqteJ2NqimKVVaFE4RPy2HWWvOZE9XRaxOZD56U0g
 KR4ZL1F3jHLYorJmefPUltR2ajbkOXCclnHXTR4hSXfDi2PXShgzU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 8:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 07:36:27PM -0300, Daniel Gutson wrote:
> > +What:                /sys/kernel/firmware-security/bioswe
>
> Ick, I stopped reading right here.
>
> No, this is not where this belongs.
>
> We already have /sys/firmware/, right?  And firmware-specific
> subdirectories below that.
>
> We also have /sys/devices/system/ and I think that would be a much
> better place for this, as it is easier to work with a real 'struct
> device' than a "raw" kobject any day.  Bonus is you get full support of
> userspace libraries when you do that, unlike when dealing with kobjects.
>
> Also, this really is a _SPECIFIC_ type of firmware that supports these
> features, right?  Why not call that out too?  This is not generic by any
> means.

As I suggested in my previous review, I wouldn't worry too much about
the user interface at the start, but instead first work out how the hardware
support fits in with the existing drivers and once that looks fine decide
on how to export it to user space.

I agree the  /sys/kernel/firmware-security/bioswe sounds like the wrong
place, but I'm not sure if adding any other new directory in sysfs is
much better. I think the most promising would be to have it on the
sysfs directory for the device it refers to, but let's first see how the
information gets into the kernel.

     Arnd
