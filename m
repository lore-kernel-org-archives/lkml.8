Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431DEC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E3F24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579648891;
	bh=PcDGSBc03nNrHQx/+YwvFCWzgmskHdp6L9IrYGnse7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tXuxD8ULZygj/g5s7K/+LiaQur8y8U/lPE8Dzn8VmopvAI56to33bAW9gVeGNOyzH
	 h6VE62BmWvxsjUPcOsWa6O7E4gS00VKFTrLUiOu7LdktjSiesFDcDhz9WQPhY+T9ca
	 Yhny3KopH6IKZNwa51gg/JuA414a4gzzPD3XhXGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgAUXVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:21:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33571 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAUXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:21:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so4646969otp.0;
        Tue, 21 Jan 2020 15:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b2BXYpfDPDVNcyG1ziQ8Rflzz+weHKCKYw4Qh7CsVWE=;
        b=Qs987i/+wMf2yi2sBTl1nCUULNYHxN7MQyeO2K8rszWPkxmH+syxG+0OVD49meIiE8
         67tujD1RgXW23gDVYJRmZeORvhiB2XpIvc0EzTUXpwh5/TQkZEqueCoDpFIzqUbFHKm4
         HMQ+o1K6ZJh13MY6rqHRCrk0X2yVhHB1lsFEFNgR4s3fdiv/aRwKQhoTeBOc1D7kbl/C
         X0vgY4fBcqvmrMf4k8zg41CTTR+d0DFK4upK84IlugI9e4c9JG+o8d5Rp6xDZtOQcEXQ
         /iMpRmF0QsbP2Ue00i3DhVrr1Gd1Dv3IU6PBxzk63g3lMHylbc80//aoVnEoKCAWPIRH
         yajQ==
X-Gm-Message-State: APjAAAXK8PSKMuXxmoiubjoWzAm7DS6MMh2NhD+iBO+FbhJAP5BinK5P
        51dN0ct27CCrircA4//b9Q==
X-Google-Smtp-Source: APXvYqytAEUvtzJujZe8GWtr4e6O/z3bPHvI6P3e8CzKdbUqWFIB7E7b8Ba8QvUU5rjNmAUkw9qENA==
X-Received: by 2002:a05:6830:1d4c:: with SMTP id p12mr5576747oth.198.1579648889363;
        Tue, 21 Jan 2020 15:21:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm12591350oie.0.2020.01.21.15.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:21:28 -0800 (PST)
Received: (nullmailer pid 29220 invoked by uid 1000);
        Tue, 21 Jan 2020 23:21:27 -0000
Date:   Tue, 21 Jan 2020 17:21:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: imx: add binding doc for aips bus
Message-ID: <20200121232127.GA21925@bogus>
References: <1579154877-13210-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579154877-13210-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:12:12AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add binding doc for fsl,aips-bus
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
> new file mode 100644
> index 000000000000..73ce1b7fc306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,aips-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX AHB to IP Bridge
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  This particular peripheral is designed as the bridge between
> +  AHB bus and peripherals with the lower bandwidth IP Slave (IPS)
> +  buses.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,aips-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    bus@30000000 {
> +      compatible = "fsl,aips-bus", "simple-bus";

'make dt_binding_check' should be failing for you because this doesn't 
match the schema. You need to add 'simple-bus'. However doing so will 
make this schema match on any node with 'simple-bus'. See 'select' in 
various arm,primecell schemas for how to avoid this problem.

Rob

> +      reg = <0x30000000 0x400000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +    };
> +...
> -- 
> 2.16.4
> 
