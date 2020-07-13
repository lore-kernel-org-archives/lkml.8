Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E29C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F6420663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594659947;
	bh=a6RqDn8jj/zLybV77B2ynjkvwCbz2Ijy0aXmGvtneQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LwmDqHJY1exVlAZTJfnAW/FGjD4+XgTAzWe9V7j/gxoV19rJkCYNcUhOxuRxI0t+r
	 fkAKUK2DN5pwwlOv0ifDLzwhXEkFEdHaQSc6jBK6LNAkfi18k9X0SBdtVuEHEfq1ZF
	 A7rivwaUscPqp0+qrli1EqtD0g8IOrSCi5/2EyOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgGMRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:05:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32987 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGMRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:05:45 -0400
Received: by mail-io1-f66.google.com with SMTP id d18so14302628ion.0;
        Mon, 13 Jul 2020 10:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jl0UjbzV2OAP2EmSX4iuTz5iJINBRO38hYrgQ/UX/A=;
        b=ZUONJt8R48VvJTpL5tlKWjVSb5G8IatBPmq+cYUrJZ1xB+dL16gl+p/Be5QRRnrqhq
         NTWhvprKhlI8q+UJPazgnL/62Ila/sz/f/zpXyT+zsybnFr7xmqjaLEAIbQLjbXOadIJ
         omL7b3/rGkYi8uvDP/PBr+bdpWBxmquaYsmvbEtHnJQwolushzgxYmFYjKqKnb9JnMgT
         eERy9c62WQV4st+xCwtwmZx4Epox9OtxNbwenI9GDy+c/Z8W/p2yKLf4a7u7zphUj4nT
         ziEbDZAdwqx/5dNSarsuDKMFpJc/YDzhWtYCytB1/SrLb2HH4SGuCf43Ay7zFJGbBeyY
         Tw0Q==
X-Gm-Message-State: AOAM531JLyt/SANBSA26zOfm54eC3dahPRIHzjiiL4AKiqRkCIaCqeoq
        6/sBznUBuZAX5/eFlNrGmDdyMjtJEg==
X-Google-Smtp-Source: ABdhPJxDEcwhz0IyGNmYp/NGGAlbzEHgUbeYWUqbdxP7AUUJu+FPa/ebrtJU6dD/xdg72XlVTipxwQ==
X-Received: by 2002:a6b:1496:: with SMTP id 144mr758347iou.6.1594659944828;
        Mon, 13 Jul 2020 10:05:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b6sm493310iow.35.2020.07.13.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:05:44 -0700 (PDT)
Received: (nullmailer pid 390110 invoked by uid 1000);
        Mon, 13 Jul 2020 17:05:42 -0000
Date:   Mon, 13 Jul 2020 11:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefano.stabellini@xilinx.com, tomase@xilinx.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: bus: Add STM32 ETZPC firewall
 controller
Message-ID: <20200713170542.GA384390@bogus>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
 <20200701132523.32533-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701132523.32533-4-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:25:21PM +0200, Benjamin Gaignard wrote:
> Document STM32 ETZPC firewall controller bindings
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/bus/stm32/st,stm32-etzpc.yaml         | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml b/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
> new file mode 100644
> index 000000000000..d92865fda40c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/stm32/st,stm32-etzpc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/stm32/st,stm32-etzpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32 Extended TrustZone Protection controller
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +
> +description: STMicroelectronics's STM32 firewall bus controller implementation
> +
> +allOf:
> +  - $ref: "firewall-provider.yaml#"
> +  - $ref: /schemas/simple-bus.yaml#

Your bus has controls/setup, it's not a simple-bus.

Do you expect an old kernel or one with support for "st,stm32-etzpc-bus" 
disabled to work? How's it going to know if certain nodes can't be 
accessed without that support? 

> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - st,stm32-etzpc-bus
> +
> +  reg:
> +   maxItems: 1
> +
> +  '#firewall-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#firewall-cells'
> +
> +examples:
> +  - |
> +    soc@5c007000 {
> +      compatible = "st,stm32-etzpc-bus", "simple-bus";
> +      reg = <0x5c007000 0x400>;
> +      #firewall-cells = <2>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +    };
> +
> +...
> -- 
> 2.15.0
> 
