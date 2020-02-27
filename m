Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F76C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ZotFPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgB0C21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:28:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgB0C21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:28:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so1393257wrj.7;
        Wed, 26 Feb 2020 18:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8Lr83wNxTFREKN1d8E1dyvqjENy/kw2pJKojCtakbE=;
        b=i9ZotFPxkm7GQc49OJKH81Y7IDYieuPltjdBMQ8RtayWDXsEW2l5Vse9B0juD/Zf6R
         n5wiYTkrGB4LyCfiL5an9ze9p88cATCobO06hR38mDhDj0rap5m8HBJDTG8J2T/r7yPH
         kCeUR5kiQ9igj++voYjo28hkQs5lsxJ1GIS9ubGA598q0rlwc0Yz0ZCMr8Wlltn5eoQ1
         q6VoyaPqLpe9l31CaT2lvxG97NOilDCYaKSuHGAsHYBH9VEXf05+thAC/Ss7ov28edUQ
         2i5KiF03aEMRn5ccvmAefJzaih16Ai8u4Y9Ree90YFn9SLQK/V6ABMJgx3mj6kzUb6Vt
         zpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8Lr83wNxTFREKN1d8E1dyvqjENy/kw2pJKojCtakbE=;
        b=NhU9AKWOKE9G9jkyjbzsTsOPNiYQacgYBb3PJb3ku7F/8vjC5FvtPJwkIWas4evZyN
         waKaRESUOcmer0pPY+x6SXkL6q4VNwjmdFkYvuG1SMVyLg/JC58jp5i9Et3Tro4A5kD7
         4LjLYZVskVx6oaiSs46R00yRw0MS0FY68w2KOx4JAeO7QG1jxrWgqLQaz4gYmeNnuNmj
         gOYRRGT0SXDYmE4wYoHbkb8sI67hsIlomzUlXMeF3ucQ7DFCU8iaz8iYglVGzCxDeFWg
         5hc4VUedHozXGS3nREHx7mXAMm3PxeMdYO34GfOv4V6Gd377DgA4IGkYc/g19Otd857T
         3xsQ==
X-Gm-Message-State: APjAAAVtr3iLgYd1gKNfxC23PONDn4EG3D30gk+IWviaZExXcS6MtoAh
        K20R46GT5VbWg1EwvDcV0NuyKtEDiBLt5mvetEnWQQ==
X-Google-Smtp-Source: APXvYqwXT16KLR5zlU/wMXoQvOaWaYIAoekY3yfqDvvkwzJK4fsraLbt2QibNRgH7xwfukOMyqXlt6f5XmWqgMLMgFU=
X-Received: by 2002:adf:f648:: with SMTP id x8mr1950156wrp.198.1582770504539;
 Wed, 26 Feb 2020 18:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20200219040915.2153-1-zhang.lyra@gmail.com> <20200219040915.2153-4-zhang.lyra@gmail.com>
 <20200226152642.GA26474@bogus>
In-Reply-To: <20200226152642.GA26474@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 27 Feb 2020 10:27:47 +0800
Message-ID: <CAAfSe-tNmQTzMSC5hZwTjC+MFOwV-UeJ7ZhK8+m3vD5RfmthoQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 at 23:26, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 19, 2020 at 12:09:11PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > add a new bindings to describe sc9863a clock compatible string.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/clock/sprd,sc9863a-clk.yaml      | 110 ++++++++++++++++++
> >  1 file changed, 110 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > new file mode 100644
> > index 000000000000..b31569b524e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2019 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: SC9863A Clock Control Unit Device Tree Bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  compatible :
> > +    enum:
> > +      - sprd,sc9863a-ap-clk
> > +      - sprd,sc9863a-aon-clk
> > +      - sprd,sc9863a-apahb-gate
> > +      - sprd,sc9863a-pmu-gate
> > +      - sprd,sc9863a-aonapb-gate
> > +      - sprd,sc9863a-pll
> > +      - sprd,sc9863a-mpll
> > +      - sprd,sc9863a-rpll
> > +      - sprd,sc9863a-dpll
> > +      - sprd,sc9863a-mm-gate
> > +      - sprd,sc9863a-apapb-gate
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
> > +    description: |
> > +      The input parent clock(s) phandle for this clock, only list fixed
> > +      clocks which are declared in devicetree.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +    description: |
> > +      Clock name strings used for driver to reference.
>
> Drop this. That's all 'clock-names'.

Ok.

>
> > +    items:
> > +      - const: ext-26m
> > +      - const: ext-32k
> > +      - const: ext-4m
> > +      - const: rco-100m
> > +
> > +  reg:
> > +    description: |
> > +      Contain the registers base address and length.
>
> Drop this. You need to define how many entries (maxItems: 1).

Ok.

>
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      enum:
> > +        - sprd,sc9863a-ap-clk
> > +        - sprd,sc9863a-aon-clk
> > +then:
> > +  required:
> > +    - reg
> > +
> > +else:
> > +  description: |
> > +    Other SC9863a clock nodes should be the child of a syscon node with
> > +    the required property:
> > +
> > +    - compatible: Should be the following:
> > +                  "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
> > +
> > +    The 'reg' property is also required if there is a sub range of
> > +    registers for the clocks that are contiguous.
>
> Which ones are these? You should be able to define that exactly starting
> with the example below.

This is for the second example below, which clocks are under syscon node.

>
> > +
> > +examples:
> > +  - |
> > +    ap_clk: clock-controller@21500000 {
> > +      compatible = "sprd,sc9863a-ap-clk";
> > +      reg = <0 0x21500000 0 0x1000>;
> > +      clocks = <&ext_26m>, <&ext_32k>;
> > +      clock-names = "ext-26m", "ext-32k";
> > +      #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      ap_ahb_regs: syscon@20e00000 {
> > +        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> > +        reg = <0 0x20e00000 0 0x4000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges = <0 0 0x20e00000 0x4000>;
> > +
> > +        apahb_gate: apahb-gate@0 {
> > +          compatible = "sprd,sc9863a-apahb-gate";
> > +          reg = <0x0 0x1020>;
> > +          #clock-cells = <1>;
>
> Doesn't this block have input clocks?

Since it switched to the new way of referencing parent, some clocks
whose parents are all in the same driver don't need to get their
parent from DT.

Thanks,
Chunyan
