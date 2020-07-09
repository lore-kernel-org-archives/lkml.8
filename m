Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD72C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACAF20672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594332869;
	bh=dI+YKovRZcmleNvC8/pS+LSupDrqJpa9QNMy7S8kGm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=exwiO4n4CYmzTuzBSLxzfX1Prp3r377clGZAWLmK9uUKetZQOALlADrdFYN9tk8PW
	 DjAbyarPfJuVbMHw0BLZYEubCkmU8OEZfjO/l6A4McUwF1qQFH6CUBpuJ4an8JospR
	 yobC/HccQrnzqft5p4NC0lDr43+n0yxcgiJcrE3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGIWO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:14:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33217 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:14:27 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so4034665ion.0;
        Thu, 09 Jul 2020 15:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0GI8wbwo9sGGwkY6G16fvlQaAYWT2insbPg48n1qsB0=;
        b=KJOaIlDPC0fk2w5GzYvRRtXnmSUid6G065usnwKhWV0qWn8MRraHcaimXTvdIhCksR
         RHIc8DWhjLY/xcyE2Ahb3xZCefT1ouuc3RDLS3ZymCO1JG2AQX+wsomRwPyYFpNMZgex
         pr5YKa+iQzRUHn7KDSaSM6BXW/4n5ODv8QVOEbYWU9BO6+oPHppzEWMD3LBUDK5nnpnA
         H3f+ohAQfueTlitpEFF+V4AsoPmUsH/y5XBM8/GA5Mm1tq6+ufAN9UBcatoZNVWetBxw
         dXyfPzclEh0kDo9BNisXxHVGvUNdf3JQXHds2IlP1ZjqHxCSwuln1JVgr2azKDNOO5Ut
         2nhg==
X-Gm-Message-State: AOAM531pFtYcDrGkzt0iLpQbwDhn73AcF0cATXnSMANWWM5p503M1opL
        axd84DfaBh4fl6rvBhHsUKZjFZf2kg==
X-Google-Smtp-Source: ABdhPJz4z0YRhpJUp29LyqfDmxPtPiXxZxITILJyx22tU8BdeEEMcaWycX5iG4kXTnIURSnYmr7XnA==
X-Received: by 2002:a05:6602:58a:: with SMTP id v10mr44439153iox.203.1594332866335;
        Thu, 09 Jul 2020 15:14:26 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id b24sm2908370ioj.1.2020.07.09.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:14:25 -0700 (PDT)
Received: (nullmailer pid 986760 invoked by uid 1000);
        Thu, 09 Jul 2020 22:14:25 -0000
Date:   Thu, 9 Jul 2020 16:14:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v5 7/7] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200709221425.GA984242@bogus>
References: <20200624151736.95785-1-alexandru.tachici@analog.com>
 <20200624151736.95785-8-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624151736.95785-8-alexandru.tachici@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:17:36PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> new file mode 100644
> index 000000000000..76b62be48d56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1266.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1266 Cascadable Super Sequencer with Margin
> +  Control and Fault Recording
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  Analog Devices ADM1266 Cascadable Super Sequencer with Margin
> +  Control and Fault Recording.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1266
> +
> +  reg:
> +    description: |
> +      I2C address of slave device.
> +    items:
> +      minimum: 0x40
> +      maximum: 0x4F
> +
> +  avcc-supply:
> +    description: |
> +      Phandle to the Avcc power supply.
> +
> +  adi,master-adm1266:
> +    description: |
> +      Represents phandle of a master ADM1266 device cascaded through the IDB.
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adm1266@40 {
> +                compatible = "adi,adm1266";
> +                reg = <0x40>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;

These aren't documented. Do you expect child nodes?

> +        };
> +    };
> +...
> -- 
> 2.20.1
> 
