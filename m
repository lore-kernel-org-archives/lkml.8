Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A921C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95A206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598482135;
	bh=t9n5BChicvUvo0OvFPgATCF49zFJ4cpxQnjvAc2Mpx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B31BRmw/pg/BG7FvoSc2JecGIIWHPYJ0eBB0qnNyQS1NPOyjkeVLWSr9zNjJks/Fh
	 X27LQZ9BY5dBeR0InUdapgDEDxU/9HEdm0nbglrLAruntzcQCBxNEG9muG52qCrN6P
	 Iuojgyxfqd5yQk5Iee7pTjrKHNqmRsvR9fq6PxJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZWsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 18:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgHZWsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 18:48:52 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8824E207CD;
        Wed, 26 Aug 2020 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598482130;
        bh=t9n5BChicvUvo0OvFPgATCF49zFJ4cpxQnjvAc2Mpx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2arXLmwRzUtdI2UVgWMynafzCRBuzdYRglrl8HjeVBoJzhnPx7XW2YZrDyPUgvY4Q
         OVSJTbUqOhU4nGG0I14qbRO8QaMA0Q4oMckDcWsMoOLRryJm7mIsqMhJLHLsL+Cnq3
         IdyatNHAQDCKjN9Lwix0wudliX/fyiVuBaEloc5A=
Received: by mail-ot1-f42.google.com with SMTP id e23so2112235otk.7;
        Wed, 26 Aug 2020 15:48:50 -0700 (PDT)
X-Gm-Message-State: AOAM531U501c+XUvYN96XzuACn300yyU++KlrxPLzmFOHBgl1QwOqYv2
        DqZ3bapNwuC4coSQs6I/yXUoG0Dn74BM9kTQfQ==
X-Google-Smtp-Source: ABdhPJz2L4SyzzrCS8ZD9RhzJ8kl8SAnaCIKsJROwGDMSPCf3t8IEbBZGm5oT7vzry62JDR+B6RrikVTTc94njQ7giA=
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr4471094oti.129.1598482129883;
 Wed, 26 Aug 2020 15:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus> <20200826214220.GA2444747@BV030612LT>
In-Reply-To: <20200826214220.GA2444747@BV030612LT>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Aug 2020 16:48:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
Message-ID: <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 3:42 PM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for the review!
>
> On Tue, Aug 25, 2020 at 04:09:13PM -0600, Rob Herring wrote:
> > On Wed, Aug 19, 2020 at 07:37:56PM +0300, Cristian Ciocaltea wrote:
> > > Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> > > and S900 SoCs and provides support for handling up to 3 external
> > > interrupt lines.
> > >
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > > Changes in v5:
> > >  - Updated controller description statements both in the commit message
> > >    and the binding doc
> > >
> > >  .../actions,owl-sirq.yaml                     | 68 +++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > > new file mode 100644
> > > index 000000000000..cf9b7a514e4e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Actions Semi Owl SoCs SIRQ interrupt controller
> > > +
> > > +maintainers:
> > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > +
> > > +description: |
> > > +  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
> > > +  and S900) and provides support for handling up to 3 external interrupt lines.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +        - enum:
> > > +          - actions,s500-sirq
> > > +          - actions,s700-sirq
> > > +          - actions,s900-sirq
> > > +        - const: actions,owl-sirq
> > > +      - const: actions,owl-sirq
> >
> > This should be dropped. You should always have the SoC specific
> > compatible.
>
> Sure, I will get rid of the 'owl-sirq' compatible.
>
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupt-controller: true
> > > +
> > > +  '#interrupt-cells':
> > > +    const: 2
> > > +    description:
> > > +      The first cell is the input IRQ number, between 0 and 2, while the second
> > > +      cell is the trigger type as defined in interrupt.txt in this directory.
> > > +
> > > +  'actions,ext-interrupts':
> > > +    description: |
> > > +      Contains the GIC SPI IRQ numbers mapped to the external interrupt
> > > +      lines. They shall be specified sequentially from output 0 to 2.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    minItems: 3
> > > +    maxItems: 3
> >
> > Can't you use 'interrupts' here?
>
> This was actually my initial idea, but it might confuse the users since
> this is not following the parent controller IRQ specs, i.e. the trigger
> type is set internally by the SIRQ driver, it's not taken from DT.

Then what's the 2nd cell for?

> Please see the DTS sample bellow where both devices are on the same
> level and have GIC as interrupt parent. The 'interrupts' property
> in the sirq node looks incomplete now. That is why I decided to use
> a custom name for it, although I'm not sure it's the most relevant one,
> I am open to any other suggestion.
>
> i2c0: i2c@b0170000 {
>   [...]
>   interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>   [...]
> };
>
> sirq: interrupt-controller@b01b0200 {
>   [...]
>   interrupt-controller;
>   #interrupt-cells = <2>;
>   interrupts = <13>, /* SIRQ0 */
>                <14>, /* SIRQ1 */
>                <15>; /* SIRQ2 */

This isn't valid if the GIC is the parent as you have to have 3 cells
for each interrupt. Ultimately the GIC trigger type has to be
something. Is it fixed or passed thru? If the latter, just use 0
(IRQ_TYPE_NONE) if the GIC trigger mode is not fixed. Having some sort
of translation of the trigger is pretty common.

Rob
