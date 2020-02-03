Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB6C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6E520658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="NeBaOOmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRJSVjHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBCIbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:31:55 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50399 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgBCIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:31:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F91B3AF2;
        Mon,  3 Feb 2020 03:31:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Feb 2020 03:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=OmLQiTU7CIJEgfH4BB0wpQ3U+xt
        6/6j/9KiOYhlqIRI=; b=NeBaOOmMgJ9dMRzU9MQWb7FnVH2O1iR3oWG3dIkQNHr
        0VR1nWZ+Kp0r4TW9ohHc0xfq0itNqE9ySjyuiTkB3UYvEs8bzblFdIkgGGM4xMs6
        2iyaqjLIMf0+YnsDehiPvbTBMdO8wbQan0IJM8Ed6m46Eaf0u0901yKe3q/FWWHY
        u5oo6mCjIiJetYEaFqaJFb/pHUbNtdAfLKdClmB+Q9d8kxhIopLQde2+Am3vTlPn
        SKFxRjjiSWKaukgmqtDtuVNH2yDN/ak81PYJvdeXOGUx37pTHrFwkcsPKnlGYpUt
        IaEQLlREdQh/Wvu+DbnNO6CR60T2oLkbYP6uddpg3XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OmLQiT
        U7CIJEgfH4BB0wpQ3U+xt6/6j/9KiOYhlqIRI=; b=uRJSVjHMbnfxpTHFBeSXO6
        /MM5JJ0f+DFb7XObhwADxy0P8yWHENTV7pjn2gw9ixtpARHAzb3YU+1nRGQcpZil
        DvNbSJJFs5pXHKRuCJqyXS9rGHT5ihlWM704Y6Cn6CHgxXUAifYgZjvqIm/5kE1z
        s3dkrFIP0x39LQqlBQrh0mv/3WqXSqt0gfwyNkThecc6IrGIDXkSp6JOjfoyshgO
        MjM0ym3Uoo7rk55W3II5pTKTgcv6HyzG9URWd01t+Z3V0gl6pSnI1019IPI4azVL
        ekVO73tGTyUYMlCbqRAHVsClnrtpTYEyctomSTUikkrfoi8sW8S62+sV6fp16GsQ
        ==
X-ME-Sender: <xms:eNo3XnYvH8QHn9S7Z_7jd3m1xpbcaOQ02zwQMGc9Eq50xSoakXKamw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:eNo3XugKssXinG4YxJDa03RwjmEGDZYbLD3-vd0NB8kaFj-fMOdl9A>
    <xmx:eNo3XpciFCpgMIo921RcMDgOEE12ZCl5HvVF-ROCj5LHK2p824V7Xg>
    <xmx:eNo3XtniRCmBDq_aH8FLq89JKsot7iokNR-pB5mJoJ55Q0OZO7EMOA>
    <xmx:edo3XhZ0wx7z1uH6IVv0Vf2cVJhJcRCc6o9xr7dEfGigKDfauvt7EA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BBF1328005A;
        Mon,  3 Feb 2020 03:31:52 -0500 (EST)
Date:   Mon, 3 Feb 2020 09:31:51 +0100
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
Subject: Re: [PATCH 08/12] dt-bindings: arm: bcm: Convert BCM4708 to YAML
Message-ID: <20200203083151.ghg57pgjlci4y7in@gilmour.lan>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-9-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202211827.27682-9-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 02, 2020 at 01:18:23PM -0800, Florian Fainelli wrote:
> Update the Broadcom BCM4708 SoC family binding document for boards/SoCs
> to use YAML. Verified with dt_binding_check and dtbs_check.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,bcm4708.txt         | 15 ----
>  .../bindings/arm/bcm/brcm,bcm4708.yaml        | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> deleted file mode 100644
> index 8608a776caa7..000000000000
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Broadcom BCM4708 device tree bindings
> --------------------------------------------
> -
> -Boards with the BCM4708 SoC shall have the following properties:
> -
> -Required root node property:
> -
> -bcm4708
> -compatible = "brcm,bcm4708";
> -
> -bcm4709
> -compatible = "brcm,bcm4709";
> -
> -bcm53012
> -compatible = "brcm,bcm53012";
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
> new file mode 100644
> index 000000000000..d48313c7ae45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm4708.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM4708 device tree bindings
> +
> +description:
> +  Broadcom BCM4708/47081/4709/47094/53012 Wi-Fi/network SoCs based
> +  on the iProc architecture (Northstar).
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +  - Hauke Mehrtens <hauke@hauke-m.de>
> +  - Rafal Milecki <zajec5@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: BCM4708 based boards
> +        items:
> +          - enum:
> +              - asus,rt-ac56u
> +              - asus,rt-ac68u
> +              - buffalo,wzr-1750dhp
> +              - linksys,ea6300-v1
> +              - linksys,ea6500-v2
> +              - luxul,xap-1510v1
> +              - luxul,xwc-1000
> +              - netgear,r6250v1
> +              - netgear,r6300v2
> +              - smartrg,sr400ac
> +              - brcm,bcm94708
> +          - const: brcm,bcm4708

I'm under the impression that while the SoC compatible description in
your other bindings is obvious enough, if anything, you should have a
description of the boards. But it's up to you :)

Maxime
