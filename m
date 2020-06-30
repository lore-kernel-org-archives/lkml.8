Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D52A2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgF3U6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:58:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgF3U6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:58:19 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N49xZ-1iqOsL3Upd-0106Tf for <linux-kernel@vger.kernel.org>; Tue, 30 Jun
 2020 22:58:16 +0200
Received: by mail-lf1-f41.google.com with SMTP id u25so12249884lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:58:16 -0700 (PDT)
X-Gm-Message-State: AOAM533cd0cnHOcf34k50qmPJjdIavBkXzY6BvmWVv2+Doe03YCwGqka
        z2hvWMquqbKvXDBZvhmBRruKpCBwAqxdhglIfDc=
X-Google-Smtp-Source: ABdhPJwbSqt9LN3Uw1yBCPaf8HBqECdZSB91uozzccAL2xYxsVAx61lvqVZFqCfvTc7pG7h4rvywCV/pS+rFxt51ZaA=
X-Received: by 2002:a19:ca48:: with SMTP id h8mr12970399lfj.161.1593550696202;
 Tue, 30 Jun 2020 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com> <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
In-Reply-To: <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 22:57:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com>
Message-ID: <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nrsMriwznsm44FAhieNgecKX4Bh0Daeo89xvPyHRsDokUcblcnB
 gUtURX+snIroJ7if7AKDMnQSNp7QueBhXiEMrQRX6u/ZIzwmbV697cIpVTecIT8mHONa+R3
 APSVxzmQIlbMaLvROdzVbLoRBm8q4W2RY8oorUm7yn8P15T3pUhTufDmO9xz0u3I2Bd/FW3
 bs9F3T93C2KHLMAqD2OVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JcuE5QM5PZA=:wvrNAqCvaJIc1/HiUVo2Yh
 Oxb+LM82Ed/fICvka8+l1FgG242Sv16lyc7mpMYXhLPRqAG4DJieZgbrHgSF+LP5rPGb5Ew0C
 bKxiw+D816d59XS8YAUmyIFNN0PLzUUoHHbbVRd4e0/S8QWrJ2fLgZO37Dg5kY//SwecQ1VBF
 jTSBUS/2mZV+abl/AZFLrOi27oiVfRCL09CZntHaQ+qMHDOFBzi7nIUKt0MBOr42dkxM4DskH
 fuDJtwV9KiNRqOKJnEAbfeWy21jb8xmUv9B96Y6HeVts55rb0PChTcKivuj0Z8FpHKvj1a8C0
 2IAFmc3a4xCrCy/goGAIfV5kw9IJuIdVRytPh/8SlzOE+BMEVXn3HvQj/TESAn6s+0ajv5Pb+
 yf/1YU/qB1yhD9xmeb5ChegjXF7LF8a1cx8NTdVNemApSWlhoNQQQhy5lC0qPKKH9cxi6T/kA
 qkB2ZlvNhQI1nkOkEdfXp2JLbEFGAU9KpF6jLgHRk/aOv9gWfcnIEE54kbAXhJUINN7+kQpso
 eBSBJSy7jygZNPH0UFB0DWAJ28zmdfFtb5ZKNBsDQZ6fAhS7172ZTxHFE9zIjt00z1mwNIcx3
 /4dVRtFuQADuXK4wBD8Xwd33RmVcexK9OHdldrwwTzlRr8BPDextLt3KblqbiUa6j+8y2SzB8
 mXhTfug241X73J5GyVGH5LSWNJyeHqlDSxg7Bjrw3NhvMf8iye3zKENosAjTL8CDumdLvjeOS
 f58LH88XRBfyb506uCeVBG3mX9iE07BTPKfP/bv9r2p8p2Lw2jZtz+TV05d2QOCFv3LdWKg8N
 ipOJuqTgx47nYuEmefm7GsQidUJWHiY6N4RsTvjb5AVayZfR/s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 9:08 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Jun 30, 2020 at 5:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Jun 30, 2020 at 12:59 AM Daniel Gutson <daniel.gutson@eclypsium.com> wrote:
