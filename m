Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12915C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77192072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clElMuza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgAQTdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:33:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:33:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so8784237wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cih+msRwzn1YOAA85noc99w8gdxLSg/goGFIlRCbXQ0=;
        b=clElMuzagV7xf4x6e/A6Gyi6TTrzowkt07/p51J6jSct9oKT4dXhkJLztzV8IwKXud
         I8AwJAnWJQR5wmb9DIf6GPsGO2bdKan8xfPfmzOgYEdJnMjGQ5KGt1LMwV3LVU9Ia6tG
         4fIXgcv1CbHbsGlR4d/gohad2DBZN7caPUGjFAktHTtj6x8QOXsPJfpnHZeOJclfziAw
         03FG0OvEPAvOHz/DvhIDoWQy1jxbfbjPHZpe0AM60e8n+nd6q5heo1bmsRDK2KaXnccI
         FvpFKbhZd0VYxxNxPSncpDGH9sN3OmW4hEi4wZjFaKdvDGaV5HNxm13J4EV5CRBSGUFl
         1CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cih+msRwzn1YOAA85noc99w8gdxLSg/goGFIlRCbXQ0=;
        b=uIoKBUddHV34CgyQtc3L7Wue0TjBixHvr/Sdt/jI/xkNFU9aqEk/zRZJx6tjdGYvdu
         kIYm9EJZUPf5X4OW9IoYB5YXLI29RPoesTC56ZPkU/MuzkVl46zelNBgcntAb5ystlJR
         Cb/H2gQOJ8y4lwn6yj11duAfbi+PrcnOaWUTiplz/Aq8B9W8UfMMhCIQSN/1S0fij/Sy
         ZSWEOmbRxDOj1qO9QA0jBisoyWvtyhsWB9Z4Ghts8RXRmiGZHfgmSfKUFiLCpK2pFTzf
         X++jgVtq3Dg89ZYFu4iY6EqiIqMxKnRQjADSr8cA655PuiQ/VaO2vLXfQLfhE985Fbpz
         l/hg==
X-Gm-Message-State: APjAAAXjF6Ypgc9jhk1GKiJDoH/oOF969MmB2VuIX+4GRiaS5gKBksWP
        ifNTB14ofwmZH1FxqH8haprk3EvLVafeGOAfQIM=
X-Google-Smtp-Source: APXvYqxgz/nAWxu+wF/RvqxrHbICkVdn1F+6svVjFL4YOA2AbA9EfWppmBlTbB8VyL/vyrQsPWVUs8G34FUse2zBel0=
X-Received: by 2002:a7b:c757:: with SMTP id w23mr6046776wmk.166.1579289585192;
 Fri, 17 Jan 2020 11:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20200110162503.7185-1-zdhays@gmail.com> <20200116192221.49986c13@xps13>
 <20200117071026.gydlruw2cxre2r2u@pengutronix.de> <CANZat+hHJy0H17xGmOP003_M1yWesJ2BjoPmW3hr7CS=HuQR+g@mail.gmail.com>
In-Reply-To: <CANZat+hHJy0H17xGmOP003_M1yWesJ2BjoPmW3hr7CS=HuQR+g@mail.gmail.com>
From:   Zak Hays <zdhays@gmail.com>
Date:   Fri, 17 Jan 2020 14:32:54 -0500
Message-ID: <CANZat+g=emsHmx7i4mEzTXh1s2=t8Bw7cmXYd0YUXKt_oNh-rA@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: micron: don't error out if internal ECC
 is set
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Zak Hays <zhays@lexmark.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco & Miquel,

On Fri, Jan 17, 2020 at 2:10 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Zak, Miquel,
>
> On 20-01-16 19:22, Miquel Raynal wrote:
> > Hi Zak,
> >
> > zdhays@gmail.com wrote on Fri, 10 Jan 2020 11:25:01 -0500:
> >
> > > From: Zak Hays <zdhays@gmail.com>
> > >
> > > Recent changes to the driver require use of on-die correction if
> > > the internal ECC enable bit is set. On some Micron parts, this bit
> > > is enabled by default and there is no method for disabling it.
>
> Which changes did you mean here?

