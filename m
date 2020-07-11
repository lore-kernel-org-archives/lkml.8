Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B16CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC2C206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYihtHLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgGKRkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgGKRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:40:12 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E0C08C5DD;
        Sat, 11 Jul 2020 10:40:12 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id g22so1922283vke.9;
        Sat, 11 Jul 2020 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYIE8uSxQydN9Hh4OnZixe7WYhGulKLL0ArcHWNV1/Q=;
        b=gYihtHLEN7XHfWdQr64bJC95ZbP0HEbrqhD5aNvATIDBdSisLylegV9e39OHptrtpW
         kLx3//DpHMwaHx4cuY3HfGa/hP7HO7rBiweZvdmgtNBHJVn984HswyeASHuWXxSFCwNC
         i6Z+bBEUq5q2r9n3lcFGBz3gi25uU5SneQjpZ2visq2wt/fOQt1d0vPPh78IHwhb6Adj
         mFvWCpOBe9EoeiK0Ote5qAAWPm5++HVkmxW7V/lMkDQpcQ/1vBQKPr7Ba9G5/Wf10hwN
         z05l/QKbGH6afdlmPiknMbJU+oOY9wwFFutkIuX8gIOGmPwUBFlgulWNPD/f6eOU6aOu
         0lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYIE8uSxQydN9Hh4OnZixe7WYhGulKLL0ArcHWNV1/Q=;
        b=Br4HC6Gm8RJM5l6bd2Sk41iiaqQC/GXl14M/6ez/4xxo3OhvFa569tIO9/DHMLcrIl
         WTLOikTt3U/M0bOMp1b9S/e5A9YrfxicALZN9d8hGRzm3SIz9IsBwzDgwOfTsx+aPXrP
         gjB70JEysugBl6Bf4sk8P8ZQh+66vEfD5YFD/qvu8RKPcl3WwzUR+GTMbdwmbMx3igMU
         mInfBaodKhJcmuE0ffyslNH1pU8Hep9uF2Ce+6TUZTSht99DQxWqyP0rAf6Fm2PtuTCL
         VCGKB7KtD5SWahYTvQMM66jFwCC9lsVaaVdkilHVwn3JkqCwHV6xgMaHG4sFhaMoh4Ob
         QTEA==
X-Gm-Message-State: AOAM532cgqeEhJbLTFTHKJGAOCZijEdF9f4FpljSQOPByJvsMozKO6X2
        uXoT7M/O7T/XBLdk3OhmN72c51ww/8XALvu1NIQ=
X-Google-Smtp-Source: ABdhPJz3Rrtvp1bF2Y2oR0nxkFbgMcYu6XA85Jf4OktHhaAlNmZ11+8EQa/RtmauBFIoV5y3ZHpa+fUY7RFf74Oovgo=
X-Received: by 2002:a1f:1889:: with SMTP id 131mr46426504vky.59.1594489211463;
 Sat, 11 Jul 2020 10:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200625004942epcas5p13b2b4303e42bdd00f203419cbf883177@epcas5p1.samsung.com>
 <20200625003025.11656-1-alim.akhtar@samsung.com>
In-Reply-To: <20200625003025.11656-1-alim.akhtar@samsung.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sat, 11 Jul 2020 23:09:35 +0530
Message-ID: <CAGOxZ51DAncpYPmF0Wi0p0si4PQxS_xDnOFGQTuOR6UMdPn6iA@mail.gmail.com>
Subject: Re: [RESEND PATCH v10] dt-bindings: ufs: Add bindings for Samsung ufs host
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     "robh+dt" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob
Can you please take this via your tree?


On Thu, Jun 25, 2020 at 6:20 AM Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
> This patch adds DT bindings for Samsung ufs hci
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>
> Hi Rob
> This is just a rebase on your's dt/next
>
> This patch was part of [1]
> [1] https://lkml.org/lkml/2020/5/27/1697
>
>  .../bindings/ufs/samsung,exynos-ufs.yaml      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
>
> diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> new file mode 100644
> index 000000000000..38193975c9f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ufs/samsung,exynos-ufs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series UFS host controller Device Tree Bindings
> +
> +maintainers:
> +  - Alim Akhtar <alim.akhtar@samsung.com>
> +
> +description: |
> +  Each Samsung UFS host controller instance should have its own node.
> +  This binding define Samsung specific binding other then what is used
> +  in the common ufshcd bindings
> +  [1] Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +
> +properties:
> +
> +  compatible:
> +    enum:
> +      - samsung,exynos7-ufs
> +
> +  reg:
> +    items:
> +     - description: HCI register
> +     - description: vendor specific register
> +     - description: unipro register
> +     - description: UFS protector register
> +
> +  reg-names:
> +    items:
> +      - const: hci
> +      - const: vs_hci
> +      - const: unipro
> +      - const: ufsp
> +
> +  clocks:
> +    items:
> +      - description: ufs link core clock
> +      - description: unipro main clock
> +
> +  clock-names:
> +    items:
> +      - const: core_clk
> +      - const: sclk_unipro_main
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: ufs-phy
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - phys
> +  - phy-names
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/exynos7-clk.h>
> +
> +    ufs: ufs@15570000 {
> +       compatible = "samsung,exynos7-ufs";
> +       reg = <0x15570000 0x100>,
> +             <0x15570100 0x100>,
> +             <0x15571000 0x200>,
> +             <0x15572000 0x300>;
> +       reg-names = "hci", "vs_hci", "unipro", "ufsp";
> +       interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clock_fsys1 ACLK_UFS20_LINK>,
> +                <&clock_fsys1 SCLK_UFSUNIPRO20_USER>;
> +       clock-names = "core_clk", "sclk_unipro_main";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
> +       phys = <&ufs_phy>;
> +       phy-names = "ufs-phy";
> +    };
> +...
>
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> prerequisite-patch-id: e0425bbe8f2aff3882b728a0caf0218b6b3e9b6e
> prerequisite-patch-id: c8c8502c512f9d6fdaf7d30e54dde3e68c3d855b
> prerequisite-patch-id: 8505df2fd70632150b50543cadc6fd7dd42d191c
> prerequisite-patch-id: 1a9701ab83425940c8aacb76737edb57ab815e47
> prerequisite-patch-id: 7881e0b87f1f04f657d9e6d450fb5231ad6ffa1a
> prerequisite-patch-id: 01dbc0e550e3fcad6e525e7e3183f9f0312e8496
> prerequisite-patch-id: ad801812fff960abab3f27d2c7383be9fd9aa439
> prerequisite-patch-id: 65474c9540e6dc749d30223897de1f486d6b3843
> prerequisite-patch-id: 64b58cd4c5ecfacf28fc20c31a6617092a1e1931
> prerequisite-patch-id: 9bcdd2995fd3f6361f8d5e89c56645058ac9ff96
> --
> 2.17.1
>


-- 
Regards,
Alim
