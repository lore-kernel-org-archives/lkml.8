Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DCFC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0CA20716
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc/R31o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgCCVAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:00:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34472 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgCCVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:00:47 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so1593733pjq.1;
        Tue, 03 Mar 2020 13:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x4UdmE08uyAXnfOkOr3SI3t/iiQEe1nG8X5Ab/Q7mOA=;
        b=tc/R31o3IU1au6TbLLV6WtQD4QYqoTMQFweevZVnHcnd+wZxed7t4BzfspRc31P/O3
         Rc1hTekoLMgtrL83M+XvbnJKlz2MQnlZnQ0vfqACUzSnf4eWwlh/UiEBhGGkCsdhTQkF
         f5T0diA2wB6rSKHJB7q959jcLgvCV1xnIMt24D77IOcgdnibmLdc/eH7oPVIPqxeWZUR
         5gJS61r2i0g2tRHZ2MzwT+VHLQNSMXyeauKZgEY8ag10EcRoyb2fYQEP3Conb1W7O62z
         NSHA9gxymb2OmLvBiiXBJUudLBCKKVjag+0raodGpMQ9iblmoXbRDVcGmqaoEiAnClG5
         J5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4UdmE08uyAXnfOkOr3SI3t/iiQEe1nG8X5Ab/Q7mOA=;
        b=iyUW5M3jWFJAImyJS6dfrEl2jrrcDl6rwyHyOtG4ViGh+CBweb3dsRvKt59tz+9gh4
         1e0WJ2MMDQ/G/4Wkur07BzslRGJek7ZCt467pXBY6q0xKSmSLg4uLnBTe//CWBJR62GS
         X0Z1afe2Z23KWB8yFdwwp5cU7/yttQeOc2O1vOkIoCD1ZRsTDKNB/ZN5SyAAftIQ3FPM
         t2zvC161pe6boYfeIUWtImmu1foN982LhTdVOVKfCRZYX42aVTLqN+cMGYv0RQdp/dus
         y07aM/OruZo2LCWKvtJZSkHknTd/cp8kBsE3Y5b2U1UhnLCFT7IIW3KS4+NlxTJQfsPh
         rZhg==
X-Gm-Message-State: ANhLgQ2VOi/n4ryJYm+laXIktHc9olGF8hvU0NV3xSG4K8JQ1zJyPTEC
        RuBtwRxSuF9PAU1LVY61MRXFP8gK
X-Google-Smtp-Source: ADFU+vuMHdgCyz74Q6t1S5Udddm9tLY1CUy9E5c6gQBtm5g3CSpy+mtMT7AyVplrwG1EG2UuRDrPTw==
X-Received: by 2002:a17:90a:7187:: with SMTP id i7mr462676pjk.6.1583269246008;
        Tue, 03 Mar 2020 13:00:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u1sm25606799pfn.133.2020.03.03.13.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 13:00:44 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:00:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: hwmon: Document adt7475 binding
Message-ID: <20200303210043.GA14692@roeck-us.net>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:46:38PM +1300, Chris Packham wrote:
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Add binding for adi,adt7475 and variants.
> Remove from trivial-devices.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v5:
>     - add review from Rob
>     
>     Changes in v4:
>     - None
>     
>     Changes in v3:
>     - split conversion to yaml from addition of new properties
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 57 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  8 ---
>  2 files changed, 57 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> new file mode 100644
> index 000000000000..2252499ea201
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/adt7475.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADT7475 hwmon sensor
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +
> +description: |
> +  The ADT7473, ADT7475, ADT7476, and ADT7490 are thermal monitors and multiple
> +  PWN fan controllers.
> +
> +  They support monitoring and controlling up to four fans (the ADT7490 can only
> +  control up to three). They support reading a single on chip temperature
> +  sensor and two off chip temperature sensors (the ADT7490 additionally
> +  supports measuring up to three current external temperature sensors with
> +  series resistance cancellation (SRC)).
> +
> +  Datasheets:
> +  https://www.onsemi.com/pub/Collateral/ADT7473-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7475-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7476-D.PDF
> +  https://www.onsemi.com/pub/Collateral/ADT7490-D.PDF
> +
> +  Description taken from onsemiconductors specification sheets, with minor
> +  rephrasing.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adt7473
> +      - adi,adt7475
> +      - adi,adt7476
> +      - adi,adt7490
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
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hwmon@2e {
> +        compatible = "adi,adt7476";
> +        reg = <0x2e>;
> +      };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 978de7d37c66..57173ec41c30 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -34,14 +34,6 @@ properties:
>            - adi,adt7461
>              # +/-1C TDM Extended Temp Range I.C
>            - adt7461
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7473
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7475
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7476
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7490
>              # Three-Axis Digital Accelerometer
>            - adi,adxl345
>              # Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
