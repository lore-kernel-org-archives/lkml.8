Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA78C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE02D20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="g9qa6/3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IENVijjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgF3IDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:03:02 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39149 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbgF3ICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:02:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B3F5C252;
        Tue, 30 Jun 2020 04:02:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jun 2020 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lu/WrihdsYQOer+w6h1sKVAQhhh
        zpgn9ANfbrgSBg08=; b=g9qa6/3vky6RpenoRSFz45zMGoY4KA1E6jJ0ZUcRlEV
        PQcFqd2AKRhgIaYvOf/xP29zscXyHpDGRrWtCl4WxMhPhmbQ+jRrNnBuMAcwCTdI
        5f0s03IvSlUqq2Wsb0eyaFpZ4emls8T4KMikrDhjWaYDcU/jbhqkrvBTQ+j/SaDM
        frRilLO1PAoEStRK4Tpa4AU8+Lird/mo7WTS8GWFDoofnPbkvgp1803YopTt61n6
        VYaM2OsbJct65v3QU2aCKXAN7KQbZpUkB/2irR7fA7szGLuzIxb4u8eltpWdx8xi
        J3TvQIqfNXYrIadNJUyVlUdBjgqNLVjBBkMx3dmyBGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lu/Wri
        hdsYQOer+w6h1sKVAQhhhzpgn9ANfbrgSBg08=; b=IENVijjTKHsAo29my84QNt
        HY8lF7lDEOJ1kLi3ESudeyXEHRivnOWiNwwtK0hFN0ul7TjHAChlcJ9b/UzEhDHo
        2eSoaardOH9Tki2+UbX0NcHp8T+t9rF6ldTEmBqXEeD0iRl/n+MqM88uGD/YexL0
        i7rEqqodW1Nbz/TEu5c0Ktgyj2ZYvr5Sq8IKPiG+hAT4eIDXqbD+Df4RjhDxytpa
        HQDi64fBZOLZPdGKuqhLFiD1D3ph99Tl74Payu2AtJc3oLcRgtinz2LfM2+qapUa
        EhyIrnoGNF/cXhGkxJro55Kk40oA2hXYpU3L8v3v4EGPz5o64hxYzEowPxEE4gTw
        ==
X-ME-Sender: <xms:n_H6Xkl5STMdOqdfkt3UgUS68MEyZUSxq3JRCbrWivKFaQus7QqTjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddttddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeefjeefkeduiefgkefgheefteekueetkeeiueekgedvvdevgfejgfduudei
    veejieenucffohhmrghinhepshhuphgvrhhushgvrhdrtghomhdprghrmhgsihgrnhdrtg
    homhenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:n_H6Xj1Wgj7m0IMsjDA-5IvL7RGLmM0Jnqca4MD3W9rSANjADEgZ0A>
    <xmx:n_H6XirelRRngq7-TERnqrtXaDDByLZhYcxsz78xbouElrd66cwcXQ>
    <xmx:n_H6XgnABOkXWd6TTqOF4FAFV72iOHSRpCk5Z-6-a0xY3kQAhUFRjA>
    <xmx:ofH6XnydwAiBKEXYT_AJwIgA_erJoiMK9bYjJ5pqJUG8o5ThSUckXw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04A033280066;
        Tue, 30 Jun 2020 04:02:38 -0400 (EDT)
Date:   Tue, 30 Jun 2020 10:02:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun4i: hdmi: Remove extra HPD polling
Message-ID: <20200630080237.dsg7umd6ju2oamg4@gilmour.lan>
References: <20200629060032.24134-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6hdlqsued72r5t5"
Content-Disposition: inline
In-Reply-To: <20200629060032.24134-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6hdlqsued72r5t5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 29, 2020 at 02:00:32PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The HPD sense mechanism in Allwinner's old HDMI encoder hardware is more
> or less an input-only GPIO. Other GPIO-based HPD implementations
> directly return the current state, instead of polling for a specific
> state and returning the other if that times out.
>=20
> Remove the I/O polling from sun4i_hdmi_connector_detect() and directly
> return a known state based on the current reading. This also gets rid
> of excessive CPU usage by kworker as reported on Stack Exchange [1] and
> Armbian forums [2].
>=20
>  [1] https://superuser.com/questions/1515001/debian-10-buster-on-cubietru=
ck-with-bug-in-sun4i-drm-hdmi
>  [2] https://forum.armbian.com/topic/14282-headless-systems-and-sun4i_drm=
_hdmi-a10a20/
>=20
> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks for figuring that out

Maxime

--f6hdlqsued72r5t5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvrxnQAKCRDj7w1vZxhR
xe0/AP9AfcSEFn4bwp+kbpsDasBM88jTsQJiznSvcxSJ4WCaWwEA/XSg2I9jaQuc
Vrmg3HbVedQSShsVClRiJer2EomSNgY=
=Tbdr
-----END PGP SIGNATURE-----

--f6hdlqsued72r5t5--
