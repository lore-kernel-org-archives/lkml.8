Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93CC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D65924656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582123349;
	bh=W6+6Bdzc+nFCT886mpTg5D+WUTg1lRbfhrjBZeyUobE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xz4QnGZoMa07gPRv8nyIjT51mE4ienGJdMOmKAV81LNf7CywmhrRK0tkC9H2lNwit
	 uSQLT9b4pKbjh4kb9HC0vq5usTFqSCZkv1TbgtYp0CM3RFRkxjT/AM4oxBqAjBR3DI
	 2raRmPD2eGbKfdmoKLj/soBXjs2gjxH7aah9if8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:42:27 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CCA24670;
        Wed, 19 Feb 2020 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582123345;
        bh=W6+6Bdzc+nFCT886mpTg5D+WUTg1lRbfhrjBZeyUobE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q6rrVqsaEy4WbKAzVTNlyIzaA/gE/EoMQf2t1vl2fJV/icxRr0ChDvep4a0oNbtca
         FtY0mDoxZTS5pDIDl9DMyli8vSvitQDrhniTHcsOPdEWYxMr3LZcTDucO0pirhrZXG
         RQVligVJB37e34uiIzCtdy17JXnVGD/kF3X3PkKk=
Received: by mail-qk1-f169.google.com with SMTP id t83so319565qke.3;
        Wed, 19 Feb 2020 06:42:25 -0800 (PST)
X-Gm-Message-State: APjAAAW8FdecG5CwzOgpl2NogjDO1+3CsdOwzC8//+VrA1DxcS5DX89S
        GeN7WAo0esB+cgiSirQuPviNIEbGNjMq71CvoQ==
X-Google-Smtp-Source: APXvYqwYfr8dnraFyGLum8QvHjHJ5i96SXqZnFjZaUAL/1vsnkTAyj3uphUfKkrkPEoyfxE9+G+DWp1h98tCz7Zzo+8=
X-Received: by 2002:a37:6457:: with SMTP id y84mr24256558qkb.254.1582123344892;
 Wed, 19 Feb 2020 06:42:24 -0800 (PST)
MIME-Version: 1.0
References: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
In-Reply-To: <208fcb9660abd560aeab077442d158d84a3dddee.1582021248.git.eswara.kota@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Feb 2020 08:42:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL56Ucpm2FK4BPKS+N=5Zxn1iQht7OdJK1pE7cPxtWL-w@mail.gmail.com>
Message-ID: <CAL_JsqL56Ucpm2FK4BPKS+N=5Zxn1iQht7OdJK1pE7cPxtWL-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add YAML schemas for Intel Combophy
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 9:31 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Combophy subsystem provides PHY support to various
> controllers, viz. PCIe, SATA and EMAC.
> Adding YAML schemas for the same.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v2:
>
>  Add custom 'select'
>  Pass hardware instance entries with phandles and
>    remove cell-index and bid entries
>  Clock, register address space, are same for the children.
>    So move them to parent node.
>  Two PHY instances cannot run in different modes,
>    so move the phy-mode entry to parent node.
>  Add second child entry in the DT example.
>
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> new file mode 100644
> index 000000000000..8e65a2a71e7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Combophy Subsystem
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +description: |
> +  Intel Combophy subsystem supports PHYs for PCIe, EMAC and SATA
> +  controllers. A single Combophy provides two PHY instances.
> +
> +# We need a select here so we don't match all nodes with 'simple-bus'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: intel,combo-phy
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^combophy@[0-9]+$"

Unit addresses are hex.

> +
> +  compatible:
> +    items:
> +      - const: intel,combo-phy

Needs to be an SoC specific compatible.

> +      - const: simple-bus
> +
> +  clocks:
> +    description: |
> +      List of phandle and clock specifier pairs as listed
> +      in clock-names property. Configure the clocks according
> +      to the PHY mode.

How many?

No need to redefine a common property name, drop description. Plus,
where's clock-names?

> +
> +  reg:
> +    items:
> +      - description: ComboPhy core registers
> +      - description: PCIe app core control registers
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: app
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: core
> +
> +  intel,syscfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Chip configuration registers handle and ComboPhy instance id
> +
> +  intel,hsio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: HSIO registers handle and ComboPhy instance id on NOC
> +
> +  intel,aggregation:
> +    description: |
> +      Specify the flag to confiure ComboPHY in dual lane mode.
> +    type: boolean
> +
> +  intel,phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 2
> +    description: |
> +      Configure the mode of the PHY.
> +        0 - PCIe
> +        1 - xpcs
> +        2 - sata

Doesn't this need to be per PHY? Or the 2 PHYs have to be the same mode?

Use the types defined in include/dt-bindings/phy/phy.h. You'll need to
add XPCS which maybe should be more specific to distinguish 1G, 10G,
etc. Also, we typically put the mode into the 'phys' cells so the mode
lives with the client node.

> +
> +patternProperties:
> +  "^cb[0-9]phy@[0-9]+$":

^phy@...

> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: intel,phydev
> +
> +      "#phy-cells":
> +        const: 0
> +
> +      resets:
> +        description: |
> +          reset handle according to the PHY mode.
> +          See ../reset/reset.txt for details.
> +
> +    required:
> +      - compatible
> +      - "#phy-cells"
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - reg-names
> +  - intel,syscfg
> +  - intel,hsio
> +  - intel,phy-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    combophy@0 {
> +        compatible = "intel,combo-phy", "simple-bus";
> +        clocks = <&cgu0 1>;
> +        reg = <0xd0a00000 0x40000>,
> +              <0xd0a40000 0x1000>;
> +        reg-names = "core", "app";
> +        resets = <&rcu0 0x50 6>,
> +                <&rcu0 0x50 17>;
> +        reset-names = "phy", "core";
> +        intel,syscfg = <&sysconf 0>;
> +        intel,hsio = <&hsiol 0>;
> +        intel,phy-mode = <0>;
> +
> +        cb0phy0:cb0phy@0 {
> +            compatible = "intel,phydev";
> +            #phy-cells = <0>;
> +            resets = <&rcu0 0x50 23>;
> +        };
> +
> +        cb0phy1:cb0phy@1 {
> +            compatible = "intel,phydev";
> +            #phy-cells = <0>;
> +            resets = <&rcu0 0x50 24>;
> +        };
> +    };
> --
> 2.11.0
>
