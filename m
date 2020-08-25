Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEAC20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598393360;
	bh=qqSPjqAn22g136ysY+v/6TnF8riitWpRVjKqhlooOEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lbInrhkn4Zb3TBGht/Vv469Fx6Lm1PLNcvuuy0Sj/gHmV8ILVtZnPwbws9teAHRbJ
	 5YAZJXKvWtglhedCO3HVdBq/0I3LM3DuozRtfFIdbOOx8zCgJMuNT/+R0AsjVjckek
	 UAIYgZx+JdYfKUzgVyiaJ6IMmCFsVSHEpLebAY5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHYWJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:09:18 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35620 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHYWJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:09:16 -0400
Received: by mail-il1-f194.google.com with SMTP id q14so122031ilm.2;
        Tue, 25 Aug 2020 15:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLKrtDPioAUBLdZ6oe5KeScwSDtIqCbNdo8WBPjs1eA=;
        b=ooQMt37K0HYFlofYfjX5p5HCY0cg5LMFZ5F+EdFcteWJ9KOOqKyvZRvsZV+uvu/SVx
         r3MD9Sa7uFzdp28dYCVuBGWRLIzxNpXccIXwgNULI9jPURQa/g+iaEbAqAPNE1oZeOcO
         fWn7hnibC9dSunoTX4CqPpXEeLUxOW7H9blFRS0oWZXAuNGI8HBmE1vp50MBrCmow0pT
         WjO/lBAZqNyXdyMkxOgD4ltxz5ReXy9qeYHVW3VhLlk5gDk7n2UND578Fp59w4ibMTsT
         kq6j9kvEH4WEJeiYOQqSNBboQgiDxpTCUGgKpoFtW2U9QAv809AFNV/+qDK4sCg3ISVJ
         nXKA==
X-Gm-Message-State: AOAM532UFwnrhkzcGPYvu9Fbfdo5Bd7FeUEd5ZLuhLNrnoq7gMGIJIkc
        OHewcjPkZ6i7qY0rbifCEQ==
X-Google-Smtp-Source: ABdhPJwfitAczHxFgEpj40L+UcJQ4elxja7tGAVv1BecnVUuns4Xh8xcC4bbofLEa/jynI/Aush6KQ==
X-Received: by 2002:a92:d646:: with SMTP id x6mr11132185ilp.237.1598393355818;
        Tue, 25 Aug 2020 15:09:15 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u89sm199111ili.87.2020.08.25.15.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:09:14 -0700 (PDT)
Received: (nullmailer pid 1429315 invoked by uid 1000);
        Tue, 25 Aug 2020 22:09:13 -0000
Date:   Tue, 25 Aug 2020 16:09:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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
Message-ID: <20200825220913.GA1423455@bogus>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
 <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd99d4a7e50904b57bb3ad050725fbb418874b7.1597852360.git.cristian.ciocaltea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:37:56PM +0300, Cristian Ciocaltea wrote:
> Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
> and S900 SoCs and provides support for handling up to 3 external
> interrupt lines.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v5:
>  - Updated controller description statements both in the commit message
>    and the binding doc
> 
>  .../actions,owl-sirq.yaml                     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> new file mode 100644
> index 000000000000..cf9b7a514e4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
> +  and S900) and provides support for handling up to 3 external interrupt lines.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - actions,s500-sirq
> +          - actions,s700-sirq
> +          - actions,s900-sirq
> +        - const: actions,owl-sirq
> +      - const: actions,owl-sirq

This should be dropped. You should always have the SoC specific 
compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description:
> +      The first cell is the input IRQ number, between 0 and 2, while the second
> +      cell is the trigger type as defined in interrupt.txt in this directory.
> +
> +  'actions,ext-interrupts':
> +    description: |
> +      Contains the GIC SPI IRQ numbers mapped to the external interrupt
> +      lines. They shall be specified sequentially from output 0 to 2.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    maxItems: 3

Can't you use 'interrupts' here?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - 'actions,ext-interrupts'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sirq: interrupt-controller@b01b0200 {
> +      compatible = "actions,s500-sirq", "actions,owl-sirq";
> +      reg = <0xb01b0200 0x4>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      actions,ext-interrupts = <13>, /* SIRQ0 */
> +                               <14>, /* SIRQ1 */
> +                               <15>; /* SIRQ2 */
> +    };
> +
> +...
> -- 
> 2.28.0
> 
