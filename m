Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D37AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D6120717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgGUUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:44:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgGUUoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:44:23 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MuUWi-1koIWl10WA-00rUec for <linux-kernel@vger.kernel.org>; Tue, 21 Jul
 2020 22:44:21 +0200
Received: by mail-qk1-f180.google.com with SMTP id j187so1937665qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:44:21 -0700 (PDT)
X-Gm-Message-State: AOAM532zD8rhU0UwE/NlM6oUROA0gSb4KgPrktsnMb4Z47ro05idAk0T
        R4f9Meo2MYS+0FfsN1JDzq9Lw2CFzTf99FB6aZ8=
X-Google-Smtp-Source: ABdhPJzS8YlEnDfoILDHvYT5YhoX79Kyk6uCEaWMKXqCPfS+dwZKn+76VKIhdZitLb0ncMD6RLZDDPOnq1+vsylZeNg=
X-Received: by 2002:a37:9004:: with SMTP id s4mr20272651qkd.286.1595364260101;
 Tue, 21 Jul 2020 13:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
 <20200717062841.GA3238569@kroah.com> <CAK8P3a1yy7YyeJH5k40yAXb23y9siBnfuqixb76t3BK9Xh=uXQ@mail.gmail.com>
 <CAFmMkTFLm9mw5-8Dj_7rhP2KBcLUoJ1WcQCJv5_k+QRsmJPxjg@mail.gmail.com>
 <20200717145746.GB3008378@kroah.com> <CAFmMkTEsm7CRBzEJSCjkhCT7NHvRUXzcgchExbnfFbwPjT0YFg@mail.gmail.com>
 <20200721105256.GC1678476@kroah.com> <CAFmMkTGtG6p48o9qSzYqQs8mJXiGAMw7b5wp2LLAmwcdhn2u4A@mail.gmail.com>
 <20200721182608.GB2586085@kroah.com>
In-Reply-To: <20200721182608.GB2586085@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jul 2020 22:44:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1e0pnGGC7tvncCLDizG3jhEds9RXJz359J0Jma5W=0cw@mail.gmail.com>
Message-ID: <CAK8P3a1e0pnGGC7tvncCLDizG3jhEds9RXJz359J0Jma5W=0cw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
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
X-Provags-ID: V03:K1:Jr6zfP3hT7GrP10HEIb/fAcpAg6OzZ8DGQ4TwtEJEj1eZiYy/go
 7LDCkIjGd/HdyIjbEChwsVlVqxeH575DaVrtn194WMYeZ69fi2xxtqehNVCh/GgUu9P9sZ8
 /pb+24VDxt6+Sa4DIiFg5sBPLvIiAL77SRwq5vEFNQvTfiV1vPzpsXccFs8r66rlY/rMTPB
 FNRhr8vI2HUd75NXLnGSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCNUwBhdnwE=:3zyWOLwfLNpNVyWjaEGTyL
 txDpvSU5yGOsQM8Vw76r8/sOyGEGKgXht2XUDSL68qoLHJfA7JU3GyKdVPugk8UUb4L3bANyd
 pv1XZ/YhU3b8hOuhZrvbZvVI14xIVsNS00kuEDStoCWSsAXIUStRrQwCqB6NQyFRQJV/ozeho
 ML8dW8TJsQ/wVNQLniofY7A8DBjL7pa6yJvcoRABPKXeEA0D/13x/JugLYLdfVk899lSuT2Bn
 2EKuTWRjvrxEk4wlaoCAPaIiN8KO4fGpY4Kfaxl00VirFLazLKNLi4Ndwdrudzc7wcaZZdWWD
 3rh3Gs1CBwa041FDM7Uk62/OKaD6P5NrtmtlVKa5Y+cHqT1g3lR11NgtkfB7bccdqq3FZd5Eq
 lfeBDCmv/pjBsKL7hraGKtqvRF/UF40DGOBpfLVFMqa/8j1+89ZRNZxpRMiYxoc0TFwkQLu+u
 3+J7ELuXIVrwUE1iQRI7UVUHTL3kB3kNKVfj5iKl4v57FWteoDRW/fiu3XzdZHWEW2+J7vxO3
 gKQcrfriBg2XsE6yrBGm/1Gi9lAdamETLL/clGd4bMkYn5D6sIyN/59kAxo6xgc+FqXKHHA0d
 zMF02UpsfKFf86ExBd5PaP84853vn39rkxe0xZ814QDnys6DdGEXRGL3oXPsvGF41HmNK1lSn
 lwQHdFNhwehKzwYTELou6TRNIdiSwz+gVMzLQLpcbHHGcXqJOTlzBQsXpeb2hwZeQd8S85QhB
 jHzJURXAOGoj+0KX0tlC6j/hcDtarS+5ssL3N6BfdRs33vUJwSTdqQANGQ0IaawF173jyZXOz
 fzEKrNDPYEehXKrhEHIMspJyJi31iyqgVyy1cQKPcQLmS/CqVt0nG153WKvqY11nXegYjet28
 KYWTXA0yoKtgSdcWk7m5cKdsOOeJvLwY6674jpE1Hp2VouPgtIszebiUhEgOzt0aOKUBxpnus
 QmdfDlPu1FgjRFl64Z/8x3tOXD6fTmzFcmrZzOeutRPwAM38EiwFN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 8:26 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 21, 2020 at 01:27:27PM -0300, Daniel Gutson wrote:
> > On Tue, Jul 21, 2020 at 7:52 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > If so, great, it should be a "class", as that way it is independent of
> > > > > any hardware type, right?  Classes show how devices talk to userspace
> > > in
> > > > > a common way (input, tty, led, block, etc.)  So why is this any
> > > > > different from that?
> > > > >
> > > >
> > > > Are you suggesting to create a new class, or use an existing one?
> > >
> > > Probably a new one, unless you can find an existing one that would fit?
> > >
> >
> > IIUC, Arnd Bergmann proposed that I create a class for each device driver
> > (in this case,
> > for the intel-spi, though I think the class would be spi-nor) and add
> > attributes to it.
> > In such a case, your proposal and his are different, mutually exclusive.
>
> Classes should be driver agnositic, and you should not have a single
> class per driver, as that is pretty pointless.

Yes, that was of course my suggestion as well.  The class is how the
interface is shown to user space, and each driver that can provide the
functionality would have to register an instance of the class device per
physical device.

> > For me it's easier and makes more sense to have a class for, say,
> > firmware-security (if I understood you correctly).
>
> I still think that's a horrible name, as that is not what you are
> describing here, but sure, a single class is good.

Right, neither the word "firmware" nor the word "security" gives it
any sufficiently specific meaning.

      Arnd
