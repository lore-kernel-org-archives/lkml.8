Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B078AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C19206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584048219;
	bh=+ksZdCIJma9x6NGiiAhI4ng/W9U30JVSmo0tlTmBArI=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=LUnIm2rOtqPYM8D4h2YH5K9IJEIn2tZK4nTUYl/3zdpyJrBw4Na8STBGIM9RoAAni
	 iNWfKOr+eugPyRc70osv8HBpdGYdmgaw4f3d1sp69ZdqU3984K40RjQSrI8p6YVgTf
	 0D1fQu/SH58f9kWjE8x+I4hQhXO/PHbpNbaxyzjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:23:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40147 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:23:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id y71so7094964oia.7;
        Thu, 12 Mar 2020 14:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xK16WdFb62NGupAN/nbttCoN1NDYo7RN8lQGldOPJF8=;
        b=TI3nm7LbeQKybESq3L/WkhAMDHLYPCPV448Z9/pOaBuZsasQHxzHeYzeZd/25PuQpg
         SDYsn5CMhwvwIA0RovGtKxjLgzqjsSOhmmL2BTTwqMV55xzP6BW4vdY1Vru3kbDsZgMh
         EMi8WlhrqTqFjZUCPp28+KveOhwi21pzi6H3loVBqXtrVkr+tlb4g58BqS4I4KFvri2I
         NBWPH2gx1tuTaF7ulhywhYp9zSN4G8dTS8350VD8z2FbXRAMONX9k4nW7tiWWo0zHzfx
         8ZglfCcDPtnU5+4gvmkoRBFoWHu/Tg1+svb8DKHvWycEmPxEfBBz+wfsUpV3teVDSlmP
         mV+Q==
X-Gm-Message-State: ANhLgQ3KIxm3F8qF3P3W/wfIUsqk7EAzHkjSNUfFA3WjHILbpJvOXsNU
        3MSX7xjKSLvvUh/LgPnUUg==
X-Google-Smtp-Source: ADFU+vtiSltMefBtp55W6i/u+qE1m5k0LPIxSRvBiwg56SBngDhgbc2KSCgzedy4Sh3uaBryuUjdfw==
X-Received: by 2002:aca:8d5:: with SMTP id 204mr4190675oii.141.1584048217271;
        Thu, 12 Mar 2020 14:23:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm6987463oih.23.2020.03.12.14.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:23:36 -0700 (PDT)
Received: (nullmailer pid 20579 invoked by uid 1000);
        Thu, 12 Mar 2020 21:23:35 -0000
Date:   Thu, 12 Mar 2020 16:23:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
List-Id: <soc.lore.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: Add Baikal-T1 L2-cache Control Block
 dts bindings file
Message-ID: <20200312212335.GA27332@bogus>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130734.194288030794@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130734.194288030794@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:07:18PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> There is a single register provided by the SoC system controller,
> which can be used to tune the L2-cache up. It only provides a way
> to change the L2-RAM access latencies. So aside from the MMIO region
> with that setting and "be,bt1-l2-ctl" compatible string the device
> node can be optionally equipped with the properties of Tag/Data/WS
> latencies.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: soc@kernel.org
> ---
>  .../bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> new file mode 100644
> index 000000000000..8769b3fa517c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-l2-ctl.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license

> +#
> +# Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> +#
> +# Baikal-T1 L2-cache Control Block Device Tree Bindings.
> +#
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/baikal-t1/be,bt1-l2-ctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 L2-cache Control Block
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description: |
> +  Baikal-T1 exposes a few settings to tune the MIPS P5600 CM2 L2-cache
> +  performance up. In particular it's possible to change the Tag, Data and
> +  Way-select RAM access latencies. This bindings file describes the system
> +  controller block, which provides an interface to set the tuning up.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: syscon
> +    then:
> +      $ref: ../../mfd/syscon.yaml#
> +    else:
> +      properties:
> +        reg-io-width: false
> +
> +        little-endian: false
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: P5600 CM2 L2-cache RAM external configuration block.
> +        const: be,bt1-l2-ctl
> +      - description: P5600 CM2 L2-cache RAM system controller block.
> +        items:
> +          - const: be,bt1-l2-ctl
> +          - const: syscon

Why is this conditional? Different h/w?

> +
> +  reg:
> +    description: MMIO register with MIPS P5600 CM2 L2-cache RAM settings.

You can drop this.

> +    maxItems: 1
> +
> +  be,l2-ws-latency:
> +    description: Cycles of latency for Way-select RAM accesses.
> +    default: 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3

These should be at the same level as 'default' or default moved here (I 
prefer the former). IOW, only $ref has to be under 'allOf'.

> +
> +  be,l2-tag-latency:
> +    description: Cycles of latency for Tag RAM accesses.
> +    default: 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3
> +
> +  be,l2-data-latency:
> +    description: Cycles of latency for Data RAM accesses.
> +    default: 1
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +        maximum: 3
> +
> +  reg-io-width:
> +    const: 4
> +
> +  little-endian: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    l2_ctl1: l2@1F04D028 {

lowercase hex.

> +      compatible = "be,bt1-l2-ctl";
> +      reg = <0x1F04D028 0x004>;
> +
> +      be,l2-ws-latency = <0>;
> +      be,l2-tag-latency = <0>;
> +      be,l2-data-latency = <1>;
> +    };
> +  - |
> +    l2_ctl2: l2@1F04D028 {
> +      compatible = "be,bt1-l2-ctl", "syscon";
> +      reg = <0x1F04D028 0x004>;
> +
> +      be,l2-ws-latency = <0>;
> +      be,l2-tag-latency = <0>;
> +      be,l2-data-latency = <1>;
> +
> +      little-endian;
> +      reg-io-width = <4>;
> +    };
> +...
> -- 
> 2.25.1
> 
