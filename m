Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA1C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587FB222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580731981;
	bh=PIUYv7Nci9uIDycGf7Rt7wbN2vVY9wOsRUk/DoeB320=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bic9Phq41dlcH6/+qVz0KPWqtRraxDDQa4na9tnWYvI3fiP3fs8ridExPULlmCcHD
	 EXq5mcvLyoOLG4YPdZo5RYqcwmRlltGLU1fcWO3XsWn9CMEvbuEOVmaQVAXvcixIbM
	 U/8X8h2JWyqUwN91SM8yss2j6yNeYSCvRxGIwHGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgBCMNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:13:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBCMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:13:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so17723605wrd.9;
        Mon, 03 Feb 2020 04:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZ1XB3cL2d42Vdd8z9DnhNwtr2+wX5XMn+SoIlAejis=;
        b=gx3dVMq7kl4AV33UXfi9toXmxvn3Uc1BuHtQ2otMie8MPok9vjoSqcXushvtiSYSnG
         jJtmkAPbnw0byiT/tTwC8QP8AXYYU6cYOcxw2jwlLiK9NwbP2QGRWR65OlaS5fBIED4a
         8R/8G4AXdVWoY0y5+Ns6uAe1411vXQ7fGNaU+spJ6+mj7TcEhmMuFoazlvkirS4Rezsj
         kBBx2o3GJi9uNSR34Af8irMBKoasEKm4Ze6AuYvuc5eywgcL+bUl+V/jZeFLMZh4lmdB
         MOOMPLmfhoKtCAkNDOKei0IhwoW2PJ+706dNzgncRjBDc7xdFOtss9AkXgNXDv3EdZLy
         GYpQ==
X-Gm-Message-State: APjAAAV3swFRFoxQtb+fsKAhwQL23sGHiX/wFCRgv5fINTwWiR6+Slkx
        TGU02kb8pNtz9Wf4vrU+r1UgfaRjrA==
X-Google-Smtp-Source: APXvYqxrP59nsdYDVnELO7VL9/LsEN2SLFf2qZcq19Z5iz0JroN/TPd2c/vDv06w/6lU6j68yAgZsA==
X-Received: by 2002:adf:b193:: with SMTP id q19mr15026212wra.78.1580731977905;
        Mon, 03 Feb 2020 04:12:57 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id u4sm300839wrt.37.2020.02.03.04.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:12:57 -0800 (PST)
Received: (nullmailer pid 7857 invoked by uid 1000);
        Mon, 03 Feb 2020 12:12:55 -0000
Date:   Mon, 3 Feb 2020 12:12:55 +0000
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: regulator: add document bindings for
 mp5416
Message-ID: <20200203121255.GA30513@bogus>
References: <20200122135958.13663-1-sravanhome@gmail.com>
 <20200122135958.13663-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122135958.13663-2-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:59:56PM +0100, Saravanan Sekar wrote:
> Add device tree binding information for mp5416 regulator driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mps,mp5416.yaml        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> new file mode 100644
> index 000000000000..702508e4267f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mp5416.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MP5416 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]{1,2}"

Needs a ^ and $.

> +  compatible:
> +    enum:
> +      - mps,mp5416
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    allOf:
> +      - $ref: regulator.yaml#

Does this node contain regulator properties?

> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4] and LDO[1-4]
> +
> +    patternProperties:
> +      "^buck[1-4]$":
> +        $ref: "regulator.yaml#"

Must be under 'allOf' or other constraints are ignored.

> +        type: object
> +
> +      "^ldo[1-4]$":
> +        $ref: "regulator.yaml#"
> +        type: object
> +
> +    additionalProperties: false
> +  additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@69 {
> +          compatible = "mps,mp5416";
> +          reg = <0x69>;
> +
> +          regulators {
> +
> +            buck1 {
> +             regulator-name = "buck1";
> +             regulator-min-microvolt = <600000>;
> +             regulator-max-microvolt = <2187500>;
> +             regulator-min-microamp  = <3800000>;
> +             regulator-max-microamp  = <6800000>;
> +             regulator-boot-on;
> +            };
> +
> +            ldo2 {
> +             regulator-name = "ldo2";
> +             regulator-min-microvolt = <800000>;
> +             regulator-max-microvolt = <3975000>;
> +            };
> +         };
> +       };
> +     };
> +...
> -- 
> 2.17.1
> 
