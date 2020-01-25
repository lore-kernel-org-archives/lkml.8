Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B544C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51232075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXto7Tly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgAYXJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:09:12 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33168 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgAYXJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 18:09:11 -0500
Received: by mail-yb1-f196.google.com with SMTP id n66so3050671ybg.0;
        Sat, 25 Jan 2020 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFVdhq/r7pIVx9grb41uXODJ84vqsahqMSF70l6XNds=;
        b=UXto7Tly7mwFexdDV7/JhULJHfKZvxeieJ8v2UDzdGe8dAy+RDMm1NGmN9bcL/T8MF
         ptgbuQD6BZZvgaTE9hJi14/Xh8XBIxKtxTFWLBFrfkbIMtRqTWnT549JfqRLYYk99uSz
         cTj5Ewg6fU/DJ4+q5hpTfC/9qr3yDVDLIHi/0OWH20tu08ckuGAdFhxd3jRqQi8NAVeu
         ko2due/sAglxn/fsbLjkUHsNTTRd8mn7LBXqq+PKNxzRTw43sOg6QRxfEtTZ0IB9YrQY
         cZgcw0sipXiy+GmtwyJdDtlDNnyeTlO6bfsoiqgottpKcgcrDJuNdOSe/KzZzZ05vczM
         k7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFVdhq/r7pIVx9grb41uXODJ84vqsahqMSF70l6XNds=;
        b=X6SMxoBv0o+7OA/HVY8wJmtpwXSmRu9Knts5k0oNpdPC3R2sYIzFUp0nXwGMVnlChL
         K0JUBAlyEhiVRBTEQqeUvGSLDUqqnG/+GQZ9It2Fm+HyjiKwKyTQL3kfPyLDAlfAc9Wu
         LlZVtbfFnjnB5uDGu+3kq5dwOPNRpDgs/l/pdr0K3igkkDYPPvtYawikD5z3c95nUGs9
         0JG95BkHuoRW057A4fNNpNIISTdg9xxEedYlPNHz7VDYj9WkIeTP3FHs/HXgmslDJsTw
         1c8dUo2+oFXh9uKsRm8e6azCb31a57N/aKdF+B9HwpUvw/r/gCaVcT2RxFVvAGzonqJX
         uhzQ==
X-Gm-Message-State: APjAAAURSU2XWRqne6Sy4+XkDD2HzQzeJaWQs6iECqhcjOQzIMAqHufr
        Kyxx0UtM5VVh+jcWQrW1YX/mjzVA
X-Google-Smtp-Source: APXvYqwll1TIzKUMFWgBsh3zd3a1t8DjCGEQVqceCoKtEZ6N0edKAq8OR/kZUo8jXfBFCzhQsa/1BQ==
X-Received: by 2002:a25:ad52:: with SMTP id l18mr7465482ybe.375.1579993750006;
        Sat, 25 Jan 2020 15:09:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l39sm4455704ywk.36.2020.01.25.15.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 15:09:09 -0800 (PST)
Date:   Sat, 25 Jan 2020 15:09:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joshua.Scott@alliedtelesis.co.nz, Chris.Packham@alliedtelesis.co.nz
Subject: Re: [PATCH v5 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 doccumentation
Message-ID: <20200125230907.GA25337@roeck-us.net>
References: <20200123220533.2228-1-logan.shaw@alliedtelesis.co.nz>
 <20200123220533.2228-3-logan.shaw@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123220533.2228-3-logan.shaw@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 11:05:33AM +1300, Logan Shaw wrote:
> Added a new file documenting the adt7475 devicetree and added the four
> new properties to it.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>

Subject: s/doccumentation/documentation/

Guenter

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
> +    description: |
> +      Configures bypassing the individual voltage input
> +      attenuator, on in0. This is supported on the ADT7476 and ADT7490.
> +      If set to a non-zero integer the attenuator is bypassed, if set to
> +      zero the attenuator is not bypassed. If the property is absent then
> +      the config register is not modified.
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
