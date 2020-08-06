Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76331206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgHFRZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:25:42 -0400
Received: from sauhun.de ([88.99.104.3]:56338 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgHFRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:25:05 -0400
Received: from localhost (router.4pisysteme.de [80.79.225.122])
        by pokefinder.org (Postfix) with ESMTPSA id 9B29B2C0845;
        Thu,  6 Aug 2020 13:24:51 +0200 (CEST)
Date:   Thu, 6 Aug 2020 13:24:51 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] macintosh: windfarm: remove detatch debug containing
 spelling mistakes
Message-ID: <20200806112451.GA14906@kunai>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wolfram Sang <wsa@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806102901.44988-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200806102901.44988-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 11:29:01AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are spelling mistakes in two debug messages. As recommended
> by Wolfram Sang, these can be removed as there is plenty of debug
> in the driver core.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Wolfram Sang <wsa@kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8r6H8ACgkQFA3kzBSg
KbZtxg//ZIR7v0tw0KiapTuptJcoisvVibsbZs3xDlTDSfplKnupUcMTPKaOIHo0
osZmu8pbyB5NQ71RUoH2XWYU1/jnaiq0K65Xq+AuMWPJYHwFE4LNw0i1S/flf9sz
+i4zUmjRqIfGLN/csp0YJwXqWOrihCbbS051/lsInN6/PsuUFhC3ebIBjqVAreMA
W1bFKFPBF216CmXYnPvuPEHkrH5Wp/uTP+Y8VJA4zrnZHO3O2+SLL+pQanIPkV4n
VbUFFht90LlhppLYwb6CphT9lbyp/11gRKGG4ljB0PG6Bi7AIR1akALdFuIW/eCS
rljR6QUJrFZZgkS4RwcJL12VpvNgFA/jL71jjM74aMywyLp2ClrOmzANNgMZcwLD
WOZLk0RXM5jtvOEToyftgNHR0m8l2EXw8Q7oG2hoP1gkYL4afGD6NwsLTwSIxa+g
aK2dFR6htfbBiEVksZBiuT9bVjqTiKgUxpfC9KPG5b0feaAefcSZHeB60DA/Jt2w
9XK0oFUm2bMeMdeA9KVp7Bm/Ug6Ffc+Qk8qBahBArOIhZFfLAfD7puin+FCt39KR
/ZO8KLajFoHNtR7ft3XbleProaOCB0ktkX0sRvZTgxLiTK1l9TtwLbg/pNlBpX5W
DPLH/HHZJTo3FGEmhEPIuh8OlVO4Vk1x3cabp/SGHtLMxPBE+lU=
=Hjx1
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
