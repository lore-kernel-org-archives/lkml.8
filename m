Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB55C4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1962824653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="n/kISbox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vcamGQh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBZS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:26:10 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60009 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgBZS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:26:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 132AC635E;
        Wed, 26 Feb 2020 13:26:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 13:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wnBprZHEG6nDIJqLZgAkT38k3aJ
        pvMwHLopX0q+7CUg=; b=n/kISboxwF8u4JH1yfzpU3qPWpiQy3X9QdS7nOC0kcW
        nsaGntcXO9cW+32GWIZEKVE9EgoLdC41AIy22JSq6wW5oET0Zz4hT0J5JPk81gmr
        D3Q1Lsep5g5h5C/0Cc+TWrVZ88KkYqczgvGhCW5QXdJAS1bMPB15s+gBS0SA4vv9
        NY0GK85Yu7FkaEXP+nD2EORa69DIZdMvKSDJjIOrg41T428tUfanfC0Ol/e2XbGQ
        x0hbvJ4CI+eyu8Gl8QaCcf9fAUYzrgjdNcyog3uAQKBoXY3fJjhSI1ywSvVGapeq
        4eDCDY/q5tQMHdxS04AWObHQBsLqVb0OrT5mkRbg8VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wnBprZ
        HEG6nDIJqLZgAkT38k3aJpvMwHLopX0q+7CUg=; b=vcamGQh3L/P2Oyds4b0Pn7
        90RlsUqvPBMPLrPPI9y0i3XTF0iSHW5HrgaE9JT79QW2GnFQGrmBHSIRoap9e7Wu
        fNhMWgjxbBnNj3QoefB1hv/xN1HywCo6wTPs7ML5Kig0l9iH41Vk5q8CGJ8tIlEq
        2+b0LtAHoCAbMj8pPxVuDPWbTwBWCRiEJqNyLEEE9G67WYuoQ5slVQk2b5nkl0Hu
        ccLWyAjLkiKLpgsEgyQVghvxLyhGx8DlyLwwNY8C4EsMBIF0N86wfIamPOvqed6n
        mNAF4r95Bx3WW9YhleFj+DjWsaSyXrUz+hoMWKEt2dNxAQqWunOEjTc72anaRLdA
        ==
X-ME-Sender: <xms:QLhWXji2o-u8iuK74SngV0QTBOImU4Hr5otLSF9ebnnyjXTWdir2LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QLhWXtbcikz4tBc8w7mElocDtfPbINR723WthFGoElvYmaeRgnJ_mg>
    <xmx:QLhWXvE_sldPnxbCWdr_sLdlUI2n0LN9QaCxpd65iT7VIGf_uDhKxw>
    <xmx:QLhWXj9CTg57QYLVhu5LBnCQpZRZ7iDposufgz85lYMhfEVkQu5rBg>
    <xmx:QbhWXjyNud6zg69_zGzOxBNkOb0gPNoqcDhScX-bZTs_x-rm4ZNLQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A53BB3060FD3;
        Wed, 26 Feb 2020 13:26:08 -0500 (EST)
Date:   Wed, 26 Feb 2020 19:26:07 +0100
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
Subject: Re: [PATCH 07/13] dt-bindings: net: Convert Calxeda Ethernet binding
 to json-schema
Message-ID: <20200226182607.zkmzja2g7smygbm6@gilmour.lan>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vri7camk7hrxk6l3"
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-8-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vri7camk7hrxk6l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 06:08:55PM +0000, Andre Przywara wrote:
> Convert the Calxeda XGMAC Ethernet device binding to DT schema format
> using json-schema.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/net/calxeda-xgmac.txt | 18 -------
>  .../bindings/net/calxeda-xgmac.yaml           | 47 +++++++++++++++++++
>  2 files changed, 47 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
>  create mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt b/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
> deleted file mode 100644
> index c8ae996bd8f2..000000000000
> --- a/Documentation/devicetree/bindings/net/calxeda-xgmac.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* Calxeda Highbank 10Gb XGMAC Ethernet
> -
> -Required properties:
> -- compatible : Should be "calxeda,hb-xgmac"
> -- reg : Address and length of the register set for the device
> -- interrupts : Should contain 3 xgmac interrupts. The 1st is main interrupt.
> -  The 2nd is pwr mgt interrupt. The 3rd is low power state interrupt.
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -
> -Example:
> -
> -ethernet@fff50000 {
> -        compatible = "calxeda,hb-xgmac";
> -        reg = <0xfff50000 0x1000>;
> -        interrupts = <0 77 4  0 78 4  0 79 4>;
> -};
> diff --git a/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml b/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
> new file mode 100644
> index 000000000000..77b8be9ebb20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/calxeda-xgmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda Highbank 10Gb XGMAC Ethernet controller
> +
> +description: |
> +  The Calxeda XGMAC Ethernet controllers are directly connected to the
> +  internal machine "network fabric", which is set up, initialised and
> +  managed by the firmware. So there are no PHY properties in this
> +  binding. Switches in the fabric take care of routing and mapping the
> +  traffic to external network ports.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    const: calxeda,hb-xgmac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Can point to at most 3 xgmac interrupts. The 1st one is the main
> +      interrupt, the 2nd one is used for power management. The optional
> +      3rd one is the low power state interrupt.
> +    minItems: 2
> +    maxItems: 3
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

You probably want to add additionalProperties: false here?

--vri7camk7hrxk6l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXla4PwAKCRDj7w1vZxhR
xW3oAP40y2RNRTvaMenRbqN/BK0cUt8YACLBncKsVhHXYtJeOwEApqwjz22BM18a
PRZ573KMDzG+AZHOpYXK6uUYAPIt/gc=
=qlWV
-----END PGP SIGNATURE-----

--vri7camk7hrxk6l3--
