Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219FC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32C3206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583517048;
	bh=5rMJ7WU8kihvc/95pzuL9wp/s1bKJesptPNnSjIQkb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M0Pc7vtBCBs0nzQdR5JskFoHAuZoQvGRDXQCGxwzXETCPfos45P5PdU/UBNFeft9i
	 VXY1sUwPx7B8gAhirmhd0BxPjoYAHyMtLKVtfkJjaWF7NPbk9imp3Cg+ljNh1k7i/V
	 TNtbKUJ8Ic2tJy/bEECQkG4IqMWqcd9tcH6Ft/BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFRur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:50:47 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE5D2084E;
        Fri,  6 Mar 2020 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583517046;
        bh=5rMJ7WU8kihvc/95pzuL9wp/s1bKJesptPNnSjIQkb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w6XMGxCBVlC8t1Olh/w9bzeElFbljQ+vK4RO7Dto6taAy9J1BWhwg6PP+iBSM8qCf
         1VCFzMwEA+0PCHnYjQMAJXwYG42lfPokdP7a/ziNkBH1/43gbXp38ColDCmyyvnksk
         r+zwHAoCU+FBK8jpGGoFrWcYI1mmZojdoVPzK6zw=
Received: by mail-qv1-f54.google.com with SMTP id e7so1318531qvy.9;
        Fri, 06 Mar 2020 09:50:46 -0800 (PST)
X-Gm-Message-State: ANhLgQ1Aq5kEo3R20pxydo2XphsTYhfSOL34vXDzpXE1QFi6ltUmmalT
        wiwYCG3xKTHFWNOAKJ+YZ9pqN5nSloh5PCW5qA==
X-Google-Smtp-Source: ADFU+vucNe1zZESDTtcVCMKR7bBRtaitwdEGUyeLjzoaSMBOobGgODVX6O6CnXWWyY/pTxIHItb3uF3mqKbfXoGYAeU=
X-Received: by 2002:ad4:45e3:: with SMTP id q3mr3794285qvu.135.1583517045699;
 Fri, 06 Mar 2020 09:50:45 -0800 (PST)
MIME-Version: 1.0
References: <1582577665-13554-1-git-send-email-tharvey@gateworks.com>
 <1582577665-13554-2-git-send-email-tharvey@gateworks.com> <20200302204949.GA6649@bogus>
 <CAJ+vNU2ySjAP3q-4rgGy1U=iJeswv1kx6bKCy+Zw7V7oArkumw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2ySjAP3q-4rgGy1U=iJeswv1kx6bKCy+Zw7V7oArkumw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Mar 2020 11:50:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnvW=pRt6M6sivxP62-qDg37czAZBKFV61CXO7Uazjsw@mail.gmail.com>
Message-ID: <CAL_JsqJnvW=pRt6M6sivxP62-qDg37czAZBKFV61CXO7Uazjsw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: Add Gateworks System Controller bindings
To:     Tim Harvey <tharvey@gateworks.com>
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

On Fri, Mar 6, 2020 at 9:58 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Mon, Mar 2, 2020 at 12:49 PM Rob Herring <robh@kernel.org> wrote:
> >
>
> Rob,
>
> Thanks for the review! Some questions below:
>
> > On Mon, Feb 24, 2020 at 12:54:23PM -0800, Tim Harvey wrote:
> > > This patch adds documentation of device-tree bindings for the
> > > Gateworks System Controller (GSC).
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > > v5:
> > >  - resolve dt_binding_check issues
> > >
> > > v4:
> > >  - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> > >  - remove unncessary resolution/scaling properties for ADCs
> > >  - update to yaml
> > >  - remove watchdog
> > >
> > > v3:
> > >  - replaced _ with -
> > >  - remove input bindings
> > >  - added full description of hwmon
> > >  - fix unit address of hwmon child nodes
> > > ---
> > >  .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 158 +++++++++++++++++++++
> > >  1 file changed, 158 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > > new file mode 100644
> > > index 00000000..f7c1a05
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> > > @@ -0,0 +1,158 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/gateworks-gsc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Gateworks System Controller multi-function device
> > > +
> > > +description: |
> > > +  The GSC is a Multifunction I2C slave device with the following submodules:
> > > +   - Watchdog Timer
> > > +   - GPIO
> > > +   - Pushbutton controller
> > > +   - Hardware Monitore with ADC's for temperature and voltage rails and
> >
> > typo
>
> will fix
>
> >
> > > +     fan controller
> > > +
> > > +maintainers:
> > > +  - Tim Harvey <tharvey@gateworks.com>
> > > +  - Robert Jones <rjones@gateworks.com>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "gsc@[0-9a-f]{1,2}"
> > > +  compatible:
> > > +    const: gw,gsc
> >
> > That's not very specific.
> >
>
> Do you mean something like 'gw,system-controller' would be better
> instead of the gsc abbreviation for 'Gateworks System Controller'?

