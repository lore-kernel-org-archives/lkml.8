Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE2C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E7820709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Z844DkNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFUCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:02:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43222 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:02:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id j5so3639940otn.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMzXlI4eXcBBSJs7KiKlj7d7z04WUy2SFwDFYe8Tcig=;
        b=Z844DkNt5lzVBUHwoyeaTPtXkCuayuNUT3Pk2kBNVVEUPQmdeLx2yvB8JgjGZrxh7V
         eoRSWTRqWCE+ILI9gcyqM6wLF4CfIrcOLygTxwvf9EsZ5+6y/u/AIjNuWIuP1ArgWyyw
         S3Fch8kxDK2me49l+VEILLCOejxa0+BxxKx4ssyZx7pLm1KDqynmaVnw6fGCizpQ0Zs4
         Ji7WQSXwehpzC77QcNSDpkQx986fP2+JBVfDgK3/BF7kUyG0Lt3I2jhHI1YFMM+CUYlB
         c4F26ezTytt/t0c34XLt1rP3pL7l9hPCLWeW9CtyN5XdYwwUBl9kz9IMIb2m5ish3noy
         fY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMzXlI4eXcBBSJs7KiKlj7d7z04WUy2SFwDFYe8Tcig=;
        b=qouuhodqmZes7XWPNoxoBaHcddFvaO8bR5OPP2XW9uvexXwz3WG0yWcMUhunq3qcSX
         YzICMLCIasQad7i8j7xpmtWDICTpz7QjrAZkyaBhdzpM5GURtUowXipw1414EEEbULJ1
         4CiXx53a6kHB3nVQt39t5eYTVsjJ49Sm6Cz+gQRpt5syAB6ElYffpMtFA3uceezzPx5u
         TFZliucWB1CBt++oGtjcKwbvfp1d/MaTQQ7wh9bQMC4LBUSjMNLgwSNCmos8vRBJZ8qj
         XGBEXGXVrOLM/hszJHac6H3TfOZBNO1tUUeLcZEHrrido06BQUd/H4ZHeKCBFMccKLC/
         7cMQ==
X-Gm-Message-State: ANhLgQ3U2tMLjt8ELn0sN8t4dtnDLUYBJEuVAn7rEc4Mm5CzJpQF0UVa
        vWCiox9ixlITkXahddBh2/JzG2TvjcqQR/G8emCFP5IaLFM=
X-Google-Smtp-Source: ADFU+vu1RS3nf8reu36DceipCuq5IpQtNWeNqmqkurUGaX9j2e/3u6+1GePdgIdM1aGini5f8bUiLhK8TFCe3F569T4=
X-Received: by 2002:a05:6830:1503:: with SMTP id k3mr4088931otp.28.1583524962480;
 Fri, 06 Mar 2020 12:02:42 -0800 (PST)
MIME-Version: 1.0
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-2-git-send-email-tharvey@gateworks.com> <20200302204949.GA6649@bogus>
 <CAJ+vNU2ySjAP3q-4rgGy1U=iJeswv1kx6bKCy+Zw7V7oArkumw@mail.gmail.com> <CAL_JsqJnvW=pRt6M6sivxP62-qDg37czAZBKFV61CXO7Uazjsw@mail.gmail.com>
In-Reply-To: <CAL_JsqJnvW=pRt6M6sivxP62-qDg37czAZBKFV61CXO7Uazjsw@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 6 Mar 2020 12:02:31 -0800
Message-ID: <CAJ+vNU2c-Qr_rdWdFC77K8dcX-wgfVN5pXhtYG1nd4iniVT+fg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
>
<snip>
> > > > +properties:
> > > > +  $nodename:
> > > > +    pattern: "gsc@[0-9a-f]{1,2}"
> > > > +  compatible:
> > > > +    const: gw,gsc
> > >
> > > That's not very specific.
> > >
> >
> > Do you mean something like 'gw,system-controller' would be better
> > instead of the gsc abbreviation for 'Gateworks System Controller'?
>
> No, I mean is there or will there be only one version of this?
>

currently just 1 version is enough

> >
<snip>
> >
> > > > +
> > > > +  hwmon:
> > >
> > > 'hwmon' is a Linux thing. I'm suspicious...
> > >
> >
> > Yes, we've discussed this before and I understand that DT shouldn't
> > use terminology that is Linux specific (which is why I replaced
> > 'hwmon' with 'adc' in the ADC nodes below) but I still see a long of
> > dt bindings in Documentation/devicetree/bindings with the word 'hwmon'
> > in them.
> >
> > Perhaps this makes more sense?
>
> Yes, that's more aligned with IIO ADC bindings. Yes, IIO is again a
> Linuxism, but I think the ADC bindings are fairly independent other
> than the directory name.
>
> >
> > adc {
> >   compatible = "gw,gsc-adc";
> >   #address-cells = <1>;
> >   #size-cells = <0>;
> >
> >   channel@6 {
> >     type = "gw,hwmon-temperature";
> >     reg = <0x06>;
> >     label = "temp";
> >   };
> >   ...
> > };
> >

