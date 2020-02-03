Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857FC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB492082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="m1jlfJmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZ5egCBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBCI3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:29:44 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59251 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbgBCI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:29:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3AD526205;
        Mon,  3 Feb 2020 03:29:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Feb 2020 03:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=iQ/ikpIbJ5P9FgOE6AgwAzVNlDM
        fzKU2pcHWjtIVj7g=; b=m1jlfJmENyRlxcyCXEJE3uTVm7HqOR7ONRKBBv2Npf8
        XqrLBjKlVJv0nvC5+vr1MmqCeqaSndPDbcCWMEmBVSArIGLvU/I2ypC5mHo5QmRt
        aacqCgaxopKpFGekpgjNEuvori2LVXVI6xgKPbNoC8AU7Dnzg1bFCqEf0B6sxJZN
        E9MIUyO/F2vvqaJaTjb3qAQoxCEeM64Iv461Gkqr92c+OmnQzcblm6tYGW7a+UH3
        tYrrF6E9M7UAs1YghdYJiBCMs6wbSgZPN42vtELvFqdF0QBZs2Be/dhO2XN4qmze
        5+038c906DDj57qpsd/w4jg6uj57fM/xhzZgX9LXi5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iQ/ikp
        IbJ5P9FgOE6AgwAzVNlDMfzKU2pcHWjtIVj7g=; b=qZ5egCBpAwIljWiIEiZ4tG
        OzpEtWoIVt3Z3sumZKtm8rrbm404G7BZhHLgxRLx6xtPQbgKFdtWhvMXU769icZf
        i+SRuNVbabeWMxVIfHxjRQJPFQwi5Alxp86+Y2tC7gSoqfu6YLPQhEPGSP9SOF/w
        USIIcmBEjdc6ua1hDYoZiEq5qDaquob5cyDb9WbdxYjd/wGIr9kWMrmNCN5qkRhr
        CqDANzCnnEqZ4Oh/VLL6CCpzQT+hJ+3xUErCafGXElBn7Gk5zp/Gb0g1DvE2vlb2
        439VEPyt5/YEn8KZ8EnPrLj2lUeuMuqyPv5c6wNwafmxckjGuW5Q9nxb7nXLjAjQ
        ==
X-ME-Sender: <xms:9Nk3XglH6jGRQQrKr1X2zjCYT6pYqpYXDuIof0B2pzyZGKg37gKqRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9Nk3Xs9qUxHKSs4k81Jh4fD5IpqD3pNZFGhGcxiC7E7y-C-E7m2X_w>
    <xmx:9Nk3XvFbv-lGdOm0yRpEjg7Z_K1kpj9tFqecVNpuG9kET6x3QuViWA>
    <xmx:9Nk3XtksGs-4jPa7-57MCzbMNXkKpkDOlvnGnvBctC7fE-OHZd62Yw>
    <xmx:9tk3Xl1NgDdaOOyy4hB9U9I-oUhabl-kFXNyeFaxTHPziO0E4FvJfg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E5BA328005A;
        Mon,  3 Feb 2020 03:29:40 -0500 (EST)
Date:   Mon, 3 Feb 2020 09:29:38 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
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
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/12] dt-bindings: arm: bcm: Convert Cygnus to YAML
Message-ID: <20200203082938.hulyzd3klqq2xqz3@gilmour.lan>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202211827.27682-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sun, Feb 02, 2020 at 01:18:16PM -0800, Florian Fainelli wrote:
> Update the Broadocom Cygnus SoC binding document for boards/SoCs to use
> YAML. Verified with dt_binding_check and dtbs_check.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,cygnus.txt          | 31 ---------
>  .../bindings/arm/bcm/brcm,cygnus.yaml         | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
> deleted file mode 100644
> index 4c77169bb534..000000000000
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -Broadcom Cygnus device tree bindings
> -------------------------------------
> -
> -
> -Boards with Cygnus SoCs shall have the following properties:
> -
> -Required root node property:
> -
> -BCM11300
> -compatible = "brcm,bcm11300", "brcm,cygnus";
> -
> -BCM11320
> -compatible = "brcm,bcm11320", "brcm,cygnus";
> -
> -BCM11350
> -compatible = "brcm,bcm11350", "brcm,cygnus";
> -
> -BCM11360
> -compatible = "brcm,bcm11360", "brcm,cygnus";
> -
> -BCM58300
> -compatible = "brcm,bcm58300", "brcm,cygnus";
> -
> -BCM58302
> -compatible = "brcm,bcm58302", "brcm,cygnus";
> -
> -BCM58303
> -compatible = "brcm,bcm58303", "brcm,cygnus";
> -
> -BCM58305
> -compatible = "brcm,bcm58305", "brcm,cygnus";
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
> new file mode 100644
> index 000000000000..2606ca956caf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/brcm,cygnus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Cygnus device tree bindings
> +
> +maintainers:
> +   - Ray Jui <rjui@broadcom.com>
> +   - Scott Branden <sbranden@broadcom.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: BCM11300 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm11300
> +          - const: brcm,cygnus
> +
> +      - description: BCM11320 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm11320
> +          - const: brcm,cygnus

This applies to other patches in your series too, but this can be
simplified to either (removing the description to make the example
simpler):

oneOf:
  - items:
    - const: brcm,bcm11300
    - const: brcm,cygnus
  - items:
    - const: brcm,bcm11320
    - const: brcm,cygnus

Or

items:
  - enum:
    - brcm,bcm11300
    - brcm,bcm11320
  - const: brcm,cygnus

The latter will provide more meaningful errors, so you should probably
pick this one over the former.

Maxime
