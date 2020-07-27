Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ABFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097D2207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="pq5TkMXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgG0Oxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgG0Oxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:53:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FDFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:53:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f14so1514082ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCQp04gaUj6KkSnmOynTN5DWIdoTsVqJqWxUkHbzffI=;
        b=pq5TkMXOQlAMMfmLjbyxYb5ODxbZOaUIvr98CgMAX+JRzkZXMXVCqNbI0PnrVM/8Ii
         +YPP+5B9ghuK0TO845Bv6JhjHvj2rM3UMlRbrF36R4ql2z6nDxX9CJV8Ufa1ALYIGdWG
         czoOmvTHFSjFGN5lnQ2hZv8t8wJ6jKhoE/ZmogrWKtHRH9/LxX2tChA0K4dKKDFARJ8K
         ysM36eVGT7/R94eoeeDlcDOKtyYNlY9YC/sEOd5uJLXWwmqzu1qmRIMfAPiECZ4DZHVH
         KUIPzPwaKL38NQWH1VYkUlwNxotUxis5blXXICAWS04m7R1ecgEwHSzM7QGidgXpmQAx
         onKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCQp04gaUj6KkSnmOynTN5DWIdoTsVqJqWxUkHbzffI=;
        b=RPXkj3yOh/DVqbin4nS7DJrt4CPJ/YLlkMNhGFsvwC6cnCmPxH11hYABQvaZsHWKAe
         Vysn9FMe87Y/Z/Hm1HzWnMisxgxKb4ykG8s5CuG+vAiapuVERlfwGbQaQ8AdOvF3/oFm
         yIdGKT5InLw7+xPMGttkNb12Z7N3tMM+d68DoLe0RQCxrWRCIg0iCR2L9K73Z8i4TUhA
         4K6DRr/jAV3OGKReN2DJbaF2zHziDaMtU7Gpr55uNQ8Yiwq60SqbRb0ck/188RHlfuVg
         HXzWycPY4UUb9zH56mJwd++7xQ33JJT0rwpk9E77OMe5jCsM0ASNjrP4mZSwkmUrxVsE
         G14g==
X-Gm-Message-State: AOAM530ykQaDPUXrRF3xPGfNrGKs6cnPNR4F/cz7DsGGizIuByqPMuTi
        qc+gdkQPnA1X7cc2wWxNtVthrG5K24DHbarPqzWWzg==
X-Google-Smtp-Source: ABdhPJy7XLns5nLG05OdBbUylSemksWFr2TLHaYF566wq5VWjAAx+FLLYE2WnV0UslxIVf7mRgpoCwhY5w/gyXEARqQ=
X-Received: by 2002:a17:906:600f:: with SMTP id o15mr6513709ejj.41.1595861615025;
 Mon, 27 Jul 2020 07:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com> <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk> <CABdtJHu2BacX+EeVkCxFYWfNxJ-7Z5MP7BqVfF2KHy+XfJGN3w@mail.gmail.com>
 <20200727141729.GJ1551@shell.armlinux.org.uk>
In-Reply-To: <20200727141729.GJ1551@shell.armlinux.org.uk>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 27 Jul 2020 16:52:58 +0200
Message-ID: <CABdtJHtQfrnfdyUgp07G=2_7dLBqnnkmAdZ_Fbqiy84tndJX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sascha Hauer <kernel@pengutronix.de>, a.zummo@towertech.it,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 4:17 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jul 27, 2020 at 03:33:17PM +0200, Jon Nettleton wrote:
> > On Mon, Jul 27, 2020 at 11:46 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Jul 23, 2020 at 09:57:55PM +0200, Alexandre Belloni wrote:
> > > > On 23/07/2020 11:49:05-0600, Rob Herring wrote:
> > > > > On Mon, Jul 20, 2020 at 12:23:59PM +0100, miguelborgesdefreitas@gmail.com wrote:
> > > > > > From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > > > >
> > > > > > This adds direct-switching mode as a configurable DT flag for
> > > > > > RTC modules supporting it (e.g. nxp pcf8523).
> > > > > > DSM switches the power source to the battery supply whenever the
> > > > > > VDD drops below VBAT. The option is recommended for hw designs
> > > > > > where VDD is always expected to be higher than VBAT.
> > > > > >
> > > > > > Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Added extended commit message for git history
> > > > > > - Separate dt bindings documentation into a single patch
> > > > > >
> > > > > >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
> > > > > >  Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
> > > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > > index 0b1080c..f715a8f 100644
> > > > > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > > > @@ -4,10 +4,14 @@ Required properties:
> > > > > >  - compatible: Should contain "nxp,pcf8523".
> > > > > >  - reg: I2C address for chip.
> > > > > >
> > > > > > -Optional property:
> > > > > > +Optional properties:
> > > > > >  - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> > > > > >    expressed in femto Farad (fF). Valid values are 7000 and 12500.
> > > > > >    Default value (if no value is specified) is 12500fF.
> > > > > > +- pm-enable-dsm: battery switch-over function is enabled in direct
> > > > > > +  switching mode. The power failure condition happens when VDD < VBAT,
> > > > > > +  without requiring VDD to drop below Vth(sw)bat.
> > > > > > +  Default value (if not provided) is the standard mode.
> > > > > >
> > > > > >  Example:
> > > > > >
> > > > > > @@ -15,4 +19,5 @@ pcf8523: rtc@68 {
> > > > > >   compatible = "nxp,pcf8523";
> > > > > >   reg = <0x68>;
> > > > > >   quartz-load-femtofarads = <7000>;
> > > > > > + pm-enable-dsm;
> > > > > >  };
> > > > > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > > index ee237b2..a0048f4 100644
> > > > > > --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > > > @@ -47,4 +47,11 @@ properties:
> > > > > >      description:
> > > > > >        Enables wake up of host system on alarm.
> > > > > >
> > > > > > +  pm-enable-dsm:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > > > +    description:
> > > > > > +      Enables the battery switch-over function in direct switching
> > > > > > +      mode. Should be set in systems where VDD is higher than VBAT
> > > > > > +      at all times.
> > > > >
> > > > > I'm all for common properties, but is this common across vendors?
> > > > >
> > > >
> > > > This is but this shouldn't be a DT property as it has to be changed
> > > > dynamically. I'm working on an ioctl interface to change this
> > > > configuration.
> > >
> > > Why does it need to be changed dynamically?  If the hardware components
> > > are not fitted to allow the RTC to be safely used without DSM, then
> > > why should userspace be able to disable DSM?
> > >
> >
> > My presumption would be if you had a system that ran at different
> > system voltages depending if it is plugged in to mains or running on a
> > battery.
>
> Yes, but we're not talking about that case with the Cubox-i.
>
> Should a platform like the Cubox-i allow the user to disable DSM?
>
> There needs to be a way to block the ability to dynamically change
> this mode if the hardware is not up to operating without DSM.
>

Agreed.  Do we need a modes supported device-tree property?  That
would actually describe the hardware as device-tree is supposed to do.
