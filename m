Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651CC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C42469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgAROeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:34:21 -0500
Received: from mx.blih.net ([212.83.155.74]:46898 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:34:21 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2020 09:34:19 EST
Received: from skull.home.blih.net (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id cd584d1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 18 Jan 2020 14:27:38 +0000 (UTC)
Date:   Sat, 18 Jan 2020 15:27:32 +0100
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Emmanuel Vadot <manu@freebsd.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add gpio bank supply for
 A64-Olinuxino
Message-Id: <20200118152732.0c9e7426074f4141dd09b586@bidouilliste.com>
In-Reply-To: <CAGb2v67U6qjNf0PPMOm191UZDQvJTGZNNREc22ZsDW61KqaUEA@mail.gmail.com>
References: <20200116194658.78893-1-manu@freebsd.org>
        <CAGb2v67U6qjNf0PPMOm191UZDQvJTGZNNREc22ZsDW61KqaUEA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 11:20:21 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Fri, Jan 17, 2020 at 3:47 AM Emmanuel Vadot <manu@freebsd.org> wrote:
> >
> > Add the regulators for each bank on this boards.
> >
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > ---
> >  .../boot/dts/allwinner/sun50i-a64-olinuxino.dts   | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > index 01a9a52edae4..1a25abf6065c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> > @@ -163,6 +163,17 @@ &ohci1 {
> >         status = "okay";
> >  };
> >
> > +&pio {
> > +       vcc-pa-supply = <&reg_dcdc1>;
> > +       vcc-pb-supply = <&reg_dcdc1>;
> > +       vcc-pc-supply = <&reg_dcdc1>;
> > +       vcc-pd-supply = <&reg_dcdc1>;
> > +       vcc-pe-supply = <&reg_aldo1>;
> > +       vcc-pf-supply = <&reg_dcdc1>;
> > +       vcc-pg-supply = <&reg_dldo4>;
> > +       vcc-ph-supply = <&reg_dcdc1>;
> > +};
> > +
> >  &r_rsb {
> >         status = "okay";
> >
> > @@ -175,6 +186,10 @@ axp803: pmic@3a3 {
> >         };
> >  };
> >
> > +&r_pio {
> > +       vcc-pl-supply = <&reg_aldo2>;
> 
> This is likely going to cause a circular dependency, because the RSB
> interface that is used to talk to the PMIC is also on the PL pins.

 Indeed that cause a Linux kernel to not boot at all.

> (How does FreeBSD deal with this?)

 We don't deal with vcc-X-supply until later in the boot, this is not
ideal but better than not dealing with them.

> Instead, just add a comment describing what is really used, and set
> the regulator to always-on, which should already be the case.

 Ok will do,

Thanks.

> ChenYu
> 
> > +};
> > +
> >  #include "axp803.dtsi"
> >
> >  &ac_power_supply {
> > --
> > 2.24.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
