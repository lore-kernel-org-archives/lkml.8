Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B5C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F1F22527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580140085;
	bh=yETsAyqvV6uSq9CHgjbudxsP1n7benId3zzzsdhb/Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pcan81I7dfDnt3QylaNi7sIakwCVfRiUvjtHahy2RD9YCAsnJkquL3kNxOyoChSAe
	 vagOApz6UVZm6fciN5cocGJuNafTPJw2w0Mhik1tJyYW4Xd7VqhkiZczZedNNfpZQA
	 F8ygRazqq9cAn32iO+QDKpZ+Vk80kOij4eV7IYkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgA0PsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:48:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44008 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgA0PsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:48:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so7043168oif.10;
        Mon, 27 Jan 2020 07:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UYR7sqxNx0kFfvk4lLW7ItpSc33p5wasYWW+LyIn5lM=;
        b=Q+Um07aGAf06wo6Rg2/mjt35oFBwgfJ04V5/wVxqkAguH2r/R0Mk6y5FGfBesjBUys
         FgL9OJqntBO9iFG/8J4y7afWeK5SllAvvICKEp9GeyqknmvPzldcFhfTWnKYt8K9M9pE
         t3sTr8ZsejF4EfHCaSAsNWlzyGqlkbeYugSIcqO/TPIX9gpibXo8VoTnnumXVg0S7ZCg
         ij8FUB8VT4BbhKc+R12iECoyDAmo4iDS/wyOgyhDQM8wS3N87cqiRmXPIXneuIRvNeH/
         WmZTFmnlDIQZIj3qe1crIaIHOy75uA+dVREE9AxeZoKZdLkVlFZa7nCaURHYlRlWwZhn
         ZHeA==
X-Gm-Message-State: APjAAAWnKEmHbdvKuATizkMfMJEE4LwmRxeltPh1/lWf9EUcP8flpXSE
        VSOn8nFri6NkEMiAVvIUJ6VYCa8=
X-Google-Smtp-Source: APXvYqyAqfTjBhJSs8fb6ApXqnQsZdS4ObYsTxvZoMsNLCtJeCtCW0J0K1gBw3llFafOgZvIKKwDCA==
X-Received: by 2002:aca:dc8b:: with SMTP id t133mr7969662oig.98.1580140082458;
        Mon, 27 Jan 2020 07:48:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm4934322oic.27.2020.01.27.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:48:01 -0800 (PST)
Received: (nullmailer pid 16178 invoked by uid 1000);
        Mon, 27 Jan 2020 15:48:00 -0000
Date:   Mon, 27 Jan 2020 09:48:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joshua.Scott@alliedtelesis.co.nz, Chris.Packham@alliedtelesis.co.nz
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Message-ID: <20200127154800.GA7023@bogus>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
 <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:10:14AM +1300, Logan Shaw wrote:
> Added a new file documenting the adt7475 devicetree and added the four
> new properties to it.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> ---
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> new file mode 100644
> index 000000000000..450da5e66e07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

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
> +  Description taken from omsemiconductors specification sheets, with minor

omsemi?
 ^

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
> +  bypass-attenuator-in0:

Needs a vendor prefix and a type ref. 

> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in0. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.

Sounds like this could be boolean? If not, define a schema for what are 
valid values.

> +    maxItems: 1
> +
> +  bypass-attenuator-in1:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in1. This is supported on the ADT7473, ADT7475,
> +      ADT7476 and ADT7490. If set to a non-zero integer the attenuator
> +      is bypassed, if set to zero the attenuator is not bypassed. If the
> +      property is absent then the config register is not modified.
> +    maxItems: 1
> +
> +  bypass-attenuator-in3:
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in3. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
> +    maxItems: 1
> +
> +  bypass-attenuator-in4:

These 4 could be a single entry under patternProperties.


> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in4. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
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
> +        bypass-attenuator-in0 = <1>;
> +        bypass-attenuator-in1 = <0>;
> +      };
> +    };
> +...
> -- 
> 2.25.0
> 
