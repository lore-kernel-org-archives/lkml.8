Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39BC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBCD24679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="lShIY13V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgB0Fw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:52:27 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39512 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB0Fw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:52:27 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so1006507qvk.6;
        Wed, 26 Feb 2020 21:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZQu+WBBvLP640mqKaU+qwV+X4smFrhhy0xX3FBTYWc=;
        b=lShIY13VzpvHtTzPD6VrWaYV6473ZNIIuGmSg6PtSGvQ+II/6GxiDCcX538DTWsUgQ
         sK0OOHwsYSLXqHQKkImNQ0CS09g2Pg2VezCrhHNnqEMZkoOLtV/p30D+MDGZeivvop1b
         cRvcb+He1yh0TWeC3qySOQ0/O3n7jsDvRiZAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZQu+WBBvLP640mqKaU+qwV+X4smFrhhy0xX3FBTYWc=;
        b=aT73ohXB5tlYWku/hq0xf4OFre0o79UxSdk+lC/t6PQNxuKK50TfSwTr3afXQsygtX
         C1F/icjWCvUmLLYaukRnOrIqZ5VoPfPjb5u/Znh0zl0N91/d1nBa6fmWnODbXgaKUQnw
         ViA70spLKS90HQpJNXXrT+frKs0yRnKyvuf+JF7++mqgbw1KNK8Hnk9strPPMH4lWd7h
         Dy4FSL3oQOU4EeDTj/GZCBcOU2QTj04MyWBapaIwiN8vOZSQzEzMoUrB9uy0hZXU6/MH
         9ZzYogE+I4dU4OcIzznxnwiT6sh+b2luSfgjVRpLKgtxxO6D3OERj11mx04Em/IlQfWZ
         /rTA==
X-Gm-Message-State: APjAAAUtOq9Zv44JnUX9rnm+U0pItTYNV/KlY5LlLoSwXDAOhYz+DmUW
        CZtbM7yB97V99Mbe2ApKGFBgFt+ktMnF7FTP6WU=
X-Google-Smtp-Source: APXvYqwy3wpzuLJo5yRO455kyQWeqLzrSaqVEDmh4g+F+ElnODT6EPqMVWP/Za8h8FVesx/hSV479+TkYYh+x6B/Hhk=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr3059012qvo.20.1582782744480;
 Wed, 26 Feb 2020 21:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20200226230346.672-1-rentao.bupt@gmail.com> <20200226230346.672-8-rentao.bupt@gmail.com>
In-Reply-To: <20200226230346.672-8-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Feb 2020 05:52:12 +0000
Message-ID: <CACPK8XfSHSFG2vkHnosDvBUw-FvVFvGuTCiA_HwAzor-LJ-YhQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed usb-vhub
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 at 23:04, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add device tree binding documentation for aspeed usb-vhub driver.

A nitpick: the bindings are supposed to describe hardware, so we would
say this patch adds documentation for the hardware

>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  No change in v2/v3/v4:
>    - the patch is added to the patch series since v4.
>
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
>
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> new file mode 100644
> index 000000000000..6ebae46641e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Facebook Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED USB 2.0 Virtual Hub Controller
> +
> +maintainers:
> +  - Felipe Balbi <balbi@kernel.org>
> +
> +description: |+
> +  The ASPEED USB 2.0 Virtual Hub Controller implements 1 set of USB Hub
> +  register and several sets of Device and Endpoint registers to support
> +  the Virtual Hub's downstream USB devices.
> +
> +  Supported number of devices and endpoints vary depending on hardware
> +  revisions. AST2400 and AST2500 Virtual Hub supports 5 downstream devices
> +  and 15 generic endpoints, while AST2600 Virtual Hub supports 7 downstream
> +  devices and 21 generic endpoints.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-usb-vhub
> +      - aspeed,ast2500-usb-vhub
> +      - aspeed,ast2600-usb-vhub
> +
> +  reg:
> +    maxItems: 1
> +    description: Common configuration registers
> +
> +  clocks:
> +    maxItems: 1
> +    description: The Virtual Hub Controller clock gate
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  aspeed,vhub-downstream-ports:
> +    description: Number of downstream ports supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  aspeed,vhub-generic-endpoints:
> +    description: Number of generic endpoints supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - aspeed,vhub-downstream-ports
> +  - aspeed,vhub-generic-endpoints
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    vhub: usb-vhub@1e6a0000 {
> +            compatible = "aspeed,ast2500-usb-vhub";
> +            reg = <0x1e6a0000 0x300>;
> +            interrupts = <5>;
> +            clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_usb2ad_default>;
> +    };
> --
> 2.17.1
>
