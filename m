Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36DB206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEOJkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:40:18 -0400
Received: from sauhun.de ([88.99.104.3]:33886 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEOJkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:40:17 -0400
Received: from localhost (p5486CC07.dip0.t-ipconnect.de [84.134.204.7])
        by pokefinder.org (Postfix) with ESMTPSA id 3463C2C2051;
        Fri, 15 May 2020 11:40:15 +0200 (CEST)
Date:   Fri, 15 May 2020 11:40:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com
Subject: Re: [PATCH v2 2/2] i2c: mediatek: Add i2c ac-timing adjust support
Message-ID: <20200515094014.GG2077@ninjato>
References: <1589461844-15614-1-git-send-email-qii.wang@mediatek.com>
 <1589461844-15614-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <1589461844-15614-3-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 09:09:05PM +0800, Qii Wang wrote:
> This patch adds a algorithm to calculate some ac-timing parameters
> which can fully meet I2C Spec.
>=20
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Applied to for-next, thanks!


--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6+Y34ACgkQFA3kzBSg
KbYUSg//XhO3MQxenuSju7wYsEkq/XyaVAfqH+foUu4RPONPXv04M4Owx+6UdCek
8EjevvFVM5f9Ir47WkKKJkt4mlmsEV8ndKjwZyY7h1A5Ocna2bQ15pGFxpQ20oe1
DT5X4s/7HsTQIubSWGbDLSujQ8xHjrT3kDFBfEh6HxBGxsuHNLCP6WjLTHZbFN18
B87VCpVFINlqCHiX/ZAKTHN6HSF00+IwENs3zMCKfE10cVuqF4OaoVNSvQyDS64y
w9erXur3M7s8ijhnHWgmSz0Vs8xAuPwWmzBlHYFAmh4bJxpFpMkDuPQU8n1aAffT
IijkylZYp5vuQu93n1tkShlo+MOgHcmEA2uCoCOb9jMJOFO6wM3AeBRzSmpTCtnn
dZLUNy7asSTYtTrEpXGmaKg2l1gEKDt3Kn99OfV+hrdquJyzljY6+Z4B4WbIDtIN
BUU+XM0JUVttFDT8Y03LEb/a49c1f+SAtzu3gmHnjwVajXwghG/xXqm1Ux8hKqcZ
BRowZ2LNDub5N58kfMtRifOXAEfLwl7gsrj6TnO9MkiZ8NpEyBJUaVK2pn3VWc+g
O8Mye8aADI4A1NPuexyCiF3awZAOiT7iEZOUWJte9VaOULGs51C8ifddMN+RgbLY
6BnDf0z49UE/IoTvvMNCoxE8/fwXd16eFvqUnq1UgY5lZRG89ls=
=SLRe
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
