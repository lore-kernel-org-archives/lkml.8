Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB1C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096272067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584040580;
	bh=D21cS+D7IwTkwc6OHsxlNp/2mqYw3sk7uVJHEGFn1X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=be41AjWRJQXn5+0n9AcNz+UXCrOz2O6yGS+qbjSm9WRfRj6+kEqIqs6dmA7zvQDP0
	 LPqLKQrbcUQzSaYqMZ+eyLMCvDruFXGZLQzqZDYtXphHf9Kr3vhaGZ1+7sh3ZvoSc9
	 U8BnTpXrNlXIHDdg2nrfL6aIzcI1b7SIIinOTA1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCLTQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:16:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37514 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgCLTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:16:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id w13so6707115oih.4;
        Thu, 12 Mar 2020 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Djo0vbOQtmH9OZB/fNNF0rVB8vAjiW39s6si94E1rBU=;
        b=b4IhyVFyP/Ay6bke+UYYohrKLnEAIoXvLT8vlEIsVHvFrqQJ0l74ku+hbB/6/9fLRv
         6QNJtYC1TDtNJZWFaGbkl60smoLT47FeT2kQw/xEyorqvSG206WTLksOGFH8LYlKsrjZ
         7HHm8/65Ddgx93xuGY4eXwuWzV2D1Ix3Q1Y3/kWvRHmq025YTXf9+jnyUDwv468NdY8V
         kz6kBY8nRXrAYGXQvc39RZfm2qH702NqZAdkVdwAflYhTJ2ick88xSx0C7Qgw2yLpI6J
         2gKnhjJ7/MwoUlyUTRmTa+7ePa5GVBBPLfGHWpY0nNvHhVhUpYczsvayjv3KcGlt5WaL
         GbrQ==
X-Gm-Message-State: ANhLgQ1LwbA9UCIhxJbRrVYlVT+8pbRmC441XvX0OA9tbupUpCK7/ecG
        G0IIpbZ8mS8d4QahoDry0Q==
X-Google-Smtp-Source: ADFU+vtoumiJSXsxdAfti3ciBXnLW6knFIc/gPBZ7nhfGVaUMZYzcaorr+6HuUQIGHwg1vFC4zuZnw==
X-Received: by 2002:aca:4106:: with SMTP id o6mr3945666oia.173.1584040578064;
        Thu, 12 Mar 2020 12:16:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z25sm1443000oti.56.2020.03.12.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:16:17 -0700 (PDT)
Received: (nullmailer pid 13893 invoked by uid 1000);
        Thu, 12 Mar 2020 19:16:16 -0000
Date:   Thu, 12 Mar 2020 14:16:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox
 documentation
Message-ID: <20200312191616.GA9697@bogus>
References: <9bc2631ff3ab60fc607a5215e561aace83c0e8ca.1583464821.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc2631ff3ab60fc607a5215e561aace83c0e8ca.1583464821.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:07:21PM +0800, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@unisoc.com>
> 
> Add the Spreadtrum mailbox documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> new file mode 100644
> index 0000000..2f2fdcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Spreadtrum mailbox controller bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-mailbox
> +
> +  reg:
> +    minItems: 2

Need to define what each entry is.

> +
> +  interrupts:
> +    minItems: 2
> +    description:
> +      Contains the inbox and outbox interrupt information.

The description should be split to define each entry:

items:
  - description: inbox interrupt
  - description: outbox interrupt

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: enable
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +  - clocks
> +  - clock-names

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mailbox: mailbox@400a0000 {
> +      compatible = "sprd,sc9860-mailbox";
> +      reg = <0 0x400a0000 0 0x8000>, <0 0x400a8000 0 0x8000>;
> +      #mbox-cells = <1>;
> +      clock-names = "enable";
> +      clocks = <&aon_gate 53>;
> +      interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> -- 
> 1.9.1
> 
