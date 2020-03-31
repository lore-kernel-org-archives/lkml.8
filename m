Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B39C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E1F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585671684;
	bh=YHNMT5j8Euq0n+mseKfPA6cKBa4Jew7v+YKTKPRHb/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qzOTsS0JdAfmu2XExeKPZ8SK3mK4yLFYqTQwFNIyx1aqFdd5zMB2DMs+LyScvjpfx
	 LcfyWqH36WC+UPBmBYnHHZs1mdtc8X+vNHr0mQ0eoXbQ9d7M3spfaVXMN9v0sWAexc
	 tL/jUB6YpVuoMGRQBxS9LW/LHoBdkXCuoWdIl4/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgCaQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgCaQVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:21:23 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58DD21473;
        Tue, 31 Mar 2020 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585671682;
        bh=YHNMT5j8Euq0n+mseKfPA6cKBa4Jew7v+YKTKPRHb/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNLQBrPcq3oyN2Ogv+oTJyFfBNekyyJFE8OMY+ksIRuIUm4Epp9KM6Y1F/8vi0HEK
         10SfgtgPdKeKpsdZiqQ2ixSx9HcCCrFep4hoh/CePpyQATN8UU/WSDZC0IVmvAP2LT
         v14r3TcSkQKemqZJ9R1yludBCEJye3nWX1UaBApI=
Received: by mail-qt1-f175.google.com with SMTP id z12so18836742qtq.5;
        Tue, 31 Mar 2020 09:21:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0eFQXJPHRl5wRowCdEqbAlE5Qup/b60Tefav6tVtVAI01tH+j3
        jEPDKj3BsjkAHgUdk6rL/n79Yy8651xuJTczsA==
X-Google-Smtp-Source: ADFU+vtynyRBpHK1zGlgHy3HIyDVqOtqkMP9vtFANRwUVhPPv/eanwLrG9DiWcusvM2HxEgWHSF1cMX0wltfSbKtWIU=
X-Received: by 2002:ac8:1611:: with SMTP id p17mr5993804qtj.300.1585671680921;
 Tue, 31 Mar 2020 09:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200315191632.12536-1-rentao.bupt@gmail.com> <20200315191632.12536-7-rentao.bupt@gmail.com>
 <20200330192347.GA6388@bogus> <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
In-Reply-To: <4dc3ac910c79dcca398eb5161dde44e1cc50baca.camel@kernel.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Mar 2020 10:21:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
Message-ID: <CAL_JsqKZeCC352TKFGDNRRogSefF9vq+J=WqCEeg59PBsSOW1w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: usb: document aspeed vhub device
 ID/string properties
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 6:14 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Mon, 2020-03-30 at 13:23 -0600, Rob Herring wrote:
> > On Sun, Mar 15, 2020 at 12:16:32PM -0700, rentao.bupt@gmail.com wrote:
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > Update device tree binding document for aspeed vhub's device IDs and
> > > string properties.
> > >
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > ---
> > >  No change in v2:
> > >    - the patch is added into the series since v2.
> > >
> > >  .../bindings/usb/aspeed,usb-vhub.yaml         | 68 +++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > > index 06399ba0d9e4..5b2e8d867219 100644
> > > --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > > @@ -52,6 +52,59 @@ properties:
> > >          minimum: 1
> > >          maximum: 21
> > >
> > > +  vhub-vendor-id:
> > > +    description: vhub Vendor ID
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - maximum: 65535
> > > +
> > > +  vhub-product-id:
> > > +    description: vhub Product ID
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - maximum: 65535
> >
> > There's already standard 'vendor-id' and 'device-id' properties. Use
> > those.
>
> So yes and no... I don't fundamentally object but keep in mind that
> traditionally, the properties are about matching with a physical
> hardware.
>
> In this case however, we are describing a virtual piece of HW and so
> those IDs are going to be picked up to be exposed as the USB
> vendor/device of the vhub on the USB bus.
>
> Not necessarily an issue but it's more "configuration" than "matching"
> and as such, it might make sense to expose that with a prefix, though I
> would prefer something like usb-vendor-id or usb,vendor-id...

For FDT uses, it's pretty much been configuration. It's mostly been
for PCI that I've seen these properties used.

> > > +
> > > +  vhub-device-revision:
> >
> > Specific to USB, not vhub.
>
> Same as the above.
>
> > > +    description: vhub Device Revision in binary-coded decimal
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - maximum: 65535
> > > +
> > > +  vhub-strings:
> > > +    type: object
> > > +
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      '^string@[0-9a-f]+$':
> > > +        type: object
> > > +        description: string descriptors of the specific language
> > > +
> > > +        properties:
> > > +          reg:
> > > +            maxItems: 1
> > > +            description: 16-bit Language Identifier defined by USB-IF
> > > +
> > > +          manufacturer:
> > > +            description: vhub manufacturer
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/string
> > > +
> > > +          product:
> > > +            description: vhub product name
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/string
> > > +
> > > +          serial-number:
> > > +            description: vhub device serial number
> > > +            allOf:
> > > +              - $ref: /schemas/types.yaml#/definitions/string
> >
> > For all of this, it's USB specific, not vhub specific. I'm not sure this
> > is the right approach. It might be better to just define properties
> > which are just raw USB descriptors rather than inventing some DT format
> > that then has to be converted into USB descriptors.
>
> Raw blob in the DT is rather annoying and leads to hard to parse stuff
> for both humans and scripts. The main strenght of the DT is it's easy
> to read and manipulate.

True, and I'd certainly agree when we're talking about some vendor
specific blob. but there's already code/tools to parse USB
descriptors.

> Also not the entire descriptor is configurable this way.
>
> That said, it could be that using  the DT for the above is overkill and
> instead, we should consider a configfs like the rest of USB gadget.
> Though it isn't obvious how to do that, the current gadget stuff
> doesn't really "fit" what we need here.

Surely the descriptor building code can be shared at a minimum.

Regardless of whether gadget configfs fits, usually it is pretty clear
whether something belongs in DT or userspace. That should be decided
first.

> Maybe we could expose the port as UDCs but not actually expose them on
> the bus until the hub is "activated" via a special configfs entry...

If control of the hub is done by userspace, I'd think configuration
should be there too.

Rob
