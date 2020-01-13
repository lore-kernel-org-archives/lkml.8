Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899BEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A99214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578938169;
	bh=SU/yL4pLyTd6FCTcX3VLWcdVv5nD03+4yH4Gn1K77mU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1zzLuCt9mYN4OsyP3Wk6+OB7c73Yxei8Ty34CqR6N+a+Z7/XrcQXktxtKbprPq7Me
	 h5cH1vz1R4MbNIWYtDnjD2JKz7AQYq6qxmVXOcdKzwAwO8ZRFfJNbBUIOqdbDBN0Pk
	 9lfSgWybpG7Yp4JAus35MNVut1pwsYT3KoNtgkMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgAMR4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMR4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:56:08 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D9A21569;
        Mon, 13 Jan 2020 17:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578938167;
        bh=SU/yL4pLyTd6FCTcX3VLWcdVv5nD03+4yH4Gn1K77mU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PLYde4y2bGJJJSqjSp28CMxyE/62HH00mNmDovWYE373wikXmIJVqh12xb6obQTH/
         ojUTkMpUiXFF89UhRuhBGFgXfZI/FEnH/wUlUc5JS7b7EO4hzvBYWXpKxdcrfCmAcb
         bM3SMx4S7p/IqMXNipF93P56YUqiLtBDdVi1YwbI=
Received: by mail-qk1-f179.google.com with SMTP id c16so9318685qko.6;
        Mon, 13 Jan 2020 09:56:07 -0800 (PST)
X-Gm-Message-State: APjAAAXsZVFnyofhlo/LS8Y24SefdJHRoZkagvbhbx8XgmigbxeL0yki
        ArKt93kYZZcg2FEw3lxW8J7N8JqCcc9JEtVoKA==
X-Google-Smtp-Source: APXvYqxNb5K7LuU7cH7NsCfttliz8NZ07o3Ct6sem/fsX8V10HnCDnkMKpaC5zN8jUGtNlhbmoY0kqFe6vT0xkFRNFM=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr15965219qkl.119.1578938166297;
 Mon, 13 Jan 2020 09:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191217015658.23017-2-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20191217015658.23017-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jan 2020 11:55:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qcR=3y1TQ+qrbfNW=_3kJ92eZP5eYvGYgteYWHyDVPw@mail.gmail.com>
Message-ID: <CAL_Jsq+qcR=3y1TQ+qrbfNW=_3kJ92eZP5eYvGYgteYWHyDVPw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 7:57 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> new file mode 100644
> index 000000000000..ff7959c21af0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +description: |+
> +  Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
> +  node is used to reference the base address of eMMC phy registers.
> +
> +  The eMMC PHY node should be the child of a syscon node with the
> +  required property:
> +
> +  - compatible:         Should be one of the following:
> +                        "intel,lgm-syscon", "syscon"
> +  - reg:
> +      maxItems: 1
> +
> +properties:
> +  compatible:
> +      const: intel,lgm-emmc-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +
> +examples:
> +  - |
> +    sysconf: chiptop@e0200000 {
> +      compatible = "intel,lgm-syscon", "syscon";
> +      reg = <0xe0200000 0x100>;
> +
> +      emmc-phy: emmc-phy@a8 {

This fails in linux-next. Please run 'make dt_binding_check' and fix:

Error: Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.19-20
syntax error
FATAL ERROR: Unable to parse input tree

The problem is labels can't have '-'.

Rob
