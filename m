Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E659C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7450920728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i66taKEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbgCCVBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:01:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43372 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbgCCVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:01:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so1880117plm.10;
        Tue, 03 Mar 2020 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOHyqE2A2oPYkvGdlKjL739HXxxl59rvVeUawxqIP4I=;
        b=i66taKEEeb9c2UywmFtiRMRUDaSoCOPiYbtjfnT785OU7mE26fTPTW+Y0nUry1d53J
         6nrmuIhqlHnWqhnKqALDxuoLHh1qbfhtAeZlO1bYSZloxIfA+IhditGloJB3f3zGwI8A
         fTKUe/Yuu1wRWD3Hqt4DNO1SFzl42D8PQPGxSWAiprStPYNVKdFYbHVVs2drfEEQnl+2
         FsnRxpm31gaSkyIOxFIvwpIxccfZlNR03yTf6U6ncqfSr2L3ArBbgqgws19jsYQYXOnL
         Y8xn6HYT4LAPP+zAKka1RIq5hwt9tWDyUxfzzIqvI8WjUEyVNCipJOCYWQIGsvXPWqed
         84sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOHyqE2A2oPYkvGdlKjL739HXxxl59rvVeUawxqIP4I=;
        b=SS9mnHBWZoDmwsy5uPbS8n4Aum3wBnaOktrCPMucvQG6pG7It74czaIdLR6gmaEwn1
         e+sFbmSaKWKlNO9xImhSQj6ISmVVy5I1R/vFObD4JlhbqiuZsjDi/TjQp3YPbXKEMJMw
         mEsg7E+YwM4ULMYKiYdfuRm6WkmrYJNLLNMGaMLu/kaEFTaGvTtvXw2KpaDD6EzM3pEi
         PCzr4+xUKFb8wZI55E/6XLcdCZmnTyAeok1Ie0H7hVeZwkh4vAmMIzTnfUl4+W12biqK
         y5iuVoXzbFiR7HSy7yRDTwJEpwx0lzENgMjSYU20/4iAhL2QtOP/VCuQc17pae+JvBPV
         Y+Eg==
X-Gm-Message-State: ANhLgQ13wEgZoxkHBeUYELqqeUXtTe8sYgtZjxQ0d2ruPVQrMuDo3IKT
        or0d7P1Kmw03WQ5Ok3QQy+Ly0sZ0
X-Google-Smtp-Source: ADFU+vv9Mtnm7Zz1kPzeZP1Sh1Vxkp+myJ3XdLycjJzDh3GJQBxcMLMEEYo5BOhwdhaLReSckp+YRQ==
X-Received: by 2002:a17:90a:4fc6:: with SMTP id q64mr434506pjh.109.1583269278019;
        Tue, 03 Mar 2020 13:01:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q187sm25312996pfq.185.2020.03.03.13.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 13:01:17 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:01:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        logan.shaw@alliedtelesis.co.nz, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] dt-bindings: hwmon: Document adt7475
 pwm-active-state property
Message-ID: <20200303210116.GC14692@roeck-us.net>
References: <20200227084642.7057-1-chris.packham@alliedtelesis.co.nz>
 <20200227084642.7057-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227084642.7057-4-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:46:40PM +1300, Chris Packham wrote:
> Add binding information for the adi,pwm-active-state property.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v5:
>     - change to adi,pwm-active-state
>     - uint32 array
>     
>     Changes in v4:
>     - use $ref uint32 and enum
>     - add adi vendor prefix
>     
>     Cahnges in v3:
>     - new
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index e40612ee075f..76985034ea73 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -50,6 +50,19 @@ patternProperties:
>       - $ref: /schemas/types.yaml#/definitions/uint32
>       - enum: [0, 1]
>  
> +  "^adi,pwm-active-state$":
> +    description: |
> +      Integer array, represents the active state of the pwm outputs If set to 0
> +      the pwm uses a logic low output for 100% duty cycle. If set to 1 the pwm
> +      uses a logic high output for 100% duty cycle.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 3
> +        maxItems: 3
> +        items:
> +          enum: [0, 1]
> +          default: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -65,6 +78,7 @@ examples:
>          reg = <0x2e>;
>          adi,bypass-attenuator-in0 = <1>;
>          adi,bypass-attenuator-in1 = <0>;
> +        adi,pwm-active-state = <1 0 1>;
>        };
>      };
>  
