Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C9AC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920992083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com header.i=@solid-run-com.20150623.gappssmtp.com header.b="rtFeL/3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgG0Nd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgG0Nd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:33:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:33:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so3258904ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wP4Kt6O/vFKZf7I8OioZ5wu30mbV3QIkDu9uPSa2GcI=;
        b=rtFeL/3bkvsvdTZCa/KswNcWitGjGI+n5qCO6lZ7yIQ+yJ7VoEsrbaumluptUIpXIR
         gglMmLoYeTYvw7qniGc8izu5WjyIu3Hy5A5B8LHwnTbHdH7dbIsKgE/DALB2OSSCtiQl
         k2izB4ykZudJid3QApa7/xi5gU5+naaadOidfWiiJ2HPLtLrLIWWwXOFs0I0qa4q5dwa
         9Ik2ECh2HoCE6GFbAkVHLMC+1wbHFJmmBCMqqBmxkb+4XcnpqUZoJuMGOScfeVpiuzri
         hoF+SL6zVOKwskJDGPLPCZzuv82uXzEB1uvqCDoSV+wMA/zeQ7TyqFGPMXqXHb4E06yK
         xsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wP4Kt6O/vFKZf7I8OioZ5wu30mbV3QIkDu9uPSa2GcI=;
        b=JqttsWl8aZxWlKobT8DvXM/TbfCu59gcnNx5j9KcVjwaiKMqx0rsN6WBF59UdzBbUD
         vJGD2uNF9mV8gyindAJxp/1YPnp+F2DUxnznA8r19W5PYf/AR+q//lB4hj73+nLKl6TP
         rCwcGpHpSeY1dU60/T1LQNKU0czjb01GmXL2lYIaMmonENzkNtXnfct0loIpZ5Yh+bRk
         RL8BmgoHgzy4uyc4QwE2I4xXIbogeiZsOkqM7yt1W/1ReupMxld7XHh2ujf0fPZVajJD
         e20C6LSyDj3Drb7yHuARqJGuFoywOobduGSe45kaxnewC2x5RsNUXwiEJUyjpCMlgn6E
         gGCA==
X-Gm-Message-State: AOAM532Gfg0JqdPPY+uQ+gKbbqb9Y18dqF+8ipyQvDik2j9hfFrnsONR
        EI6d7F/fAauxdVEa0u4cScnP2EFiSqDsvUfAp907Ig==
X-Google-Smtp-Source: ABdhPJzJGn+4YDJzQefhbMCC1tH9BXbFde1p6PfI6RTnxkY59oNtWoUgcWF5pmJomBPWvBJQO23dmeziJ/HbuhtjAYs=
X-Received: by 2002:a17:906:a204:: with SMTP id r4mr13603758ejy.552.1595856834293;
 Mon, 27 Jul 2020 06:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com> <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net> <20200727094553.GH1551@shell.armlinux.org.uk>
In-Reply-To: <20200727094553.GH1551@shell.armlinux.org.uk>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Mon, 27 Jul 2020 15:33:17 +0200
Message-ID: <CABdtJHu2BacX+EeVkCxFYWfNxJ-7Z5MP7BqVfF2KHy+XfJGN3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>,
        a.zummo@towertech.it, Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:46 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jul 23, 2020 at 09:57:55PM +0200, Alexandre Belloni wrote:
> > On 23/07/2020 11:49:05-0600, Rob Herring wrote:
> > > On Mon, Jul 20, 2020 at 12:23:59PM +0100, miguelborgesdefreitas@gmail.com wrote:
> > > > From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > >
> > > > This adds direct-switching mode as a configurable DT flag for
> > > > RTC modules supporting it (e.g. nxp pcf8523).
> > > > DSM switches the power source to the battery supply whenever the
> > > > VDD drops below VBAT. The option is recommended for hw designs
> > > > where VDD is always expected to be higher than VBAT.
> > > >
> > > > Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Added extended commit message for git history
> > > > - Separate dt bindings documentation into a single patch
> > > >
> > > >  Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt | 7 ++++++-
> > > >  Documentation/devicetree/bindings/rtc/rtc.yaml        | 7 +++++++
> > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > index 0b1080c..f715a8f 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt
> > > > @@ -4,10 +4,14 @@ Required properties:
> > > >  - compatible: Should contain "nxp,pcf8523".
> > > >  - reg: I2C address for chip.
> > > >
> > > > -Optional property:
> > > > +Optional properties:
> > > >  - quartz-load-femtofarads: The capacitive load of the quartz(x-tal),
> > > >    expressed in femto Farad (fF). Valid values are 7000 and 12500.
> > > >    Default value (if no value is specified) is 12500fF.
> > > > +- pm-enable-dsm: battery switch-over function is enabled in direct
> > > > +  switching mode. The power failure condition happens when VDD < VBAT,
> > > > +  without requiring VDD to drop below Vth(sw)bat.
> > > > +  Default value (if not provided) is the standard mode.
> > > >
> > > >  Example:
> > > >
> > > > @@ -15,4 +19,5 @@ pcf8523: rtc@68 {
> > > >   compatible = "nxp,pcf8523";
> > > >   reg = <0x68>;
> > > >   quartz-load-femtofarads = <7000>;
> > > > + pm-enable-dsm;
> > > >  };
> > > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > index ee237b2..a0048f4 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > > @@ -47,4 +47,11 @@ properties:
> > > >      description:
> > > >        Enables wake up of host system on alarm.
> > > >
> > > > +  pm-enable-dsm:
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +    description:
> > > > +      Enables the battery switch-over function in direct switching
> > > > +      mode. Should be set in systems where VDD is higher than VBAT
> > > > +      at all times.
> > >
> > > I'm all for common properties, but is this common across vendors?
> > >
> >
> > This is but this shouldn't be a DT property as it has to be changed
> > dynamically. I'm working on an ioctl interface to change this
> > configuration.
>
> Why does it need to be changed dynamically?  If the hardware components
> are not fitted to allow the RTC to be safely used without DSM, then
> why should userspace be able to disable DSM?
>

My presumption would be if you had a system that ran at different
system voltages depending if it is plugged in to mains or running on a
battery.
