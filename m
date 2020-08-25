Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139DB20786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jDJtJl7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQwV16YT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHYNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:38:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60003 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgHYNgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 39191CBA;
        Tue, 25 Aug 2020 09:36:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=XHcB3lfuJdBj/uhS/d953h60U8+
        CEnvM9rby8l4dE4s=; b=jDJtJl7ct1gAl0Uixf+XlUzglvvfeVPah8nCF6fZpK8
        ugAzz4oAsuk/fWNwrkuT+nopp3KwxSpkGi9N31yJEN167jEQdo4AXrGUW13W/o6M
        y4135Km1lawFkUevuI4MZyPGbOvo/1YizhSFifQbgTXw2Xe9AuzqMUDOS7z8XDKz
        68wEf/1BxJFm+ZrnElS2SSX0rQmBcS1KeyL4Y1frFkRwVGWiTv9JegIfMuQWREud
        P6ZDixWKn4HhtmlSIsbATNaTlXUBP2VXZS4ZRT6TEEWdZcvQRUTBgJ6VOJXwHmly
        aQDaxhsbZJ9fCM09E+p0EN/AYzs20tFaYCVdKdYgFww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XHcB3l
        fuJdBj/uhS/d953h60U8+CEnvM9rby8l4dE4s=; b=sQwV16YTjA9mCbHP2EdFWk
        akekylENwXpVXrad1RGjmzz3lsgunda6S5gcMAv07VuG5KEAksyXd2lFqy8QMhgF
        uPn5HRrauSmo+h3rCzgr4ZSAIUaJKt8aaWKjdD3wyFcgOptcNf5lAiXv9HcnZCoP
        c4/30ueXAynEh9gJNx55kqS9+9iCqT6ykV+QK9h5TAaFVltySWuIv4W8+bBweYvZ
        jxrPKnT3b/2eZMa+QunURHeL6sWM6vGFSsJHrRg16sM/8FoDQ/lHyGSdfTEV06TS
        WhrDSRNXQ8B4hYYSpkgmF/9yzGNDXxGQ3+ovzX2Eq+5zV80DFG0VFD0TqXjF3HRQ
        ==
X-ME-Sender: <xms:zxNFX01RIQdyWUYhd108sfMWedAX3A7fVlNUgensCReNTz7bOsTIxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvddune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zxNFX_HnLPnZAFtmp7v6zY68LcKiGuoXU7D6zZ6-LFVOW2tj3eTZyA>
    <xmx:zxNFX86fDTh9uafhj2va9DSy-y079vNZCj3l03uW_aXVcu-KfnLN7Q>
    <xmx:zxNFX92KK1ZnYOYvsvSdOA4EhCYU4rZ3CHQ0skeses4O5ittfXCwEg>
    <xmx:zxNFX86jaXSnUuFGDGvECbIXNOugFyIgv_FsSDKopxVaZm0MbLI8aw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 736C53060067;
        Tue, 25 Aug 2020 09:36:15 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:52:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/16] dt-bindings: clk: sunxi-ccu: add compatible
 string for A100 CCU and R-CCU
Message-ID: <20200825085204.3biqowzuadnj3xmx@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <5791b0a39e7ca2f1c11d3bade9ebeb7fece31230.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nw2w5smxiudyu7pw"
Content-Disposition: inline
In-Reply-To: <5791b0a39e7ca2f1c11d3bade9ebeb7fece31230.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nw2w5smxiudyu7pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 02:56:08PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> This patch adds binding to a100's ccu clock and r-ccu clock.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--nw2w5smxiudyu7pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TRNAAKCRDj7w1vZxhR
xdHjAP4sW/Io5fENbaX1ppc/3TRDnJ28gJ2VPhnFwI7caE5EYgEAjO01t8Cq/2Ae
ejt6qJtsS4yo03W3ysfzcbnnSES4kA8=
=DnY1
-----END PGP SIGNATURE-----

--nw2w5smxiudyu7pw--
