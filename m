Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA5A206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVmyC9t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbgEYIug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388800AbgEYIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:50:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19751C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:50:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so6449044lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MClqz66Xz6cvx9U2z34WXfhFIf6bKDdfxKE4l1S5Dc=;
        b=PVmyC9t1Z3kTTSKm2hlXSwuZ4zCyT1V5zi3DvufV6enEk9caxMbM9EwjGHOAa15zXL
         4VcBCEA7Cbbj7wdMXzI6KXnxQKLzpc6Ny+MiSJEMqsu83vdADazzfJILQKj+eVhEpzZq
         /1Xv2TjwzEbzj2SUq8eh0YoJc1/APIpcOqdLz1qKEFuljfkLTbV6D8I0LNqGh6EPKMgH
         6bOnf/+i+2I0SEBxgysQe3swEwHX6SkG3W05RAU2AzBLhrk8E1pCMNZv5l9CsAUkrpNC
         WiYJ2O2Z6AQpigrRkQ3DPbudFvtSlmzyN0BIolAKiiPYIhSLyz2r2kyxohrYMzRIO1Bh
         4vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MClqz66Xz6cvx9U2z34WXfhFIf6bKDdfxKE4l1S5Dc=;
        b=aqe4G2r7M6zMbLDfPl+kmtpzXB2/UrN2E+yMmt1+ejrPshWGVE9Wpf5zcuERgS9nkj
         VHkOwv5DanDrDxfl9z6k5cM3ofiJ3IIBh5rCqHB7RhgEMZGrln13gCc8UZK/3gjh3ScR
         WLzZqlF4KuS2waN2dy75Pq/JzspikudqETRH5XzgIE5S4AA+O9V+ieNzRrMTHQHxtm7I
         dos3O/m5t1ru5HA44nWTaHIa4VGcUm68/IMHUXttZ0gelPoDIGdbBr7rhO5BQ04sXdZW
         vMAVIf1qqIACC4yL8EIqC3G22x1QTJjLyhGRWWcZdyd48a+4LnOtL6KxGUl3y8nMsoGf
         TYpg==
X-Gm-Message-State: AOAM533HhbrZGA9FgwOVz8M0vnNy9wV0YCgZAyKpvMqPzCmRe3py1AJp
        yoMIDUDSqSBnA03S0G419FAiqqdOAQn4hHFoqDFA8w==
X-Google-Smtp-Source: ABdhPJwEqiQr6pJCsZYfcsO57SsykPVbI/VsBBSRlb4YLFujW7KBNC+YrNwAzMlIvsgiyenalkPQqpdKxVH4ZoO4loY=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr13992943lfi.47.1590396633587;
 Mon, 25 May 2020 01:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141134.25819-1-lars.povlsen@microchip.com>
 <20200513141134.25819-2-lars.povlsen@microchip.com> <CACRpkdZa7OM3bqB+zRprEQ3M4m9hG3uPCoYxrdH_O=oxD8zi8Q@mail.gmail.com>
 <87pnb1nf2j.fsf@soft-dev15.microsemi.net>
In-Reply-To: <87pnb1nf2j.fsf@soft-dev15.microsemi.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:50:22 +0200
Message-ID: <CACRpkdYesD9sRQZXQNEaBY2Ouu3bjKKGWpRtU-Lpa4AcjyPwXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add bindings for mscc,ocelot-sgpio
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 10:50 PM Lars Povlsen
<lars.povlsen@microchip.com> wrote:
> Linus Walleij writes:
>
> > On Wed, May 13, 2020 at 4:11 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
> >
> >> This adds DT bindings for the Microsemi SGPIO controller, bindings
> >> mscc,ocelot-sgpio and mscc,luton-sgpio.
> >>
> >> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> >
> >> +  microchip,sgpio-ports:
> >> +    description: This is a 32-bit bitmask, configuring whether a
> >> +      particular port in the controller is enabled or not. This allows
> >> +      unused ports to be removed from the bitstream and reduce latency.
> >> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >
> > I don't know about this.
> >
> > You are saying this pin controller can have up to 32 GPIO "ports"
> > (also known as banks).
> >
> > Why can't you just represent each such port as a separate GPIO
> > node:
> >
> > pinctrl@nnn {
> >     gpio@0 {
> >         ....
> >     };
> >     gpio@1 {
> >         ....
> >     };
> >     ....
> >     gpio@31 {
> >         ....
> >     };
> > };
> >
> > Then if some of them are unused just set it to status = "disabled";
> >
> > This also makes your Linux driver simpler because each GPIO port
> > just becomes a set of 32bit registers and you can use
> > select GPIO_GENERIC and bgpio_init() and save a whole
> > slew of standard stock code.
> >
>
> Linus, thank you for your input.
>
> The controller handles an array of 32*n signals, where n >= 1 && n <=
> 4.
>
> The problem with the above approach is that the ports are disabled
> *port*-wise - so they remove all (upto) 4 bits. That would be across the
> banks.
>
> You could of course have the "implied" semantics that a disabled port at
> any bit position disabled all (bit positions for the same port).

I don't understand this, you would have to elaborate...

In any case microchip,sgpio-ports is probably not the right thing,
use ngpios which is documented and just divide by 32 to get the
number of ports I think? But that is just in case they get
enabled strictly in sequence, otherwise you'd need a custom
property.

Yours,
Linus Walleij
