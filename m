Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A895C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53696206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586021354;
	bh=1YRY/BtoK+oCmfLxUgTel8s7rvGfSUbGrrzgKVih6nY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IydX0XGY/VTOcvOqgCJdgLIWz34MBI3Coj7796OyDPqypvN67g6LP0AjsQqQByWiA
	 ov4m8DA1xvO9CYGlLoiRMhcCFks0nc8v7Ldqbs1uAJYEKrzQX5Jh+wCcdF0NteOHOg
	 AwM98LHuSiw7r7fIvLmjE/8Mcqt8uDxcBZg3yHd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgDDR3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDR3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:29:12 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D7120738;
        Sat,  4 Apr 2020 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586021352;
        bh=1YRY/BtoK+oCmfLxUgTel8s7rvGfSUbGrrzgKVih6nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K7g6enz9N7SInnM1t57+GGbJ3tnE12kvNU9CHwPa5UmgCqMwiV4nmhOfME3a3gKEw
         JA01/sC0/EGndoehPB+s8TfHgJfyjAuh0KMVH/tO35gjji2rRkLGt8VTHXXGfqw32t
         oo2xJMdu/CFr66gZDnsYT04SqNSULnE0ZZu8V31o=
Received: by mail-qk1-f177.google.com with SMTP id b62so11667720qkf.6;
        Sat, 04 Apr 2020 10:29:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuYMxIL5KdGK32vBmYlVnq+miOnStuJdw7Cw1uM3IYbjh7Y4V5dR
        Q8AFgeprgMQa+MhN76/IXxjC4RlTlPyMts6TiQ==
X-Google-Smtp-Source: APiQypKltYkylVrSPKCUv+1vg9krREsG3icPca70j/C/uoyPDOcwI2wCbSRcNg5mnZ14H6Lfn8qOBnwKqoaC0DWfWAY=
X-Received: by 2002:a37:393:: with SMTP id 141mr14220851qkd.393.1586021350914;
 Sat, 04 Apr 2020 10:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200320094233.GA30959@localhost.localdomain>
In-Reply-To: <20200320094233.GA30959@localhost.localdomain>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 4 Apr 2020 11:28:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjLGz6LPQmTP5eJTdti38yQa86UWiwCTae81Fr7eMHtA@mail.gmail.com>
Message-ID: <CAL_JsqJjLGz6LPQmTP5eJTdti38yQa86UWiwCTae81Fr7eMHtA@mail.gmail.com>
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

On Fri, Mar 20, 2020 at 3:42 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own documents for BD71837
> and BD71847) as they have different amount of regulators. This way we can
> better enforce the node name check for regulators. ROHM is also providing
> BD71850 - which is almost identical to BD71847 - main difference is some
> initial regulator states. The BD71850 can be driven by same driver and it
> has same buck/LDO setup as BD71847 - add it to BD71847 binding document and
> introduce compatible for it.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I did, but there's some dtc warnings that need to be fixed:

Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:23.17-30:
Warning (reg_format): /example-0/i2c/pmic@4b:reg: property has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (pci_device_reg): Failed prerequisite 'reg_format'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (simple_bus_reg): Failed prerequisite 'reg_format'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:20.13-131.11:
Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-cells for
I2C bus
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:20.13-131.11:
Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells for
I2C bus
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:21.25-130.15:
Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
default #address-cells value
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dts:21.25-130.15:
Warning (avoid_default_addr_size): /example-0/i2c/pmic@4b: Relying on
default #size-cells value
 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.example.dt.yaml:
Warning (unique_unit_address): Failed prerequisite
'avoid_default_addr_size'

Rob
