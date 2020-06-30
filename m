Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C36C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71A020775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rc+Ca3tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgF3GrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgF3GrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:47:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA227C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:46:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so21143083ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmFRI05KEQyW9X/3WyeY71+JG49+1sxgawOGTBE7aEk=;
        b=rc+Ca3tf00wqSX64JeEakDqEJSh8rw+48bpff6CEjnnFqAMBSNnoUtn9eER6VNGyhd
         HitKxOZC3EYDADkWjm6WJtzT81JNvAFA5JUoeLS7OWz4QtS7qBpjjhJHx3MES6g9PziR
         fU5XzGduGXYponHky45n/mQrrDf2+gANjH5fszKueSkmuzMyMzZfehHAVo9Cte1cKYbR
         tGlj76d9zM7U12rWsRJrxPa4s7jdKkz8iOHzo2J9hnbAvMop9yDzUBLq0S2n7BkEFD2l
         qNx+3lyC4IRjRPWhCKzv3BiwZin/TJr3Y3Cm8Sk1FsYI3dwXrHzuRWx1xanD/X4hRcXO
         jGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmFRI05KEQyW9X/3WyeY71+JG49+1sxgawOGTBE7aEk=;
        b=E2ylkYFGiaPilJOm5eXX2CykMGE6JX7ScYX0YNc7OI5bsgLQAH6swi/cw/w1OizGvT
         dNOaE/2jSOt+nOJ3k8CD/Kq6dlT3rXeGu1hI2KDYedioezBmt7K7kjs1iLg6+F6I5KyK
         KUkJqXARa8d5etMsKAvZ6u5YOnVol5ZARlRJAxWf43jodWidQnCqwuIW2tKHhPvQSXDX
         GweuYT36RClLlKnYCmkuXKlj2zYEOe41NZoumnN4Oo0zjODCh3WP64bBuzEmFMLCFLyS
         UGepZ9+JEM7FD6CsbIo5yCuJgS26J7Be9O3u5CFzlTj6yBHHzmYs+u2VonwDJzTwwC83
         4LKA==
X-Gm-Message-State: AOAM532OlpycZOisGMou7ytxulworjJqZgf4gLC49A2wwwXeZHIKPjm5
        klKaY8zitJ9O1tTE+T0vkQ+iYylqz/VT9r5X4mpDRA==
X-Google-Smtp-Source: ABdhPJyhyyz8XQcU1a6vCXE6S0n+3/i6YMdUcFrktR33RNv5Qte8vv6ZFQLo8+tPN3qccrrR+wMi/GbT336jJozFZp0=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr10122914lja.152.1593499618074;
 Mon, 29 Jun 2020 23:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200630032014.22956-1-andy.tang@nxp.com> <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
 <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com> <DBBPR04MB60907EC06EAABC949DD42E3EF36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB60907EC06EAABC949DD42E3EF36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 12:16:46 +0530
