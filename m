Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9D7206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYs6ntqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgF3FhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgF3FhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:37:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:37:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so20997991ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y+NTTpix/VNOdqLN5V3EttevSJs3w1JqKA5tqe0k7BM=;
        b=eYs6ntqmqtss9ojrvsY3GbB/7L1Al+U7Czg/OV/4iPVxFlg/rgjAwylYV2+807Ouw3
         lG2gJOT6XtkwFhsSetyTp9B8beQdewzvq/NiVR+Ld/CtY3TmqPqJsGdIKNRSJgpEG+Va
         HI+a0ktwNFAqqxnY5QzXXsDkxmfbfRXtzzJwH0R0p3Krd1wqu9p9hRUdHu4borVz2iky
         ua61SdmRu99QBiPLuGGEbJJhbl2bl2jK8hph6bBgjLfGUKts9nCzELPGrg3B/qD8RTO+
         CvwzlQaEB3O6b3sCb6o28skMvKESdqY+ZIMoymJl+kjgJvPPzrUfHCVuchyknlc7mlgz
         SIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y+NTTpix/VNOdqLN5V3EttevSJs3w1JqKA5tqe0k7BM=;
        b=Avtc+n03BhmFsDbhc/AdjC9+WTEV7aNx5uWYYNoKh5afNcbqFVgSRXgV4u/rgICXPc
         mcA5HE8cvasv0Zc3fVCBHCcjd07JJ+MhV2ut+8T/awy10Q5Qc+WyIwGYkCHdln717O7M
         HkB6AQWxmHEhHPvkk4y3m8L16Gt8LqFIAlPwbKstzWx4Q8QYsxFDsecPh4X17ufN2lFh
         PMQQSlY30sRyN/66CGt2lqgPwwWKh7Q3SZREY29e4VpeqiYU9z4WuCln+epcj5atW+2w
         1MztWcPE33RbDtMabVxco3GlBJYlCh4ryqOeVjbynjgcVODnOAZqax7ea3ZkcorZM16D
         3KQA==
X-Gm-Message-State: AOAM5310S5GQa5pTG2okFYWXuOiIjq9AAf3wipLpROiDFJlxj6h65xKC
        6YGkxvKQjnGK7lkpmNuOvj7xFz80x0e+zGQ4wFZTQA==
X-Google-Smtp-Source: ABdhPJyetVRam7dpe9Lk5SgkZI4NJyaTUvqWahZ3sGQ69bb4D0vK7IghSfJMsneSvvEZUdzelLl1qUxjPYP5FO0EPoY=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr9501981ljp.346.1593495428184;
 Mon, 29 Jun 2020 22:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200630032014.22956-1-andy.tang@nxp.com> <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
 <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 11:06:56 +0530
Message-ID: <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com>
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

On Tue, Jun 30, 2020 at 10:58 AM Andy Tang <andy.tang@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Amit Kucheria <amit.kucheria@linaro.org>
> > Sent: 2020=E5=B9=B46=E6=9C=8830=E6=97=A5 13:12
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; lakml <linux-arm-kernel@lists.infradead.o=
rg>;
> > open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> > Subject: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zo=
ne
> > support
> >
> > Caution: EXT Email
> >
> > On Tue, Jun 30, 2020 at 8:56 AM <andy.tang@nxp.com> wrote:
> > >
> > > From: Yuantian Tang <andy.tang@nxp.com>
> > >
> > > There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> > > node to enable it.
> > > Also update the values in calibration table to make the temperatures
> > > monitored more precise.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > ---
> > >  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 100
> > > +++++++++++-------
> > >  1 file changed, 62 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > index 36a799554620..ccbbc23e6c85 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > @@ -129,19 +129,19 @@
> > >         };
> > >
> > >         thermal-zones {
> > > -               cpu_thermal: cpu-thermal {
> > > +               core-cluster {
> > >                         polling-delay-passive =3D <1000>;
> > >                         polling-delay =3D <5000>;
> > >                         thermal-sensors =3D <&tmu 0>;
> > >
> > >                         trips {
> > > -                               cpu_alert: cpu-alert {
> > > +                               core_cluster_alert:
> > core-cluster-alert
> > > + {
> > >                                         temperature =3D <85000>;
> > >                                         hysteresis =3D <2000>;
> > >                                         type =3D "passive";
> > >                                 };
> > >
> > > -                               cpu_crit: cpu-crit {
> > > +                               core_cluster_crit: core-cluster-crit =
{
> > >                                         temperature =3D <95000>;
> > >                                         hysteresis =3D <2000>;
> > >                                         type =3D "critical"; @@
> > -150,7
> > > +150,7 @@
> > >
> > >                         cooling-maps {
> > >                                 map0 {
> > > -                                       trip =3D <&cpu_alert>;
> > > +                                       trip =3D
> > <&core_cluster_alert>;
> > >                                         cooling-device =3D
> > >                                                 <&cpu0
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > >                                                 <&cpu1
> > > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>, @@ -163,6 +163,26 @@
> > >                                 };
> > >                         };
> > >                 };
> > > +
> > > +               soc {
> > > +                       polling-delay-passive =3D <1000>;
> > > +                       polling-delay =3D <5000>;
> > > +                       thermal-sensors =3D <&tmu 1>;
> > > +
> > > +                       trips {
> > > +                               soc-alert {
> > > +                                       temperature =3D <85000>;
> > > +                                       hysteresis =3D <2000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +
> > > +                               soc-crit {
> > > +                                       temperature =3D <95000>;
> > > +                                       hysteresis =3D <2000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> >
> > You should also add a cooling-maps section for this thermal zone given =
that it
> > has a passive trip type. Otherwise there is no use for a passive trip t=
ype.
> It is better to have a cooling device. But there is only one cooling devi=
ce on this platform
> which is used by core-cluster. So there is no extra cooling device for it=
.
> This zone can take action when critical temp is reached. So it is still u=
seful.
> What do you suggest?

If the action taken by the core-cluster cooling-maps is the only one
that can be taken, I suggest getting rid of the the soc-alert passive
trip completely. It is not of any use.

If there is a chance that your soc thermal-zone can heat up before
your cpu-cluster zone (unlikely), you could use the same cooling
device (cpu0, cpu1) for soc thermal zone too.
