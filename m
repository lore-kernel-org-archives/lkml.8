Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33562C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D0B2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f44+CoWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394744AbgAPR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:59:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34334 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394723AbgAPR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:59:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so19738719edw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ownIKscCoJ0ifHnW+WtXLNIaHz3TKTKB9xX6VT8y1A8=;
        b=f44+CoWj4lO/C+QdvGojAgqPOI4YZ5boSw/hGgMBaiTA4H+d+tLuOpWvF99HpOOy3A
         iqkPKL8kBRo9t8ns8InBbiB/zCzzOxaT0N7uBbkLZGBFz8f/SvuTmzL5s/PgsrFmPg76
         Bjtkflj/Fk1zbC/Vt4uT8Aa+gjWLtXgUcFpMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ownIKscCoJ0ifHnW+WtXLNIaHz3TKTKB9xX6VT8y1A8=;
        b=qV98hMd0yGFSyTeECaO+Cv2Bchta8ZC60JpFC/hvfQpEUPbZ1iuL5PfYl32B7Och93
         RtKcFYS++tWdal0RmPu/kbyIYoFrrOz842wHP90taHDIol/q+tJuNtOapSs4d+/9gG2M
         qwLQmfVrh96MFjQzNbH5CqKaWnCqGLqvbNR99tRS4gDYUa6pZ738RJ2xc0pLp7Sy3fld
         vlqqh86kyEf1ajIGck70Z0H1aMuKEBzefCw/IvUPseFePnaMcO6g4Wx1DK8CUj4/GnVl
         UNHwtmY4ps9+mdEPR8r80yMm9oeGTthlk3QOgCJ9EemADZUkaT02oIFQPJnncHIvk+/X
         Sy9w==
X-Gm-Message-State: APjAAAVSSwbDJ4rvb56v3NQ29gHlFEhuBm4mhkffcFPwRZpVnP8h0P3c
        /2Nw55Qvt++TSZnesGeqVDKbvifXNV4=
X-Google-Smtp-Source: APXvYqw4PTotrGhk2VAOEhyS3ZV29hZJWI/gUNyedOEjBfJkvCixcYNhB9g+Jdp0Q9shEYA7I5SGvg==
X-Received: by 2002:a17:906:33db:: with SMTP id w27mr4168230eja.347.1579197545699;
        Thu, 16 Jan 2020 09:59:05 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k26sm902652edv.13.2020.01.16.09.59.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 09:59:05 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id l8so19738641edw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:59:04 -0800 (PST)
X-Received: by 2002:a05:6402:1547:: with SMTP id p7mr37597769edx.73.1579197544298;
 Thu, 16 Jan 2020 09:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20191217005424.226858-1-swboyd@chromium.org> <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
 <20191220231040.GA11384@bogus> <5e12cc29.1c69fb81.fe838.d5f3@mx.google.com>
In-Reply-To: <5e12cc29.1c69fb81.fe838.d5f3@mx.google.com>
From:   Andrey Pronin <apronin@chromium.org>
Date:   Thu, 16 Jan 2020 09:58:52 -0800
X-Gmail-Original-Message-ID: <CAP7wa8Lfgm5h5j0jvkYP+sFHnz6jRb1m8fCi-8AvPmNqfupenw@mail.gmail.com>
Message-ID: <CAP7wa8Lfgm5h5j0jvkYP+sFHnz6jRb1m8fCi-8AvPmNqfupenw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: tpm: Convert cr50 binding to YAML
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 5, 2020 at 9:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rob Herring (2019-12-20 15:10:40)
> > On Tue, Dec 17, 2019 at 09:45:02AM -0800, Doug Anderson wrote:
> > > On Mon, Dec 16, 2019 at 4:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> > > > new file mode 100644
> > > > index 000000000000..8bfff0e757af
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> > > > @@ -0,0 +1,52 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: H1 Secure Microcontroller with Cr50 Firmware on SPI Bus
> > > > +
> > > > +description:
> > > > +  H1 Secure Microcontroller running Cr50 firmware provides several functions,
> > > > +  including TPM-like functionality. It communicates over SPI using the FIFO
> > > > +  protocol described in the PTP Spec, section 6.
> > > > +
> > > > +maintainers:
> > > > +  - Andrey Pronin <apronin@chromium.org>
> > >
> > > Does Andrey agree to be the maintainer here?
>
> I Cced Andrey in hopes of eliciting a response.

Yes, I finally can confirm I agree to be the maintainer.

>
> > >
> > >
> > > I'd like to see if we can delete most of what you've written here.
> > > Specifically in "spi/spi-controller.yaml" you can see a really nice
> > > description of what SPI devices ought to look like.  Can we just
> > > reference that?  To do that I _think_ we actually need to break that
> > > description into a separate YAML file and then include it from there
> > > and here.  Maybe someone on the list can confirm or we can just post
> > > some patches for that?
>
> I'm not sure what to do here.
>
> > >
> > >
> > > > +properties:
> > > > +  compatible:
> > > > +    const: google,cr50
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > >
> > > I'm curious if you need a minItems here.  ...and if we don't somehow
> > > include it, should we follow 'spi-controller.yaml' and treat this like
> > > an int?
> >
> > Really, just 'true' is sufficient as you can't say which CS number it is
> > here.
>
> Ok.
>
> > >
> > >
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - spi-max-frequency
> > >
> > > Technically spi-max-frequency might not be required (the SPI binding
> > > doesn't list it as such), but I guess it was before...
> >
> > Generally, we expect a device knows its max and this should only be used
> > it a board has a lower value. However, sometimes there's exceptions.
> >
> > Shouldn't really be debate here unless the old binding doc was wrong.
>
> The old binding doc had it as required and the spi framework seems to
> bail out if this property isn't specified (see of_spi_parse_dt() for
> more details).
>
> >
> > >
> > >
> > > > +  - interrupts
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +    spi {
> > > > +      #address-cells = <0x1>;
> > > > +      #size-cells = <0x0>;
> > > > +      tpm@0 {
> > > > +          compatible = "google,cr50";
> > > > +          reg = <0>;
> > > > +          spi-max-frequency = <800000>;
> > > > +          interrupts = <50 IRQ_TYPE_EDGE_RISING>;
> > >
> > > I would tend to prefer seeing the interrupt parent in the example
> > > since it's pretty likely that the GPIO controller isn't the overall
> > > parent and likely that our interrupt is a GPIO.  I'm not sure the
> > > convention, though.
> >
> > Example is fine, but shouldn't be in the schema.
>
> Ok. Will add an interrupt parent like
>
>         interrupt-parent = <&gpio_controller>;
>


-- 
Andrey
