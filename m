Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0172AC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C209F20409
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDW1feaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCYP2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:28:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36816 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgCYP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:28:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id s1so2149600lfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAfXLeK4jv3GCXZEXdtxljvjsSAfg9wpjX0t8Ep/xn0=;
        b=aDW1feaQrj/vQbwncf35ZAbIJQv6QoVYZCbKz9TCT9fUH98JKwEEaGp+U3VA4/RSxj
         M2U1pJCxnd/u57YPJBO93DEX2pyVd5yTcvNeo3knsXJMSZXsjuSwyZbLvyiU1biwWm6p
         CGrF1GW7glPm10woi2K7MCSpOd6gPGxgfI5wUW4egp3qRlpv0tElS6C3iexVg400nWrW
         jFLalqO3PixJa/k6GxgaWExvLfeARawYBJhoYg6e2BCtnChUG8KMqaG1szJeWQ2KoZpY
         BHHVvBAmrzGU9sAO4d+K7uYZ0ONthZXN1RMD0zzJ5xLy4buThs8hGRL8hQeUor+yr0S0
         i15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAfXLeK4jv3GCXZEXdtxljvjsSAfg9wpjX0t8Ep/xn0=;
        b=Re2EFhcPg9yVMMj2hGGH4FKFIIu1PaKMUDEFGhlV9EUDXgMPjfxq9GDcWlrUJnRxFz
         4bdAOkMsvHi5X9wQqAqFRlZB07uLKxDf3KR7zX3dbs6hwJZPhEadEiUR/5pBelotuAjG
         tzuogVfQ7u0rtfak/fo6V3hYaAHVArk0f1jQf6x1w+lLYLwxonsfQCYi+hAq/XwS/KbW
         QR1vsSb2YtqLEy5p3nMSdmT8xpDix3H2NsaIIaGCw2/BfcgKvKccFIk4w3AKeaXKqMNI
         /br+KwBXISMoTj7xsSSpyXYFXqyC+tMBkQa2FZgtTrGRLgeEzFgnBVND3Pmz8wNx2bR2
         Wr8w==
X-Gm-Message-State: ANhLgQ38WzH9lyG8wWrSmANES/SFRaZmIfF3WpSQJa8XMJl/fLY5lQYQ
        UbgreHoumA7Apj6KBZJOz6tFcJVGGJSeJZm9Y1mhLQ==
X-Google-Smtp-Source: ADFU+vvPsxfhLZkuw1zm3DaRk4jDzbr+V6wKm8OS63ckoV6lXpkrggY1jnKk/LQr1ujMiOa33DUQuJWItnCXDLsD8jE=
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr2721177lfl.82.1585150114380;
 Wed, 25 Mar 2020 08:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <1ee4240e29edefc36b5d410d4792971c2bb4c5d5.1585117436.git.amit.kucheria@linaro.org>
 <a89df770-eeb9-e4f2-2a46-ee4389720597@arm.com>
In-Reply-To: <a89df770-eeb9-e4f2-2a46-ee4389720597@arm.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 25 Mar 2020 20:58:23 +0530
Message-ID: <CAP245DX04zTMhNep46MNB7yhxnBshX0bb7sQmaSq_6KScvH2jg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: Add yaml bindings for
 thermal cooling-devices
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 3:51 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Amit,
>
> On 3/25/20 6:34 AM, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The property #cooling-cells is required in each device that acts as a
> > cooling device - whether active or passive. So any device that can
> > throttle its performance to passively reduce heat dissipation (e.g.
> > cpus, gpus) and any device that can actively dissipate heat at different
> > levels (e.g. fans) will contain this property.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >   .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
> >   1 file changed, 116 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> > new file mode 100644
> > index 000000000000..b5599f7859f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: (GPL-2.0)
> > +# Copyright 2020 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Thermal cooling device binding
> > +
> > +maintainers:
> > +  - Amit Kucheria <amitk@kernel.org>
> > +
> > +description: |
> > +  Thermal management is achieved in devicetree by describing the sensor hardware
> > +  and the software abstraction of cooling devices and thermal zones required to
> > +  take appropriate action to mitigate thermal overload.
> > +
> > +  The following node types are used to completely describe a thermal management
> > +  system in devicetree:
> > +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> > +   - cooling-device: device used to dissipate heat either passively or artively
> > +   - thermal-zones: a container of the following node types used to describe all
> > +     thermal data for the platform
> > +
> > +  This binding describes the cooling devices.
> > +
> > +  There are essentially two ways to provide control on power dissipation:
> > +    - Passive cooling: by means of regulating device performance. A typical
> > +      passive cooling mechanism is a CPU that has dynamic voltage and frequency
> > +      scaling (DVFS), and uses lower frequencies as cooling states.
> > +    - Active cooling: by means of activating devices in order to remove the
> > +      dissipated heat, e.g. regulating fan speeds.
> > +
> > +  Any cooling device has a range of cooling states (i.e. different levels of
> > +  heat dissipation). They also have a way to determine the state of cooling in
> > +  which the device is. For example, a fan's cooling states correspond to the
> > +  different fan speeds possible. Cooling states are referred to by single
> > +  unsigned integers, where larger numbers mean greater heat dissipation. The
> > +  precise set of cooling states associated with a device should be defined in
> > +  a particular device's binding.
>
> [snip]
>
> > +
> > +    thermal-zones {
> > +            cpu0-thermal {
> > +                    polling-delay-passive = <250>;
> > +                    polling-delay = <1000>;
> > +
> > +                    thermal-sensors = <&tsens0 1>;
> > +
> > +                    trips {
> > +                            cpu0_alert0: trip-point0 {
> > +                                    temperature = <90000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "passive";
> > +                            };
> > +                    };
> > +
> > +                    cooling-maps {
> > +                            map0 {
> > +                                    trip = <&cpu0_alert0>;
> > +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>;
>
> Maybe add something like this, to better reflect the description:
>
>                         trip = <&cpu0_alert0>;
>                         /* Corresponds to 1000MHz in OPP table */
>                         cooling-device = <&CPU0 5 5>;
>
> This is less confusing than THERMAL_NO_LIMIT.

Thanks for the review.

Will fix.
