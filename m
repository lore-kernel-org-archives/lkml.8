Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DAD206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590787077;
	bh=vpKoyoWN5r6O3rlLTDJNlJPVdlLTIMxaOA92uuObPJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IuO3dq5m3xihk3KRcAFIm+6p2xTwcyiUBR9XXBEHuhZlGza0OGGV/g26eOjYELAVi
	 1gONOmZkpEB+598FPdNGViyD1H+/NZ/cht0xyKFwi26C5aGT9XAEJOPawXHlTFp4TA
	 pmb1pr0G37kS5ty0vxzx2NBhbR5i8po58cQXdQlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgE2VR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:17:56 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39940 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgE2VRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:17:55 -0400
Received: by mail-il1-f194.google.com with SMTP id t8so3362045ilm.7;
        Fri, 29 May 2020 14:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUXcWEVyGeAOrT4sCouBuRywKuKYWtHu45lPmV+EjrM=;
        b=nO/VaQfVLUdP+MS002zaTmo62t4ug3fpAAZ0LSjsfV++CwAfYYECsveush6QrupusU
         uG3KkB5qfaHqlRMRrtF9ctG1IjqNo2zgeqgj22TFnKIouV/ZatSdpC22KKRjVFMropb4
         pl9xnGu6LvysL6hW/hHLewnRCrCKMaZVWpWb4AcoaYh+VYgHKXTXd0jup36FMc6ekg7K
         F5xV6/s6BQ8edtgFL0A1aG8nrwGtluS25hzt8j/jnvu9RrZkbPTLiuIpg9rMzClJRRlQ
         m4h0YHMd/Y2f+FNVA6Pttj8kGxDsHVVtyPH0S1VJHoQtlYHSDR7cOo2DYy2+GFhNvo1l
         IKgQ==
X-Gm-Message-State: AOAM533bciewWWeIEK4Y+EaU/3wF5+2rdq8FNkoSd4g4mXhmH0D8LMcY
        9J7OAuj3yhyStAeyNTXpw7C8HD8MOg==
X-Google-Smtp-Source: ABdhPJyVQopdodmrG1J/7Gqr/xZs0tHWJIN9wz1LuRxvYuIRTOK2a60ioznc8C+lv3tHwhikdv876w==
X-Received: by 2002:a05:6e02:8ee:: with SMTP id n14mr8971926ilt.189.1590787074907;
        Fri, 29 May 2020 14:17:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a17sm5194699ilr.68.2020.05.29.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:17:54 -0700 (PDT)
Received: (nullmailer pid 2984285 invoked by uid 1000);
        Fri, 29 May 2020 21:17:53 -0000
Date:   Fri, 29 May 2020 15:17:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH v3 6/6] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200529211753.GA2981084@bogus>
References: <20200529130506.73511-1-alexandru.tachici@analog.com>
 <20200529130506.73511-7-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529130506.73511-7-alexandru.tachici@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 04:05:06PM +0300, alexandru.tachici@analog.com wrote:
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
> +        };
> +    };
> +...
> -- 
> 2.20.1
> 
