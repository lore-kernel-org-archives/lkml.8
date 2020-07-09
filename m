Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F9CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D5420775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594335484;
	bh=Bycng0MCmO4qy4OQ51llJXxsiZoGKgyXRKaZ0gExkx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dT7ulgWSFMUtM+ghUc4O17kAY18lmMFwNbjygRwCpniW1AquxfbA6DMnRyd+Lt5aS
	 GwQZB6lmhbkryGOOsQPIKwKEbW/TiMoNpOp0k0Mixz8lzVrQYgeeX+q6cVT0vlT3dx
	 f+YlSWsFewXyDU/EtIZgVWC4uDfNJ6fPnwthvq78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGIW6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:58:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42291 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGIW6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:58:02 -0400
Received: by mail-il1-f196.google.com with SMTP id t27so3455232ill.9;
        Thu, 09 Jul 2020 15:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUysYX5gx8v+ALLFOwqd441nucMw0JC5sr5in7urozA=;
        b=qMcRNxTERM1ppIeJ6XTvotMKnkVyYNVt5WkE3hSYWIfvftPxmZzmu+9rF5m5/JwqJA
         g+FN6WSFNhtsYtFGRDFF4qW2fbbScTexOGpFThk2ksCYcLVlDW6uXoy6mpBCRxGQmakm
         fwtGn6gFbCxvT5tJJPW4mIPMSS9Crk2K8JKim5Q1U7UKHLVNoHP/vL8QES+7RPfBSQnq
         i7hDF0NKaGzhxvfpGBe0luuHhmVO+IVOslcdDy5L4ucJXRFFrLLxPT5AAq75r4Rc71ev
         sAvNsdhECUCS9aML8A77ZLLseiC8lGZOmIK1gFLsE/jPf+siZntN3Xix37PaqSxKpIcc
         Gs2Q==
X-Gm-Message-State: AOAM532A0fntijfpJWq6tfI9CTuNur75IqM05PofGUNfYishAL/tdhvl
        evSkFHkvG6ZvThrfBAwkiQ==
X-Google-Smtp-Source: ABdhPJwK7B+LuXVaPNciMiac694dleIoNATkdJfhjt6w+WeI4pE+/FDfEN/0wJ7P19KC1zRRRaGygw==
X-Received: by 2002:a92:4101:: with SMTP id o1mr38094648ila.53.1594335481573;
        Thu, 09 Jul 2020 15:58:01 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v5sm2837555ios.54.2020.07.09.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:58:00 -0700 (PDT)
Received: (nullmailer pid 1047705 invoked by uid 1000);
        Thu, 09 Jul 2020 22:57:59 -0000
Date:   Thu, 9 Jul 2020 16:57:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        l.stach@pengutronix.de, lukas@mntmn.com, agx@sigxcpu.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/5] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20200709225759.GA1040142@bogus>
References: <20200709164736.18291-1-laurentiu.palcu@oss.nxp.com>
 <20200709164736.18291-5-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709164736.18291-5-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:32PM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Add bindings for iMX8MQ Display Controller Subsystem.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> new file mode 100644
> index 000000000000..a951409cf76d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 NXP
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: iMX8MQ Display Controller Subsystem (DCSS)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@nxp.com>
> +
> +description:
> +
> +  The DCSS (display controller sub system) is used to source up to three
> +  display buffers, compose them, and drive a display using HDMI 2.0a(with HDCP
> +  2.2) or MIPI-DSI. The DCSS is intended to support up to 4kp60 displays. HDR10
> +  image processing capabilities are included to provide a solution capable of
> +  driving next generation high dynamic range displays.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx8mq-dcss
> +
> +  reg:
> +    items:
> +      - description: DCSS base address and size, up to IRQ steer start
> +      - description: DCSS BLKCTL base address and size
> +
> +  interrupts:
> +    items:
> +      - description: Context loader completion and error interrupt
> +      - description: DTG interrupt used to signal context loader trigger time
> +      - description: DTG interrupt for Vblank
> +
> +  interrupt-names:
> +    items:
> +      - const: ctxld
> +      - const: ctxld_kick
> +      - const: vblank
> +
> +  clocks:
> +    items:
> +      - description: Display APB clock for all peripheral PIO access interfaces
> +      - description: Display AXI clock needed by DPR, Scaler, RTRAM_CTRL
> +      - description: RTRAM clock
> +      - description: Pixel clock, can be driver either by HDMI phy clock or MIPI
> +      - description: DTRC clock, needed by video decompressor
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: rtrm
> +      - const: pix
> +      - const: dtrc
> +
> +  port:
> +    type: object
> +    description:
> +      A port node pointing to the input port of a HDMI/DP or MIPI display bridge.

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
