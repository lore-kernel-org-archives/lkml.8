Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC35C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECF5206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467999;
	bh=ZtASUsHSUH9iBmQouSmlHBp0adBRXfaTVKN3IEKwB2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nU+JqJh8EwiYRHyEZ6nzcOzdAcujb3DWT1slYQzVAqdUQ4jYrHEuRiHaWPMzR7Xr+
	 Lb47yWplcQdc8sUzH07FVieqSP1SCmozvQtud/Nt0rpL/WeOncKlAfzwbkpK/YBUhX
	 fIG5nAioXFbbzcKtPxGw8NmH8OgRVtL4gBe6W3C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgF2V75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgF2SfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:25 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCA3255C7;
        Mon, 29 Jun 2020 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593453470;
        bh=ZtASUsHSUH9iBmQouSmlHBp0adBRXfaTVKN3IEKwB2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2kKS+wDhkOuxpH9plHm9j0XcBd1NOUkJJmJEvlxcmanpfHqlzhfaHZvWTWdWKm1fj
         wSf07FVi3Vc5BoJg00SsFz9stOKYZjSXPZ0CZnwRUr9xGG9SK7jE+dnTuQahmLknAV
         QdfXGtfSQm+QApl5nSJa5URHEmOz9dzGsODL98zw=
Received: by mail-ot1-f51.google.com with SMTP id q21so8790879otc.7;
        Mon, 29 Jun 2020 10:57:49 -0700 (PDT)
X-Gm-Message-State: AOAM530ZH+ymx1LRhBUi64LdyKz+BbmrCg9xFIijTPklFGRFQdXbXrT8
        a0c6j2G3NQXXwQ5O1ORx4/1uP7KmUySXwk2IGA==
X-Google-Smtp-Source: ABdhPJyimQAzFgXMjRYrAPs8oEIeWpJhMBKYcA7auFeZopuljB1Q7c28J7qEymPHWgbqxTgyvUyyluEt85Lj4qCu1n4=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr14554766ots.192.1593453469212;
 Mon, 29 Jun 2020 10:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200618224413.1115849-1-robh@kernel.org> <20200619215341.GA6857@ravnborg.org>
 <20200622165730.pnx7fzbq5e6q5h4l@holly.lan>
In-Reply-To: <20200622165730.pnx7fzbq5e6q5h4l@holly.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Jun 2020 11:57:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1yJ09k6tKak==TjRN17VzueVkcf-WOLw2ETL2ZJv9sg@mail.gmail.com>
Message-ID: <CAL_JsqK1yJ09k6tKak==TjRN17VzueVkcf-WOLw2ETL2ZJv9sg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight bindings
 to DT schema
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:57 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jun 19, 2020 at 11:53:41PM +0200, Sam Ravnborg wrote:
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > > new file mode 100644
> > > index 000000000000..7e1f109a38a4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > > @@ -0,0 +1,98 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/pwm-backlight.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: pwm-backlight bindings
> > > +
> > > +maintainers:
> > > +  - Lee Jones <lee.jones@linaro.org>
> > > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > > +  - Jingoo Han <jingoohan1@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: pwm-backlight
> > > +
> > > +  pwms:
> > > +    maxItems: 1
> > > +
> > > +  pwm-names: true
> > > +
> > > +  power-supply:
> > > +    description: regulator for supply voltage
> > > +
> > > +  enable-gpios:
> > > +    description: Contains a single GPIO specifier for the GPIO which enables
> > > +      and disables the backlight
> > > +    maxItems: 1
> > > +
> > > +  post-pwm-on-delay-ms:
> > > +    description: Delay in ms between setting an initial (non-zero) PWM and
> > > +      enabling the backlight using GPIO.
> > > +
> > > +  pwm-off-delay-ms:
> > > +    description: Delay in ms between disabling the backlight using GPIO
> > > +      and setting PWM value to 0.
> > > +
> > > +  brightness-levels:
> > > +    description: Array of distinct brightness levels. Typically these are
> > > +      in the range from 0 to 255, but any range starting at 0 will do. The
> > > +      actual brightness level (PWM duty cycle) will be interpolated from
> > > +      these values. 0 means a 0% duty cycle (darkest/off), while the last
> > > +      value in the array represents a 100% duty cycle (brightest).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +
> > > +  default-brightness-level:
> > > +    description: The default brightness level (index into the array defined
> > > +      by the "brightness-levels" property).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > Same comment as before...
>
> Sorry the "ditto" meant I didn't thing about PWM as much as I should
> have.
>
> The situation for PWM is a little different to LED. That's mostly
> because we decided not to clutter the LED code with
> "num-interpolated-steps".
>
> The PWM code implements the default-brightness-level as an index into
> the brightness array *after* it has been expanded using interpolation.
> In other words today Linux treats the default-brightness-level more
> like[1].
>
>     description: The default brightness level. When
>       num-interpolated-steps is not set this is simply an index into
>       the array defined by the "brightness-levels" property. If
>       num-interpolated-steps is set the brightness array will be
>       expanded by interpolation before we index to get a default
>       level.
>
> This is the best I have come up with so far... but I concede it still
> lacks elegance.

Happy to add this or whatever folks want if there's agreement, but I
don't want to get bogged down on re-reviewing and re-writing the
binding on what is just a conversion. There's a mountain of bindings
to convert.

Rob
