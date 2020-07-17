Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB26C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFCC2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGQPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:39:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGQPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:39:57 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQMqN-1k9KcV3CDJ-00MMtU for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 17:39:54 +0200
Received: by mail-qv1-f48.google.com with SMTP id e3so4398539qvo.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:39:54 -0700 (PDT)
X-Gm-Message-State: AOAM533wCfrLJfS4zBVaTv5Ot90hMRQqPkz2e8zoHVGnyq+9lqFhwMzH
        havjYJQ6v0r6h71OF8KnHbagxSeFEvve9bzZ1J0=
X-Google-Smtp-Source: ABdhPJxRrNbbdhfqUDbrX5F9rMm9sYu2zby6QL6ExVOp71ClC5e17qHLUP8RHGENBQtdadkjz1skp5j4QtDNlvN8KXg=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr9104679qvb.210.1595000393645;
 Fri, 17 Jul 2020 08:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2miOXUESw+ayiEzAZ07NcieztVMEY31wUgrkD2tBAtDg@mail.gmail.com> <CAFmMkTG3rMtmNxYf0jXgGN7zJgK2U8Ogtrd4yH0Ee1rC7pf9Mg@mail.gmail.com>
In-Reply-To: <CAFmMkTG3rMtmNxYf0jXgGN7zJgK2U8Ogtrd4yH0Ee1rC7pf9Mg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 17:39:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a384fKBEYU22UDOyr2vpdo+A+keoF_4jhcevG-w9rvtdw@mail.gmail.com>
Message-ID: <CAK8P3a384fKBEYU22UDOyr2vpdo+A+keoF_4jhcevG-w9rvtdw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lEtYPZyCryh1w3i15heFhslpyk/raxlGvX8tDy6460B1MpXhVOz
 gbArQy0pzmfza3Ee/PTGfXORdgb+82dmN4cgsWGTsdd3IN5LVQbL+DDVQc15oJpaBQRio3r
 xZip3CCn4Rbdsm9ArtzK4MleMq8Arna6OpRx3fWXPIChDpanw0KCCjecIKMaY4iZ6CkxCtb
 UE+ZBC5AXIpL8lsOqWCQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5YyfqHBaGU=:5+wIljemyFgpA0f3gTNjmZ
 kWmqb0kfhWJI1ORdASzEKUxxXrujOCBECwoZ3978Vh/k32RDD2nivbmWqh1y3dLEx3+gWVk61
 mqj24Zd/knr0rJhrsM8ZxAIzYg+Qic8ICqaCTQ0dnAjlrViefqEFBpFUG8AAI/w1SWbNiyLVW
 yjykEF3nXn6iOf8QedIKLdo0yYuaCyf7GEt35AgYdZBJJjwHfYN+2ov8FmDFVNdUlphOmpe57
 MuJ0KBDNmK4R8dDPzekBe0Or555ikAWyS6KJ1K5ZCU2ROMKpNqB2bCyHjE+B278fg8M9Mssj4
 ZjPqkutVhq5rh4gx1IOm5KKRl/QAtcO8Kg7oQsMglWqeUohl8SDQqVjThCZ+30K/C5jMhfmnj
 ZuBCP7YxNCqVVa9v5LyhVu9NIjiRMuOaG868ORt3JQoUAW5PjPbPljTabwSlbxvz7Ob9Qvjua
 u9cqovYNx9hUo4H/AfntUDFdGpCPSQTBu6fUoB2aXJebvvYY9xSvQMrQt9WJZmC1je5blBnzf
 LO7d+uG5XPmMzhIoQNPfSA7F/a2pZpUruXawSO/emA5yTJX3fQ6BcLsV96QJ2U4c0uNDXV4yg
 9mZEzg4+thj3mCg0CUXwf2BBp5+OFxGzGynzNL7pMf0JJjOpzZM9um2sqh8KZW7Ac+iWcqj6m
 5ncgdb+HQWwmNk9LYDkqrDpXRrsCGdvjG15h6DdawGrym2Tn9fDeHKjmBvfPhhxjMNBr5YDTS
 kXr1GoxazK8OjJXUO0Hl/RovndM6Pb9aqZYgDl8NG6ezUXR/RUTf3bE7Zf5K2JuHNMwvMCs/+
 6lHj4j0FeleG3bBc5Qy8KShy+sHJeKR8aTgI4CgE/WD9Zr6PFDsHE/AnprExlMS+YFW5VXkXQ
 /Y+hCjpnYdQMyOluNcdAt4i+6XB5Zp1DWtGHirAN83etleKhwc82OT+JEM5ELpCcoamnvzsX4
 hULAMmYPRiiwoHnSeoUb/lJXsu4s/hTnBYeMR3PrWc0LgaD5hQ/gy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:21 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Fri, Jul 17, 2020 at 11:48 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jul 17, 2020 at 12:36 AM Daniel Gutson <daniel.gutson@eclypsium.com> wrote:
>> >
>>
>> > +static ssize_t internal_callback(struct kobject *kobj,
>> > +                                struct kobj_attribute *attr, char *buf)
>> > +{
>> > +       struct firmware_security_data *fwsd =
>> > +               container_of(attr, struct firmware_security_data, kobj_attr);
>> > +       return fwsd->callback(buf, fwsd->private_data);
>> > +}
>> > +
>> > +int register_firmware_security_data_callback(
>> > +       const char *name, ssize_t (*callback)(char *buf, void *private_data),
>> > +       void *private_data)
>>
>> Why do you have a callback interface here?
>
>
> Because that was what I understood from you :) and it made sense for me.
> Callbacks depend on the DID, so it can't be static. The returned value is dynamic too.
> The callback idea here is like the show() callback of the kobjects.
>
>>
>> I would have expected
>> all the data to be static during the kernel run time, so just passing the
>> information here would make it much simpler.
>
>
> What information are you referring to?
> Please give me more details about your idea because using a callback is the only solution I can think about.

I still don't understand what the values are that you export. Can
you try to describe better what you are actually exporting to user
space, and how they change at runtime?

My impression was that the state of the registers you read would
be the same if you read them multiple times, at least until you
reboot and the firmware has a chance to change them.

>> > @@ -76,7 +119,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>> >         { PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
>> >         { PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>> >         { PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&bxt_info },
>> > -       { },
>> > +       {},
>> >  };
>> ...
>> >  #include "intel-spi.h"
>> >
>> > @@ -48,17 +49,17 @@
>> >
>> >  #define FADDR                          0x08
>> >  #define DLOCK                          0x0c
>> > -#define FDATA(n)                       (0x10 + ((n) * 4))
>> > +#define FDATA(n)                       (0x10 + ((n)*4))
>> >
>> >  #define FRACC                          0x50
>> >
>> > -#define FREG(n)                                (0x54 + ((n) * 4))
>> > +#define FREG(n)                                (0x54 + ((n)*4))
>> >  #define FREG_BASE_MASK                 0x3fff
>> >  #define FREG_LIMIT_SHIFT               16
>> >  #define FREG_LIMIT_MASK                        (0x03fff << FREG_LIMIT_SHIFT)
>> >
>>
>> Accidental whitespace change, please skip these changes?
>
>
> This came from clang-format, I thought it was a requirement so I left this
> fixed. Should I revert the changes from clang-format?

Yes, you should ensure that newly added code does not introduce
incorrect whitespace, but never mix cosmetic changes to existing
code with newly added functionality.

>> > @@ -161,7 +164,8 @@ struct intel_spi {
>> >
>> >  static bool writeable;
>> >  module_param(writeable, bool, 0);
>> > -MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
>> > +MODULE_PARM_DESC(writeable,
>> > +                "Enable write access to SPI flash chip (default=0)");
>> >
>> >  static void intel_spi_dump_regs(struct intel_spi *ispi)
>> >  {
>>
>> This looks like a useful change, but it should be a separate patch.
>
>
> More clang-format.

Ah, I had misread the change, thinking that you added the description, but
you really only change the whitespace, and in fact make it worse. ;-)

       Arnd
