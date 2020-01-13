Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCAC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C052222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578934630;
	bh=20et0LeLmZcC7OKy7vKwN9+K/OlCrNBAUQXGF/uI4Ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xLcPSmsJr+QucSukJc3jsf0AsNcUhhPbTTOEuwleb8SmLtA5A6mZaPNYO2VxNCi2B
	 NTXXTQRo/F4rlz8/UEvhvoIexyY00LLUE9pVYbgsL7gPtIgIZO+3io8CIxKvbtzBxY
	 7l1Kb2jPIeAlnoqh1TY+Ju2Mp20efkUAeHZBbCxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgAMQ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:57:09 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9894321569;
        Mon, 13 Jan 2020 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578934627;
        bh=20et0LeLmZcC7OKy7vKwN9+K/OlCrNBAUQXGF/uI4Ag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=veBU+eKOUE5VGAUmt7sNuZhR1+9WkXvOzHOGSXdXg+/YtqYHJY2VT7k5klhydzHaq
         iuhX+Yv4NPz7Hy+qIjnmvpnUB0koPQuneDpJN7zSWUxFuU79fLv4bFuLQseP5WQcl9
         pd6t5FPqVo55UIfkdkarWRzLGHz0fGH7gtt8/tAc=
Received: by mail-qk1-f180.google.com with SMTP id c17so9116093qkg.7;
        Mon, 13 Jan 2020 08:57:07 -0800 (PST)
X-Gm-Message-State: APjAAAXYxIhihUyX1s1LmRZxO5rVMLwYEyMQMJG42pqiw6G3yRRDAY4u
        dSKzDDrAdv+veAsCNx5cpC3eOHm7TSsscPGn8w==
X-Google-Smtp-Source: APXvYqx0AU9Rs93kGIbdKP4WuIqx2HQeMHqGE1y+wqUojZ5zlZijSOTRfZHRaa0C2MdvTpIMqNAVwVf3+uFigUY3viw=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr17722883qkn.254.1578934626652;
 Mon, 13 Jan 2020 08:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20200109112548.23914-1-sravanhome@gmail.com> <20200109112548.23914-3-sravanhome@gmail.com>
In-Reply-To: <20200109112548.23914-3-sravanhome@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jan 2020 10:56:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4vTzyfAG2UWzzkhVkBSLDRPjdyDUFZJ9LrDmsFsQ1gA@mail.gmail.com>
Message-ID: <CAL_JsqJ4vTzyfAG2UWzzkhVkBSLDRPjdyDUFZJ9LrDmsFsQ1gA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: regulator: add document bindings for mpq7920
To:     Saravanan Sekar <sravanhome@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:26 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.

Mark, Please revert this. Not even close to valid schema and my
questions on v4 are unanswered.

>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mps,mpq7920.yaml       | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> new file mode 100644
> index 000000000000..598f3ea070c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mpq7920.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7920 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]{1,2}"
> +  compatible:
> +    enum:
> +      - mps,mpq7920
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> +
> +      mps,switch-freq:

This needs to be under 'properties'. Otherwise, everything below here
is just part of 'description'.

As I asked on v4, shouldn't this be a common property? Switching
frequency is a common property for switching regulators, right?

> +        description: |
> +          switching frequency must be one of following corresponding value
> +          1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
> +        $ref: "/schemas/types.yaml#/definitions/uint8"
> +        enum: [ 0, 1, 2, 3 ]
> +        default: 2
> +
> +      buck1:

This should be under 'patternProperties' as '^buck[1-4]$'. Then you
aren't duplicating a bunch of property schemas.

> +        type: object
> +        $ref: "regulator.yaml#"

Should be:

allOf:
  - $ref: regulator.yaml#

> +        description: |
> +          4.5A DC-DC step down converter
> +
> +        mps,buck-softstart:

Needs to be under 'properties'

> +           $ref: "/schemas/types.yaml#/definitions/uint8"
> +           enum: [ 0, 1, 2, 3 ]
> +           default: 1
> +           description: |
> +             defines the soft start time of this buck, must be one of the following
> +             corresponding values 150us, 300us, 610us, 920us
> +
> +         mps,buck-phase-delay:
> +           $ref: "/schemas/types.yaml#/definitions/uint8"
> +           enum: [ 0, 1, 2, 3 ]
> +           default: 0
> +           description: |
> +             defines the phase delay of this buck, must be one of the following
> +             corresponding values 0deg, 90deg, 180deg, 270deg
> +
> +         mps,buck-ovp-disable:
> +           type: boolean
> +           description: |
> +             disables over voltage protection of this buck

Seems like configurable over voltage protection would be a common
regulator property?

