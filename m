Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD48C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4842B24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Snb74y/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZfzZzHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBZSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:24:36 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44069 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgBZSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:24:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 935E761D8;
        Wed, 26 Feb 2020 13:24:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 26 Feb 2020 13:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=gV1crvvxr36zMBtfehWsFeB8WGj
        6uZV2sTGpY7aRnRQ=; b=Snb74y/dbC1RNmGdmuhKjwow+8MomytmQE9KgfEaCgr
        DTEx6wcMLuoGUo950JpAQZk7aNoWChFmkJfb8tbwQy2J9pxWw2U3wW4oReh6Ny0c
        0avg0AKB0oA/uR0qvAo7XW4/3KJF90gC/YRidB4j0NeySKkQcVe3K6tgxKq+3af8
        rnkIvP26k/KdRkeEPK0XJ3WVDLg+g0gv0yAf7X/NnvwXFnTi7XUlEONPZOnvQNQV
        xykuMf2GaRWX3qlrJxVIY9dUWho/wkMlePM/7J+np4HOj1nrC2bx9l2XQecZItsT
        3aOede4cweZnPRo8EuchHv3ETOes+lMiMhQ4cLgVppQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gV1crv
        vxr36zMBtfehWsFeB8WGj6uZV2sTGpY7aRnRQ=; b=IZfzZzHIfEKvQOzjVxhv6k
        Qwi4loNtwZZTn8bXnWCScAXmj4sbwH8nK3G2YAItTS1cdy7qtMunMvHfq5hSdKZM
        z+h3M1QzTmDzGamuazRI306gUMTXkVajqY9jZxvqQ0Dk2UHicC+6H60MVGb/fIvu
        kEDkk+/k8zcEg/rb5i9Hfg/bPIm+hJiyD3BPFOYQHPIoRH6Lj7Vp+xH2mA365BmX
        JXRHVUdXHbnID6fHZVz+YlHH+awoYLsOn0AFPIsaeSIkveN5UaiJaitm2OiLdFm0
        WqqszslwQ0Yrt/syzpApPZfaPVFDU/MpPWtX0uZtf/vK+e8mTvIZeYZmoAJvkBtw
        ==
X-ME-Sender: <xms:4bdWXiDs2cUGG-tf-gFQkg4d6E5I_HnsWhS5kZfPRXtXEkzTixGnjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeeltddr
    keelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4bdWXj9BQCe5GnYNTRgl8K918CEqwQCHYkME02c_85ZO1fNnsIyvzA>
    <xmx:4bdWXi9qjG3-ou-Gf481UUek3utSlsOFAXPLYLF7WtFmHNJ9UgIQNA>
    <xmx:4bdWXqfzTVouAebt0tTNz01vnzH7u4dpgiDCCvfZ19zwqMo1s4tonA>
    <xmx:4rdWXhRY1M7h650ph0r505zfVFyjhDWtpaJWUe0Qq0l-sSy0ZDDkQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 39B363060D1A;
        Wed, 26 Feb 2020 13:24:33 -0500 (EST)
Date:   Wed, 26 Feb 2020 19:24:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
        soc@kernel.org, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/13] dt-bindings: clock: Convert Calxeda clock bindings
 to json-schema
Message-ID: <20200226182431.xmmgbtxsa6qovnsv@gilmour.lan>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oxpe5iexw42u333m"
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-6-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oxpe5iexw42u333m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 06:08:53PM +0000, Andre Przywara wrote:
> Convert the Calxeda clock bindings to DT schema format using json-schema.
>
> This just covers the actual PLL and divider clock nodes. In the actual
> DTs they are somewhat unconnected (no ranges or bus compatible) children
> of the sregs node, but for the actual clock bindings this is not
> relevant.
>
> One oddity is that the addresses are relative to the parent node,
> without that being pronounced using a ranges property.
> But this is too late to fix now.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
>
> ---
>  .../devicetree/bindings/clock/calxeda.txt     | 17 ----
>  .../devicetree/bindings/clock/calxeda.yaml    | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/calxeda.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/calxeda.txt b/Documentation/devicetree/bindings/clock/calxeda.txt
> deleted file mode 100644
> index 0a6ac1bdcda1..000000000000
> --- a/Documentation/devicetree/bindings/clock/calxeda.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Device Tree Clock bindings for Calxeda highbank platform
> -
> -This binding uses the common clock binding[1].
> -
> -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Required properties:
> -- compatible : shall be one of the following:
> -	"calxeda,hb-pll-clock" - for a PLL clock
> -	"calxeda,hb-a9periph-clock" - The A9 peripheral clock divided from the
> -		A9 clock.
> -	"calxeda,hb-a9bus-clock" - The A9 bus clock divided from the A9 clock.
> -	"calxeda,hb-emmc-clock" - Divided clock for MMC/SD controller.
> -- reg : shall be the control register offset from SYSREGs base for the clock.
> -- clocks : shall be the input parent clock phandle for the clock. This is
> -	either an oscillator or a pll output.
> -- #clock-cells : from common clock binding; shall be set to 0.
> diff --git a/Documentation/devicetree/bindings/clock/calxeda.yaml b/Documentation/devicetree/bindings/clock/calxeda.yaml
> new file mode 100644
> index 000000000000..0ad66af0eb0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/calxeda.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/calxeda.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device Tree Clock bindings for Calxeda highbank platform
> +
> +description: |
> +  This binding covers the Calxeda SoC internal peripheral and bus clocks
> +  as used by peripherals. The clocks live inside the "system register"
> +  region of the SoC, so are typically presented as children of an
> +  "hb-sregs" node.
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - calxeda,hb-pll-clock
> +      - calxeda,hb-a9periph-clock
> +      - calxeda,hb-a9bus-clock
> +      - calxeda,hb-emmc-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

There's no need to specify the type, it's already checked by a schemas
there:
https://github.com/devicetree-org/dt-schema/blob/master/schemas/clock/clock.yaml

Maxime

--oxpe5iexw42u333m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXla33wAKCRDj7w1vZxhR
xVCCAP9FAtviN9vMSzmOMnEaf0clsEnPEWJoqlOFffHEYfYkVQD+PsaFiKiidYgC
Vj9cjeIjaMRIA5EoTsMzHLWl1v8W6A8=
=mtDo
-----END PGP SIGNATURE-----

--oxpe5iexw42u333m--
