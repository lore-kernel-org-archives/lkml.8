Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=INCLUDES_PATCH,RDNS_NONE,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgCKPsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:48:52 -0400
MIME-Version: 1.0
References: <20200303172533.30602-1-dafna.hirschfeld@collabora.com>
 <20200310211437.GA18992@bogus> <f612396e-e5e2-db76-6297-a108b53e4000@collabora.com>
In-Reply-To: <f612396e-e5e2-db76-6297-a108b53e4000@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 11 Mar 2020 10:48:39 -0500
Message-ID: <CAL_JsqLTMdG-=_pTPsazspEO3LtDth=xm9s8sqzW+AswWttKJA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: atmel_mxt_ts: convert
 atmel,maxtouch.txt to yaml
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc: devicetree@vger.kernel.org, Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 10:23 AM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> Hi,
> Thanks for the review
>
> On 10.03.20 22:14, Rob Herring wrote:
> > On Tue, Mar 03, 2020 at 07:25:33PM +0200, Dafna Hirschfeld wrote:
> >> Convert the binding file atmel,maxtouch.txt to yaml format.
> >> Also change the file name in the MAINTAINERS file.
> >>
> >> This was tested and verified on ARM and ARM64 with:
> >>
> >> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> >> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> >>
> >> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> >> ---
> >>   .../bindings/input/atmel,maxtouch.txt         | 41 ------------
> >>   .../bindings/input/atmel,maxtouch.yaml        | 64 +++++++++++++++++++
> >>   MAINTAINERS                                   |  2 +-
> >>   3 files changed, 65 insertions(+), 42 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> >>   create mode 100644 Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> >> deleted file mode 100644
> >> index c88919480d37..000000000000
> >> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> >> +++ /dev/null
> >> @@ -1,41 +0,0 @@
> >> -Atmel maXTouch touchscreen/touchpad
> >> -
> >> -Required properties:
> >> -- compatible:
> >> -    atmel,maxtouch
> >> -
> >> -    The following compatibles have been used in various products but are
> >> -    deprecated:
> >> -    atmel,qt602240_ts
> >> -    atmel,atmel_mxt_ts
> >> -    atmel,atmel_mxt_tp
> >> -    atmel,mXT224
> >> -
> >> -- reg: The I2C address of the device
> >> -
> >> -- interrupts: The sink for the touchpad's IRQ output
> >> -    See ../interrupt-controller/interrupts.txt
> >> -
> >> -Optional properties for main touchpad device:
> >> -
> >> -- linux,gpio-keymap: When enabled, the SPT_GPIOPWN_T19 object sends messages
> >> -    on GPIO bit changes. An array of up to 8 entries can be provided
> >> -    indicating the Linux keycode mapped to each bit of the status byte,
> >> -    starting at the LSB. Linux keycodes are defined in
> >> -    <dt-bindings/input/input.h>.
> >> -
> >> -    Note: the numbering of the GPIOs and the bit they start at varies between
> >> -    maXTouch devices. You must either refer to the documentation, or
> >> -    experiment to determine which bit corresponds to which input. Use
> >> -    KEY_RESERVED for unused padding values.
> >> -
> >> -- reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
> >> -
> >> -Example:
> >> -
> >> -    touch@4b {
> >> -            compatible = "atmel,maxtouch";
> >> -            reg = <0x4b>;
> >> -            interrupt-parent = <&gpio>;
> >> -            interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
> >> -    };
> >> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> >> new file mode 100644
> >> index 000000000000..024dc4ded4f3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
> >> @@ -0,0 +1,64 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/input/atmel,maxtouch.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Atmel maXTouch touchscreen/touchpad
> >> +
> >> +maintainers:
> >> +  - Nick Dyer <nick@shmanahar.org>
> >> +
> >> +description: |
> >> +  Atmel maXTouch touchscreen/touchpad
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: atmel,maxtouch
> >> +
> >> +  reg:
> >> +    description: The I2C address of the device
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    description: The sink for the touchpad's IRQ output
> >
> > How many? Needs 'maxItems: 1'>
> > You can drop the description.
> >
> >> +
> >> +  linux,gpio-keymap:
> >> +    description:
> >> +      When enabled, the SPT_GPIOPWN_T19 object sends messages
> >> +      on GPIO bit changes. An array of up to 8 entries can be provided
> >> +      indicating the Linux keycode mapped to each bit of the status byte,
> >> +      starting at the LSB. Linux keycodes are defined in
> >> +      <dt-bindings/input/input.h>.
> >> +      Note, the numbering of the GPIOs and the bit they start at varies between
> >> +      maXTouch devices. You must either refer to the documentation, or
> >> +      experiment to determine which bit corresponds to which input. Use
> >> +      KEY_RESERVED for unused padding values.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    maxItems: 8
> >> +
> >> +  reset-gpios:
> >> +    description: GPIO specifier for the touchscreen's reset pin (active low)
> >> +    maxItems: 1
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts
> >> +
> >> +additionalProperties: true
> >
> > That's the default and we generally want this to be 'false'.
> but many nodes has more properties not described here so I could not
> set it to false.

Like touchscreen-* properties? Then you should reference
touchscreen.yaml. And add 'unevaluatedProperties: false' here. That
doesn't yet do anything, but will when the tools support the lastest
json-schema release.

Rob