> +
> +      buck2:
> +        type: object
> +        $ref: "regulator.yaml#"
> +        description: |
> +          2.5A DC-DC step down converter
> +
> +        mps,buck-softstart:
> +          description: |
> +            defines the soft start time of this buck, must be one of the following
> +            corresponding values 150us, 300us, 610us, 920us
> +          $ref: "/schemas/types.yaml#/definitions/uint8"
> +          enum: [ 0, 1, 2, 3 ]
> +          default: 1
> +
> +        mps,buck-phase-delay:
> +          description: |
> +            defines the phase delay of this buck, must be one of the following
> +            corresponding values 0deg, 90deg, 180deg, 270deg
> +          $ref: "/schemas/types.yaml#/definitions/uint8"
> +          enum: [ 0, 1, 2, 3 ]
> +          default: 0
> +
> +        mps,buck-ovp-disable:
> +          description: |
> +            disables over voltage protection of this buck
> +          type: boolean
> +
> +      buck3:
> +        type: object
> +        $ref: "regulator.yaml#"
> +        description: |
> +          4.5A DC-DC step down converter
> +
> +        mps,buck-softstart:
> +           description: |
> +             defines the soft start time of this buck, must be one of the following
> +             corresponding values 150us, 300us, 610us, 920us
> +           $ref: "/schemas/types.yaml#/definitions/uint8"
> +           enum: [ 0, 1, 2, 3 ]
> +           default: 1
> +
> +         mps,buck-phase-delay:
> +           description: |
> +             defines the phase delay of this buck, must be one of the following
> +             corresponding values 0deg, 90deg, 180deg, 270deg
> +           $ref: "/schemas/types.yaml#/definitions/uint8"
> +           enum: [ 0, 1, 2, 3 ]
> +           default: 1
> +
> +         mps,buck-ovp-disable:
> +           description: |
> +             disables over voltage protection of this buck
> +           type: boolean
> +
> +      buck4:
> +        type: object
> +        $ref: "regulator.yaml#"
> +        description: |
> +          2.5A DC-DC step down converter
> +
> +        mps,buck-softstart:
> +          description: |
> +            defines the soft start time of this buck, must be one of the following
> +            corresponding values 150us, 300us, 610us, 920us
> +          $ref: "/schemas/types.yaml#/definitions/uint8"
> +          enum: [ 0, 1, 2, 3 ]
> +          default: 1
> +
> +        mps,buck-phase-delay:
> +          description: |
> +            defines the phase delay of this buck, must be one of the following
> +            corresponding values 0deg, 90deg, 180deg, 270deg
> +          $ref: "/schemas/types.yaml#/definitions/uint8"
> +          enum: [ 0, 1, 2, 3 ]
> +          default: 1
> +
> +        mps,buck-ovp-disable:
> +          description: |
> +            disables over voltage protection of this buck
> +          type: boolean
> +
> +      ldortc:

Again, make this a pattern.

> +        $ref: "regulator.yaml#"
> +        description: |
> +          regulator with 0.65V-3.5875V for RTC, always enabled
> +
> +      ldo2:
> +        $ref: "regulator.yaml#"
> +        description: |
> +          regulator with 0.65V-3.5875V
> +
> +      ldo3:
> +        $ref: "regulator.yaml#"
> +        description: |
> +          regulator with 0.65V-3.5875V
> +
> +      ldo4:
> +        $ref: "regulator.yaml#"
> +        description: |
> +          regulator with 0.65V-3.5875V
> +
> +      ldo5:
> +        $ref: "regulator.yaml#"
> +        description: |
> +          regulator with 0.65V-3.5875V

You need 'required' here listing compatible, reg, and regulators.

And then 'additionalProperties: false'

> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@69 {
> +          compatible = "mps,mpq7920";
> +          reg = <0x69>;
> +
> +          regulators {
> +            mps,switch-freq = <1>;
> +
> +            buck1 {
> +             regulator-name = "buck1";
> +             regulator-min-microvolt = <400000>;
> +             regulator-max-microvolt = <3587500>;
> +             regulator-min-microamp  = <460000>;
> +             regulator-max-microamp  = <7600000>;
> +             regulator-boot-on;
> +             mps,buck-ovp-disable;
> +             mps,buck-phase-delay = <2>;
> +             mps,buck-softstart = <1>;
> +            };
> +
> +            ldo2 {
> +             regulator-name = "ldo2";
> +             regulator-min-microvolt = <650000>;
> +             regulator-max-microvolt = <3587500>;
> +            };
> +         };
> +       };
> +     };
> +...
> --
> 2.17.1
>
