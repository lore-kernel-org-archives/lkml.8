Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21984C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025792076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594659681;
	bh=YP+Q3ycNjgRpQIKzSN0RepzmavN2DDlJsBGVnx+Kb0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+u4rBQmwR0eN/NHcEgB4VZaGFY0uzaeiUgrZoU1WZC97/IEZ1PTOM/32c6bKrdxm
	 A1XqTmYQfFHx14Cp8i3F9ELrDneHUgI3IJwpPMQci+RgHctt7Dg/j1mVtMIYqfA5WL
	 qU2cxhwEjtTFq3n8sCoREByQTgknVt/TiB3c1N5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgGMRBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:01:19 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35678 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:01:19 -0400
Received: by mail-il1-f195.google.com with SMTP id t18so11820096ilh.2;
        Mon, 13 Jul 2020 10:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+ATDfebf9MV39yazJSR2REjUJRTM5Ietg8G+hjq9hs=;
        b=ZxAgbNgRqB6fP1D8x2d6i8HVjRG+vGvJxZiaTYoESfpplqy5Tdd5Z14JvIKWGz1V3x
         7UKTTBpJ3IhlegV+Jy6Kmxmeo1F4yq9/ksy8dz9HNAg47zwqlfLI/nDn5uVLiX9WR5RH
         9s5qHAxyCYe03Ww1Mz6jZhGLAJpTqBTVVf9kUgZ7s9dFpArqj7C0fPPytXS0wdh2V+cZ
         B4NIVIz4H6ZyQPS+38/vJUA/YwbmLPGNKcJ/7aAj3DE1UxjRHHg/fu59Saig4l9FYiIX
         21QZ5MSsksiA6p+Dw46BwCWckft3gBiVZxcRtrbQgvbM3yvb4l9CNtlu59g39zbe4j4x
         TviQ==
X-Gm-Message-State: AOAM531a63pfJT1qCnMJKMp7As/KrvaHSciKekD5Uu01mhodzoSUVkNE
        FKlrCrRdmmUh5KmPEn+Eow==
X-Google-Smtp-Source: ABdhPJz8Xnzy5VMGLC1oVbharKqEmV8XouNZObzNUKUHDywbuYQ837jCWWk9uWJgtsZ2IZZCJw3hPw==
X-Received: by 2002:a92:9892:: with SMTP id a18mr656663ill.60.1594659678061;
        Mon, 13 Jul 2020 10:01:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w4sm7909214ioc.23.2020.07.13.10.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:01:17 -0700 (PDT)
Received: (nullmailer pid 384200 invoked by uid 1000);
        Mon, 13 Jul 2020 17:01:16 -0000
Date:   Mon, 13 Jul 2020 11:01:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefano.stabellini@xilinx.com, tomase@xilinx.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: bus: Add firewall bindings
Message-ID: <20200713170116.GA364356@bogus>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
 <20200701132523.32533-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701132523.32533-2-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:25:19PM +0200, Benjamin Gaignard wrote:
> Add schemas for firewall consumer and provider.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/bus/stm32/firewall-consumer.yaml      | 36 ++++++++++++++++++++++
>  .../bindings/bus/stm32/firewall-provider.yaml      | 18 +++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
>  create mode 100644 Documentation/devicetree/bindings/bus/stm32/firewall-provider.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml b/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
> new file mode 100644
> index 000000000000..d3d76f99b38d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/stm32/firewall-consumer.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/stm32/firewall-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Bus Firewall consumer binding

I'm all for common bindings, but I want to see more than 1 user before 
accepting this. There's been some other postings for similar h/w 
(AFAICT) recently.

> +
> +description: |
> +  Firewall properties provide the possible firewall bus controller
> +  configurations for a device.
> +  Bus firewall controllers are typically used to control if a hardware
> +  block can perform read or write operations on bus.
> +  The contents of the firewall bus configuration properties are defined by
> +  the binding for the individual firewall controller device.
> +
> +  The first configuration 'firewall-0' or the one named 'default' is
> +  applied before probing the device itself.

This is a Linux implementation detail and debatable whether the core 
should do this or drivers.

> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +
> +# always select the core schema
> +select: true
> +
> +properties:
> +  firewall-0: true
> +
> +  firewall-names: true
> +
> +patternProperties:
> +  "firewall-[0-9]":
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"

So I guess multiple properties is to encode all the modes into DT like 
pinctrl does. Is that really necessary? I don't think so as I wouldn't 
expect modes to be defined by the consumer, but by the provider in this 
case. To use pinctrl as a example, we could have pad setting per MMC 
speed. That has to be in the consumer side as the pinctrl knows nothing 
about MMC.

Rob
