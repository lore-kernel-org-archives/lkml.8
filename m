Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39D7C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81958205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwz8/nr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDTWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:38:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12244C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:38:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r66so10356835oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqYg6ntkQ0k1GeM/P7oYOBS8jSkjVtqvvJulIoVkKiM=;
        b=qwz8/nr5QucNjlHATqW9FL6h37kLUiDAM6dAkwSyUVvKHTH+CaeQglYUw9of9Nj/z3
         xsEFNBcLPrY6BVm0w2eVW+vAd0NuE3MgW/KuVwUelG4Kxq3oBpzYp+ki+lK6cWAWlYoY
         BgEXbx09x4ia97ZGfEYlmbTuttJjMWJdWGCcK79SYrAVDfMATttQPvhJWng5Fp9d9BNY
         pC0znJHuBdB5MhWQOsrJ0b9NCX8jxP4/qJKcnRrh30nCYOiq1dwcbX7FBFxCG4kmDwna
         ih8cSxzfaCfZLU/wDR6ebyxVMDFfFPYTV1c6PlpF2/EYAgAQ3YGA8QX0c6bvOcdpvmil
         +Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqYg6ntkQ0k1GeM/P7oYOBS8jSkjVtqvvJulIoVkKiM=;
        b=p5VZASBiKqBS5BduqL/xz/PD7+jeW37lqCXgCfNbKj/oZB24Qo/XGEQ/qZpQRbPrh7
         5JDEMFazZJ7rgiJtAsp8LeZHPWOcbfocVYu2yzu5OJUwBYHAJcOpZCXybFruV4Qw6Fie
         hlWNX0gl1dgZKUCvsHNbHMgGSyV67z34X7L68w7KRCFUGqdcxRiae2SkvoPawQDX78dB
         wa0K8Lfk5XGmW7WmxSqjwXKQ72KOmeFpHzrp/FWzgDnU5SxR/9pEZ7VGhrdYtGeyAMtj
         83Qu0aG7v7rChiXdZ0kWQ/ccZ2NrqsQHWuQfLQOTSvA8b/pj3mlDdmU7Gw2TUeAPb+Y5
         HRgA==
X-Gm-Message-State: AGi0PubCYeIFXFPexaizuUl4L8nOTaSPwVCqKK684A+YpVziZpiqkx/k
        73XJU6Ohlv5wRUCF1D/jOOnlqFHnNusFnOkhMKGtsw==
X-Google-Smtp-Source: APiQypLhshDKGKzPG2/FUFOcpcMmXm5mKm0h4rRpZd/H1AvaVthcwyaU7iTZW2bPIGE9obKIx5h2rI+JvNTiDoMcMkI=
X-Received: by 2002:aca:5251:: with SMTP id g78mr1246189oib.172.1587422311105;
 Mon, 20 Apr 2020 15:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200417165442.1856-1-nsaenzjulienne@suse.de> <500e8c46a9b411aed03965b6f9130ccde457193d.camel@suse.de>
 <CAGETcx8EJiLSV8jzrusim6EvyVvX4H8ANvZaJwO72G1=iS-N2Q@mail.gmail.com> <1363207183f599732f8bb9c97624886df42ced13.camel@suse.de>
In-Reply-To: <1363207183f599732f8bb9c97624886df42ced13.camel@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Apr 2020 15:37:54 -0700
Message-ID: <CAGETcx-9VbdgNUUstbrGzoAA=4s+EPCznG9LrDoj+Gz-C5g__A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: property: fw_devlink misc fixes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 4:29 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Saravana,
>
> On Fri, 2020-04-17 at 13:55 -0700, Saravana Kannan wrote:
> > On Fri, Apr 17, 2020 at 11:06 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > Hi Saravana,
> > >
> > > On Fri, 2020-04-17 at 18:54 +0200, Nicolas Saenz Julienne wrote:
> > > > As I'm interested in using this feature to fine-tune Raspberry Pi 4's
> > > > device probe dependencies, I tried to get the board to boot with
> > > > fw_devlink=on. As of today's linux-next the board won't boot with that
> > > > option. I tried to address the underlying issues.
> > > >
> > >
> > > On a semi-related topic, have you looked at vendor specific properties? most
> > > of
> > > them create a consumer/supplier relationship, it'd be nice to be able to
> > > take
> > > those ones into account as well.
> >
> > I'm on the wall about that. If we take every vendor specific property,
> > this file will explode. Not sure I want to do that.
> >
> > Also, we haven't even finished all the generic bindings. I'm just
> > adding bindings as I get familiar with each of them and I test them on
> > hardware I have lying around before sending it out. So, there's where
> > my focus is right now wrt fw_devlink and DT.
> >
> > I wonder how many of the vendor specific properties do very similar
> > things and got in over time. Maybe they can be made generic? What one
> > did you have in mind?
>
> Well, long story short, we need to create a relationship between RPi4's PCI bus
> (which hangs from an interconnect in DT) and RPi4's co-processor, which has a
> highly unconventional firmware driver (raspberrypi.c in drivers/firmware). The
> PCI bus just needs the co-processor interface to be up before probing,

I'm guessing it still works fine today by doing a deferred probe and
you are just trying to avoid having to do a deferred probe? I haven't
kept track of RPi4's upstream support status.

> that's
> all (I'll spare you the details of why). Ideally we want to avoid adding
> platform specific code into an otherwise generic bus driver as it'll be used by
> a number of unrelated SoCs, and it's generally frowned upon.

Which PCI driver is that specifically (I'm sure I can dig around to
find RPi4's DT and figure it out, but it's easier to just ask :) ) ?
Also, can you point me to the DT and the nodes that we are talking
about here (the PCI and the firmware nodes)?

> There is no generic property to handle this case, and it's very unlikely there
> will ever be one, since these firmware drivers have very little in common. I
> guess this could make an argument for a generic _last resort only_
> 'supplied-by' property, but I bet this solution won't be very popular.

Ha, this was my initial idea for the whole fw_devlink feature. I
called it depends-on. Rob/Frank convinced me to instead just parse the
existing bindings -- which was definitely the right call. Otherwise DT
would have been a mess. Adding support for "depends-on" for one off
use cases might still be a touchy topic. I myself am on the wall. It's
useful for some rare cases, but it's also very easy to abuse.

> Another idea that comes to mind for vendor specific properties would be
> exporting a macro in the lines of "DEFINE_SIMPLE_PROP()" for supplier drivers
> to define custom properties. The parse_prop() callbacks could then be added
> into a special section for of/property.c to pickup and parse. The good thing is
> that the list length would be limited by the kernel configuration and the
> maintenance burden moved to the driver authors, at least to some extent.

I did think about this option too sometime back, but not too keen on
that -- at least at this point. Mostly because there are other issues
I want to resolve first and want to get their design right before
getting to hand off property parsing to other drivers/files.

> Anyway, if something comes to mind to solve RPi4's situation feel free to
> propose anything :).

I'll let you know if I do. I'm not sure I fully understand the issue
though. I don't think you are trying to avoid deferred probes because
you aren't trying to improve boot time. I'm guessing the PCI bus
driver in question has no way to know when to defer the probe, in this
case you are trying to fix?

-Saravana
