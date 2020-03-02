Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A489CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DD72465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583192870;
	bh=ur8ZwHkyldfeXitGtL6gWFIjE4yJTQYaVaTWrtYij4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGT9FGF57d1N1XYEibt4r3buEgLVbxKQUgoAkOlRxEPYfN5eQXHke9+sSOsFcMoHT
	 b6LE+0+pc9b2cij2USEZASYKX/J0VMZqp0hiFEUcCxz2xB2md6+c0jGRpkCDxP147S
	 qUZYgeOHAJHvhGGcbmTIkp90oDnQZ3a4rwzTlTdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCBXrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:47:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38308 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:47:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id i14so1193729otp.5;
        Mon, 02 Mar 2020 15:47:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/RkNcxyLqUX/+PgUpkEl7v2Jd0JMvdb/wExbaQt108=;
        b=nomFvKa1NStZwFm9mb7CBUdadrt7KBsNYC3ksZ7JcqRRB9R/4x5fKKh3i/ORttsIiX
         W+f0LM9VcldQBPn46IikXgpv9/ApP9h5qwkx9KxkjTAIKNTP51GbKQ8rJns6MA4M0Mpz
         eHUhUBRwP6y7lEiE3moKzE/X/ylUktohbtzsHu6MMM8XSZ+A43FIQOW3oU/37D9h7Nxb
         Q3+55uaucAQb0C8TpCBs3LM8wa47qESaUtTyA9pD1Ia0mmfBUTUv4lCpZ9AxisS0zNJJ
         HgSO96T9dyIx+TxFdiyLO30cYAIByFHxqOMTJ/FSfMmpoYcYHSt7UY4Um/beVCRYi69B
         0kpw==
X-Gm-Message-State: ANhLgQ3rsjkfJt6JaKZG8PNgcJVmAW4emPtJz99NU7aAsL8QpwvAeLqT
        BotsVsRfxIlRORSK4/9QLQ==
X-Google-Smtp-Source: ADFU+vuxpmnJMb8DOFdRXd1/mWLsgWVNrXdVa77SguBZ7LSbwMPbChW5+xbwnEeE1XzjzZTeiYahoQ==
X-Received: by 2002:a9d:7509:: with SMTP id r9mr1274145otk.270.1583192866512;
        Mon, 02 Mar 2020 15:47:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m23sm3457031otq.37.2020.03.02.15.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:47:45 -0800 (PST)
Received: (nullmailer pid 30642 invoked by uid 1000);
        Mon, 02 Mar 2020 23:47:44 -0000
Date:   Mon, 2 Mar 2020 17:47:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     rentao.bupt@gmail.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v6 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200302234744.GA21778@bogus>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
 <20200228020757.10513-8-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228020757.10513-8-rentao.bupt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:07:57PM -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add device tree binding documentation for the Aspeed USB 2.0 Virtual HUb
> Controller.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  Changes in v6:
>    - added 2 required properties into example and passed "make
>      dt_binding_check".
>  Changes in v5:
>    - updated maintainer to Ben.
>    - refined patch description per Joel's suggestion.
>  No change in v2/v3/v4:
>    - the patch is added to the patch series since v4.
> 
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> new file mode 100644
> index 000000000000..b9f33310e9a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

Dual license new bindings please.

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright (c) 2020 Facebook Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/aspeed,usb-vhub.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED USB 2.0 Virtual Hub Controller
> +
> +maintainers:
> +  - Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

If 'Common' means something specific to this block, then keep. 
Otherwise, you can drop ti.

> +
> +  clocks:
> +    maxItems: 1
> +    description: The Virtual Hub Controller clock gate

Drop this.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  aspeed,vhub-downstream-ports:
> +    description: Number of downstream ports supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Constraints?

'maximum: 5' ?

default?

> +
> +  aspeed,vhub-generic-endpoints:
> +    description: Number of generic endpoints supported by the Virtual Hub
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

Constraints?

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
> +            aspeed,vhub-downstream-ports = <5>;
> +            aspeed,vhub-generic-endpoints = <15>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_usb2ad_default>;
> +    };
> -- 
> 2.17.1
> 
