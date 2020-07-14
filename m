Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569E32075F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594761087;
	bh=d/inj00VssFARtJHINdbyeltu6189BFFI92XI1Fgmfc=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=sVfky47uq0XE8pxkbFJmLciSjjplCgs6l9PH6zXaYAfD8NK1ikQ+kQCEkkpY6MTmx
	 NzGepuv+64TM01oDhcC+HDYjskDMgZ6OhqHV1H9vrgm4pjRHAvagwEJ0EC1pD375pJ
	 s5i1PZUn2dQxw44LasD8+BkQPa5VLkjYBsdoQfI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGNVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:11:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41130 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGNVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:11:25 -0400
Received: by mail-io1-f67.google.com with SMTP id p205so10306535iod.8;
        Tue, 14 Jul 2020 14:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Swq7a5ctRoc+RuUYTUtL7qfmQuMHqbMs5u22W+BDmI=;
        b=f0lxcX8VuyTB5tLjjCGW/mImBTsdeHub4NYpK0PrOmigpfRRTT4i+OBSuH0StOBbF+
         TGh1Re8U4eYTJgjJVVFLYNkhU1Mh9YzvXsEYZsm32QLnI8q6r+d30UpSHWWqTFBlFilo
         sL7uOanNLXABFE06IH+moucIh07Rfb0TRiHQgchM40KVNX38UN8ReHBkkzJWlSW2EiS1
         bhUDqGKc46XKp6MlITNTFsWO/EZwUyw2qT3ZBvn4NvnCBtNP6O00t8khwVtpW78jfLvC
         dtWD8PeullDzBmkZQAJD5eOHTX8hN1QvuK6aznSf3gjglHB3VjdZXknXp5TqxRC6+6eM
         cOTg==
X-Gm-Message-State: AOAM530ywV6YyNhsteMAFH3X22wAgwAXFCokPL37JbrW2rZX6GjVtDgA
        rkWL2uJnCNKoFCx57TM/jQ==
X-Google-Smtp-Source: ABdhPJxQmB+aTO4ntgpsDZOBSbGOX3QoKNxusCrXTBL7nhUHdW/a1NUULt6jrIxYZguq5sV6SCOjow==
X-Received: by 2002:a6b:8f04:: with SMTP id r4mr6811433iod.160.1594761084379;
        Tue, 14 Jul 2020 14:11:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v4sm53032ilo.44.2020.07.14.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:11:23 -0700 (PDT)
Received: (nullmailer pid 2924676 invoked by uid 1000);
        Tue, 14 Jul 2020 21:11:22 -0000
Date:   Tue, 14 Jul 2020 15:11:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: arm: Add Keem Bay bindings
Message-ID: <20200714211122.GA2921587@bogus>
References: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
 <20200714161305.836348-3-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714161305.836348-3-daniele.alessandrelli@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 05:13:00PM +0100, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Document Intel Movidius SoC code-named Keem Bay, along with the Keem Bay
> EVM board.
> 
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../devicetree/bindings/arm/keembay.yaml      | 19 +++++++++++++++++++

/intel,keembay.yaml

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keembay.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/keembay.yaml b/Documentation/devicetree/bindings/arm/keembay.yaml
> new file mode 100644
> index 000000000000..f81b110046ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/keembay.yaml
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/keembay.yaml#

And don't forget this update.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Keem Bay platform device tree bindings
> +
> +maintainers:
> +  - Paul J. Murphy <paul.j.murphy@intel.com>
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - intel,keembay-evm
> +      - const: intel,keembay
> +...
> -- 
> 2.26.2
> 
