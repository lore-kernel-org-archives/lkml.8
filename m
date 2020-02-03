Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20466C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB90F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Wc9ETG5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4SKOeja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgBCIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:30:31 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57603 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgBCIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:30:31 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D79996033;
        Mon,  3 Feb 2020 03:30:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Feb 2020 03:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=5/m6d79XqC9vih4B9gJzt6EMAAq
        GOFeC4/ftf/InF74=; b=Wc9ETG5YTTVqP2mH7AArIOvpsRa4oqCDhVFHQ7ndmrj
        OKrRHmubRX1ZmMydSFd9fExYLWMF4tIDSZniv5mPq2/Sg/c/XwE0cBIIEd+64q/y
        7KFsjiCkSHFZEvDLa/q07IEDfFgHsr4RQ1GBWlyZ1oH3f1ED6OfDaCstbEm0WiMJ
        Q9BOtnSjJbqsAeuIBS2kAmL9tDfejt4Z+Uwiyf8KuVZ5l6G/S39wvYQPt+I4Bin+
        bjRNpd959xj7SmCVtN74hV7K1yivbwLnXSY2av8M9fzAE8wN1X3dwIUAuuhu9V6q
        OOyBBJgwXJhJFIzSdsdmkkBRaGVQKrlnSqamjRaaxrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5/m6d7
        9XqC9vih4B9gJzt6EMAAqGOFeC4/ftf/InF74=; b=e4SKOejaPuaElhEpZzf++6
        tDS39Yw9YlE9M0swTTtiAzAZYV2O16wAUWOHfCcZ5iBPANuAbsCE9wXZGqbQzFEc
        tDZj9vE7wU9+hlcqwuIkGCf4KHEz4pqi8LRnu8q69vmUFKy297Yf0sLPcJ1Bx5GT
        AwM3sW+dQTa8oFQN/ww3882DVFmnethZs9y9eDWmFTTm5gK5aFzCWrGUU0d9h22F
        ZsIbA/z/nLkQe2H6fay5UYhWt68bpoRoAnSJMJ4mNfk05Mw28pMT/GjDlRNbP1Pl
        u5JUUEIE6QNu41CfXs9t4/nohlyZ4hqrHKw4KvK/7cb1j/QrdW+h0FD8SvaSkxfQ
        ==
X-ME-Sender: <xms:Jdo3Xnu3y5Y5o6vYrJgS19KaqK89UoLXaf3jDvhyym23lzAiPxbUaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Jdo3XsuWHqy773o6GtBS5pRDDCsUHiroq-gm6Lcw5OnaXKCFkiAugg>
    <xmx:Jdo3XlyDT5P_uAaHslnEJvHh2391qPtgmNwsfJnQCE-8gOmH2y9-Fg>
    <xmx:Jdo3XqifrhjYa6UGH3hnidOFRzXW_6BNEWNF9R1N1AdjoN1RR98Z8w>
    <xmx:Jdo3XiWkI3DmgL0L1mvDLKDHpLzMLYlgY1DhKmd77sTnPU8k3am_Jg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 700D13060134;
        Mon,  3 Feb 2020 03:30:29 -0500 (EST)
Date:   Mon, 3 Feb 2020 09:30:27 +0100
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
Subject: Re: [PATCH 06/12] dt-bindings: arm: bcm: Convert BCM21664 to YAML
Message-ID: <20200203083027.gdlrv7vcv5hir3g7@gilmour.lan>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202211827.27682-7-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2020 at 01:18:21PM -0800, Florian Fainelli wrote:
> Update the Broadcom BCM21664 SoC binding document for boards/SoCs to use
> YAML. Verified with dt_binding_check and dtbs_check.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 ------------
>  .../bindings/arm/bcm/brcm,bcm21664.yaml       | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
> deleted file mode 100644
> index e0774255e1a6..000000000000
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Broadcom BCM21664 device tree bindings
> ---------------------------------------
> -
> -This document describes the device tree bindings for boards with the BCM21664
> -SoC.
> -
> -Required root node property:
> -  - compatible: brcm,bcm21664
> -
> -Example:
> -	/ {
> -		model = "BCM21664 SoC";
> -		compatible = "brcm,bcm21664";
> -		[...]
> -	}
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
> new file mode 100644
> index 000000000000..8a38a6b68f60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm21664.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM21664 device tree bindings
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: BCM21664 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm21664-garnet
> +          - const: brcm,bcm21664

Do you really need the oneOf here?

Maxime
