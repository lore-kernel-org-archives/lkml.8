Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC5AC2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF54206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586021450;
	bh=iu5Wfddj0F+JxETYj4W/lxAjw7GfUHDBF0DQwuci5Yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dmwkqho2Klyr7AqfUL1oehkkoK61IMQNb7uO/pVtBmLci9FcNqmv3B217vbHYFTuU
	 EP1vOZT1vjfCOPrClPHlKXCOrKtPLniGQTYXGOEHLbW0DmczkDHgAces07dc9eYXPw
	 WpwXptWQijf1E6PhfU9c5nkKHaZIOkI+1o8mO4KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDDRat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDRas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:30:48 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785F620719;
        Sat,  4 Apr 2020 17:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586021447;
        bh=iu5Wfddj0F+JxETYj4W/lxAjw7GfUHDBF0DQwuci5Yo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPo5eFMaHNxEKpZQbLkAjpAzQ2isaBQaINszUVFcZZfcDc2N4uGFfnTH5JJ1BxwLB
         qwlWVorYpUEluyb+KP4wWVNmQ1g1uUUGJ4MF3z9pQhxH2ZitJUHdKmOlQoRMH3xxw6
         yXIKvwrUPLJDCBI13siwwTz2SGnLfTt9XOvqKLGQ=
Received: by mail-qt1-f177.google.com with SMTP id m33so9329137qtb.3;
        Sat, 04 Apr 2020 10:30:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuYc4daP1XcmYUmY8ueqAuUve+sj/YMWgbEtILiGS6X44Os7zLE5
        YJeGTXfQz9ZEgPBv7KFuxS1lQ82Yd6EokMOHkg==
X-Google-Smtp-Source: APiQypIID7IpWNF4KnAIw9M0luBvXme6yb+vzm0vk0OBcNAs1gRtQr/B3GPssKZMhZttLpjUOmhCNJ8wuVJ/4X3ktN0=
X-Received: by 2002:ac8:6649:: with SMTP id j9mr13801811qtp.110.1586021446598;
 Sat, 04 Apr 2020 10:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200320094233.GA30959@localhost.localdomain> <CAL_JsqJjLGz6LPQmTP5eJTdti38yQa86UWiwCTae81Fr7eMHtA@mail.gmail.com>
In-Reply-To: <CAL_JsqJjLGz6LPQmTP5eJTdti38yQa86UWiwCTae81Fr7eMHtA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 4 Apr 2020 11:30:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2VBDHSWViyvjEBckOqsMQVUdOGjABH0AT6LiaMnJx1Q@mail.gmail.com>
Message-ID: <CAL_JsqJ2VBDHSWViyvjEBckOqsMQVUdOGjABH0AT6LiaMnJx1Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 11:28 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Mar 20, 2020 at 3:42 AM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> > the binding document to two separate documents (own documents for BD71837
> > and BD71847) as they have different amount of regulators. This way we can
> > better enforce the node name check for regulators. ROHM is also providing
> > BD71850 - which is almost identical to BD71847 - main difference is some
> > initial regulator states. The BD71850 can be driven by same driver and it
> > has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> > introduce compatible for it.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> I did, but there's some dtc warnings that need to be fixed:
>
> Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:23.17-30:
> Warning (reg_format): /example-0/i2c/pmic@4b:reg: property has invalid
> length (4 bytes) (#address-cells == 2, #size-cells == 1)
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (pci_device_reg): Failed prerequisite 'reg_format'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:20.13-131.11:
> Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for
> I2C bus
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:20.13-131.11:
> Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for
> I2C bus
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:21.25-130.15:
> Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
> default #address-cells value
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:21.25-130.15:
> Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
> default #size-cells value
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
> Warning (unique_unit_address): Failed prerequisite
> 'avoid_default_addr_size'

And also:

Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dts:23.17-30:
Warning (reg_format): /example-0/i2c/pmic@4b:reg: property has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dts:20.13-112.11:
Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for
I2C bus
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dts:20.13-112.11:
Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for
I2C bus
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dts:21.25-111.15:
Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
default #address-cells value
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dts:21.25-111.15:
Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
default #size-cells value
Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.example.dt.yaml:
Warning (unique_unit_address): Failed prerequisite
'avoid_default_addr_size'
