Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA6FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B32064A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy0aA5hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCIBdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:33:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35141 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCIBdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:33:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so9056268wro.2;
        Sun, 08 Mar 2020 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOLz31PfM94v71nBp9rIJn7CPiQJaqmEk0QWIWrZ18k=;
        b=uy0aA5hv89h7EzmyCXpXpFncO8YGNvoOxx3zxS2ocVl+qzviqLEy0tRQvKxHOMayPq
         HF3gyl0yRChm8q5vLcesLwyEvnlK6vFH4LK4gCn5xwPf+ZZTBSg3ch6QrmcwiGKkfyyH
         HbNZBsivQW5FridAhAugcMnUy4PnunzJpRGfu4dprWJd8TJHUxbC/wNXmTodrbtjKY4G
         JBDkFvRwUOzAT2CmeZMuUwDOPjkA2MPI3LrQQvMNdnJ0ETew8LeeJPW4+hymJOBbQR0Z
         GB6TmTBlE6kf9Nx3XiPToAKhFwl4nefCtt5BNmP2NTapTPexoECd1ZmKNWPWe6G+2Q5k
         ukSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOLz31PfM94v71nBp9rIJn7CPiQJaqmEk0QWIWrZ18k=;
        b=LiwCdwnQglXJCyuY+1Ic4jfJPDpHmiel/ZyXitRh9kq4w/vrIPGa0CqimRN31HqQLp
         PQaLvL0fDsuDv8QeVEcWx1cu31FJyJIQQSRgp/zWAGXRlZb/EJgvxQiqe+AeU82pkHI2
         RAc+IcMN3hPNYVAL8fpRPWncJ1DXOnfsXuZMAQr7jdy1k3fxX4KjEmKd4T71sLud0ycz
         D99UAJNlXmnFftHEgdIygQY+NCsGVfq9DlEMuOBIA/9gMthmr9XQyvIQNx6ZyHVLqPdy
         cg6Qe6QO7+uQKN0j+j1OaM27vdhNNpdH6vSBomAD2Gm39tXRUDTNf0eoYQlOu3W2HDFi
         wL6w==
X-Gm-Message-State: ANhLgQ0olTtkdRGg8YknVVTaL1qF4NnruDbl+AChpVjn+NMmCnotVit3
        TwzfOWdi3vtocu8yvGLXG9BkzLP7xm4aRfv/t4E=
X-Google-Smtp-Source: ADFU+vscvdqCsLNsZ/dm1KHbMRBDWbFtHrDeccAWQ9yH2mE3+K6oA3dm3JxkBPV9RAVpMjNHSx3qio3W59xJDMMLXF8=
X-Received: by 2002:adf:e408:: with SMTP id g8mr18539592wrm.198.1583717623496;
 Sun, 08 Mar 2020 18:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072730.9193-1-zhang.lyra@gmail.com> <20200304072730.9193-4-zhang.lyra@gmail.com>
In-Reply-To: <20200304072730.9193-4-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 9 Mar 2020 09:33:07 +0800
Message-ID: <CAAfSe-sJU77_aA5DXcM9D6dnjSgcy8V7zABunFbCSvL2k-RY8Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Can I have your acked-by on this patch now? Or do you have comments?

Thanks,
Chunyan


On Wed, 4 Mar 2020 at 15:28, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> add a new bindings to describe sc9863a clock compatible string.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> new file mode 100644
> index 000000000000..bb3a78d8105e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2019 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: SC9863A Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible :
> +    enum:
> +      - sprd,sc9863a-ap-clk
> +      - sprd,sc9863a-aon-clk
> +      - sprd,sc9863a-apahb-gate
> +      - sprd,sc9863a-pmu-gate
> +      - sprd,sc9863a-aonapb-gate
> +      - sprd,sc9863a-pll
> +      - sprd,sc9863a-mpll
> +      - sprd,sc9863a-rpll
> +      - sprd,sc9863a-dpll
> +      - sprd,sc9863a-mm-gate
> +      - sprd,sc9863a-apapb-gate
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are declared in devicetree.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - sprd,sc9863a-ap-clk
> +        - sprd,sc9863a-aon-clk
> +then:
> +  required:
> +    - reg
> +
> +else:
> +  description: |
> +    Other SC9863a clock nodes should be the child of a syscon node in
> +    which compatible string shoule be:
> +            "sprd,sc9863a-glbregs", "syscon", "simple-mfd"
> +
> +    The 'reg' property for the clock node is also required if there is a sub
> +    range of registers for the clocks.
> +
> +examples:
> +  - |
> +    ap_clk: clock-controller@21500000 {
> +      compatible = "sprd,sc9863a-ap-clk";
> +      reg = <0 0x21500000 0 0x1000>;
> +      clocks = <&ext_26m>, <&ext_32k>;
> +      clock-names = "ext-26m", "ext-32k";
> +      #clock-cells = <1>;
> +    };
> +
> +  - |
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      ap_ahb_regs: syscon@20e00000 {
> +        compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> +        reg = <0 0x20e00000 0 0x4000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0 0x20e00000 0x4000>;
> +
> +        apahb_gate: apahb-gate@0 {
> +          compatible = "sprd,sc9863a-apahb-gate";
> +          reg = <0x0 0x1020>;
> +          #clock-cells = <1>;
> +        };
> +      };
> +    };
> +
> +...
> --
> 2.20.1
>
