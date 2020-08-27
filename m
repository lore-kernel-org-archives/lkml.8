Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550F72075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwVP72Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgH0KGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0KGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:06:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675DC061264;
        Thu, 27 Aug 2020 03:06:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so6853158eje.7;
        Thu, 27 Aug 2020 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H5b7vH/Mm3tUXXI+YL/JUy2ooYJLh277NmvDbO34a90=;
        b=ZwVP72WyTO8UGptv0QVO5pjPiiQxg3QQS7Gv/qsfr7frOnlHhnafxMvJ8GUvauUwiy
         uLalmuljZwpayEuok0FSqKxa3vNn3g9hbEurMvRAEEt9YK4xMSqhF007MB8FOS8k+neX
         MrQNRIYxhZSENGn4U1CHf1keMtchPVHuE9FmnnSN5gu4LZs9Z/N8b9gtgsWQRoS7ItP4
         NVK7W2+VyAfHr0FKGGHjtf7WV+CPvJi/uK0F7APbInCebpnB0qY37oDwnt9xzrdLCpv6
         VWgOzd0sLDg0vqc/ojtdllNADxIgE2hEd7nV4JB1/1L9C6ZeZdOO5ZSztGXoo8XXV8eJ
         EqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5b7vH/Mm3tUXXI+YL/JUy2ooYJLh277NmvDbO34a90=;
        b=DlJrSr+dcRhebKPEmKJEkBOwd+JTKmG5TyX5NS6c+OIy4LGgVVRF3O79DnsxpiRDdx
         MWyyrFxjc/DFgY0/jnlJBeqvoHpVINTS/slzbSVLCONsiOh8cR7nYUe8mdLrn/K5BkBS
         jPzOz2fF+SIPGc2xXpQJERWAIda0xgwR3BVTYC1g6ZW2eskGhfkA0rH9SzarZ5gjyobD
         as/hhWcMrSTSumDIQdXOxtWfFQqmqoDdhT0QsYcQzLGMrNbMTB0JHlBKwm9/ChUVgJWb
         gt0/90DVZAJnyPrPKuGuMwNfHNZW+zSQFii9LVowIIjyeuDhDWxYMFioza8m6xqYlniM
         ASJw==
X-Gm-Message-State: AOAM532nQhCmumrIETveTWxLJoZ1FfbjBW3lQm8M6onvKvdCtNxXcoph
        T6dyE2JY8utOJtGwLjz9u5U=
X-Google-Smtp-Source: ABdhPJwYe3czk57emax7/H0cocpDsdNj6ermBTHkChVY5+jGk5Ax7YgihFrLjoGyeAX88M/oCzwkVg==
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr19513097ejb.418.1598522792401;
        Thu, 27 Aug 2020 03:06:32 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id cz21sm1191148edb.45.2020.08.27.03.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 03:06:31 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:06:29 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Actions
 SIRQ controller binding
Message-ID: <20200827100629.GA2451538@BV030612LT>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
 <20200825220913.GA1423455@bogus>
 <20200826214220.GA2444747@BV030612LT>
 <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLvXDFL6vFooPYLJ1QnZ7L756fNesXo-LW_scs9rV-zPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 04:48:38PM -0600, Rob Herring wrote:
> On Wed, Aug 26, 2020 at 3:42 PM Cristian Ciocaltea
> <cristian.ciocaltea@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > Thanks for the review!
> >
> > On Tue, Aug 25, 2020 at 04:09:13PM -0600, Rob Herring wrote:
> > > On Wed, Aug 19, 2020 at 07:37:56PM +0300, Cristian Ciocaltea wrote:
> > > > Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> > > > and S900 SoCs and provides support for handling up to 3 external
> > > > interrupt lines.
> > > >
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > ---
> > > > Changes in v5:
> > > >  - Updated controller description statements both in the commit message
> > > >    and the binding doc
> > > >
> > > >  .../actions,owl-sirq.yaml                     | 68 +++++++++++++++++++
> > > >  1 file changed, 68 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > > > new file mode 100644
> > > > index 000000000000..cf9b7a514e4e
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Actions Semi Owl SoCs SIRQ interrupt controller
> > > > +
> > > > +maintainers:
> > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > +
> > > > +description: |
> > > > +  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
> > > > +  and S900) and provides support for handling up to 3 external interrupt lines.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +        - enum:
> > > > +          - actions,s500-sirq
> > > > +          - actions,s700-sirq
> > > > +          - actions,s900-sirq
> > > > +        - const: actions,owl-sirq
> > > > +      - const: actions,owl-sirq
> > >
> > > This should be dropped. You should always have the SoC specific
> > > compatible.
> >
> > Sure, I will get rid of the 'owl-sirq' compatible.
> >
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-controller: true
> > > > +
> > > > +  '#interrupt-cells':
> > > > +    const: 2
> > > > +    description:
> > > > +      The first cell is the input IRQ number, between 0 and 2, while the second
> > > > +      cell is the trigger type as defined in interrupt.txt in this directory.
> > > > +
> > > > +  'actions,ext-interrupts':
> > > > +    description: |
> > > > +      Contains the GIC SPI IRQ numbers mapped to the external interrupt
> > > > +      lines. They shall be specified sequentially from output 0 to 2.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    minItems: 3
> > > > +    maxItems: 3
> > >
> > > Can't you use 'interrupts' here?
> >
> > This was actually my initial idea, but it might confuse the users since
> > this is not following the parent controller IRQ specs, i.e. the trigger
> > type is set internally by the SIRQ driver, it's not taken from DT.
> 
> Then what's the 2nd cell for?

I should have added also a child device sample to make it more clear
how this is supposed to work:

&i2c0 {
  atc260x: pmic@65 {
    [...]
	interrupt-parent = <&sirq>;
	interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
  };
};

The PMIC above uses the SIRQ2 pin of the SIRQ controller to trigger
interrupts, while the controller is responsible for proper translation
before sending to GIC, i.e. converting falling edge to rising edge signal
and active low to active high signal. 

> > Please see the DTS sample bellow where both devices are on the same
> > level and have GIC as interrupt parent. The 'interrupts' property
> > in the sirq node looks incomplete now. That is why I decided to use
> > a custom name for it, although I'm not sure it's the most relevant one,
> > I am open to any other suggestion.
> >
> > i2c0: i2c@b0170000 {
> >   [...]
> >   interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> >   [...]
> > };
> >
> > sirq: interrupt-controller@b01b0200 {
> >   [...]
> >   interrupt-controller;
> >   #interrupt-cells = <2>;
> >   interrupts = <13>, /* SIRQ0 */
> >                <14>, /* SIRQ1 */
> >                <15>; /* SIRQ2 */
> 
> This isn't valid if the GIC is the parent as you have to have 3 cells
> for each interrupt.

Right, that's the reason of replacing 'interrupts' with
'actions,ext-interrupts'.

> Ultimately the GIC trigger type has to be
> something. Is it fixed or passed thru? If the latter, just use 0
> (IRQ_TYPE_NONE) if the GIC trigger mode is not fixed. Having some sort
> of translation of the trigger is pretty common.

Yes, as explained above, the SIRQ controller performs indeed the
translation of the incoming signal. So if I understand correctly, your
suggestion would be to use the following inside the sirq node:

interrupts = <GIC_SPI 13 IRQ_TYPE_NONE>, /* SIRQ0 */
             [...]

> Rob

Thanks,
Cristi
