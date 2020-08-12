Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569C2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597251210;
	bh=3Zly9PDpbFLVZ78t+MC0ZT/mY4FawC7RWObR4hUgzFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xjbzmd7hoQgYLhALyFpqIYUQeRPkirK4ztpmapMWlusM22W/DQCGSZ1xIu/zwDm8S
	 oWqGoIfF31CZ8/v526IBquyGHaq9crT4/PN3Dx8L0HzXAmtLNz8LkVX4OBvEXA1Cca
	 Wec2H2FYVks49DOL+JDplkSJ9MEDVLKN3Om7YsiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHLQx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:53:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:53:12 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so3596511iob.3;
        Wed, 12 Aug 2020 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrbB1lAerHD2VaQ3JRVtjguqYJiBvVxH8bz9gL6d2W4=;
        b=C+DFNw1Uy8pS9wXvtX4y29HiOY2qbZ+4z6KzX8n8iU/fBwks7n0ea1N9TqHc/8OCSL
         2gIWG11b8r3j7q+tmaKJGPioyQJV5dkaC39xQya2yN17XFkQgGSDyKQMoYUZ6unk6E3i
         EPiJ6ik5TxrQBlZseNjg3JpswbW0Iqy4gHzBh3RZYZRo3KJZsisMxXtpOhNMH6AAQHW9
         Py9PWYMEpxUNZerPsaIk9tTqYndxYETJLsbhflDl6ArhsX8nXFrKNYB1oRRQsYRg3RQD
         nukSbVzanqaglWTftBs3WirO3H6D/TZtiSKPH5sIiC/jizwFKZjEd9C/oPbJyzlnv72p
         O01Q==
X-Gm-Message-State: AOAM533ulF+E4wIutxfVzsaKmN3SpW3sotIIMtpahAsKf42BMO7BaFtl
        gqVZ2qjP9ztNOxLRbwmhGuyAfuU=
X-Google-Smtp-Source: ABdhPJy/C8+8iSnQDUDylgIDOuZ5oe2TnqZ2fpwpG2alSZnIQpWRVRdvOCghw0KBozx+le75i8D2LA==
X-Received: by 2002:a05:6638:1685:: with SMTP id f5mr390007jat.48.1597251191730;
        Wed, 12 Aug 2020 09:53:11 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n3sm1330443ilj.29.2020.08.12.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:53:11 -0700 (PDT)
Received: (nullmailer pid 2361147 invoked by uid 1000);
        Wed, 12 Aug 2020 16:53:09 -0000
Date:   Wed, 12 Aug 2020 10:53:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] devicetree: hwmon: shtc1: add sensirion,shtc1.yaml
Message-ID: <20200812165309.GA2357620@bogus>
References: <20200807073143.30462-1-chris.ruehl@gtsys.com.hk>
 <20200807073143.30462-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807073143.30462-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:31:43PM +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.

low-precision

> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> new file mode 100644
> index 000000000000..41cc59b0b0e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
> +
> +maintainers:
> +  - chris.ruehl@gtsys.com.hk

Full name too please.

> +
> +description: |
> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
> +  designed especially for battery-driven high-volume consumer electronics
> +  applications.
> +  For further information refere to Documentation/hwmon/shtc1.rst
> +
> +  This binding document describes the binding for the hardware monitor
> +  portion of the driver.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,shtc1
> +      - sensirion,shtw1
> +      - sensirion,shtc3
> +
> +  reg:
> +    const: 0x70
> +
> +  sensirion,blocking-io:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      If set, the driver hold the i2c bus until measurement is finished.
> +
> +  sensirion,low-precision:
> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      If set, the sensor aquire data with low precision (not recommended).
> +      The driver aquire data with high precision by default.
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c1 {

i2c {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      clock-frequency = <400000>;
> +
> +      shtc3@70 {
> +        compatible = "sensirion,shtc3";
> +        reg = <0x70>;
> +        sensirion,blocking-io;
> +      };
> +    };
> +...
> -- 
> 2.20.1
> 
