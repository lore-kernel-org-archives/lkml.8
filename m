Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF00C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44D720767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584572135;
	bh=uTyNAhR02/lueaTrSpsEtzvYiAwF0pB5xc/FKKpl73o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q+wu4H6IuNjTpV7oyeKPOPuaPJ652yvKaTZvnb7OsaWE2IUQoIl0eHvTp5sQwIILw
	 Z+mNLhCT88bcYYM8gUtAnI3t8kkQ8J42QZc4sY/Oaoa0PbZJh8bwY9qKthQg6PJpSy
	 JH+Od4hOppUyGolqCixltU7Mw4e7hZTEtUvTl3WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCRWze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgCRWze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:55:34 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB16620767;
        Wed, 18 Mar 2020 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584572133;
        bh=uTyNAhR02/lueaTrSpsEtzvYiAwF0pB5xc/FKKpl73o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ro+4MZPj8/lr9itNf5dBH8a0rGlg1/wfIPWd62qVHcJMz5O10Y3Mue4fJROANWR2M
         d9Id+B6QYs3dyhoYst2vuOUd2TWEt+ABTNjT89wpllcLEIOsJgqknKRgSJf4HGNAhX
         +I2/h5ahnh8tO9lM4ZKnPS35fNMJ5ZBu0SkyHzks=
Received: by mail-qk1-f172.google.com with SMTP id z25so199267qkj.4;
        Wed, 18 Mar 2020 15:55:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ36jYfueqEy5UxYViMD1YiHbousaFRN8I7EmfobmxjrBDQLcRoq
        i/P/Y9JyL1JbOjNlXKxd+DR+D2i3Fspg7glRmQ==
X-Google-Smtp-Source: ADFU+vvCBiYODaoYfbldWLW9rUsXW8+xYy7ob9N5BeJKkvAFoqoJHOy2oWFdT1cWnjoHpZxefKYgPbVzCXJcCqWfkKI=
X-Received: by 2002:a37:393:: with SMTP id 141mr196155qkd.393.1584572131923;
 Wed, 18 Mar 2020 15:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200317163555.18107-1-jbx6244@gmail.com>
In-Reply-To: <20200317163555.18107-1-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Mar 2020 16:55:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0M1n7M1EjnJhum9Sn30FEb3ux4agJSa1KhNwUxv4THg@mail.gmail.com>
Message-ID: <CAL_Jsq+0M1n7M1EjnJhum9Sn30FEb3ux4agJSa1KhNwUxv4THg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: sram: convert rockchip-pmu-sram
 bindings to yaml
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:36 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Current dts files with 'rockchip-pmu-sram' compatible nodes
> are manually verified. In order to automate this process
> rockchip-pmu-sram.txt has to be converted to yaml.
>
> A check with the command below gives for example this error:
>
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
> compatible:0:
> 'rockchip,rk3288-pmu-sram' was expected
> arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff700000:
> compatible:
> ['mmio-sram'] is too short
>
> Fix this error by adding an extra 'mmio-sram' compatible and
> 'if then' structure to filter yaml warnings.

Seems to me you should fix the .dts file. If we adjust schemas to make
dts files pass, then what is the point of the schemas?

> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/
> rockchip-pmu-sram.yaml

Until recent changes in linux-next now, this is not sufficient as all
examples are not checked against all schemas.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/sram/rockchip-pmu-sram.txt | 16 --------
>  .../bindings/sram/rockchip-pmu-sram.yaml           | 46 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
>
> diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> deleted file mode 100644
> index 6b42fda30..000000000
> --- a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Rockchip SRAM for pmu:
> -------------------------------
> -
> -The sram of pmu is used to store the function of resume from maskrom(the 1st
> -level loader). This is a common use of the "pmu-sram" because it keeps power
> -even in low power states in the system.
> -
> -Required node properties:
> -- compatible : should be "rockchip,rk3288-pmu-sram"
> -- reg : physical base address and the size of the registers window
> -
> -Example:
> -       sram@ff720000 {
> -               compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
> -               reg = <0xff720000 0x1000>;
> -       };
> diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
> new file mode 100644
> index 000000000..bb72e4f53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/rockchip-pmu-sram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SRAM for pmu
> +
> +description:
> +  The sram of pmu is used to store the function of resume from maskrom(the 1st
> +  level loader). This is a common use of the "pmu-sram" because it keeps power
> +  even in low power states in the system.
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +# The extra 'mmio-sram' compatible and 'if then' structure is needed
> +# to filter yaml warnings.
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mmio-sram
> +      - items:
> +        - const: rockchip,rk3288-pmu-sram

We've been just adding the compatibles to the common sram.yaml for the
simple cases like this.


> +        - const: mmio-sram
> +
> +  reg:
> +    maxItems: 1
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: rockchip,rk3288-pmu-sram
> +
> +then:
> +  required:
> +    - compatible
> +    - reg
> +
> +examples:
> +  - |
> +    pmu_sram: sram@ff720000 {
> +      compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
> +      reg = <0xff720000 0x1000>;
> +    };
> --
> 2.11.0
>
