Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D4CC4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="yus4oUi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DX+HCmNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBZS0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:26:40 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35621 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgBZS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:26:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 173AE632B;
        Wed, 26 Feb 2020 13:26:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 13:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZbZ/0vhYA4XlNPugmzBODvVTf7d
        FFmG6XFvRhLGolH0=; b=yus4oUi+lbkU/lwNVE6TDX8ieDC9TVA8FpmVnBLt1P+
        OsTic7vy/dVgroLf0b7OAAw/3lYFI0JZLxyXKu7pe7jy9a53tbxeLHS7ofYXZjSj
        bqC6ACh/4OIDfevHP8hALpBVaOXeOodHQlJ7TtAl4R1XR+ctVYlOHUyqMQybD3km
        2qTds6K4j9nSiE76euziI+tFHfyoTd8wnxd/g51L7zaW6GkKwDB1AHwpuUcd/AGJ
        fbHVmvHR1YqhILxII+4SAXQx8DGJ4YWAtWZETJ6Aqfvq2nhqp4wESGt1DRyKbJpC
        FT1FCadtbI0+s/wv69D78uhBxlYwwNMQnMdtNXNoUcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZbZ/0v
        hYA4XlNPugmzBODvVTf7dFFmG6XFvRhLGolH0=; b=DX+HCmNKsFq4u4w+m8e8a2
        pWcir14pq4oC4O5Ka5wRR++NEUXNyD3FecpR2Sk78ACaYzQWA4prgCw1rZcfPatq
        F+y/Ys1XbTvny6eD1G8ekbIiIMjgHc9TrywQp0IR6xmYbPnkCnF/7BeXy6rJ7vpN
        kWnkTTqFmnetTcuPDp1jMC4gvLcGDC6N5mgRKgAGHdIU0p22r5NhgZrfQ3Z0DMSq
        SP+WF8rW1mSXjISjNgbDOQPU0PczS78zlX5+XbAZwyYM8v+UrekV0/fJcr7pMtg/
        kZEelN1/g+jwW9KBCXHO8vzxHspT2TnFZ4UVeRyjnFUtzy4AQriw/ECN8pz/NKmg
        ==
X-ME-Sender: <xms:XrhWXuygDzA1L9tYgfTFHqWYh75TPmxGRloq7x-cbEAWZ7S0uOeoKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XrhWXg9eBwWqeIXp8Y3uxxVTcs-afyrSok5ktvFnYGwfFVzhpLS4RQ>
    <xmx:XrhWXkzbJlwj-TnoOTsGG_9OEsxcbb1ul6fLXUFBP_6Yrb-VYyrE_w>
    <xmx:XrhWXiv24Wo3K9LfBsgCj6CvBrni9YkKZ3BHJDEyK_1Oo4faKGmzRw>
    <xmx:X7hWXpY3l0pvbtwJdS0Aa8_zxgH_ji3YUaMVf-HyXXUiCrPj7Qiaww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A24E3280065;
        Wed, 26 Feb 2020 13:26:38 -0500 (EST)
Date:   Wed, 26 Feb 2020 19:26:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
        soc@kernel.org, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 08/13] dt-bindings: phy: Convert Calxeda ComboPHY binding
 to json-schema
Message-ID: <20200226182637.npnurwcexvpgwmvo@gilmour.lan>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="le2zpoj6qhgy5u3q"
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-9-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--le2zpoj6qhgy5u3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 06:08:56PM +0000, Andre Przywara wrote:
> Convert the Calxeda ComboPHY binding to DT schema format using
> json-schema.
> There is no driver in the Linux kernel matching the compatible
> string, but the nodes are parsed by the SATA driver, which links to them
> using its port-phys property.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/phy/calxeda-combophy.txt         | 17 -------
>  .../bindings/phy/calxeda-combophy.yaml        | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt b/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
> deleted file mode 100644
> index 6622bdb2e8bc..000000000000
> --- a/Documentation/devicetree/bindings/phy/calxeda-combophy.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Calxeda Highbank Combination Phys for SATA
> -
> -Properties:
> -- compatible : Should be "calxeda,hb-combophy"
> -- #phy-cells: Should be 1.
> -- reg : Address and size for Combination Phy registers.
> -- phydev: device ID for programming the combophy.
> -
> -Example:
> -
> -	combophy5: combo-phy@fff5d000 {
> -		compatible = "calxeda,hb-combophy";
> -		#phy-cells = <1>;
> -		reg = <0xfff5d000 0x1000>;
> -		phydev = <31>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
> new file mode 100644
> index 000000000000..2ef68b95fae1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/calxeda-combophy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda Highbank Combination PHYs binding for SATA
> +
> +description: |
> +  The Calxeda Combination PHYs connect the SoC to the internal fabric
> +  and to SATA connectors. The PHYs support multiple protocols (SATA,
> +  SGMII, PCIe) and can be assigned to different devices (SATA or XGMAC
> +  controller).
> +  Programming the PHYs is typically handled by those device drivers,
> +  not by a dedicated PHY driver.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    const: calxeda,hb-combophy
> +
> +  '#phy-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  phydev:
> +    description: device ID for programming the combophy.
> +    $ref: /schemas/types.yaml#/definitions/uint32

I guess you can limit the range here, or does it cover the whole u32
range?

Maxime

--le2zpoj6qhgy5u3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXla4XQAKCRDj7w1vZxhR
xcr0AP9Go6W67LY8iVw9+n5AaBx1stq75hwfJ7JhT21EiH7KngD+MDzNzsxx0KyP
E4dL+rbvbuh34GSh5uWm0X/T3hSjoQk=
=eJJp
-----END PGP SIGNATURE-----

--le2zpoj6qhgy5u3q--