No, I mean is there or will there be only one version of this?

>
> > +
> > > +  reg:
> > > +    description: I2C device address
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  interrupt-controller: true
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1
> > > +    description: The IRQ number
> >
> > description is wrong. You can just drop it.
> >
>
> ok
>
> > > +
> > > +  hwmon:
> >
> > 'hwmon' is a Linux thing. I'm suspicious...
> >
>
> Yes, we've discussed this before and I understand that DT shouldn't
> use terminology that is Linux specific (which is why I replaced
> 'hwmon' with 'adc' in the ADC nodes below) but I still see a long of
> dt bindings in Documentation/devicetree/bindings with the word 'hwmon'
> in them.
>
> Perhaps this makes more sense?

Yes, that's more aligned with IIO ADC bindings. Yes, IIO is again a
Linuxism, but I think the ADC bindings are fairly independent other
than the directory name.

>
> adc {
>   compatible = "gw,gsc-adc";
>   #address-cells = <1>;
>   #size-cells = <0>;
>
>   channel@6 {
>     type = "gw,hwmon-temperature";
>     reg = <0x06>;
>     label = "temp";
>   };
>   ...
> };
>
>
> > > +    type: object
> > > +    description: Optional Hardware Monitoring module
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: gw,gsc-hwmon
> > > +
> > > +      "#address-cells":
> > > +        const: 1
> > > +
> > > +      "#size-cells":
> > > +        const: 0
> > > +
> > > +      gw,fan-base:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The fan controller base address
> >
> > Shouldn't this be described as a node in the DT or be implied by the
> > compatible?
>
> It does look out of place there. Would adding another subnode outside
> of the (perhaps misnamed) 'hwmon' node make more sense?:
>
> fan:
>  properties:
>    compatible: gw,gsc-fancontroller
>    reg:
>      description: address of the fan controller base register
>      maxItems: 1

Seems somewhat better location in that the first level is
sub-functions of this chip.

But now you have 'adc' with no address and 'fan' (w/ reg should be
fan@...) with an address, so that's not consistent.

Also, I think fan controllers and fans need to have separate nodes as
there are different types of fans such as with and without tach
signals. I've tried to steer other fan bindings that way. Depends how
complex the fan controller is whether that's necessary.

> > > +    patternProperties:
> > > +      "^adc@[0-2]$":
> >
> > There's only one number space at any level. So if you ever need anything
> > else at this level, it can't have an address. Just something to
> > consider.
> >
>
> yes, one number space is ok if I understand what you mean but I meant
> this to be "^adc@[0-9]+$" to support the number of ADC pins the part
> supports.
>
> > > +        type: object
> > > +        description: |
> > > +          Properties for a single ADC which can report cooked values
> > > +          (ie temperature sensor based on thermister), raw values
> > > +          (ie voltage rail with a pre-scaling resistor divider).
> > > +
> > > +        properties:
> > > +          reg:
> > > +            description: Register of the ADC
> > > +            maxItems: 1
> > > +
> > > +          label:
> > > +            description: Name of the ADC input
> > > +
> > > +          type:
> >
> > Very generic property name, but it's not generic. Needs a vendor prefix
> > at least.
>
> You mean the property name of 'type' is fine, but the values will need
> to be vendor specific like 'gw,temperature', 'gw,voltage',
> 'gw,voltage-raw' or is it inappropriate to use 'type'?

Don't use 'type'.

Is this for 'how to setup/program the adc' or 'what am I measuring'?
For example, configure the adc for temperature readings vs. measure
CPU temperature. Seems like a common thing needed for ADC. 'label'
already covers the latter case.

> > > +            description: |
> > > +              temperature in C*10 (temperature),
> > > +              pre-scaled voltage value (voltage),
> > > +              or scaled based on an optional resistor divider and optional
> > > +              offset (voltage-raw)
> > > +            enum:
> > > +              - temperature
> > > +              - voltage
> > > +              - voltage-raw
> > > +
> > > +          gw,voltage-divider:
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +            description: values of resistors for divider on raw ADC input
> > > +            items:
> > > +              - description: R1
> > > +              - description: R2
> >
> > Needs a standard unit suffix. With that, you can drop the type
> > reference.
>
> I understand the unit suffix but not sure what you mean by type
> reference. Do you mean:
>
> gw,voltage-divider-milli-ohms:
>   description: values of resistors for divider on raw ADC input
>     items:
>       - description: R1
>       - description: R2

Yes, drop the '$ref'.

Rob
