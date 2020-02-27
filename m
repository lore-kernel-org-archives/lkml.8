Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A50C4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fotHPoKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgB0B67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:58:59 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:49499 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgB0B66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:58:58 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 01R1wrhO007970;
        Thu, 27 Feb 2020 10:58:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01R1wrhO007970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582768734;
        bh=f0RtcMm91pUvRhf0tWvY0RBgrv1rYufzVOjyf6MfCfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fotHPoKlYAO5kpyEqqKLQOXS4F/trfYkFriNsEWjC86UpYW6cQasCHv2DFLLr1D0J
         H7orBEvT3m+1md0mVNi8XrLewttMhYJ0XAV7schvaPn4q0//2tvN3lF/jzee8DsVJp
         H3dvA8ewfQDfOm1iKOzIjECi2kuBadKwrrZ/iBcYx/5j4yDxBpQDRWdqHBNjnc8M+Z
         dir83QBiVumV71W01EbLyqnTiAnaDLZ09EOmNYQbrYv6IKpDgO1tXQgVe4V5fecItU
         RXehyFhUWWVHMYjmUzUduwaa2PVppj4rF3ld9qZZZZgrdPCXU7kwsnbN1onAvDvJyS
         9wamCJyToPgqA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id n27so841634vsa.0;
        Wed, 26 Feb 2020 17:58:54 -0800 (PST)
X-Gm-Message-State: APjAAAWMlOrgox3Pwt1leB+LY97Y8u2BE474V94Vvmqr34dLT42XJueG
        tNhI0N6hfBL0inFhDS0fEvj3Mx2lDC64hjIR6nU=
X-Google-Smtp-Source: APXvYqxS/NpYKxdzB2PqcLVxTMrbA3ernXND+XDm0KOzE5cfpSGY5b+4SUxf9m2c26wWKmdvddCFLKtYmXd2gSO7fhk=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr1183258vsh.179.1582768733281;
 Wed, 26 Feb 2020 17:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20200222141927.3868-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200222141927.3868-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 27 Feb 2020 10:58:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmzYzK_A4iF6b-LxTT-o5Ut2=TyBeRQPSfCdj7FHhgBQ@mail.gmail.com>
Message-ID: <CAK7LNAQmzYzK_A4iF6b-LxTT-o5Ut2=TyBeRQPSfCdj7FHhgBQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Convert Denali NAND controller to json-schema
To:     Rob Herring <robh+dt@kernel.org>, DTML <devicetree@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


This was applied, but I just noticed one stupid mistake.



On Sat, Feb 22, 2020 at 11:20 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Convert the Denali NAND controller binding to DT schema format.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  .../devicetree/bindings/mtd/denali,nand.yaml  | 149 ++++++++++++++++++
>  .../devicetree/bindings/mtd/denali-nand.txt   |  61 -------
>  2 files changed, 149 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/denali,nand.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/denali-nand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/denali,nand.yaml b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
> new file mode 100644
> index 000000000000..b41b7e4bfe78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/denali,nand.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/denali,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Denali NAND controller
> +
> +maintainers:
> +  - Masahiro Yamada <yamada.masahiro@socionext.com>
> +
> +properties:
> +  compatible:
> +    description: version 2.91, 3.1, 3.1.1, respectively


Please delete this description.

This is a copy-paste mistake, which
came from my other patch
"dt-bindings: mmc: Convert UniPhier SD controller to json-schema"




> +    enum:
> +      - altr,socfpga-denali-nand
> +      - socionext,uniphier-denali-nand-v5a
> +      - socionext,uniphier-denali-nand-v5b
> +




-- 
Best Regards
Masahiro Yamada
