Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3C3C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156752072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvZFFp2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgELEKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 00:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgELEKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:10:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:10:52 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so3348867ion.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE00sNcmDR9xC5H1fz45Er0w3JgojCtUdrgoXbvLCok=;
        b=DvZFFp2/FFHUGDdhblKHegReeE5SaNHK0MmgkYtoFA1ZzelJeQK2TmlaEy7lN6sHpo
         nKKZnsgzR689jYvWw2L83enoUgXQ7jGQ1engWE5dGkPrYHrZVb8eB5hz4qo7FKFQe927
         WsXI/6Fc18GArAIVkzYvSqX0kZp8CaOaAkgOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE00sNcmDR9xC5H1fz45Er0w3JgojCtUdrgoXbvLCok=;
        b=KacXaKqLI6qlJ016/TpmNySAMPIgeHxmIokUdZNrK5KVaGYyB8g5ofuIOyZ4zDgE++
         566O5Ti9QoI0UqG35FBbKlRLvMI3auNAGWHacVHoGN6KAWVksJWACch884fRPeoDhjx3
         8Bsx3BC63SL+ps8HWJwZ/NrdjMQ7ildYjxpzkH4YG81OpXXqulYcCKOrOZUsj8RMnYEw
         OckGYSl0eyR0vNaCjq35oy3KlL/FrprW3PGnObby2eRLuHu/jL2qE10BcPzcKgsXHZMt
         01vU3r766D5W3Oqqk6KDwFlK0q8epBI9n+bK12eYpbQGyCDqBU048CVNA49gyrhGUjEz
         3I/w==
X-Gm-Message-State: AGi0PuYVYJurVVlDJlwnt7e4+i3zxX37g/lxfT5PS77wXSQLqPhRjphG
        KeaLovDyR/ISMPPYWU4IzrmZO4ecsWMq4BtczLqm3Q==
X-Google-Smtp-Source: APiQypIQwSeEOrnZ4jmhrR2hGNd84Zxq4wlnUceVkTuGSbJGf/CePep+aL0mgBasRNxYhPh7DeVItk2Hlv2xEPzgR5k=
X-Received: by 2002:a05:6638:11d4:: with SMTP id g20mr4264460jas.19.1589256651855;
 Mon, 11 May 2020 21:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200506230324.139241-1-gwendal@chromium.org> <20200506230324.139241-2-gwendal@chromium.org>
 <20200508161635.00006cd2@Huawei.com>
In-Reply-To: <20200508161635.00006cd2@Huawei.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 11 May 2020 21:10:40 -0700
Message-ID: <CAPUE2uvT4zf9xR7Bq12xB3W_r_Sm=qG3g7PQ9VWfP8j92894EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: Add in_illumincance vectors in different
 color spaces
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 8:16 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 6 May 2020 16:03:22 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Illuminance in the title.  Plus I'm still arguing these
> aren't illuminance values.
>
> The Y value is illuminance but X and Z definitely aren't.
> RGB needs to stick to intensity - like the other existing
> RGB sensors.
>
> Gah.  XYZ and IIO is a mess.
>
> I suppose we could introduce a new type and have
> in_illumiance_raw
> in_chromacity_x_raw
> in_chromacity_z_raw but chances of anyone understanding what we
> are on about without reading wikipedia is low...
>
> Sigh.  Unless someone else chips in, I'm inclined to be lazy and rely
> on documentation to let in_illuminance_x,y,z be defined as being
> cie xyz color space measurements.
>
> It seems slighlty preferable to defining another type for these,
> though I suspect I'll regret this comment when some adds
> cie lab which was always my favourite colour space :)
>
>
>
> > Define 2 spaces for defining color coming from color sensors:
> > RGB and XYZ: Both are in lux.
> > RGB is the raw output from sensors (Red, Green and Blue channels), in
> > addition to the existing clear channel (C).
>
> > The RGBC vector goes through a matrix transformation to produce the XYZ
> > vector. Y is illumincance, and XY caries the chromaticity information.
> > The matrix is model specific, as the color sensor can be behing a glass
> > that can filter some wavelengths.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > New in v2.
> >
> >  Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d3e53a6d8331b..256db6e63a25e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1309,6 +1309,33 @@ Description:
> >               Illuminance measurement, units after application of scale
> >               and offset are lux.
> >
> > +What:                /sys/.../iio:deviceX/in_illuminance_red_raw
> > +What:                /sys/.../iio:deviceX/in_illuminance_green_raw
> > +What:                /sys/.../iio:deviceX/in_illuminance_blue_raw
> > +KernelVersion:       5.7
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Illuminance measuremed in red, green or blue channels, units
> > +             after application of scale and offset are lux.
>
> No they aren't.  Units are some magic intensity at some magic wavelength.
>
> > +
> > +What:                /sys/.../iio:deviceX/in_illuminance_x_raw
> > +What:                /sys/.../iio:deviceX/in_illuminance_y_raw
> > +What:                /sys/.../iio:deviceX/in_illuminance_z_raw
> > +KernelVersion:       5.7
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             lluminance measured in the CIE 1931 color space (XYZ).
> > +             in_illuminance_y_raw is a measure of the brightness, and is
> > +             identical in_illuminance_raw.
>
> That is fair enough.
>
> > +             in_illuminance_x_raw and in_illuminance_z_raw carry chromacity
> > +             information.
> > +             in_illuminance_x,y,z_raw are be obtained from the sensor color
> > +             channels using color matching functions that may be device
> > +             specific.
> > +             Units after application of scale and offset are lux.
>
> True for Y, not for X and Z which don't have 'units' as such.
Indeed,I have difficulty mapping what comes from the sensor after
adapting to an acceptable universal entity.

The goal of the sensor is to measure the ambient correlated color
temperature (CCT), based on the x and y of the CIE xyY color space.
Given x and y are defined as x = X / (X + Y +Z) and y = X / (X + Y +
Z), X, Y and Z must have the same units.

CCT(x,y) is computed in user space, for example using this
approximation (https://en.wikipedia.org/wiki/Color_temperature#Approximation).

Gwendal.


>
> > +             The measurments can be used to represent colors in the CIE
> > +             xyY color space
>
> XYZ
>
> > +
> >  What:                /sys/.../iio:deviceX/in_intensityY_raw
> >  What:                /sys/.../iio:deviceX/in_intensityY_ir_raw
> >  What:                /sys/.../iio:deviceX/in_intensityY_both_raw
>
>