>> The description should start with a little more background for those that
>> don't already know what this driver is for. What is a "system SPI chip"?
>> Is this an SPI host connected over LPC, or an LPC bus connected over
>> SPI? Is there a particular spec that this follows?
>
>
> "System SPI chip" refers to the main system firmware, which is accessed through an SPI interface.
> AFAIK there's no spec for this, though it's a de-facto standard applying to the earliest days of legacy BIOS.
> This driver provides visibility to the system firmware configuration access.

Oh, so it isn't even the SPI controller, just a flash chip hanging off
a random SPI controller, or possibly something else. I suppose it could
be any MFD device, or possibly something different.

>> > +int spi_read_sbase(enum PCH_Arch pch_arch __maybe_unused,
>> > +                  enum CPU_Arch cpu_arch, struct spi_sbase *reg)
>> > +{
>> > +       int ret = 0;
>> > +
>> > +       reg->register_arch.source = RegSource_CPU;
>> > +       reg->register_arch.cpu_arch = cpu_arch;
>> > +
>> > +       switch (cpu_arch) {
>> > +       case cpu_avn:
>> > +       case cpu_byt:
>> > +               ret = read_sbase_atom_avn_byt(&reg->cpu_byt);
>> > +               break;
>> > +       default:
>> > +               ret = -EIO;
>> > +       }
>> > +       return ret;
>> > +}
>> > +EXPORT_SYMBOL_GPL(spi_read_sbase);
>>
>> This function seems to be Intel Atom specific but has a rather generic
>> name for an exported symbol.
>
>
> It 'currently' is atom specific, but as I mentioned in the mail, the idea was
> to submit an initial patch with some attributes. The more platforms and fields
> I need, this switch will get more and more populated. This is about reading the
>  SBASE register, which in my current state, is only used for Atom. I can submit
> a driver with more fields where these switches get more populated, but I
> thought it would be easier starting with three fields only.
>
> Anyways I'll give up on the exports for now until a kernel module shows up needing the reading layer.

The problem is more the namespace: as the driver has almost nothing
to do with spi, this is not what the function should be named. The other
problem is that the function should not really exist in the first place,
as no driver has any business reading the register base of a random
other device that already has a driver.

>> > +enum CPU_Arch {
>> > +       cpu_none,
>> > +       cpu_bdw,
>> > +       cpu_bdx,
>> > +       cpu_hsw,
>> > +       cpu_hsx,
>> > +       cpu_ivt,
>> > +       cpu_jkt,
>>
>> You might want to avoid having a central instance listing all possible
>> CPUs. Instead, structure it so that the common parts know nothing
>> about a specific implementation and each one can be kept in a separate
>> file for easier extension.
>
>
> CPUs differ in register structure, not only extending, but having different fields too.
> All this information comes from datasheets that don't tell "this is CPU XX with these extensions",
> so sometimes it is easier to copy what the datasheet says.
> I didn't understand what's wrong with having a central enumeration of all available CPUs?

> This is a way of polymorphism, where I can just do a single
> read_[register](struct register* register) and then "browse" inside the register definition by knowing the architecture.
> Could you please explain your alternative with more detail? The user wants its architecture's definition, and will not
...
>> The driver that owns the MMIO region normally maps it once during its
>> probe() function and then keeps a pointer around
>
>
> This case is different. Please note that this is not a "device driver",
> that's why it doesn't own the MMIO region. This driver gathers information
> from the SPI controller only in the current state (it will be expanded).
> That's why it maps and then unmaps in the same operation.

To answer all the above points: This needs to be in a driver, and
in case of pch, that driver is drivers/mtd/spi-nor/intel-spi.c.

This driver already has access to the registers you need, and the
information you pass corresponds to the devices that this driver
manages, which in turn is where user space would logically search
for it. You can read the registers in the intel_spi_probe() function
and then add attributes to the mtd device in sysfs.

I think a good way to handle this in a generic way would be to add
members to the mtd_info structure and then have the attributes
created by the mtd core code for any device that initializes those
struct members, along with the existing 'type', 'size', 'flags',  etc
attributes.

     Arnd
