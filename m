Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E105C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235162078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594313582;
	bh=Ou1869HVFSvMwv+8dhYgjVi8A7KdtbtdmscrHUk5bU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D8VLX3C/eWRo5JJwG8Ka3z4YnG4JaIvre0R7trYihGUX9HkqU/qjSiSBcvaz2Aqvn
	 r7bj1iYgw/8O47NhaWyrgs41UNJwwKKC2iLvHjwidDTu1NADfcZcWVExOf5zVz5xjH
	 DgWOlT6EM48k1slozNQDFsxTrOr75nrezWdYlxn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGIQxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:53:01 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33367 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:53:00 -0400
Received: by mail-il1-f196.google.com with SMTP id a11so2641751ilk.0;
        Thu, 09 Jul 2020 09:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/DCDecxKksLQjx2pJx97E2fm4hbkP0T5+uzMJw8RSw=;
        b=Mb5vSJwc6KGMq7PEECu1KP6eU13QQQDRxxSucMnH6xOdmOpbwrjRk0YjHz8uM5SFwi
         J2muvvrKXAwND51BslJwmqoUi/vjRZsirT98PiXJMNy+qVzYfMLconPJWBbCF/4LcIcf
         NM3xvFrzgPy3WRNYl7PEYFsR/0U91qlVN5NY4QDcialL8/9vvfBJyy+kDYRqEosUq9ba
         3c+A84UBGf/2WLIEBG0ky/HQeKtIhDCtkEgCvNesmChf0aDHQPqJ32z+wK5PA7bk1swb
         ksKAAXEwXGMqfK0UJn5HBJYyqlzON7yqWYsHWTiAv0JxFCsIZBvKpfUc6sjnRi9h2M7b
         8OFA==
X-Gm-Message-State: AOAM531pAzKvM3IS42LsYdl6rjhO3gdZ0e+AyqjoU3muYw8InEdBw85W
        s2GrwjfxAkslz/T/uUKrUg==
X-Google-Smtp-Source: ABdhPJxpUGLRhdHevt6FxnlHLfFjo1zs7m9mcBQFfsYIWjkHPg9D1Aon2dvz6mvRSv5guWR5rc9R2w==
X-Received: by 2002:a92:c5c6:: with SMTP id s6mr49200705ilt.139.1594313579681;
        Thu, 09 Jul 2020 09:52:59 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id r11sm2115791ilm.2.2020.07.09.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:52:58 -0700 (PDT)
Received: (nullmailer pid 505434 invoked by uid 1000);
        Thu, 09 Jul 2020 16:51:07 -0000
Date:   Thu, 9 Jul 2020 10:51:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
Message-ID: <20200709165107.GB498064@bogus>
References: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
 <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708040748.9014-3-chris.ruehl@gtsys.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:07:47PM +0800, Chris Ruehl wrote:
> Add documentation for the newly added DTS support in the shtc1 driver.
> To align with the drivers logic to have high precision by default
> a boolean sensirion,low_precision is used to switch to low precision.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  .../bindings/hwmon/sensirion,shtc1.yaml       | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> new file mode 100644
> index 000000000000..6725a7b646b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> @@ -0,0 +1,60 @@
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
> +    maxItems: 1
> +    description: I2C address 0x70

If 0x70 is the only address, then do:

reg:
  const: 0x70

> +
> +  sensirion,blocking_io:

s/_/-/

> +    $ref: /schemas/types.yaml#definitions/flag
> +    description:
> +      If set the i2c bus hold until measure finished.
> +
> +  sensirion,low_precision:
> +    $ref: /schemas/types.yaml#definitions/flag

s/_/-/

> +    description:
> +      If set aquire data with low precision (not recommended).
> +      The driver aquire data with high precision by default.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c1 {
> +      status = "okay";

Don't show status in examples.

> +      clock-frequency = <400000>;
> +
> +      shtc3@70 {
> +        compatible = "sensirion,shtc3";
> +        reg = <0x70>
> +        sensirion,blocking_io;
> +        status = "okay";
> +      };
> +    };
> +...
> -- 
> 2.20.1
> 
