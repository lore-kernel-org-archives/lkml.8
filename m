Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31846C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25CD207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582078837;
	bh=PukdpJhhjgYuAnS+LZqnItKFXpPSM7F0J1SE58D5GOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yhJX3VADRC/PVe+CnwUKjJRb0nEDJu2Yjd7IJJ1k7SdfQNkAB2mLNN5Ugh9NbAJlq
	 pnprytuUIgI+/eho41n3f377JvsSHGCTLkr3dMDN348YGloFIAvsRBKsS89M2WbQM6
	 8b+h7QMmE40UDX6olg36Iyct8c2GSSm2uu3hcvfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBSCUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgBSCUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:20:35 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068C624656;
        Wed, 19 Feb 2020 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582078834;
        bh=PukdpJhhjgYuAnS+LZqnItKFXpPSM7F0J1SE58D5GOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4lXXwO4SG3sg/Vjn3QtQ8n6He791ZtltltY8C9Epz8Ev7O+ItEwRyZoilVbAkbVI
         ZuEC0tJX6L3mi9N7G5Yif6uwcbZC+mPeNJEOEg4Y1rAdYE70I1qXIVko6LiJ7E+11B
         1sTqa+CltotDgvP+ukaB1tlX38y4z5pWwb8JVHVg=
Received: by mail-qv1-f50.google.com with SMTP id g6so10155202qvy.5;
        Tue, 18 Feb 2020 18:20:33 -0800 (PST)
X-Gm-Message-State: APjAAAWtdNnwruCTYajSY7faAXD4TA+lITKrh0+dY7T1/prj5+MQnRC1
        ZxHfxZPqQxfhDe4Lh+iN6lzkgFHkGV0YyF8HPg==
X-Google-Smtp-Source: APXvYqxtH4o9QxC+wJQ6/wOQr4uDaUYk+7j4zB9Fpp9gPaJ4ls+hEXLdVid0z3MoBMAlbuS+Dn+XXQvbF8+GM2YW3+E=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr17987010qvu.136.1582078833043;
 Tue, 18 Feb 2020 18:20:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200213123953epcas1p45c39830a9ec6bd535f5370702f603806@epcas1p4.samsung.com>
 <20200213123934.10841-1-dafna.hirschfeld@collabora.com> <a1bc262f-d8af-9590-105b-1db0b16f2861@samsung.com>
In-Reply-To: <a1bc262f-d8af-9590-105b-1db0b16f2861@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 18 Feb 2020 20:20:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvCmwfA7tnyv05McZi+Gh=u8G9Kc2mb-VKbON9TPhKgQ@mail.gmail.com>
Message-ID: <CAL_JsqJvCmwfA7tnyv05McZi+Gh=u8G9Kc2mb-VKbON9TPhKgQ@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: extcon: usbc-cros-ec: convert
 extcon-usbc-cros-ec.txt to yaml format
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 4:30 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> On 2/13/20 9:39 PM, Dafna Hirschfeld wrote:
> > convert the binding file extcon-usbc-cros-ec.txt to
> > yaml format extcon-usbc-cros-ec.yaml
> >
> > This was tested and verified on ARM with:
> > make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> >
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Changes since v1:
> > 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> > 2 - changing the maintainers
> > 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
> >
> > Changes since v2:
> > 1 - Changing the patch subject to start with "dt-bindings: extcon: usbc-cros-ec:"
> > 2 - In the example, adding a parent isp node, a reg field to cros-ec@0
> > and adding nodes 'extcon0/1' instead of one node 'extcon'.
> >
> > Changes since v3:
> > in the example, changing the node isp1 to spi0
> >
> >  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 --------
> >  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 56 +++++++++++++++++++
> >  2 files changed, 56 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> >  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> > deleted file mode 100644
> > index 8e8625c00dfa..000000000000
> > --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -ChromeOS EC USB Type-C cable and accessories detection
> > -
> > -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> > -able to detect the state of external accessories such as display adapters
> > -or USB devices when said accessories are attached or detached.
> > -
> > -The node for this device must be under a cros-ec node like google,cros-ec-spi
> > -or google,cros-ec-i2c.
> > -
> > -Required properties:
> > -- compatible:                Should be "google,extcon-usbc-cros-ec".
> > -- google,usb-port-id:        Specifies the USB port ID to use.
> > -
> > -Example:
> > -     cros-ec@0 {
> > -             compatible = "google,cros-ec-i2c";
> > -
> > -             ...
> > -
> > -             extcon {
> > -                     compatible = "google,extcon-usbc-cros-ec";
> > -                     google,usb-port-id = <0>;
> > -             };
> > -     }
> > diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > new file mode 100644
> > index 000000000000..9c5849b341ea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: https://protect2.fireeye.com/url?k=d3c63a24-8e5dc647-d3c7b16b-0cc47a31cdbc-e8d8e2b7806aed8e&u=http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
> > +$schema: https://protect2.fireeye.com/url?k=04f78247-596c7e24-04f60908-0cc47a31cdbc-1b9a3937c161a4b6&u=http://devicetree.org/meta-schemas/core.yaml#

^^^

> > +
> > +title: ChromeOS EC USB Type-C cable and accessories detection
> > +
> > +maintainers:
> > +  - Benson Leung <bleung@chromium.org>
> > +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > +
> > +description: |
> > +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> > +  able to detect the state of external accessories such as display adapters
> > +  or USB devices when said accessories are attached or detached.
> > +  The node for this device must be under a cros-ec node like google,cros-ec-spi
> > +  or google,cros-ec-i2c.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,extcon-usbc-cros-ec
> > +
> > +  google,usb-port-id:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: the port id
> > +    minimum: 0
> > +    maximum: 255
> > +
> > +required:
> > +  - compatible
> > +  - google,usb-port-id
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        cros-ec@0 {
> > +            compatible = "google,cros-ec-spi";
> > +            reg = <0>;
> > +
> > +            usbc_extcon0: extcon0 {
> > +                compatible = "google,extcon-usbc-cros-ec";
> > +                google,usb-port-id = <0>;
> > +            };
> > +
> > +            usbc_extcon1: extcon1 {
> > +                compatible = "google,extcon-usbc-cros-ec";
> > +                google,usb-port-id = <1>;
> > +            };
> > +        };
> > +    };
> >
>
> Applied it. Thanks.

And once again corrupted it when applying it:

Documentation/devicetree/bindings/Makefile:12: recipe for target
'Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dts'
failed
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/validators.py",
line 774, in resolve_from_url
  document = self.store[url]
  File "/usr/local/lib/python3.6/dist-packages/jsonschema/_utils.py",
line 22, in __getitem__
  return self.store[self.normalize(uri)]
KeyError: 'https://protect2.fireeye.com/url?k=04f78247-596c7e24-04f60908-0cc47a31cdbc-1b9a3937c161a4b6&u=http://devicetree.org/meta-schemas/core.yaml'