I was referring to the combination of these two patches:

9748e1d87573  Thomas Petazzoni  mtd: nand: add support for Micron on-die ECC
cb2bf403a462  Chris Packham  mtd: rawnand: micron: allow forced on-die ECC

>
> > > This is a false assumption though as that bit being enabled does not
> > > necessarily mean that the on-die ECC *has* to be used. It has been
> > > verified with a Micron FAE that other methods of error correction are
> > > still valid even if this bit is set.
>
> It would be cool if a micron FAE can provide a document with all the
> quirks and how those quirks can be handled.
>

Agreed. I'll ask my contact at Micron if such a document exists and
if they would be willing to share it.

> > > HW ECC offers generally higher performance than on-die so it is
> > > preferred in some situations. This also allows multiple NAND parts to
> > > be supported on the same PCB as some parts may not support on-die
> > > error correction.
>
> By HW ECC you mean the host ecc controller?
>

Yes. I used the term HW ECC as that is how it is referenced in the
device tree (nand-ecc-mode = "hw") and the driver (NAND_ECC_HW).

> > > With that in mind, only throw a warning that the on-die bit is set
> > > and allow the init to continue.
> >
> > I don't think I can take this patch as-is. We must find a reliable way
> > to discriminate Micron parts features. If we cannot (I think we can't
> > before of the endless list of bugs they have introduced without
> > documenting them), the best way is to build a static table.
>

That's understandable. I'll look into this a little more and see if it's
feasible to implement a static table to handle this.

Thanks,
Zak


On Fri, Jan 17, 2020 at 2:28 PM Zak Hays <zdhays@gmail.com> wrote:
>
> Hi Marco & Miquel,
>
> On Fri, Jan 17, 2020 at 2:10 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Hi Zak, Miquel,
> >
> > On 20-01-16 19:22, Miquel Raynal wrote:
> > > Hi Zak,
> > >
> > > zdhays@gmail.com wrote on Fri, 10 Jan 2020 11:25:01 -0500:
> > >
> > > > From: Zak Hays <zdhays@gmail.com>
> > > >
> > > > Recent changes to the driver require use of on-die correction if
> > > > the internal ECC enable bit is set. On some Micron parts, this bit
> > > > is enabled by default and there is no method for disabling it.
> >
> > Which changes did you mean here?
>
> I was referring to the combination of these two patches:
>
> 9748e1d87573  Thomas Petazzoni  mtd: nand: add support for Micron on-die ECC
> cb2bf403a462  Chris Packham  mtd: rawnand: micron: allow forced on-die ECC
>
> >
> > > > This is a false assumption though as that bit being enabled does not
> > > > necessarily mean that the on-die ECC *has* to be used. It has been
> > > > verified with a Micron FAE that other methods of error correction are
> > > > still valid even if this bit is set.
> >
> > It would be cool if a micron FAE can provide a document with all the
> > quirks and how those quirks can be handled.
> >
>
> Agreed. I'll ask my contact at Micron if such a document exists and
> if they would be willing to share it.
>
> > > > HW ECC offers generally higher performance than on-die so it is
> > > > preferred in some situations. This also allows multiple NAND parts to
> > > > be supported on the same PCB as some parts may not support on-die
> > > > error correction.
> >
> > By HW ECC you mean the host ecc controller?
> >
>
> Yes. I used the term HW ECC as that is how it is referenced in the
> device tree (nand-ecc-mode = "hw") and the driver (NAND_ECC_HW).
>
> > > > With that in mind, only throw a warning that the on-die bit is set
> > > > and allow the init to continue.
> > >
> > > I don't think I can take this patch as-is. We must find a reliable way
> > > to discriminate Micron parts features. If we cannot (I think we can't
> > > before of the endless list of bugs they have introduced without
> > > documenting them), the best way is to build a static table.
> >
>
> That's understandable. I'll look into this a little more and see if it's
> feasible to implement a static table to handle this.
>
> Thanks,
> Zak
