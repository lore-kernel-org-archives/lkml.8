Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E91020792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595524091;
	bh=wTz4dVcNYw2XYzUYPyT9glnJpQIVk+xl65k6EbvGgvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UkWLw0e3Lqi49sMD1YxaD1rU+FJ4tMJYsUV6AcHs3nkAKeBwn4ge/o3oXJ+W+Px5A
	 nS14cyf6ZQZhyr2wTS0r6r+2fwKfk0Qdk3k998S9EvjWv4NxQwxZtHUVTzh8C04rXu
	 4jiGeTcVRAPgu43sTuFBzNoVX5g1UZ5fE+FF2d9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWRIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:08:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43602 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:08:09 -0400
Received: by mail-io1-f66.google.com with SMTP id k23so6962190iom.10;
        Thu, 23 Jul 2020 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PWZkJpZ4ipb8P8p+Pg9LEmAeqADVPvG7RRrCZ//S+E=;
        b=qD0xTsqkPQUJrr/7dbMgo0CxBgTIw5RnBAT+Cox7K+bvWBN71BM4GlfWdngtsqGFSu
         BC/aE7iQyBNet0JTKLhQ4IF6Ffb2QimWaabuvklKo0aHelc/IHHYRxZR3sNx77+S88bl
         QB8hDoYXGnmtRJkjiiZ4RzVZa2/RL++xPV8MbCba72Lsy1gCnJx30dNZGRbwA0WxzfcO
         hLjEA7oKp5Wiae8YlLuNndNS0ZL/gh1AcvrNW2fLGOc1AUbwu6gDGDdMBMJK9BodxaBo
         b79qjeQ2KE3vAlBwnZTnWvH9oEjdiCRYI81z1/EsdR+Sw8NU7zgmwCxaOhfYU3rB2Anz
         9Nsg==
X-Gm-Message-State: AOAM530dq+k/dofK83dVs6ai5/RUQBmM3o2EPN+4LWml8mivsUlyjZK8
        e2ej7knRuEbj8BHXfabVyA==
X-Google-Smtp-Source: ABdhPJy+mKukhzCYRjhxLsHsBZnW1R9/7jgyhS48f5gwxsaDSYQ5vRd5zhVrQuLqdvM6icVj9WOxxA==
X-Received: by 2002:a6b:7c08:: with SMTP id m8mr2363635iok.200.1595524087764;
        Thu, 23 Jul 2020 10:08:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n15sm1524181ioc.15.2020.07.23.10.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:08:07 -0700 (PDT)
Received: (nullmailer pid 542912 invoked by uid 1000);
        Thu, 23 Jul 2020 17:08:06 -0000
Date:   Thu, 23 Jul 2020 11:08:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Emil Renner Berhing <kernel@esmil.dk>
Subject: Re: [PATCH v5 4/4] dt-bindings: timer: Add CLINT bindings
Message-ID: <20200723170806.GA535824@bogus>
References: <20200723142409.47057-1-anup.patel@wdc.com>
 <20200723142409.47057-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723142409.47057-5-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 07:54:09PM +0530, Anup Patel wrote:
> We add DT bindings documentation for CLINT device.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> new file mode 100644
> index 000000000000..8ad115611860
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Core Local Interruptor
> +
> +maintainers:
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  SiFive (and other RISC-V) SOCs include an implementation of the SiFive
> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> +  interrupts. It directly connects to the timer and inter-processor interrupt
> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> +  interrupt controller is the parent interrupt controller for CLINT device.
> +  The clock frequency of CLINT is specified via "timebase-frequency" DT
> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,clint0
> +      - const: sifive,fu540-c000-clint

Wrong order. Most specific goes first.

> +
> +    description:
> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiFive
> +      CLINT v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    clint@2000000 {

timer@...

> +      compatible = "sifive,clint0", "sifive,fu540-c000-clint";
> +      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> +                             &cpu2intc 3 &cpu2intc 7
> +                             &cpu3intc 3 &cpu3intc 7
> +                             &cpu4intc 3 &cpu4intc 7>;
> +       reg = <0x2000000 0x4000000>;

64MB of register space? Doesn't matter much for 64-bit, but would waste 
lots of virtual space (low mem) on 32-bit.

> +    };
> +...
> -- 
> 2.25.1
> 
