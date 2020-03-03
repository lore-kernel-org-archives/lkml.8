Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CCC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD58C20674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/VOtcoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgCCVBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:01:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbgCCVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:01:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id 7so2113524pgr.2;
        Tue, 03 Mar 2020 13:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfSv9EpZGNBP9wDtLcQWJrZ8ejizuXo4KFtHhhZ/iPw=;
        b=c/VOtcoK+gmL5tFNBsZVmozwpWRCsZG+PQRjisOpfdKwln/bvzhZJNmuNPAk4Mbur0
         MpwtXpjryJYg+ppd5IxNMrgmqT7ZmkdS3KjydtzvfdwNVKfWOo3bDY8BaUUzCKwUpZSd
         VTJ6/zzAR9JCfKogLmUQjcn4KDX8CyKLU21ud58MCNPLRk2ODRglhg8gHGpt2E0yFhwD
         EZTTt2ak/sqHjOcR5/GjFgsUOwCob4A+EIeRq1nAJFHt0pL6dui8fvu/CmI6GBrcNrOH
         534SWclnav+vwHUli3xiTcH2rdzgTxiPXntAd6upBPa+cAhdN70bWTKI+0TMxS56a23h
         SYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfSv9EpZGNBP9wDtLcQWJrZ8ejizuXo4KFtHhhZ/iPw=;
        b=psQhPuQnQCLSaiccWUIAn9vOkerou/6qq2Opmi7GRYfds63HvZpB+0Ly0WKoDPY8eQ
         d9yeu6BgcnXWTOagTSBn4FWUs71pkDhqTPtOoN0dfSZAepGyoGou6w7xY7RHA4AatdbH
         9DNzE0G5hWH7mYdlie37+JL0rdzyILmlcSdtET/MylhbinMRZsmpepRhLveY5FWWsS/H
         p7bl/ewE2uC2ncyrrTA1rVYOc1ZsKkgWjnuecVZO43YfKV+rhwmER8RCo0DenDwzKy0G
         eeCyGLI8S/ImkPSy1AU/jKDmu6LoqIqLctKt10n+916SC3nh/ielvpZNWI7TfjpGXhpN
         C1sg==
X-Gm-Message-State: ANhLgQ0jtHRf1rXvJ8KgtPNUaIp88kX9gqW2kFmZESyb6VgGIzOKJhJo
        jEv310Psu7r2jZD4p1LuncnUsjy3
X-Google-Smtp-Source: ADFU+vtm9J6nNMBMZ05HH3hafz3KGjgFj58J6K6AHetERb5/O5WfwrevSOBQ3QIteRwNaZ2UEebbaA==
X-Received: by 2002:a62:3808:: with SMTP id f8mr6038654pfa.30.1583269259688;
        Tue, 03 Mar 2020 13:00:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c73sm107620pje.44.2020.03.03.13.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 13:00:59 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:00:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
Message-ID: <20200303210058.GB14692@roeck-us.net>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:46:39PM +1300, Chris Packham wrote:
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Add documentation for the bypass-attenuator-in[0-4] property.
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
>     - use $ref uint32 and enum
>     - add 'adi' vendor prefix
>     
>     Changes in v3:
>     - separated addition of new properties from conversion to yaml
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index 2252499ea201..e40612ee075f 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -39,6 +39,17 @@ properties:
>    reg:
>      maxItems: 1
>  
> +patternProperties:
> +  "^adi,bypass-attenuator-in[0-4]$":
> +    description: |
> +      Configures bypassing the individual voltage input attenuator. If
> +      set to 1 the attenuator is bypassed if set to 0 the attenuator is
> +      not bypassed. If the property is absent then the attenuator
> +      retains it's configuration from the bios/bootloader.
> +    allOf:
> +     - $ref: /schemas/types.yaml#/definitions/uint32
> +     - enum: [0, 1]
> +
>  required:
>    - compatible
>    - reg
> @@ -52,6 +63,8 @@ examples:
>        hwmon@2e {
>          compatible = "adi,adt7476";
>          reg = <0x2e>;
> +        adi,bypass-attenuator-in0 = <1>;
> +        adi,bypass-attenuator-in1 = <0>;
>        };
>      };
>  