Message-ID: <CAP245DUzQBmKvg9oit8StKyfvp==eVZZ7dh0DUAwKkQnjSL_yw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone support
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:07 PM Andy Tang <andy.tang@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Amit Kucheria <amit.kucheria@linaro.org>
> > Sent: 2020=E5=B9=B46=E6=9C=8830=E6=97=A5 13:37
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; lakml <linux-arm-kernel@lists.infradead.o=
rg>;
> > open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> > Subject: Re: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more therma=
l
> > zone support
> >
> > Caution: EXT Email
> >
> > On Tue, Jun 30, 2020 at 10:58 AM Andy Tang <andy.tang@nxp.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Amit Kucheria <amit.kucheria@linaro.org>
> > > > Sent: 2020=E5=B9=B46=E6=9C=8830=E6=97=A5 13:12
> > > > To: Andy Tang <andy.tang@nxp.com>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> > > > Rob Herring <robh+dt@kernel.org>; lakml
> > > > <linux-arm-kernel@lists.infradead.org>;
> > > > open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > > > <devicetree@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> > > > Subject: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more therma=
l
> > > > zone support
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On Tue, Jun 30, 2020 at 8:56 AM <andy.tang@nxp.com> wrote:
> > > > >
> > > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > > >
> > > > > There are 2 thermal zones in ls1088a soc. Add the other thermal
> > > > > zone node to enable it.
> > > > > Also update the values in calibration table to make the
> > > > > temperatures monitored more precise.
> > > > >
> > > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > > ---
> > > > >  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 100
> > > > > +++++++++++-------
> > > > >  1 file changed, 62 insertions(+), 38 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > > > index 36a799554620..ccbbc23e6c85 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > > > @@ -129,19 +129,19 @@
> > > > >         };
> > > > >
> > > > >         thermal-zones {
> > > > > -               cpu_thermal: cpu-thermal {
> > > > > +               core-cluster {
> > > > >                         polling-delay-passive =3D <1000>;
> > > > >                         polling-delay =3D <5000>;
> > > > >                         thermal-sensors =3D <&tmu 0>;
> > > > >
> > > > >                         trips {
> > > > > -                               cpu_alert: cpu-alert {
> > > > > +                               core_cluster_alert:
> > > > core-cluster-alert
> > > > > + {
> > > > >                                         temperature =3D
> > <85000>;
> > > > >                                         hysteresis =3D <2000>;
> > > > >                                         type =3D "passive";
> > > > >                                 };
> > > > >
> > > > > -                               cpu_crit: cpu-crit {
> > > > > +                               core_cluster_crit:
> > > > > + core-cluster-crit {
> > > > >                                         temperature =3D
> > <95000>;
> > > > >                                         hysteresis =3D <2000>;
> > > > >                                         type =3D "critical"; @@
> > > > -150,7
> > > > > +150,7 @@
> > > > >
> > > > >                         cooling-maps {
> > > > >                                 map0 {
> > > > > -                                       trip =3D <&cpu_alert>;
> > > > > +                                       trip =3D
> > > > <&core_cluster_alert>;
> > > > >                                         cooling-device =3D
> > > > >                                                 <&cpu0
> > > > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > > >                                                 <&cpu1
> > > > > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>, @@ -163,6 +163,26 @@
> > > > >                                 };
> > > > >                         };
> > > > >                 };
> > > > > +
> > > > > +               soc {
> > > > > +                       polling-delay-passive =3D <1000>;
> > > > > +                       polling-delay =3D <5000>;
> > > > > +                       thermal-sensors =3D <&tmu 1>;
> > > > > +
> > > > > +                       trips {
> > > > > +                               soc-alert {
> > > > > +                                       temperature =3D
> > <85000>;
> > > > > +                                       hysteresis =3D <2000>;
> > > > > +                                       type =3D "passive";
> > > > > +                               };
> > > > > +
> > > > > +                               soc-crit {
> > > > > +                                       temperature =3D
> > <95000>;
> > > > > +                                       hysteresis =3D <2000>;
> > > > > +                                       type =3D "critical";
> > > > > +                               };
> > > > > +                       };
> > > > > +               };
> > > >
> > > > You should also add a cooling-maps section for this thermal zone
> > > > given that it has a passive trip type. Otherwise there is no use fo=
r a
> > passive trip type.
> > > It is better to have a cooling device. But there is only one cooling
> > > device on this platform which is used by core-cluster. So there is no=
 extra
> > cooling device for it.
> > > This zone can take action when critical temp is reached. So it is sti=
ll useful.
> > > What do you suggest?
> >
> > If the action taken by the core-cluster cooling-maps is the only one th=
at can
> > be taken, I suggest getting rid of the the soc-alert passive trip compl=
etely. It is
> > not of any use.
> >
> > If there is a chance that your soc thermal-zone can heat up before your
> > cpu-cluster zone (unlikely), you could use the same cooling device (cpu=
0, cpu1)
> > for soc thermal zone too.
> Thanks for your suggestion.
> I was told that a cooling-maps can not be applied to more than one therma=
l zone.
> So the only option is to remove the alert trip.

The cooling-map is unique to the thermal-zone. But the cooling devices
may be reused.

See arch/arm64/boot/dts/qcom/sdm845.dtsi for an example.

So, in your case, you would have a cooling-map section that ties the
soc-alert trip to the same cooling devices as in cpu-cluster cooling
map.
