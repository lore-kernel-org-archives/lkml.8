Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B689C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CA420CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441054AbgDOFzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389655AbgDOFzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:55:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:55:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jOb0p-0007PS-AL; Wed, 15 Apr 2020 07:55:03 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jOb0o-0004zR-LO; Wed, 15 Apr 2020 07:55:02 +0200
Date:   Wed, 15 Apr 2020 07:55:02 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, leonard.crestez@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
Message-ID: <20200415055502.zc2su6snnpkrq2v7@pengutronix.de>
References: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zdjfy7h2qmazbiyv"
Content-Disposition: inline
In-Reply-To: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:52:13 up 151 days, 21:10, 164 users,  load average: 0.14, 0.08,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zdjfy7h2qmazbiyv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:21:15PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The i.MX8 SCU message header size is the number of "u32" elements,
> not "u8", so fix the check.
>=20
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1461658 ("Memory - corruptions")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Measuring size in mailboxes instead of bytes is really challenging :) I
would expect similar issues on other places as well.

Regards,
Oleksij

> ---
>=20
> V2:
>  Drop parenthesis, add comment, update err msg.
>=20
>  drivers/mailbox/imx-mailbox.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 7906624a731c..fd3a9a60416d 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -154,12 +154,17 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
> =20
>  	switch (cp->type) {
>  	case IMX_MU_TYPE_TX:
> -		if (msg->hdr.size > sizeof(*msg)) {
> +		/*
> +		 * msg->hdr.size specifies the number of u32 words while
> +		 * sizeof yields bytes.
> +		 */
> +
> +		if (msg->hdr.size > sizeof(*msg) / 4) {
>  			/*
>  			 * The real message size can be different to
>  			 * struct imx_sc_rpc_msg_max size
>  			 */
> -			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", size=
of(*msg), msg->hdr.size);
> +			dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on TX; =
got: %i bytes\n", sizeof(*msg), msg->hdr.size << 2);
>  			return -EINVAL;
>  		}
> =20
> @@ -198,9 +203,8 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
>  	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
>  	*data++ =3D imx_mu_read(priv, priv->dcfg->xRR[0]);
> =20
> -	if (msg.hdr.size > sizeof(msg)) {
> -		dev_err(priv->dev, "Exceed max msg size (%zu) on RX, got: %i\n",
> -			sizeof(msg), msg.hdr.size);
> +	if (msg.hdr.size > sizeof(msg) / 4) {
> +		dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; g=
ot: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
>  		return -EINVAL;
>  	}
> =20
> --=20
> 2.16.4
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--zdjfy7h2qmazbiyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl6WobYACgkQ4omh9DUa
UbP8/w//YHbDbL+u9ngJfXC53iYK9a1Z+a530z3UfwOPd43Olx8jR6v3nh7e8sfp
ddDpI/9zXnF9+3KyI+TLh6opJSClkzmHblBQHvZ6aizkyUd71Z+yed5Q4pYQpSy0
Vd24FYELjK93pOVHA5WH0UztRXLno+U0ltTvrEDO6hsniSiEsK6dg3YnrvwPGZxi
wdnf8URhfTZCsfAEpM/qJMLA6Zfuwyp7wRKOVmWfOwdiuRdK66ku3zd9QcbE1eLZ
Ekqhl1i9tvLPSX65NOYdAoF2D7+cra/8rPKDJZUWaBtgUDpFzuEi4FH+oIp6RLsD
o+s442kAj3cuYJAWPV2pSFcSZ7EfGSzLlSmp3If5cQIKuA99ZBwChCNcwzE1ZPI1
eK1CZ5zAb2jCtFigUSselV58ioh7ruH7SkDIBN2PbfG6cY74MRnWMw7AmfnWjI79
G7oqcigebW79R7CL9dbjS+ieRYK6siZ4Ko7KnUrpUxhLfrYEpCU7ZKJzTHvHeaXf
63sXp3z5GrDZn3PoTDJfI+nRPtxrODPn0hWep872KE4KUE2cP09p9ETUuXAzaQ/W
Dnt077vPavUXym08Soeqjy/FerzgzZIDYIRA53Z7ClxU4wqpzC0Fls9lbx9lZIK+
7uyP6aLKBziUFgen/f27+bW+bd1VKpEhG+zYObmwDNTZNNijkhU=
=M2ls
-----END PGP SIGNATURE-----

--zdjfy7h2qmazbiyv--
