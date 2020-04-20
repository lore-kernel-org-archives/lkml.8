Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C826D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="azA8QLNw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDabqPL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgDTNZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:25:07 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35281 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgDTNZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:25:06 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A1E9E52B;
        Mon, 20 Apr 2020 09:25:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yhnengzziE5vWLTBpc6TNXdgy73
        OT3X2ZS0zw6Wtevw=; b=azA8QLNwW36SCKr3HQis4odPzSWwi4U88WuVeVY14ob
        NDbQfJICGGzzlUTu3pHWH9zcBwI86JB2UozgMbXKCznSJTP6eVIMhHho0y2usVXg
        CKbqqo3uUS2YuYTSOU319pS8AOkt63fUqJxTsbLE+MSCYg3BnrAaLL9dhILJZF4d
        tCxvCv3WNeSXXQOfL//doHnWo2VG3Wqh+X0tPGB5yksUmVB1rXWY9dOMDsu3H6FX
        a6S3KMSO9+7at32DwO1UBnNqEeVprjoYdwJAwN4kq+zFSjugAsdSpIEfpFMVd5pF
        1cB1x/C754snD44ZJtAUUS0RAkgmjzxDLAYA+Qe91BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yhneng
        zziE5vWLTBpc6TNXdgy73OT3X2ZS0zw6Wtevw=; b=LDabqPL769MMweHDyQwOF7
        6inA3sLIdEIjZzH8iojdhdDPIHqjRyJC3wlxrgLzqPNezIRE/jbwAe7NgSTxmt9K
        KFW5XMwaj2XR2Lz57rw7//yvsNcP6J3cfigVpGwOmHtG+GceO5ewTaZEa5QmuRoV
        aGVSOiniLgHZFTeFxrKV8pU++UHtUxmL+o95/mKYfmYSbbE+iMMcUdxgyufTLepw
        tqikKuShseCopd4b4Setjm1D84ZHcPL/oqHD/o0nA1IUA3dTGwKyDHxeuQ243BPY
        o1LlM9fcSmG57NfAbZtSMszxCmutmDW8Oh/5pMaKX6BbRDwMltPSAn2no0dDGC7A
        ==
X-ME-Sender: <xms:raKdXihyfHpv81ALfb1YoHtF2BVbmDjGgXLdDuaf3bKPMQzoeaTQKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:raKdXkFCHcowvAEl21ur6EYF_t-bKFth9B6LxGKsnYmBDOijs8ikkw>
    <xmx:raKdXtBwbwDvYzdmGzKEmi5rD_uVtqgXI6jadnHpmuIUs7w75fLUdQ>
    <xmx:raKdXo8uaAE9SdE4qPxmQQKDbfcy0gzYoEyOV8Y6L7dJQYwAW2gbAQ>
    <xmx:saKdXoqdtuHV2nYQJGk0XRqX3LJ53kyxo1-JizyZ12ODFOlARn3enA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74791328005E;
        Mon, 20 Apr 2020 09:25:01 -0400 (EDT)
Date:   Mon, 20 Apr 2020 15:25:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v5 0/9] Add support for Allwinner H6 DVFS
Message-ID: <20200420132500.gsnsdv3jaotjup5w@gilmour.lan>
References: <20200420130021.3841-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fktdxkekevkzu3a3"
Content-Disposition: inline
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fktdxkekevkzu3a3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 03:00:12PM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>=20
> This is the same as v4 and v3 on top.
> I have also fix the commit title for Pine H64 as we now only enable CPU D=
VFS.
>=20
> Sorry for the noise,
> Cl=E9ment

I dropped the previous ones and applied, thanks!
Maxime

--fktdxkekevkzu3a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2irAAKCRDj7w1vZxhR
xTOIAQDZ6ddkodAU0H7ADOOqC0WuJOktcAKK+MPuKpf6tzBCEgEAxm0lP1QHVwMp
YYrf4zOjMAPR251l/CaafMgcfxuSRwk=
=xMW6
-----END PGP SIGNATURE-----

--fktdxkekevkzu3a3--
