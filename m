Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27AC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB73F206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="zIZsDrrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbgDCFqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:46:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33452 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgDCFqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:46:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id y138so4240106vsy.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4XNepmeOooAZ1+s30LlQ+CWVHmuUGaSrMEBEx9YwGo=;
        b=zIZsDrrcJTGyEaY5wJrQpWkaz8MwaasE7La+XUSJtg3/Fei8sHG6TmlNUnjdV7T8wX
         1FIaPRHwHluCkALganU6p5noYpWnVJvyIcTBe/kRZvpNkl0XRMrzCX5rf92cMtef4pqC
         mAnt9li35bOeUdLroCDFuMJGkqRiePNH/be4Pxcwvu/tpzxeR/WQu3iVky+eJ+PODVFi
         FziBzTQuwvkfBRaQbRN1MBwYaHBeLy2LEHuO8dbafMgAdj+9bWofkpNNeErdiyWGXIFE
         HYIHu9XnCX4FetnrNoz53MjaDLTaShXiszb1qIIrvZZWtkXGaHxZg55ongNI0Mv/UmTj
         AYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4XNepmeOooAZ1+s30LlQ+CWVHmuUGaSrMEBEx9YwGo=;
        b=c3HABnFd9sGv4uniq8kbyITyuxJ47NKTFnL0KFi//VJDtEGCYmigo+17YT56QGSReE
         6J/ZxefgQ4bBeTIoS7S4tufBN4XDsuEb0T9chjh1ozoqc4sDY7SQmDSC1pQMS9FtIOVC
         +exaRt0aJv2BAwgN2YumIZUosKZ74dna2ScLmyJpRJ0LOFFMon7IJTjh1Ck3fF9jmsZC
         OJFMWdi+pVY8b74FKIXQVbdLUZGHp5LUb0RhcDAchzCItlZZvYqBmHZDwYLGAlTV8Jfq
         Q1tKDsRvmt8exm2qJs41Eb+Y1mTVXi2tnyxetOUu7/OfGOv2v3cr4D75RYiALMoMdSVt
         7hwQ==
X-Gm-Message-State: AGi0PuZyDeCsFAU7oSceSTA5cUgDSr2fIKf68uViDmu7JtM6+aDzQXWf
        2yZPgR/FFJFsnSSTmo2h8ZwkQVldzfimimsGumIMMw==
X-Google-Smtp-Source: APiQypKwPJ3eQAj3UmcqOc18/vQnRNsFvQw3FTV9eUmQpOy4PLfT3A7xYCqvCkwaapvUhQCilHz1KbZizZs8pohCCcQ=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr5288832vsq.182.1585892764055;
 Thu, 02 Apr 2020 22:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
 <1584966504-21719-3-git-send-email-Anson.Huang@nxp.com> <CAHLCerNG3ZBbWrTwXxCbd1BOfyHxuvpAuo5tW_bNKgWcO5zESA@mail.gmail.com>
 <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 3 Apr 2020 11:15:53 +0530
Message-ID: <CAHLCerMEn7g3a-MG9xiiLKMUCLXjKRiuZ_wMjRjPJCXvDMzDdA@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 9:04 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Amit
>
> > Subject: Re: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
> >
> > On Mon, Mar 23, 2020 at 6:05 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > i.MX8MP has a TMU inside which supports two thermal zones, add support
> > > for them.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> >
> > [snip]
> >
> > >
> > > +       thermal-zones {
> > > +               cpu-thermal {
> > > +                       polling-delay-passive = <250>;
> > > +                       polling-delay = <2000>;
> > > +                       thermal-sensors = <&tmu 0x0>;
> >
> > No need for 0x0, just use 0
>
> OK.
>
> >
> > > +                       trips {
> > > +                               cpu_alert0: trip0 {
> > > +                                       temperature = <85000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               cpu_crit0: trip1 {
> > > +                                       temperature = <95000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "critical";
> > > +                               };
> > > +                       };
> > > +
> > > +                       cooling-maps {
> > > +                               map0 {
> > > +                                       trip = <&cpu_alert0>;
> > > +                                       cooling-device =
> > > +                                               <&A53_0
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_1
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_2
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_3
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               soc-thermal {
> > > +                       polling-delay-passive = <250>;
> > > +                       polling-delay = <2000>;
> > > +                       thermal-sensors = <&tmu 0x1>;
> >
> > No need for 0x1, just use 1
>
> OK.
>
> >
> > > +                       trips {
> > > +                               soc_alert0: trip0 {
> > > +                                       temperature = <85000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               soc_crit0: trip1 {
> > > +                                       temperature = <95000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "critical";
> > > +                               };
> > > +                       };
> >
> > You need a cooling-map here since you have a passive trip point.
>
> Currently, there is no cooling map defined for soc thermal zone, the cpufreq cooling
> is mapped to cpu thermal zone already, so do you think it is OK to leave it as no cooling
> map, or it is better to put cpufreq cooling for soc thermal zone as well?
>

If there is no cooling, why do you need a passive trip point? Just
make it a hot trip that will send you a nofication (if .notify
callback registered).

Regards,
Amit
