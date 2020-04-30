Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5DC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C8A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eRjy/X/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0Q4+cQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD3PAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:00:52 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47127 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgD3PAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:00:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B10A78D5;
        Thu, 30 Apr 2020 11:00:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 Apr 2020 11:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wL1V4tEUZLHoYkqrxr+Oa2YFwHa
        SxUnLHe2fYo122cQ=; b=eRjy/X/c9rApVN5yi3uYKaqPzwMsOtlHhuAPrrF9B0i
        iQHRl9Hq3IoeKZnDpKXdUVukJFX4edjbAyw+PrWeL72xFgDS3d0VnDgD8vRomIHk
        jHqHPb9GspYzXbr3/BFZykLjhgF85nlTBjs5l/y18Gw6PKaH2vp9kZCOjHZk+J/f
        R9980fuYOFWW9Bm7XzlDnGQn3k/8or+kEj/WABQZmjjPRSbrXCjAgvySy5eSIc51
        9roQF9ZR8AUC8j3NgSFrwg4dVBRFMGY9R5Qw8aC91OEv6jk3GTl0K8FqbtBmf/LF
        uijbza0qqx+UuXw3zUf6xhLY0I9rgdgKyePp0M2VI7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wL1V4t
        EUZLHoYkqrxr+Oa2YFwHaSxUnLHe2fYo122cQ=; b=F0Q4+cQNnzFq6/khK4e0qg
        /uk03HpDnjPjU69ImFsyOKvOUS5AT/EC3QOa+tZYvOBm3mp4t+wx9z4gzvDwl2LQ
        gZJJvJAopHBtdg+gkElykoUiHQpX2C7uJPicjRck/hinYcfmpCGGUHEx+peQabh2
        ZwAZ0kC60GiGdkbZkylblzzI/40ka8SI7jPpf0VkUv0MnhTn8+BwSDzfXJKl14fO
        Cnj5XVcE26Y/kPKjfgusmQnp0p/q0eEao12kMqXGmYlCmHe+4Ngr4vtPMC0pluxx
        HpscKjJZMHw/U/birRicLdmQXrbBku75D2qVzyBDRXf/dbQxdRyhLXgr3AFzyE2Q
        ==
X-ME-Sender: <xms:IOiqXstmmURRV0ZP7DmZQjTMi5sQQs2YJOKJg-9cVB14fX8rdv6YqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:IeiqXgSZ82gBjRU5ofAh50ol90uhIKkhV4SvCizrBlbVQHMBUTyJaw>
    <xmx:IeiqXo-y_KKfB6E-DGBL2WXPZ-FyCk90DGsGXLiFLt0W3Zdalko_ZA>
    <xmx:IeiqXs_b7h9AdXlQrkqHgOKF51RQ1HbbJQ_Xx1EGnyKu71VSFPy1lg>
    <xmx:IuiqXmZ0KdB4UONcdqNrdb_ratIO2QL61zscAKDpLU2RJwAOtLiPQw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2E543065F2B;
        Thu, 30 Apr 2020 11:00:48 -0400 (EDT)
Date:   Thu, 30 Apr 2020 17:00:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 4/6] dt-bindings: net: sun7i-gmac: Add syscon support
Message-ID: <20200430150046.theqniqcrfjiokyo@gilmour.lan>
References: <20200430115702.5768-1-plaes@plaes.org>
 <20200430115702.5768-5-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="efw2ihuaxv6irv3b"
Content-Disposition: inline
In-Reply-To: <20200430115702.5768-5-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--efw2ihuaxv6irv3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 02:57:00PM +0300, Priit Laes wrote:
> Now that driver supports syscon-based regmap access, document also the
> devicetree binding.
>=20
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  .../bindings/net/allwinner,sun7i-a20-gmac.yaml    | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gm=
ac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.ya=
ml
> index 703d0d886884..c41d7c598c19 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
> @@ -29,17 +29,26 @@ properties:
>    clocks:
>      items:
>        - description: GMAC main clock
> +
> +      # Deprecated
>        - description: TX clock
> =20
>    clock-names:
>      items:
>        - const: stmmaceth
> +
> +      # Deprecated
>        - const: allwinner_gmac_tx

That would be deprecated: true

Also, you still require to have two clocks here?

> =20
>    phy-supply:
>      description:
>        PHY regulator
> =20
> +  syscon:
> +    $ref: /schemas/types.yaml#definitions/phandle
> +    description:
> +      Phandle to the device containing the GMAC clock register
> +
>  required:
>    - compatible
>    - reg
> @@ -48,6 +57,7 @@ required:
>    - clocks
>    - clock-names
>    - phy-mode
> +  - syscon

You can't do that though, this changes the binding in a non-backward compat=
ible
way

I guess you could add an if clause to require it if clocks has a single mem=
ber.

Maxime

--efw2ihuaxv6irv3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqroHgAKCRDj7w1vZxhR
xaUUAP9VjkAn7iLXVy4t1HqW05/RoWbJVdFH3BGNDFaVLw0YZAD/Zj1MU1dV2h5E
VoTak9i1lQOKrH5HLCG+yUEjfZKZCQU=
=aG3C
-----END PGP SIGNATURE-----

--efw2ihuaxv6irv3b--
