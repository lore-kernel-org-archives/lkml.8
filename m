Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01845C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C292076E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8aJtIxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYF2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:28:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46588 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYF2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:28:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id k191so589100pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8N0rPXEMEpOTwvRNXAealaZxrwhS+QzBPcYcoPv+yBg=;
        b=T8aJtIxmEO+mOV+J0Sb3wWW1rbnh+Wg//lVYq3y4ob0x9ANYMpYraYN8TgLitLrHf+
         /4H7rReEVf2Sk0SqmpIM/phgSnP2G9/EJBmgIqkZcv81dAm8hKrs8zMjOiLoH20NnuLZ
         csJIdOsayKFCsWugB/DiU5+QFHKut4B9cB2ilqYJgnRUEfVXMef+1uJXFtXHG9PBQ1FX
         sU3KHKKfJM4ljfD0AqQ32IDyyXdhXuXCOrBTfy8lyQlqIpCgxkHfdXkvnLn7yTEWThvn
         2BvZrJabF1pS9SGVfHhMBELiMfjQ8qZJXeQrH2ukOvLlV9dPA67vZQS3/Hvl+U+ViL9k
         kHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8N0rPXEMEpOTwvRNXAealaZxrwhS+QzBPcYcoPv+yBg=;
        b=RI8ktuSHi4TSFiCh/5XYcpVkJlTpRhkKK8ryIz+kCj1SaY6e+Z0aLPwX+5aice0vKk
         rQ9Rn3WmZB5zhqdlXCYci+FiK/V5mfczPIUXiCn1OsHqfNQiUrZXqMTTNO6XPzrTOSaF
         BLRP9etpXmfXjFJvR7s1jHbS/12Dr3U9o60PZHGaz4EBHY/qMDgmh3lZtTplGhLB5e0c
         6uZJTA0f6ffU9OrRB9cD57i07x/gGjkRrq8l9T5QYKnUkCpJUyCHiOxtXCowrnc0oqVT
         oqaDFw2kBzaISOws3rpLuV0x9w18ZArhnBRe8qry0EZv1qJaOqB7JE2HSrOZbX1seWVi
         czCQ==
X-Gm-Message-State: ANhLgQ2oCV+Fqng6GpIAwvvGMBQLpfrpXQdCzeVwsZmTXe2CJqdqArjB
        +kGRZZhzLVKZFDIJhCkydnYzbg==
X-Google-Smtp-Source: ADFU+vtzd5lWm2EtFMQU9+05SsDLK/lqKBsIUsSc6FmuLkPh3nI/qbzHhJZkKpje0KHcAgvsfq8jyw==
X-Received: by 2002:a63:56:: with SMTP id 83mr1378001pga.249.1585114083903;
        Tue, 24 Mar 2020 22:28:03 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j17sm17543192pfd.175.2020.03.24.22.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:28:03 -0700 (PDT)
Date:   Tue, 24 Mar 2020 22:28:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 2/2] dt-bindings: remoteproc: Add documentation for
 SPSS remoteproc
Message-ID: <20200325052800.GH522435@yoga>
References: <1584754330-445-1-git-send-email-rishabhb@codeaurora.org>
 <1584754330-445-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584754330-445-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 18:32 PDT 2020, Rishabh Bhatnagar wrote:

