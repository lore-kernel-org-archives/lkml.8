Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F308C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E82120791
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594694273;
	bh=K8jI6zknpMC31Ic2WpkzSCBbDaa/02sIBIrlsPfMJN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uqzlxunt/P9jhWYHrMjDQClGv6McnDJWYeyzWoof7QXRHnCBUWYs+fIz2sjVD+TwR
	 t8myhbJc5CQiEin0/mF/Wt/r3iYBCzYrHRvcLq2OlXPYlORlZ1x+5bL//P0ZT+aJC1
	 6+ovC4tOCqkpgjxDAUoD7cRmXjA5lrEnZw3JOKwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGNChw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:37:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35840 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNChv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:37:51 -0400
Received: by mail-io1-f65.google.com with SMTP id y2so15756358ioy.3;
        Mon, 13 Jul 2020 19:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9yRXPbAuKbatZZtOZ8lv0tgEHkyKNFIEmB9CuDKx1I=;
        b=ppPi6zGuZcktUVBS3VkRxcwiRltB9NMrwCVkVcUbaFsydlYiuvrg5piMPVNhXlfFQi
         g5Bx3csedIUexIls+qAqI3KaNoh259DwDD2G4ZisWUUrapUYE0UufBnFTs2j9zwbxTTH
         wij9LZKu7vt7YrB4w8lfItF+XTq7Apq6zOW4fu2A5hUZK166QrIabkk2XVRFjf5lWE2T
         GTsjhUac4BuHi693o0nOrWdZWiLWxTHJ/jbUQsxCZiRweOpeV+fCiMcF5UuyZ8QStUUh
         z2zmgvwK3mCTgVD/s0odNtjg0J6gFF73llcHZT1FdO1yPImyvIXdBCZRiJdfWFBj1+yb
         nFRA==
X-Gm-Message-State: AOAM5304dwXwxpW9/YTMcR0hQ2Tf9RSkKbBVRD+JQJLh6xE4WdWcsviX
        LkodEy35t0DL6V8bXNp6v+BaxCQROUbO
X-Google-Smtp-Source: ABdhPJwB0uH4+dXlUcswfGdYzX5Q71gv/PavH+vKBm/oYyn40EnjX/9utyBqyLLVsYAIO9o14kvV5A==
X-Received: by 2002:a02:9182:: with SMTP id p2mr3548431jag.69.1594694270483;
        Mon, 13 Jul 2020 19:37:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h5sm8923943ilq.22.2020.07.13.19.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:37:49 -0700 (PDT)
Received: (nullmailer pid 1171324 invoked by uid 1000);
        Tue, 14 Jul 2020 02:37:48 -0000
Date:   Mon, 13 Jul 2020 20:37:48 -0600
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
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: timer: Add CLINT bindings
Message-ID: <20200714023748.GA1164267@bogus>
References: <20200627161957.134376-1-anup.patel@wdc.com>
 <20200627161957.134376-6-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627161957.134376-6-anup.patel@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:49:57PM +0530, Anup Patel wrote:
> We add DT bindings documentation for CLINT device.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  .../bindings/timer/sifive,clint.txt           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt

Bindings should be in DT schema format now.

> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.txt b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> new file mode 100644
> index 000000000000..45b75347a7d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.txt
> @@ -0,0 +1,34 @@
> +SiFive Core Local Interruptor (CLINT)
> +-------------------------------------
> +
> +SiFive (and other RISC-V) SOCs include an implementation of the SiFive Core
> +Local Interruptor (CLINT) for M-mode timer and inter-processor interrupts.
> +
> +It directly connects to the timer and inter-processor interrupt lines of
> +various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local interrupt
> +controller is the parent interrupt controller for CLINT device.
> +
> +The clock frequency of CLINT is specified via "timebase-frequency" DT
> +property of "/cpus" DT node. The "timebase-frequency" DT property is
> +described in: Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +Required properties:
> +- compatible : should be "riscv,clint0" or "sifive,clint-1.0.0". A specific

A new versioning scheme from SiFive? To review, we don't do version 
numbers unless there's a well defined and documented scheme. IOW, one 
that's not s/w folks just making up v1, v2, v3, etc.

> +  string identifying the actual implementation can be added if implementation
> +  specific worked arounds are needed.
> +- reg : Should contain 1 register range (address and length).
> +- interrupts-extended : Specifies which HARTs (or CPUs) are connected to
> +  the CLINT.  Each node pointed to should be a riscv,cpu-intc node, which
> +  has a riscv node as parent.
> +
> +Example:
> +
> +	clint@2000000 {
> +		compatible = "sifive,clint-1.0.0", "sifive,fu540-c000-clint";

Doesn't match the binding.

> +		interrupts-extended = <
> +			&cpu1-intc 3 &cpu1-intc 7
> +			&cpu2-intc 3 &cpu2-intc 7
> +			&cpu3-intc 3 &cpu3-intc 7
> +			&cpu4-intc 3 &cpu4-intc 7>;
> +		reg = <0x2000000 0x4000000>;
> +	};
> -- 
> 2.25.1
> 
