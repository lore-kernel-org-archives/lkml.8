Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CDAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD54206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="P+epqYZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgF2VFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730964AbgF2TMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA116C08C5E0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:09:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so15067864wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqfpvi3iYp3AoWQd6MSO7doKcVpn2TJcLUHhv2lCYnI=;
        b=P+epqYZloSbYG+AbCi/vnUslABKw6dTGUxMtmqk70qo8e+GHDnz6Dbj5BXuIthZXlr
         0CUpkny20y3Yi7lcLdxO2389kQqc1CTuKFzUqM8HFZl6leu+QHNMNupx6coQ9Xamlt8J
         UrVTd09fowebynpt5CnTRX6sTrUk3AEUOWSufL5JBNhUQc3w+a8ju9ea9wskW6zcwJIV
         Nk9jFaS8B2u61i4nClqxT+s5PbGTbUnE59r5ZZC+wzzFr3EQ1+J4+KrFqIXMj1UJ8dko
         PHGqVkikH/7/UHJnsmnU0RCBkuyeJOQlXlvXwZG8auj4EAlsUCItoyML8iPmiC3N6of5
         oQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqfpvi3iYp3AoWQd6MSO7doKcVpn2TJcLUHhv2lCYnI=;
        b=juKw5KT5U3FgKGuix7FmYB/VbmAMYzUW6YttjE5ZHA9q9Bo0qMVKLY9VNShciq1iN7
         wcq2YcCrjMvfA79uxcXBJtGZYFO7dcCbiWF5B4zUwpVLB8g4Hvm9ncku1FHCx1/5fpxR
         SIF9/kmkK1PUA0D7XGcojUC7zkHtMmpire0Bi6ZmRKTnIBRM0hbUCo+vuN7mvNsocs7e
         nZwUq/cNVJxXJkW+bby1Yo7yeSX4H1LQ25rxh7gP1MD6EL4f3xkyrBkXlV8KxxjuCjJB
         RK3J9sVkWpxntDKiEnyEPZF7TyhRE1TriDTOaTV34saiQOLwSARlCNfQ/6Qi1MPGFJ+v
         GGkw==
X-Gm-Message-State: AOAM5312paaV0/wKEU+M3QnAfUaLHnCeFsVZvNhorVVsn27TNM5xWZQk
        6bTK+jREf3MnzHgQecGjh8mQWfxjcwjJlqQtooVOVxI2
X-Google-Smtp-Source: ABdhPJwx1knjHefqrB+oeWQ3YcqzAY6RsgARQklwQOrsgV4BeAw50AB+MKIpRinxVhKDLYaH38jdH075e1ij93+pORY=
X-Received: by 2002:adf:ff87:: with SMTP id j7mr9282883wrr.128.1593403776321;
 Sun, 28 Jun 2020 21:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
In-Reply-To: <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 09:39:24 +0530
Message-ID: <CAAhSdy3VBUTMg_b2tO12cTYuvHYtH=4dj9-qT-at35Whf3w_7w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] dt-bindings: riscv: Add YAML documentation for PMU
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
>
> Add device tree bindings for performance monitor unit. And it passes the
> dt_binding_check verification.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml
>
> diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
> new file mode 100644
> index 000000000000..f55ccbc6c685
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Performance Monitor Units
> +
> +maintainers:
> +  - Zong Li <zong.li@sifive.com>
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: riscv,pmu
> +
> +  riscv,width-base-cntr:
> +    description: The width of cycle and instret CSRs.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  riscv,width-event-cntr:
> +    description: The width of hpmcounter CSRs.
> +    $ref: /schemas/types.yaml#/definitions/uint32

The terms "base" and "event" is confusing because
we only have counters with no interrupt associated with it.

The RISC-V spec defines 3 counters and rest are all
implementation specific counters.

I suggest using the terms "spec counters" and "impl counters"
instead of "base counters" and "event counters".

Further, "riscv,width" properties are redundant because
RISC-V spec clearly tells that counters are 64bit for both
RV32 and RV64.

> +
> +  riscv,n-event-cntr:
> +    description: The number of hpmcounter CSRs.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  riscv,hw-event-map:
> +    description: The mapping of generic hardware events. Default is no mapping.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  riscv,hw-cache-event-map:
> +    description: The mapping of generic hardware cache events.
> +      Default is no mapping.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +required:
> +  - compatible
> +  - riscv,width-base-cntr
> +  - riscv,width-event-cntr
> +  - riscv,n-event-cntr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmu {
> +      compatible = "riscv,pmu";
> +      riscv,width-base-cntr = <64>;
> +      riscv,width-event-cntr = <40>;
> +      riscv,n-event-cntr = <2>;
> +      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
> +      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
> +    };
> +
> +...
> --
> 2.27.0
>

Regards,
Anup
