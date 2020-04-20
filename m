Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A44C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA29020722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJL1QKKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgDTOU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727890AbgDTOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:20:58 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92368C061A0C;
        Mon, 20 Apr 2020 07:20:57 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n10so11104469iom.3;
        Mon, 20 Apr 2020 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=42ZUa8jWdE/lvIlXQ+IaCeRxAVuDOUkmSNgCJWEQBiU=;
        b=kJL1QKKg8hZD4dmy5HJBPi0VXJYjon4U+mxBDXd4WLeA6JYTuRShbDcgFt/8qAhDJ8
         rhuz8FTqtmUpcY+jaHRbFWuI060FieGdJ2QUb68Mg+PQpEK98WRTb0kibVi5zgnECM9+
         +jlRLVRRL8pAKVXeAnpmHP5alVl+nPALYdy1KwTuzoapeLjW5CAstiYlMJnJlG5phOu/
         0bXhnSWy4JQx6LFMZ3k23WhI8R2m7fd4Lsif6jOKKvgYEyLOEoGfr+1n1erve7RChDo0
         3TfmZPREQ7ciNlZQTB+Mxuf54kw7PRPgVIO7Hw83iBXumXo6A74n/Bk1XNawEZXHbTv0
         adZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=42ZUa8jWdE/lvIlXQ+IaCeRxAVuDOUkmSNgCJWEQBiU=;
        b=JnZIOPjZyKkad4buQC2vF+WUywfb3yXtCclv1RIi5SjvOeKyRuEMV3I47QekE0lRn6
         uaLpiiQATxKBHP0gIsJ2PBjxcT9I7QAiUaK0lrNQRD+xv3abCW4gdf2ZWu8RmE/K2inZ
         N6C/8XoJvOAFguUqKO47sS7tKrY/Uc9OSib/ATS274RZDvnallK5H096wYsXSwHI8+ut
         UrlIJcpsBW6KC6Twk3btJJPDQKvODOOksat69KZuvFadkiPtNV3487Q2R4NngUzrgwQD
         2J2DflDcl5aeCJdgxAQUQmGS7cxzr+phnx1RzzVFkmKyRiR8aLgp6PTJ58hqIDcWUUQ4
         bYOg==
X-Gm-Message-State: AGi0PubsQxt9QaYpWED4fHnoDN1Gq8W2OV16JPlptKUgr6kxzNfg5txX
        aIY+24BIxHO1WTSt9sT645wxeuUQDUcQlQzhIXo=
X-Google-Smtp-Source: APiQypL0OkJvfEysFH1/EQ62r1/N4+ezRkdGJZS2/B6mM481eEQlfXXpdzcY5DOOq2sqZq3sPyJawscazL2Vh5IS3Og=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr15827724ioj.101.1587392456788;
 Mon, 20 Apr 2020 07:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200420130021.3841-1-peron.clem@gmail.com> <20200420130021.3841-3-peron.clem@gmail.com>
 <20200420134604.bkjp66fjiggses7a@core.my.home>
In-Reply-To: <20200420134604.bkjp66fjiggses7a@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 Apr 2020 16:20:45 +0200
Message-ID: <CAJiuCcf_-2bSR61goL7vLXGSjNCsUYQ12j2JM3V4MJiSo3srZw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] arm64: dts: allwinner: h6: Add thermal trip
 points/cooling map
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On Mon, 20 Apr 2020 at 15:46, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> Hi,
>
> On Mon, Apr 20, 2020 at 03:00:14PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > This enables passive cooling by down-regulating CPU voltage
> > and frequency.
>
> Does this not produce a lot of warnings for you during compilation?

I got flooded by lots of warnings, from sun50i-a64, stringray-usb,
ipq6018 and didn't see but two are from sun50i-h6.

The #cooling-cells property is missing for CPU.

Will send a patch for noticing.

Regard,
Clement



>
> regards,
>         o.
>
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index 370e77b86fe1..60da1627772b 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -964,6 +964,30 @@
> >                       polling-delay-passive =3D <0>;
> >                       polling-delay =3D <0>;
> >                       thermal-sensors =3D <&ths 0>;
> > +
> > +                     trips {
> > +                             cpu_alert: cpu-alert {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +
> > +                             cpu-crit {
> > +                                     temperature =3D <100000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&cpu_alert>;
> > +                                     cooling-device =3D <&cpu0 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu1 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu2 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&cpu3 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> >               };
> >
> >               gpu-thermal {
> > --
> > 2.20.1
> >
