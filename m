Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0679C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9232074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGFJUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:20:48 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:20:47 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MDhV1-1k1xoB2MK7-00AkN5 for <linux-kernel@vger.kernel.org>; Mon, 06 Jul
 2020 11:20:44 +0200
Received: by mail-qt1-f177.google.com with SMTP id g13so28382647qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 02:20:44 -0700 (PDT)
X-Gm-Message-State: AOAM5314Hs2OHzNIaFIwYmD/KlKkj24s7SmwvXPHaHYgIghr3IWHkAHt
        /G7NosgWgjtwh10YKjsTCI4gabcEekHr93XyMCc=
X-Google-Smtp-Source: ABdhPJzL5OV0lWdEwJ4376Sf2NzOTtKnrdcdyWsvtwuC8GD4Ckid2ZP0O4KLmOxecB6179+7Iza40O2VGDSmKAipJjc=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr48889319qtm.7.1594027243359;
 Mon, 06 Jul 2020 02:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
 <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
 <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com> <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com>
In-Reply-To: <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 11:20:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2G_UzKv5HmQk1gyaHXY+YzVedknwof+9fmCjQuF+hu2A@mail.gmail.com>
Message-ID: <CAK8P3a2G_UzKv5HmQk1gyaHXY+YzVedknwof+9fmCjQuF+hu2A@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Xwe6Ulj16Eu/nYvOOYX3mYAWJPsfJoYMWeBWl1tNxx73BkSQl4B
 Ku1btjB5Rb3JX1V/f1gDIy5BKusZYTfht7GZM05SHTCAxkFjcKzS6pK3/K9HOqIqujHz3bn
 M32Ebv2D4tWxvG9Dlnopt2sF0OUf5poIdQpy9Zfd94mY6CjXja19wKKfhoZ32gla9bhgB9L
 R7Kacnig01QeeT7TO7xZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AP9py/bOyLI=:13IsYeuM3bnR0buIt5Jl11
 PC1l0RM032QOu54uJBZD+tOOp7B+SM6lLDLmLI5RnK6muwu1d7z77zZx3lJFkcD8IeNkpcYJz
 Oc27jvuFWkvQquX0cHr0EPogMZ1GJUv/i/0WV3Ik8hiyZ38BNLKIBC0yenjqBiA8XXFRxwKIm
 lHrnD1INnbGp8zp5z2TP4ygaMT81Sw3v5rVGxbfaH1/yQYTO3N67SQ2d3WRuuAuTURMOCoLk+
 Im9UDV0r4sZGWqmY9fVAIBgN7eII26KQ9od1KJhpiZIYqdYHptpY7W3sGIzXL3B/qf1GWw0JO
 ArbJSUQ0rJ9K7Xzu01r4JgEzt2AulkVL24argJIyE91HUKpPMP76Lxs4gHmrcqerLlzY6hGDF
 hB8KaUoKaM6cbx0oNvkTY+MkRn/GGjwSI9ApHZ4oduD1VZ/OHZzij2OvkaLNB8s7Tc/9CyFlZ
 2B9RCPBzBzm9wspYQZym3kAtUZ7RZI2NspRAH34GjUO6DPF8sT5EtgMEOtHNf5SdvYYgV5uPi
 5TxBKuAJs0pRNBV6Tz9Vm1JQX7qTQqrj8oYbknX0Z93TZnyDqUga/WdMtYW5sMy+0PJ7xPWqd
 6i9N1wVIfFzklpMGkZTUYayp29KYKVqxs/VMVLJTkQEs2nGrcVMuqbj0BNBybnQVgbueeRg/l
 aniFeikNo+qRghqwhLq+9wx3xP9rmCwIgDHttwAnmKnYtPOEZsSlwuckKl4gd+mbw0VypxX5X
 i8cTmvZ0ZVU6NJxTNLdh65/2xPFXyGN3tMBFG7Z1GHIAM6wCIlHlfInZ5rXLLb/zsZsE6zdWi
 jEz2suqIdm/TMic5lTN+kQsMZO9hzUocbniOlG8gROTSBDvHY0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 10:43 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Jun 30, 2020 at 5:58 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> After analyzing the intel-spi driver, I came up to these observations that led
> me conclude that it is not what I need to use:
>
> * Some SPI Controllers have 0xFFFF as their VID DID bytes in the PCI
> config space. This causes that the PCI devices enumeration doesn't include them,
> and thus a PCI device driver won't be probed even despite listing the DID
> that the datasheet specifies. I effectively confirmed this by doing a PCI device
> driver and trying the intel-spi in systems with this characteristic. In short, the
> intel-spi driver doesn't work with these systems.

I don't understand what you mean here. How do *you* find the device if the
device-id is 0xffff?

My impression was that the spi-nor host is not a PCI device at all
but instead is a function on the mfd device, and probed as a
platform_driver with the "intel-spi" name.

> * Additionally, there is a difference of functionality: the intel-spi driver is a MTD,
> and -despite it effectively contains some of the DIDs my proposed driver
> supports- it doesn't offer an API to read the BIOS related registers (which is not the
> function read_register, since it reads chip registers). In fact, note that it reads
> HSFS from the PCI config space using MMIO, by just reading the mapped
> memory offset. The read register callback reads a different type of registers
> with a different mechanism (eg it does a writel before a readl). By being a MTD,
> it doesn't need to read for example the Bios Control register (which I need), or
> other registers that I need but are irrelevant for MTD operations.
>
> I should add a new interface to the driver just to read these registers or an
> interface to read an arbitrary offset from the mapped memory.
> * Finally, some of the registers I need are present in the PCI Config Space

Config space of *which* device in particular? Is this the Atom MFD device,
the SPI-NOR host, or something else?

> (others are in other places), but the offsets (and/or the offsets of the fields)
> vary depending on the architecture of the CPU or the PCH. That's why I
> first detect the architecture based on the VID/DID and then use the appropriate
> definition. Moreover, there are cases where the same registers  is obtained
> by reading the PCI CFG in some architectures, whereas it is obtained by
> reading MMIO in other architectures (eg Atom). All this information is provided
> in the Intel's datasheets.

Is this MMIO space part of a PCI device BAR, or how do you find it?
If it belongs to a PCI device, which one is this, and why can't there
be a driver for it?

> Because of these reasons, I'm proposing a misc (not-device) driver that supports
> many Intel architectures (and families) to expose the information.
> I understand your proposal to first enhance existing _device_ drivers, but I
> couldn't find suitable options.

Maybe try adding an interface to one of the drivers at first, and then extend
it to the other hardware after an initial code review. Do not bypass the driver
model or try to do everything at once with a single module that knows
details of multiple unrelated hardware implementations.

     Arnd