> Add devicetree binding for Secure Subsystem remote processor
> support in remoteproc framework. This describes all the resources
> needed by SPSS to boot and handle crash and shutdown scenarios.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,spss.yaml  | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
> new file mode 100644
> index 0000000..9ca7947a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,spss.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/qcom,spss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPSS Peripheral Image Loader
> +
> +maintainers:
> +  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
> +description: |
> +  This document defines the binding for a component that loads and boots firmware
> +  on the Qualcomm Secure Peripheral Processor. This processor is booted in the
> +  bootloader stage and it attaches itself to linux later on in the boot process.
> +
> +properties:
> +  compatible:
> +    enum:
> +      "qcom,sm8250-spss-pas"
> +
> +  reg:
> +    items:
> +      - description: IRQ status register
> +      - description: IRQ clear register
> +      - description: IRQ mask register
> +      - description: Error register
> +      - description: Error spare register
> +
> +  reg-names:
> +    items:
> +      - const: sp2soc_irq_status
> +      - const: sp2soc_irq_clr
> +      - const: sp2soc_irq_mask
> +      - const: rmb_err
> +      - const: rmb_err_spare2
> +
> +  interrupts:
> +    maxitems: 1
> +    items:
> +      - description: rx interrupt
> +
> +  clocks:
> +    items:
> +      - description:
> +                    reference to the xo clock to be held on behalf
> +                    of the booting Hexagon core
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  cx-supply: true
> +
> +  px-supply: true
> +
> +  memory-region: true
> +    items:
> +      - description: reference to the reserved-memory for the SPSS
> +
> +  qcom,spss-scsr-bits:
> +    - description: Bits that are set by remote processor in the irq status
> +                   register region to represent different states during
> +                   boot process
> +
> +  child-node:
> +    description: Subnode named either "smd-edge" or "glink-edge" that
> +                 describes the communication edge, channels and devices
> +                 related to the SPSS.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - cx-supply
> +  - px-supply
> +  - memory-region
> +  - qcom,spss-scsr-bits
> +
> +
> +examples:
> +  - |
> +    spss {

remoteproc@188101c but probably rather remoteproc@1880000



> +        compatible = "qcom,sm8250-spss-pil";

s/pil/pas/

> +        reg = <0x188101c 0x4>,
> +                <0x1881024 0x4>,
> +                <0x1881028 0x4>,
> +                <0x188103c 0x4>,
> +                <0x1882014 0x4>;

As noted in the driver review, these are all from the same block, map it
once.

> +        reg-names = "sp2soc_irq_status", "sp2soc_irq_clr",
> +                    "sp2soc_irq_mask", "rmb_err", "rmb_err_spare2";
> +        interrupts = <0 352 1>;

interrupts = <GIC_SPI 352 IRQ_TYPE_EDGE_RISING>;

> +
> +        cx-supply = <&VDD_CX_LEVEL>;

These are power domains.

> +        cx-uV-uA = <RPMH_REGULATOR_LEVEL_TURBO 100000>;

And we'll just vote for max.

> +        px-supply = <&VDD_MX_LEVEL>;
> +        px-uV = <RPMH_REGULATOR_LEVEL_TURBO 100000>;
> +
> +        clocks = <&clock_rpmh RPMH_CXO_CLK>;
> +        clock-names = "xo";
> +        qcom,proxy-clock-names = "xo";

We don't specify this in DT.

> +        status = "ok";

This can be omitted from the example.

> +
> +        memory-region = <&pil_spss_mem>;
> +        qcom,spss-scsr-bits = <24 25>;

As requested, just hard code these in the driver instead.

> +
> +        glink-edge {

This depends on a separate binding, which we haven't yet discussed.
Perhaps worth omitting it for now?

> +                qcom,remote-pid = <8>;
> +                transport = "spss";

The registered subdev should always be of "spss" type, shouldn't be a
need to describe that here.

> +                mboxes = <&sp_scsr 0>;
> +                mbox-names = "spss_spss";
> +                interrupt-parent = <&intsp>;
> +                interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>;

As you map the entire scsr region in the remoteproc driver, this should
reference the spss rproc node above.

> +
> +                reg = <0x1885008 0x8>,
> +                      <0x1885010 0x4>;
> +                reg-names = "qcom,spss-addr",
> +                            "qcom,spss-size";

And it seems reasonable that we pass this information from the rproc
when we create the subdev, rather than having the glink implementation
dig it out from the scsr.

Regards,
Bjorn

> +
> +                label = "spss";
> +                qcom,glink-label = "spss";
> +        };
> +    };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
