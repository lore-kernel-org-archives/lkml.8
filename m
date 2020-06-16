Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79226C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52BC0207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BAHU/pAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIDDPxWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgFPMQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:16:47 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50313 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgFPMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:16:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0F4F258022A;
        Tue, 16 Jun 2020 08:16:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Jun 2020 08:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=q9eVcFed6me6zfjtvNk1obWG+SN
        i2fnGdjrskD0vSG4=; b=BAHU/pAeM2scQGmMJ0hhcXovaHhPr34Xzz0ChofdSJg
        AbngtQzbdsT7IerRj1Z1T5xkSME4ko5EOFNaMDWtlnUNKkDtgQx8lEByQatHXC+W
        i11GKw2L2mJCSxb6Ovn5yQuKO6H9Xf9oKpa4LHg6jRzhZCDMh/oJAjew9Th3TNbH
        c9EZ8FtFcWUjVJq/GUxiUSwnXIY8GQYkWuBq78+J9ZwmP1RVB81Kf17eWqeY+8Wb
        1k67hGDTa03Pq9CKD+mphuZ8qBsEn9ILBPVFDvbjhjzCE60mDq9F8HzwewemcU3t
        z3Ys55/lZEZCtEEcREdgROoCw43S+7fnCgfM1Eped/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q9eVcF
        ed6me6zfjtvNk1obWG+SNi2fnGdjrskD0vSG4=; b=UIDDPxWGVNnO2saImDFp4B
        +bhlEotEEI/0Az/S9cQm9LMspnTo7S4IS3SmERDhhUeC0vYxLM3OlAL3KUzrlUun
        v3T7yC0SO9eMs1tk0nH01iShh6+urULcFjrxkJ2ayWEj2iSgvJV6GwFclaxA8xrF
        CXB2A87ZeGgEwRfUsJg6j6wu6yj2kIcnJmpVwXJq+xkHyszgiwBPxfX1DnP/d4yF
        bbVa2npUz6VprOfF8wAdA44+Q2+1OneFdSXHD8DEWb4K5dFcwwd+EZ0vrHNKsqj+
        grHQUbcGqD9gGd5l8xP595frNA2sf9bQNeN/jqnQXljnBdbDVlqHgDQJNUpIGGFQ
        ==
X-ME-Sender: <xms:LLjoXiUWFpcp-6aNeYQZMr10z6NghfcX-JKiF9jaB6MYwVMrPZ-1LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejtddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:LLjoXunHXvSuz4MdOPO4yUkIKHWS-G0gMmh6WktCHNEt6PcpQYcLDg>
    <xmx:LLjoXmbMIoR76LZEpL2Tww1pGkXEXzzpUPrtvmHPKhZDSekUlxoJsg>
    <xmx:LLjoXpUXYK2Pfp-lvrXSbNcOzK18o-6NQ71VY69t5ZGM885RYMGkng>
    <xmx:LbjoXm6aVegWGcdleeGvE_4GmmmiCjxtz-Bb7cm__1AVd8F6-_sPsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6F793280063;
        Tue, 16 Jun 2020 08:16:43 -0400 (EDT)
Date:   Tue, 16 Jun 2020 14:16:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
Message-ID: <20200616121641.jpoz237p43sbndg2@gilmour.lan>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
 <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
 <810816166d8ef554e1bb1f4a2b39ea0b8a1a3d5b.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ci3vlkf364l5m74a"
Content-Disposition: inline
In-Reply-To: <810816166d8ef554e1bb1f4a2b39ea0b8a1a3d5b.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ci3vlkf364l5m74a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Mon, Jun 15, 2020 at 06:26:19PM +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2020-06-11 at 11:23 +0200, Maxime Ripard wrote:
> > Now that we have a driver for the DVP, let's add its DT node.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
>=20
> I can take this patch, but I guess the rest should go trough the clock tr=
ee.
> Is it OK with you?

We have a build dependency on the reset framework for that driver, so it
should rather go through the reset tree (or Philipp should make an
immutable branch that the clk maintainers can merge).

Maxime

--ci3vlkf364l5m74a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXui4KQAKCRDj7w1vZxhR
xR6QAQDrS5Zm0rFCB485zOO5ySoYqmG8mz7ONQ28lCcVXz77/AD9FfLXEu+FTL5M
nXMtMehcZqAyWNkNLhs4fiYUEQ69yQ4=
=oeEm
-----END PGP SIGNATURE-----

--ci3vlkf364l5m74a--
