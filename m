Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D31C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86E820738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyCFzgkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZVm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:42:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D80C061574;
        Wed, 26 Aug 2020 14:42:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d11so4824348ejt.13;
        Wed, 26 Aug 2020 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkQL+Dz21LFiMHXtvS7buva83SIiDacIGRIi5LVRWg8=;
        b=PyCFzgkN4OSai9YlhJND550USk3u7FaciC9YgUIZvY0Dh8d5TA0I24RDsNx6i7gQIt
         43S8wVNDsP9AW3izt9SO0uBb+igdIKuhEB9S9recizqdcc9vwij9FM3ShhZkWckO1N14
         SR+MdGCz0v1X9nSFShTSMQ3QQmsRDPyW5OiIze0AIfebwEKaTXtdGSftF99HKtHuv+Lm
         xnspvSP0TAOxJb57VIv4Z1fnzrve8CwGT/gdAxHVPtPo2dKgtPUHss9jeXI34ynG/B2Z
         5WVyjXhHSfTi6KpxG7FK4HNBW2et8UQeEkghOGdMDQbhZfvIgKymf42g1MrUo2IcMTXz
         m/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkQL+Dz21LFiMHXtvS7buva83SIiDacIGRIi5LVRWg8=;
        b=QcDaZSsBDpkvJiM0aDNctydEWXKpoF8AXMt2dt1GZhlcRUmofGQ/SZVcXgmXIhheyP
         4sKCF5Vc/yqewR/XkHr8/N/nyO73+c20RjntF3vxqs/NGhgPHvns9K0Gk4isbUpuX3Qd
         5689aFECNyF4pOeKTj1IKZGge/J2QRCymyDX/NCtxXRECYDPSYMh6/kk8rxpjYRw07wz
         ACd/saql6fA4yf2n9L69WXxnKN/UPuh68cae9NJiveb+7KXe2qQwZwMRhyZAZZTuPedk
         phL+UuHP7LCvB086BDWuXOdEynsBCzRzx7zQDIOTxNXOMUJwbQ/9YeoGrNX2RxdXglH6
         O0VQ==
X-Gm-Message-State: AOAM530AHDpFDK0EstjrkacQ6WmIFCC8Tz/YrUKYM0d4B3f87E0F1Dsx
        OuH1oqMPFeoh/cIiJ2X1Lpo=
X-Google-Smtp-Source: ABdhPJwDStQ0rjD3Lur2BK6467nAxbWULaSG6srrhmhkiq7NgIt/9VvkrfTyfXgZXbN5LfIVRGWiBA==
X-Received: by 2002:a17:906:2349:: with SMTP id m9mr17411173eja.425.1598478143345;
        Wed, 26 Aug 2020 14:42:23 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id ci27sm173363ejc.23.2020.08.26.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 14:42:22 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:42:20 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
Message-ID: <20200826214220.GA2444747@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825220913.GA1423455@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review!

On Tue, Aug 25, 2020 at 04:09:13PM -0600, Rob Herring wrote:
> On Wed, Aug 19, 2020 at 07:37:56PM +0300, Cristian Ciocaltea wrote:
> > Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> > and S900 SoCs and provides support for handling up to 3 external
> > interrupt lines.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v5:
> >  - Updated controller description statements both in the commit message
> >    and the binding doc
> > 
> >  .../actions,owl-sirq.yaml                     | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > new file mode 100644
> > index 000000000000..cf9b7a514e4e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Actions Semi Owl SoCs SIRQ interrupt controller
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > +
> > +description: |
> > +  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
> > +  and S900) and provides support for handling up to 3 external interrupt lines.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - actions,s500-sirq
> > +          - actions,s700-sirq
> > +          - actions,s900-sirq
> > +        - const: actions,owl-sirq
> > +      - const: actions,owl-sirq
> 
> This should be dropped. You should always have the SoC specific 
> compatible.

Sure, I will get rid of the 'owl-sirq' compatible.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +    description:
> > +      The first cell is the input IRQ number, between 0 and 2, while the second
> > +      cell is the trigger type as defined in interrupt.txt in this directory.
> > +
> > +  'actions,ext-interrupts':
> > +    description: |
> > +      Contains the GIC SPI IRQ numbers mapped to the external interrupt
> > +      lines. They shall be specified sequentially from output 0 to 2.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 3
> > +    maxItems: 3
> 
> Can't you use 'interrupts' here?

This was actually my initial idea, but it might confuse the users since
this is not following the parent controller IRQ specs, i.e. the trigger
type is set internally by the SIRQ driver, it's not taken from DT.

Please see the DTS sample bellow where both devices are on the same
level and have GIC as interrupt parent. The 'interrupts' property
in the sirq node looks incomplete now. That is why I decided to use
a custom name for it, although I'm not sure it's the most relevant one,
I am open to any other suggestion.

i2c0: i2c@b0170000 {
  [...]
  interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
  [...]
};

sirq: interrupt-controller@b01b0200 {
  [...]
  interrupt-controller;
  #interrupt-cells = <2>;
  interrupts = <13>, /* SIRQ0 */
               <14>, /* SIRQ1 */
               <15>; /* SIRQ2 */
};

Regards,
Cristi

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +  - 'actions,ext-interrupts'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    sirq: interrupt-controller@b01b0200 {
> > +      compatible = "actions,s500-sirq", "actions,owl-sirq";
> > +      reg = <0xb01b0200 0x4>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      actions,ext-interrupts = <13>, /* SIRQ0 */
> > +                               <14>, /* SIRQ1 */
> > +                               <15>; /* SIRQ2 */
> > +    };
> > +
> > +...
> > -- 
> > 2.28.0
> > 
