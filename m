Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08147C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E1C24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582842163;
	bh=c3j+vRp0Lh7Ozt/xPptH346wW5138N1TD0vkBGoWdB4=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=t73u1oM4MQf+1oSFdIawNPsGJKInlEN9zaoH7FQxvY/HdZfbXHhBYti5jp+drmxlF
	 pnKspmd7hpC8iHGy4R+zikZhoKifE8gVFsbeQxfdIRF30arPmA22vWzQpfzgEqtGQQ
	 yl19zqyQzeEkeQjjXuD+kkY0ZJmNbC41y4BeY4oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgB0WWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:22:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43471 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgB0WWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:22:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so730361oth.10;
        Thu, 27 Feb 2020 14:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Twand65sZdOLPd8mLMV5yo/gk50yR6BORm4y7JCU1Fs=;
        b=hEzqBN6Mvj9KfgNlEKt9y8RJ6vQiLq0I9dOO5mn1uQgd4V3U9fxwAc/XodE9n439o9
         gimQWAV+Gec6+PMph5xwuNfv2sfd3C2/3RQk/oatUzyzHNVwD7Lfax03IiD7oqBDfjeo
         tosQ9Umx67gLIdhE+h9khbddjRR8k4LP0aXT9WmYjC2FdswndPh/v5UbkSI2OT/qGtk+
         Yx3N+6EjbF16r3saggOOm3HCEjtnxfI28qFM9jqFNHpkGuNtqqOxW08GGRV0OI9jomRa
         eOZCaRdWa17RiOxZccVkgAu9FsGF3SQG7AJzQD1puTNBQMzFmQtUi97aIt+EnNiBK760
         05VQ==
X-Gm-Message-State: APjAAAXdKaM0FNXGIEnSF3PVFgMCatPrk2lXV4yPBs6QdHwdtwLvIbN1
        ALSnZfyRDYufTEOQWSPDrg==
X-Google-Smtp-Source: APXvYqz5B7zZblz4z3k+XJtWJQ8eJGRpmeq7mhbk1IJZq3BK1sqHfVfQ2pt+9lrRhZUpnAzW5mSOdg==
X-Received: by 2002:a9d:5e9:: with SMTP id 96mr871219otd.307.1582842161560;
        Thu, 27 Feb 2020 14:22:41 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm2396457oto.62.2020.02.27.14.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:22:41 -0800 (PST)
Received: (nullmailer pid 25505 invoked by uid 1000);
        Thu, 27 Feb 2020 22:22:40 -0000
Date:   Thu, 27 Feb 2020 16:22:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 12/13] dt-bindings: arm: Add Calxeda system registers
 json-schema binding
Message-ID: <20200227222240.GG26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-13-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-13-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:09PM +0000, Andre Przywara wrote:
> The Calxeda system registers are a collection of MMIO register
> controlling several more general aspects of the SoC.
> Beside for some power management tasks this node is also somewhat
> abused as the container for the clock nodes.
> 
> Add a binding in DT schema format using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/arm/calxeda/hb-sregs.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml b/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
> new file mode 100644
> index 000000000000..4753e8dc5873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/calxeda/hb-sregs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda Highbank system registers
> +
> +description: |
> +  The Calxeda Highbank system has a block of MMIO registers controlling
> +  several generic system aspects. Those can be used to control some power
> +  management, they also contain some gate and PLL clocks.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    const: calxeda,hb-sregs
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    type: object
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sregs@fff3c000 {
> +        compatible = "calxeda,hb-sregs";
> +        reg = <0xfff3c000 0x1000>;
> +
> +        clocks {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            osc: oscillator {
> +                #clock-cells = <0>;
> +                compatible = "fixed-clock";
> +                clock-frequency = <33333000>;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
