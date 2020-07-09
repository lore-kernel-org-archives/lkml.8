Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F979C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8DC206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594334967;
	bh=ZERvbEu3oP+8uFS+ohcuN+W19cPMgieB6CxNafaOMqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B6X3dfuFSipILDEo0lH2g/VErpYUTHpKt13VJejxtsQuijM9BckItmNwXXQyMPOgl
	 XNF52irD1ndOUQIassuOenDagXNYqiBdcNXupj9kjEG5L3nS9VJkDoK3bX8TlxhjJF
	 czmazS062cBAIJR2n8mlU+D3+8aO+6qFTLFZCEhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGIWt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:49:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39586 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:49:25 -0400
Received: by mail-io1-f67.google.com with SMTP id f23so4085771iof.6;
        Thu, 09 Jul 2020 15:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=on6I1QaqksTzTjlk5LO0XNZUtfYL91/HKW7wZAJpRps=;
        b=X9Fni4qy1ScpWGGNSFSsKQrdETImTZ5Y+zcLhH8CATmuMZclhRTlieqHevm+9OzJ2/
         ZeFMIbaoctiOa87wn9jFT2GXT4a1XuL2sa62eFD3sSlVnyqJD0ZgYJ+SB4WhzSQOyDgN
         TkrDfCf+tdvipieitTivLbsVt0Sv4Z4cLe6DivVtYEIWU/enxuQ3mP6n2rmkNjc3qbPC
         NdQdHgRVYd1EiF4N7/KOXrOy9BDaoLbW98oJ0hDtFtfilMUbezfXtIQxDo3IV0ztxo//
         1QxvNpFq3MvloemtF1+/C5b6AKxvBpzya4Kb2q4YZMiIT93w7Kfe46gNMU9Z3v9+aQL6
         Q46Q==
X-Gm-Message-State: AOAM5316gUiVdEEX2QN/cWx0qp396MynMXfGHlcPuwN4ABIBZnXgIbe0
        DptKx3VRzH3SwsWRCV+IJw==
X-Google-Smtp-Source: ABdhPJwmhaOV9WAsplbi/ssPpb80zMM6ajMx8LL+irUXuxYUPiVWDy14EPJ4V7O8B0jvp25RjJRaag==
X-Received: by 2002:a6b:440d:: with SMTP id r13mr43363375ioa.114.1594334964718;
        Thu, 09 Jul 2020 15:49:24 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p11sm2595327ilb.55.2020.07.09.15.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:49:24 -0700 (PDT)
Received: (nullmailer pid 1033224 invoked by uid 1000);
        Thu, 09 Jul 2020 22:49:23 -0000
Date:   Thu, 9 Jul 2020 16:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
Message-ID: <20200709224923.GA1029808@bogus>
References: <20200705140353.53093-1-zhouyanjie@wanyeetech.com>
 <20200705140353.53093-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200705140353.53093-2-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 10:03:52PM +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add the OST bindings for the X10000 SoC from Ingenic.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v1->v2:
>     No change.
>     
>     v2->v3:
>     Fix wrong parameters in "clocks".
>     
>     v3->v4:
>     1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>     2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>     3.Modify the description in "ingenic,sysost.yaml".
>     
>     v4->v5:
>     No change.
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  | 60 ++++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
> 
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> new file mode 100644
> index 000000000000..03257ed806fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for SYSOST in Ingenic XBurst family SoCs
> +
> +maintainers:
> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> +
> +description:
> +  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
> +  and one or more 32bit timers for clockevent.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +
> +      - enum:

Only 1 entry, drop 'oneOf' and the blank line.

> +          - ingenic,x1000-ost
> +          - ingenic,x2000-ost
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ost
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/x1000-cgu.h>
> +
> +    ost: timer@12000000 {
> +    		compatible = "ingenic,x1000-ost";
> +    		reg = <0x12000000 0x3c>;
> +
> +    		#clock-cells = <1>;
> +
> +    		clocks = <&cgu X1000_CLK_OST>;
> +    		clock-names = "ost";
> +
> +    		interrupt-parent = <&cpuintc>;
> +    		interrupts = <3>;
> +    	};
> +...
> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
> new file mode 100644
> index 000000000000..9ac88e90babf
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,sysost.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides clock numbers for the ingenic,tcu DT binding.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
> +
> +#define OST_CLK_PERCPU_TIMER	0
> +#define OST_CLK_GLOBAL_TIMER	1
> +
> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
> -- 
> 2.11.0
> 
