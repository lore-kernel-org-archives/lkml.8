Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE38C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949CD2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0kKzSxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbgBNRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:36:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46339 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390145AbgBNQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so11276271ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZy/2z20rQr+AZdAg5mBnbB8bwtIRJaA+N58PUrVOnU=;
        b=q0kKzSxAaRi40pL9e42a2YRfXqBYeh0GO136AUpv4Sy/B5RUFaHSKYdAat9LWsXNQq
         8wGk9sMJS0ZGQZnZmamOiwBWCaHh4f+ufFpczx5vfyYxe51fyIbpiMudk1ydapLoFb6w
         rK5X45HcvQMyVFfXq5inLv61KrGjtD3sOyTS3NinbHykT5tm3bXP5siZBYRmyJ8tOshn
         v08UpR9sZAH9Kov4ZV8GwlsDKvoKEcCqUIrjR/c9usKy2X676NJuNVvJbwkc043fp+PU
         wTIUfFBpObrZz8GamGuuqGVA7qMKeNbvXcV7ajy1qIngZPf/rVUZi/qEDJI0+Ou4NVai
         NieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZy/2z20rQr+AZdAg5mBnbB8bwtIRJaA+N58PUrVOnU=;
        b=bJEsnIGHLyAm8QVP41nDI50Wxte4DH1zcgxDzhNioRLpRMot58xcrb1S1Jt8I06rU1
         gvWExJah5WHV5wq20ebihnp8hcMm3F7Fz/KgtsxhEhtL8IHemBy21+WNYvW4aJ6YebQM
         pPE34s98oibkkMXdeR/NpZ3XPLDjPBu/QYt6ZCfvD4S3HShaDb852nzR3HHtN4WLqjnl
         JHArWZPqvmK6L/LMLJJecKn+iNBlC84rNwzScyfAJd0GvGy/XD6uOVgN4Jpxtj3LP1vS
         hMWZefyNwrs25BPerU0g1JPJTNrZyU4ac02aIxsVK4fMxOS8PqjoTXE3bvtEE5VYcok2
         wOSA==
X-Gm-Message-State: APjAAAUWoWSkRoU+PC6yysS/8xeypqFQ/cn9i25Zw+Umh2kmgxvp7sfy
        ElObUnlgNxvxk5SCp4Q9La+ZcRgjjWI/HqRB5pAf9Q==
X-Google-Smtp-Source: APXvYqzJN7ytfDnK6tZ5nG+mPSSYfHbFQ8ddbX1jdU4abEP4ser8GiuEaC5aIp2nOnJIJo+28PrKUKGhtrbKXFffkjc=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr2530015ljg.168.1581696318753;
 Fri, 14 Feb 2020 08:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com> <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com> <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com> <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com> <20200129111717.GA3928@sirena.org.uk>
 <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com> <20200131090650.GA2267325@kroah.com>
In-Reply-To: <20200131090650.GA2267325@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 17:05:07 +0100
Message-ID: <CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Grant Likely <grant.likely@arm.com>
Cc:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> Why do people want to abuse the platform bus so much?  If a device is on
> a bus that can have such a controller, then it is on a real bus, use it!

I'm not saying it is a good thing, but the reason why it is (ab)used so
much can be found in:
drivers/of/platform.c

TL;DR: struct platform_device is the Device McDeviceFace and
platform bus the Bus McBusFace used by the device tree parser since
it is slightly to completely unaware of what devices it is actually
spawning.

And everything and its dog is using device tree in the embedded
world. (A quick glance in drivers/acpi gives me the impression
that ACPI is doing the very same thing but I am not a domain expert
there so I am not really sure.)

Whenever a device is created from a device tree it gets spawned
on either the platform bus or the amba bus. In 99 cases out of
100 it is going to be a platform_device.

In most device trees all devices ultimately spawn from the device
tree and the root of absolutely everything including irq chips on
the SoC, timers, PCI hosts and USB root hubs and whatnot is a
platform device, because that is how the core device tree parser has
chosen to spawn off devices.

This generic code goes back to
commit eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f
"of: Merge of_platform_bus_type with platform_bus_type"
where the device tree-specific bus was replaced by the
platform bus. This code was then moved down to drivers/of
and used in multiple architectures. Grant's patch makes perfect
sense because at the time some devices were created using board
files (thus platform_device) and others using device tree and having
two different probe paths and driver files for this reason alone
was not reasonable. The same reasoning will apply to ACPI
vs device tree drivers.

What we  *could* have done was to handle special devices
special, like happened for AMBA PrimeCells. Mea Culpa, I suppose
I am one of the guilty.

Supporting new bus types for root devices in systems described
in device tree would requiring patching drivers/of/platform.c
and people are afraid of that because the code there is pretty
complex.

Instead platform_device is (ab)used to carry stuff over from the
device tree to respective subsystem.

In some cases the struct platform_device from device tree is
discarded after use, it is just left dangling in memory with no other
purpose than to serve as .parent for whatever device on whatever
bus we were really creating.

For some devices such as root irq_chips they serve no purpose
whatsoever, they are just created and sitting around never
to be probed, because the code instantiating them parse the
device tree directly.

For the devices that actually probe to drive a piece of silicon,
arguably a different type of device on a different bus should be
created, such as (I am making this up) struct soc_device
on soc_bus. (Incidentally soc_bus exists, but its current use case
is not for this.)

I don't really see any better option for Benjamin or anyone else
though?

The reason why it is used so much should at least be clarified
now I think.

Yours,
Linus Walleij
