Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AFFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CC1206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgFDMG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:06:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42200 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgFDMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:06:23 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7EB4D1C0BD2; Thu,  4 Jun 2020 14:06:21 +0200 (CEST)
Date:   Thu, 4 Jun 2020 14:06:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jacek.anaszewski@gmail.com, matthias.bgg@gmail.com, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH] leds: mt6360: Add LED driver for MT6360
Message-ID: <20200604120621.GA3560@duo.ucw.cz>
References: <1591252004-12681-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1591252004-12681-1-git-send-email-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add MT6360 LED driver include 2-channel Flash LED with torch/strobe mode,
> and 3-channel RGB LED support Register/Flash/Breath Mode
>=20
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> base-commit: 098c4adf249c198519a4abebe482b1e6b8c50e47

Does this need device tree binding, too?

> +++ b/drivers/leds/leds-mt6360.c
> @@ -0,0 +1,1061 @@
> +// SPDX-License-Identifier: GPL-2.0

Could we get GPL 2.0 or later?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtjjvQAKCRAw5/Bqldv6
8uu2AJ94mDQBXm5GCB+DGTjiC5seurSDSgCaA35bqtIrtU4tkebxxxG9yKvSs5E=
=/E8n
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