ok, will use adc/channel instead of hwmon/adc and change compatible to
'gw,gsc-adc'

> >
> > > > +    type: object
> > > > +    description: Optional Hardware Monitoring module
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: gw,gsc-hwmon
> > > > +
> > > > +      "#address-cells":
> > > > +        const: 1
> > > > +
> > > > +      "#size-cells":
> > > > +        const: 0
> > > > +
> > > > +      gw,fan-base:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description: The fan controller base address
> > >
> > > Shouldn't this be described as a node in the DT or be implied by the
> > > compatible?
> >
> > It does look out of place there. Would adding another subnode outside
> > of the (perhaps misnamed) 'hwmon' node make more sense?:
> >
> > fan:
> >  properties:
> >    compatible: gw,gsc-fancontroller
> >    reg:
> >      description: address of the fan controller base register
> >      maxItems: 1
>
> Seems somewhat better location in that the first level is
> sub-functions of this chip.
>
> But now you have 'adc' with no address and 'fan' (w/ reg should be
> fan@...) with an address, so that's not consistent.
>
> Also, I think fan controllers and fans need to have separate nodes as
> there are different types of fans such as with and without tach
> signals. I've tried to steer other fan bindings that way. Depends how
> complex the fan controller is whether that's necessary.
>

The fan controller does now support a tach signal reported via one of
the ADC channels (which I've neglected to cover) so I can represent
that as well in a new first level node such as:

  fan:
    type: object
    description: Optional FAN controller

    properties:
      compatible:
        const: gw,gsc-fan

      reg:
        description: The fan controller base address
        maxItems: 1

      gw,fan-tach-ch:
        description: The fan tach ADC channel
        maxItems: 1

    required:
      - compatible
      - reg

fan {
  compatible = "gw,gsc-pwm-fan";
  reg = <0x2c>;
  gw,fan-tach-ch = <0x16>;
};

<snip>
> >
> > > > +        type: object
> > > > +        description: |
> > > > +          Properties for a single ADC which can report cooked values
> > > > +          (ie temperature sensor based on thermister), raw values
> > > > +          (ie voltage rail with a pre-scaling resistor divider).
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            description: Register of the ADC
> > > > +            maxItems: 1
> > > > +
> > > > +          label:
> > > > +            description: Name of the ADC input
> > > > +
> > > > +          type:
> > >
> > > Very generic property name, but it's not generic. Needs a vendor prefix
> > > at least.
> >
> > You mean the property name of 'type' is fine, but the values will need
> > to be vendor specific like 'gw,temperature', 'gw,voltage',
> > 'gw,voltage-raw' or is it inappropriate to use 'type'?
>
> Don't use 'type'.
>
> Is this for 'how to setup/program the adc' or 'what am I measuring'?
> For example, configure the adc for temperature readings vs. measure
> CPU temperature. Seems like a common thing needed for ADC. 'label'
> already covers the latter case.

This is for translation of the raw ADC to a cooked value. An earlier
version of the GSC reported cooked values (doing the scaling in the
GSC firmware) and later versions report raw values which need to be
scaled depending on optional voltage divider so you can consider that
'setup'. Instead of handling this via a 'version' of the GSC I elected
to describe the difference in ADC channel type as I already had on
that reported millidegree celcius vs millivolts. I could just move
them to properties such as:

gw,temperature
gw,voltage
gw,voltage-raw

Only one of the above is allowed and am not sure how to represent that
in the yaml.

Alternatively I could call this property name 'gw,conversion' and
leave the three type enum?

>
> > > > +            description: |
> > > > +              temperature in C*10 (temperature),
> > > > +              pre-scaled voltage value (voltage),
> > > > +              or scaled based on an optional resistor divider and optional
> > > > +              offset (voltage-raw)
> > > > +            enum:
> > > > +              - temperature
> > > > +              - voltage
> > > > +              - voltage-raw
> > > > +
> > > > +          gw,voltage-divider:
> > > > +            allOf:
> > > > +              - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +            description: values of resistors for divider on raw ADC input
> > > > +            items:
> > > > +              - description: R1
> > > > +              - description: R2
> > >
> > > Needs a standard unit suffix. With that, you can drop the type
> > > reference.
> >
> > I understand the unit suffix but not sure what you mean by type
> > reference. Do you mean:
> >
> > gw,voltage-divider-milli-ohms:
> >   description: values of resistors for divider on raw ADC input
> >     items:
> >       - description: R1
> >       - description: R2
>
> Yes, drop the '$ref'.
>

ok,

Thanks,

Tim
