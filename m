Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2565222B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230195;
	bh=cKFjaW06OuMzdfbriJFyPbGD4y3uj8s+6v5Yet5QtTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uA1PyYshr3IlXhYTOX31xAnkH7Qiw+7C0BlOo7h1lrjZk7Ba6xcyfVysTLJeETItQ
	 cAzsNupMhorlLH7/qU31yE4yhJOqVtHfxYSDRi7n6PkGft5PW1PwedhEC8lHv+FTeG
	 3gpg4oNww5QBDds196ZXq43wANUWr0zSoZ6Mua+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgGaVQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:16:33 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42483 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGaVQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:16:32 -0400
Received: by mail-il1-f193.google.com with SMTP id i138so20561041ild.9;
        Fri, 31 Jul 2020 14:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQO0uI+psydb/Ibemy47TzaYMTINL62/vJsws3Wfm3k=;
        b=sStFY759+Dpl9lBhUOkVl0UJcC/OFLZvJpRqViYMvsttbu9MbEEzObas5n6JWjGN5g
         ds0vikr9P8tlbSgFRgju6kF7m2eSp2JDtIS/TZkK9zVn5hzkCxmRxgZt9CEHtNEwM8Gf
         VTlNOs9tr2Qr+5PfHmh/BSxJVR9C9OBsbEIYFMXV4gT2CzAjiIyF827pbXZ9gBgWDrBe
         NMtwlm9/kD7WAOiTabRLogAP4Z17bXoZGxYBeKhiwZWPR3oSOU7vc+26J0G5rDt3BrUG
         66j3WMgeD28qESSpLxOTcnnVutCBDnyVZq1dCqqUnJE6VAzc1QpCtOWtRk8vXDUaaOF5
         SVVg==
X-Gm-Message-State: AOAM5331rsf4hZHUJwpDpQbYh03mo3XtIGMizl4Qv4eI5QGXm8GIqOX1
        JnW28soBSLZi4PxbGIU4Kw==
X-Google-Smtp-Source: ABdhPJxie779Cg4xpVQe/gw4yjHCxh1Hv06GT4YBFq8ZP9oLnLDKMLwpGbABhip+UNHh5bwYY7WZvg==
X-Received: by 2002:a92:b60a:: with SMTP id s10mr5527524ili.119.1596230191084;
        Fri, 31 Jul 2020 14:16:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x88sm5824648ilk.81.2020.07.31.14.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:16:30 -0700 (PDT)
Received: (nullmailer pid 805806 invoked by uid 1000);
        Fri, 31 Jul 2020 21:16:29 -0000
Date:   Fri, 31 Jul 2020 15:16:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: regulator: Convert sy8824x to json-schema
Message-ID: <20200731211629.GA801219@bogus>
References: <20200729125320.5521ed23@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729125320.5521ed23@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:53:20PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> Convert the sy8824x binding to DT schema format using json-schema.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> Since v1
>   -It seems there's something wrong with my last email, so send out a v2 with
>    another email account
> 
>  .../bindings/regulator/silergy,sy8824x.yaml   | 40 +++++++++++++++++++
>  .../devicetree/bindings/regulator/sy8824x.txt | 24 -----------
>  2 files changed, 40 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
> new file mode 100644
> index 000000000000..62a476c94111
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/silergy,sy8824x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: silergy sy8824c,sy8824e,sy20276 and sy20278 PMIC
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - silergy,sy8824c
> +      - silergy,sy8824e
> +      - silergy,sy20276
> +      - silergy,sy20278
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Needs a $ref to regulator.yaml and then:

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        regulator@60 {
> +          compatible = "silergy,sy8824c";
> +          regulator-min-microvolt = <800000>;
> +          regulator-max-microvolt = <1150000>;
> +          reg = <0x60>;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Documentation/devicetree/bindings/regulator/sy8824x.txt
> deleted file mode 100644
> index c5e95850c427..000000000000
> --- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -SY8824C/SY8824E/SY20276 Voltage regulator
> -
> -Required properties:
> -- compatible: Must be one of the following.
> -	"silergy,sy8824c"
> -	"silergy,sy8824e"
> -	"silergy,sy20276"
> -	"silergy,sy20278"
> -- reg: I2C slave address
> -
> -Any property defined as part of the core regulator binding, defined in
> -./regulator.txt, can also be used.
> -
> -Example:
> -
> -	vcore: regulator@00 {
> -		compatible = "silergy,sy8824c";
> -		reg = <0x66>;
> -		regulator-name = "vcore";
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1150000>;
> -		regulator-boot-on;
> -		regulator-always-on;
> -	};
> -- 
> 2.28.0.rc0
> 
> 
