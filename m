Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B66C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC4320714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AslVb9g0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjkFUGLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBZS1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:27:49 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52033 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgBZS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:27:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9DBD02911;
        Wed, 26 Feb 2020 13:27:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 13:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=w7QtfAdJdr3KTau3Bb/pu7t8pVV
        wKSSTDZcCOh+zDEk=; b=AslVb9g0Ie2irex/ew16YVstLQFhTpBwY8TvBetJ0G4
        0KakXTO63pZDsiCOclUvVXCIVSCURThusPpn5MlPSryh9Z4WDfKfLyeQetpHmviL
        nYGLeN+9/snCpv3N0eLhgx+LZJdHGhI/xf5PtpEnSXBMiKpjbbG7lEGkhI/tvf6o
        Y7uOJXQG2quym/59x2ybLLrEVMUZXPrHiMB2TPkfZOfGxH2LaBMzIQc3NqpHsqqs
        93ljrgE9/vknU+hkPHIMRbUcnjxcPjiuo928szk/UvXWLjGJaWpdzfWHb+lfb24n
        Oi9l4mn3q4RqxD3eND6io0iYVx4ZgUV/YahpsEaTSfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=w7QtfA
        dJdr3KTau3Bb/pu7t8pVVwKSSTDZcCOh+zDEk=; b=hjkFUGLOnET4YzBudYf1yt
        iOW0D2bAgRXwxEkmTUDx5XUQ4ttFlBYCRQ9HbwshIZmsvdmfom6klg62GMhkq6ac
        OWmLvRbrtJlPdbRXob6euLEkqoIWPmJgvWwkWAxFQNgD/uMabYK1M7ZRLXg/kRTx
        0oXZEP6EqjY2TUsKzsef7M7PI/4cbbfAVhF6XsZXp99Q0LpT1ZBjkypBCgdBpKLC
        oOeRyEMtfJaZ76DO9I2wrxAA+T1G9MnSWUSTENXknY7Dvb/2XStIcoTMlXyTiG7U
        8XGKJpprk6gBx2rKn97dGQIfGQwCDf8rhMvfjIGOcoPuTnOy1xyJcixHHLtw/pig
        ==
X-ME-Sender: <xms:o7hWXi3f76kl8Z5bRKiK9vtN4o7dgLXWXqkXuyUDzX-OTVD4l5D5aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvg
    estggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:o7hWXqS7oNFHEHdvy65-r3crZ60q2UMLt56TCLYZUlUS0uK6Jv6ofA>
    <xmx:o7hWXuTEn_zjEQRtUNSDAtjJ5e5-ANCrjjXPDHeausxNmOPAChwOHg>
    <xmx:o7hWXjXsOfNFMnPB9WNVwFnlUwPRZLSjeRvkg3sTRmHMqDxqc2coAA>
    <xmx:o7hWXud2Qcqb-MKhNKKGL1G5RZKEjzXuzDdqIJBdLpONuTrDRRGM5Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C13203280059;
        Wed, 26 Feb 2020 13:27:46 -0500 (EST)
Date:   Wed, 26 Feb 2020 19:27:45 +0100
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
Subject: Re: [PATCH 10/13] dt-bindings: memory-controllers: convert Calxeda
 DDR to json-schema
Message-ID: <20200226182745.gevcx3zb6hgewdnx@gilmour.lan>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-11-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vy5cdj22bi4li54x"
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-11-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vy5cdj22bi4li54x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 06:08:58PM +0000, Andre Przywara wrote:
> Convert the Calxeda DDR memory controller binding to DT schema format
> using json-schema.
> Although this technically covers the whole DRAM controller, the
> intention to use it only for error reporting and mapping fault addresses
> to DRAM chips.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../memory-controllers/calxeda-ddr-ctrlr.txt  | 16 --------
>  .../memory-controllers/calxeda-ddr-ctrlr.yaml | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
> deleted file mode 100644
> index 049675944b78..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Calxeda DDR memory controller
> -
> -Properties:
> -- compatible : Should be:
> -  - "calxeda,hb-ddr-ctrl" for ECX-1000
> -  - "calxeda,ecx-2000-ddr-ctrl" for ECX-2000
> -- reg : Address and size for DDR controller registers.
> -- interrupts : Interrupt for DDR controller.
> -
> -Example:
> -
> -	memory-controller@fff00000 {
> -		compatible = "calxeda,hb-ddr-ctrl";
> -		reg = <0xfff00000 0x1000>;
> -		interrupts = <0 91 4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
> new file mode 100644
> index 000000000000..c5153127e722
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/calxeda-ddr-ctrlr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Calxeda DDR memory controller binding
> +
> +description: |
> +  The Calxeda DDR memory controller is initialised and programmed by the
> +  firmware, but an OS might want to read its registers for error reporting
> +  purposes and to learn about the DRAM topology.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  compatible:
> +    items:
> +    - enum:
> +        - calxeda,hb-ddr-ctrl
> +        - calxeda,ecx-2000-ddr-ctrl

You don't need the items here, you can just have the enum directly
(like you did in your other schemas).

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

And you're probably missing additionalProperties too (and in other
schemas).

Maxime

--vy5cdj22bi4li54x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXla4oQAKCRDj7w1vZxhR
xRBXAP9ZQmrAOPSaIYVCepMGalL4VRu2WiDmkJ11EtPV92bOxAD/aNate5SpGBab
3eDUe7Y2I/AUh3aU1kJNSh0pBw7wYwg=
=BFTG
-----END PGP SIGNATURE-----

--vy5cdj22bi4li54x--
