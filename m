Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2868C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAA32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589843651;
	bh=GXR83qtwdDbrZxkBXEKAXiWeE1p5THJydmS7rxH2rjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c8gA7a7D+6Nbs4spw/D0wENk1IKWoMLTVw0LhsWBK1lO4o2JQw8P/iVa0wkZifeIz
	 A6vxMStG3Nvac3SPtroixCfkuHBQs4YlAZUWuaOoGXvrCZz1Due89KOJUD73IOroVk
	 dxAzsWt4w1ZS1WMgfxkjBqVORFrL1B4KSXjsW7h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgERXOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:14:10 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E512067D;
        Mon, 18 May 2020 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843650;
        bh=GXR83qtwdDbrZxkBXEKAXiWeE1p5THJydmS7rxH2rjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c+hwd3Kf46sVo9AuXOkdmcRICchoBV/6eyN4ZrdRt1rfzxUW8MY6zk95oWIn7EYsk
         A86goNl25PWc20yYMHqP7QaHWfwIq4SLG1rhDKM4U1aN9FTtMMc4IVym5cT2wdqzDX
         a6wuR7Sa828uQQaPe7FDO7RD42Mh3sFXnPA09FSA=
Received: by mail-ot1-f54.google.com with SMTP id d26so9659075otc.7;
        Mon, 18 May 2020 16:14:09 -0700 (PDT)
X-Gm-Message-State: AOAM531/fir5yj0NYQd0kwZc+6DsIzx7kG5YwHRxtQwA/WJOiHh30kaM
        g8s8mVsUquuxS6h5p9P8depMy/ltxgdr22E7AQ==
X-Google-Smtp-Source: ABdhPJz4O9rEWx8T9VergSeE5BZRA92UaUypy77OD9VVs0mDqqxpXBq4sUFpllqi+T5YTfqCIKtUAde6em694OTW+LQ=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr14200957oth.192.1589843649219;
 Mon, 18 May 2020 16:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200508082937.14171-1-rogerq@ti.com> <20200508082937.14171-3-rogerq@ti.com>
 <20200518145133.GA2280@bogus>
In-Reply-To: <20200518145133.GA2280@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 18 May 2020 17:13:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8TTq_bpGvhUSQ92n84rrBrHFt75U2PDKRFjzK5VLAAg@mail.gmail.com>
Message-ID: <CAL_JsqL8TTq_bpGvhUSQ92n84rrBrHFt75U2PDKRFjzK5VLAAg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: mdf: ti,j721e-syscon.yaml: Add J721e
 system controller
To:     Roger Quadros <rogerq@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 8:51 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, May 08, 2020 at 11:29:32AM +0300, Roger Quadros wrote:
> > Add DT binding schema for J721e system controller.
> >
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  .../bindings/mfd/ti,j721e-syscon.yaml         | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
>
> Use the compatible string for filename.
>
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
> > new file mode 100644
> > index 000000000000..e832fb43f884
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,j721e-syscon.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI J721e System Controller Registers R/W Device Tree Bindings
> > +
> > +description: |
> > +  This represents the Control Module registers (CTRL_MMR0) on the SoC.
> > +  System controller node represents a register region containing a set
> > +  of miscellaneous registers. The registers are not cohesive enough to
> > +  represent as any specific type of device. The typical use-case is
> > +  for some other node's driver, or platform-specific code, to acquire
> > +  a reference to the syscon node (e.g. by phandle, node path, or
> > +  search using a specific compatible value), interrogate the node (or
> > +  associated OS driver) to determine the location of the registers,
> > +  and access the registers directly.
> > +
> > +maintainers:
> > +  - Kishon Vijay Abraham I <kishon@ti.com>
> > +  - Roger Quadros <rogerq@ti.com
> > +
> > +allOf:
> > +  - $ref: "syscon.yaml#"
>
> Drop this as it is not needed.
>
> > +
> > +properties:
> > +  compatible:
> > +    anyOf:
> > +      - items:
> > +        - enum:
> > +          - ti,j721e-system-controller
> > +
> > +        - const: syscon
>
> What about simple-mfd?
>
> > +
> > +      - contains:
> > +          const: syscon
> > +        additionalItems: true
>
> Should be dropped.
>
> You are going to need a 'select' entry or this will match on any syscon
> or simple-mfd node:
>
> select:
>   properties:
>     compatible:
>       contains:
>         const: ti,j721e-system-controller
>   required:
>     - compatible

Sorry, forget the 'select' part (still should drop the 2nd clause).
I'd found a bug in what handles this automatically, but it's only when
you have 'simple-mfd' and not 'syscon'.

Rob
