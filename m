Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646FC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14075206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GN//1xQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRBAYWKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD1HwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:52:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48727 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:52:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FAB65C0242;
        Tue, 28 Apr 2020 03:52:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 03:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=V3F6bgU0rAXVY56HsN7kHIpWzuM
        aEzjdPUeTPKOkaG0=; b=GN//1xQTf4yXhNpbQP8Zc9xxWk2xJ56RdOw6PKZoz9o
        +E8qbi3XzM/0l5NjjHGni9L2JYmrL71d5+SWiI/VvGkYqFQAEFCqMzAEgYMvWGCJ
        NhoM6XnhWHQ5evKR2/xaZHPoeJF4qwHYmNNwblSeeIyJInBEX/HXnUJvV5+GDNFT
        KjMxIqx1mDMJhHPCAclkzhoCbTfHyP7f/lj088nx0ZizFngGObQk0I54AJLv/v/k
        YRiEGE3DjWi2iUk3hYwrOVSORWaEDtUu7BlI0OrWr3I4wDblqrQg7oEO+GPO4rAd
        bJcog3vcMQj5jPcfRMszK10HMsDg5mEx08DRLJ0RM/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=V3F6bg
        U0rAXVY56HsN7kHIpWzuMaEzjdPUeTPKOkaG0=; b=MRBAYWKAjvaFWz3YsE0ku/
        DkNYdH2W8vHcXBjxUqP6lV+gftTI7UB/s+QWKzSlGq3RKYPCPk+skGoMf+jxjugq
        BfFKkE4o612wolzPCWp2o65mvUlrYZZ6sx6ZVXK+T4Q+CdUt1Ul0ywawrfwhhm+d
        EvyYYEsPoLnOrnoRVEMS4zplri9bo/QguB0tcCA/U8m6SP6cZK/wBZ0HWJ6Gs9cW
        4qpN3RyasCDP/zGEPFDic/5S4iza6HI5hSReB2L1+/E6HNVHnYwSNnDwcNRnLdc4
        HB+t0kZUiYQxwTuQpL/2GcxSC+1fDzYShOm9ATWLZL9X3wosb/9cjRQWarRc+EKA
        ==
X-ME-Sender: <xms:n-CnXihsqEnrGJ6OHdfqI_LaCGXt45oS_PVy6mlP6a6yrTJhkF7hAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:n-CnXn7wEhWJJmoj2mTVuVT6nrrfmoj7LMLFO5iVC1NnxQ9k9YiiRw>
    <xmx:n-CnXnqqdU2Zd_WRJhmy0R8kMIBsbva2BWQZE_w2_QFHiXUR4LhUHg>
    <xmx:n-CnXtUBXrMLAiP5tEIrcxRbmhyynOGVX28lmk21_fGKmDn9idb2AA>
    <xmx:oOCnXoRNxVwYOm0wyWwXdWGslFkNT-bOA2RcB8C18LI9WcdK8zyvRw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 025DA3280068;
        Tue, 28 Apr 2020 03:51:58 -0400 (EDT)
Date:   Tue, 28 Apr 2020 09:51:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Use dedicated CPU OPP table
 for Tanix TX6
Message-ID: <20200428075156.65okklrupingiza6@gilmour.lan>
References: <20200426121709.1216-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hy3utu7gd5xuclrb"
Content-Disposition: inline
In-Reply-To: <20200426121709.1216-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hy3utu7gd5xuclrb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 02:17:09PM +0200, Cl=E9ment P=E9ron wrote:
> Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> voltage to meet OPP table. The DVFS is not working as expected.
>=20
> Introduce a dedicated OPP Table where voltage are equals to
> the fixed regulator.
>=20
> Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables fo=
r Tanix TX6")
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

I'm not really a big fan of duplicating the OPPs, since that would make an
update of those very likely to be overlooked for that particular board (and
since it's a board that not a lot of people have, it would be harder to not=
ice
too).

IIRC, removing the cpu-supply property should work as well?

Maxime

--hy3utu7gd5xuclrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfgnAAKCRDj7w1vZxhR
xcKQAQCy9iRfHhgQB0zjFFyIcVr+pNkJu/NoOpUwGHC8OFi59QD/b/ffdd2k2+Gp
1HaeNUO40UjzCAvU3mSLTulZyrAF0Q8=
=TWTU
-----END PGP SIGNATURE-----

--hy3utu7gd5xuclrb--
