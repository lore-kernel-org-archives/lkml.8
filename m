Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106CCC3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DEC206D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580679036;
	bh=VdLRZqk+H3Imny+gDyGky1KRiuixaXactoYWKmUoh0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tHXyGWek+wMW8mr/1I4TFSNCa1tuQkLP66N4ejr6EDIK0DVewfZQQGZ4dmoC6TbyY
	 BeOH5idoel+ukOkHaECuY75vJPVweq+Y23+xtsnXFNyvbwU9deCmYSZEDAxI8QfCYC
	 pSxn+So65VM3OcCtOwK1luciBE/WERkJ3r283hXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBBVag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBVaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:30:35 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2233206D3;
        Sun,  2 Feb 2020 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580679035;
        bh=VdLRZqk+H3Imny+gDyGky1KRiuixaXactoYWKmUoh0k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l8A0C0boYECZuWi3ryOaAWOo7tY5wsYjR1HQs2PalQtNLCujhArePN57Z8RR9tOkN
         mLMCmWNaNoPwSmPHXDSX52r3b6biDPr0+IuIStzPAaN9bhCGiTEgqTTruf1yFA94+C
         Dv6pJCnrS/Wx+KZG9gpN1Fw/jbiLh9gi3sef5IH8=
Received: by mail-qv1-f43.google.com with SMTP id g6so5930617qvy.5;
        Sun, 02 Feb 2020 13:30:34 -0800 (PST)
X-Gm-Message-State: APjAAAUwsO49H4vmgFIfasWT5O8IKPHhd1XOmCNCd1WyOKD221tpx5Bp
        PXyHM0kbtJw6iiVBbAKqCcj0zJjwhcP5G9XMTA==
X-Google-Smtp-Source: APXvYqx1g5mqdVF98VrntlFMyPTLWRw5bRqj5c9aFp97VOvISBeqahu7q9Dw2HqrEwhBmqSByPbrJtBbgAmwZhOSOrs=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr19826919qvn.79.1580679033968;
 Sun, 02 Feb 2020 13:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20200202211827.27682-1-f.fainelli@gmail.com> <20200202211827.27682-11-f.fainelli@gmail.com>
In-Reply-To: <20200202211827.27682-11-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 2 Feb 2020 21:30:20 +0000
X-Gmail-Original-Message-ID: <CAL_JsqJDoOFQTRDAeugcv6vPaM6qRbJ5B3-pjZZC+nn=q-ex6Q@mail.gmail.com>
Message-ID: <CAL_JsqJDoOFQTRDAeugcv6vPaM6qRbJ5B3-pjZZC+nn=q-ex6Q@mail.gmail.com>
Subject: Re: [PATCH 10/12] dt-bindings: arm: bcm: Convert Vulcan to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 9:19 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Update Vulcan SoC family binding document for boards/SoCs to use YAML.
> Verified with dt_binding_check and dtbs_check.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 --------
>  .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 24 +++++++++++++++++++
>  2 files changed, 24 insertions(+), 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
> deleted file mode 100644
> index 223ed3471c08..000000000000
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Broadcom Vulcan device tree bindings
> -------------------------------------
> -
> -Boards with Broadcom Vulcan shall have the following root property:
> -
> -Broadcom Vulcan Evaluation Board:
> -  compatible = "brcm,vulcan-eval", "brcm,vulcan-soc";
> -
> -Generic Vulcan board:
> -  compatible = "brcm,vulcan-soc";
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
> new file mode 100644
> index 000000000000..0bfb45457150
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/brcm,vulcan-soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Vulcan device tree bindings
> +
> +maintainers:
> +  - Robert Richter <rrichter@marvell.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Northstar2 based boards

Copy-n-paste?

> +        items:
> +          - enum:
> +              - brcm,vulcan-eval
> +              - cavium,thunderx2-cn9900
> +          - const: brcm,vulcan-soc
> +
> +...
> --
> 2.17.1
>
