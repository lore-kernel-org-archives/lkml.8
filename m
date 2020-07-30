Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0E32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="UaGR5oDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgG3WlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgG3WlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:41:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9339C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:41:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so18524679qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/SZ4gxiHI+Nu5sjx4/Ifukn3+Fq5G1RhckhYI+XJZH0=;
        b=UaGR5oDb0PnD9tn6aHvMCK4E40Y8bqg+uvmMWeBUnknAD/FZQEbiqXQkOVAz6croJH
         pmHjwzLN/wh3s79CgPZZzGqyx8N4ZwPPeK6zpsChEIerErdkQpvFrSmvOY7E9N+WG2Di
         vfX1ptHRM3/jKQsv1jDP0KWhMHqz60JKew71bouK5f9xHAhwr8+Oj2aSA9U7663e7rct
         WMEW582NQihgVVOZSZ9LtjbFEe8uSD0glTx1XA7TfqNYVOwhM+WZEDFMq39+gVkJ5QRx
         /6iC8G3ZgZP163nPoyfQvjoHiv3ZWkrnOAKHa9NznA+gQ0GTjA7FFEX0sZ2IEJagwM37
         TwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/SZ4gxiHI+Nu5sjx4/Ifukn3+Fq5G1RhckhYI+XJZH0=;
        b=ZI0ej2ZUin6IiTae27NeDivuSOsQ2bXyZLoHNBasZDDIZ/yMczw6CKd+7bFB42538N
         DkVquOFuAuwDMQ0pLIH/20Xli+gqmseWWHgqnpx28kPaj9zy0pfjGH44ebVc1gQ6w5k5
         RN8+zKtN3421tkrmQqpwgKYlFD5TZM0HGcDHuVUL9wd1VkJxIw9ldso4tayUGaVZszay
         wd7PMHQZlOMwqgAPBYQX+pyrK5KvKJIUn8KUIaEvg8JWwjG6yS7vBLEBmlTPoWNUzWOU
         WyHkjZyHtmTnFGsuYmjMvK3k2HxCokhUg2/NAYBvJ/1vYe7IvgPlL8blDasL0zfvXMgm
         SykQ==
X-Gm-Message-State: AOAM532IIZG9rCtLaP2TmQk+zsGQgXHgiLpE/Q9gxvRbfP4r0NKZ5m3s
        y2nKwvtkwc9JpDoew7wpqtZP4vmOSPrygYPLXd9mQg==
X-Google-Smtp-Source: ABdhPJy+lcQAWamOUPlE2y8kdYzh4K6OjR+IMRhd09HGQ25M/lvvopNMLWlx5Al+JuqSXbnBjl4mlgQRqMivFn5ZUqk=
X-Received: by 2002:ac8:3ae4:: with SMTP id x91mr904442qte.203.1596148859987;
 Thu, 30 Jul 2020 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com> <5bd9d37f-4567-f28b-3932-58bd9de38882@infradead.org>
In-Reply-To: <5bd9d37f-4567-f28b-3932-58bd9de38882@infradead.org>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 30 Jul 2020 19:40:49 -0300
Message-ID: <CAFmMkTFD6V9c2RFfMMb5ouQ5v52nymPxx3HNp53h9Vp+SdmkGA@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 7:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> Could we get some consistency in the use of "bios" vs. "Bios" vs. "BIOS", please.
> BIOS is preferred IMO.

OK for the next patch.

>
> On 7/30/20 2:41 PM, Daniel Gutson wrote:
> >
> > This initial version exports the BIOS Write Enable (bioswe),
> > BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> > fields of the Bios Control register. The idea is to keep adding more
> > flags, not only from the BC but also from other registers in following
> > versions.
> >
> > The goal is that the attributes are avilable to fwupd when SecureBoot
>
>                                       available
>
> > is turned on.
> >
> > The patch provides a new misc driver, as proposed in the previous patch,
> > that provides a registration function for HW Driver devices to register
> > class_attributes.
> > In this case, the intel SPI flash chip (intel-spi) registers three
> > class_attributes corresponding to the fields mentioned above.
> >
> > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > ---
> >  .../ABI/stable/sysfs-class-platform-lockdown  | 23 +++++++
> >  MAINTAINERS                                   |  7 +++
> >  drivers/misc/Kconfig                          |  9 +++
> >  drivers/misc/Makefile                         |  1 +
> >  drivers/misc/platform-lockdown-attrs.c        | 57 +++++++++++++++++
> >  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
> >  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 49 +++++++++++++++
> >  drivers/mtd/spi-nor/controllers/intel-spi.c   | 62 +++++++++++++++++++
> >  .../platform_data/platform-lockdown-attrs.h   | 19 ++++++
> >  9 files changed, 228 insertions(+)
> >  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
> >  create mode 100644 drivers/misc/platform-lockdown-attrs.c
> >  create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h
> >
> > diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > new file mode 100644
> > index 000000000000..6034d6cbefac
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > @@ -0,0 +1,23 @@
> > +What:                /sys/class/platform-lockdown/bioswe
> > +Date:                July 2020
> > +KernelVersion:       5.8.0
> > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > +Description: If the system firmware set BIOS Write Enable.
> > +             0: writes disabled, 1: writes enabled.
> > +Users:               https://github.com/fwupd/fwupd
> > +
> > +What:                /sys/class/platform-lockdown/ble
> > +Date:                July 2020
> > +KernelVersion:       5.8.0
> > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > +Description: If the system firmware set Bios Lock Enable.
>
>                                            BIOS
>
> > +             0: SMM lock disabled, 1: SMM lock enabled.
> > +Users:               https://github.com/fwupd/fwupd
> > +
> > +What:                /sys/class/platform-lockdown/smm_bwp
> > +Date:                July 2020
> > +KernelVersion:       5.8.0
> > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > +Description: If the system firmware set SMM Bios Write Protect.
>
>                                                BIOS
>
> > +             0: writes disabled unless in SMM, 1: writes enabled.
> > +Users:               https://github.com/fwupd/fwupd
>
>
>
> cheers.
> --
> ~Randy
>


-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
