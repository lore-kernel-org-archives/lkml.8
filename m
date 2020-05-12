Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC0C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AE12078C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589280203;
	bh=jzCqV+SFKFhWU4aN5Ei2B+Qc7JGgaQ+Q2MhwlwDpgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DYtikEAbCckJan7hzXR/bcsrEUg8ikPNchwELcKYKuoVszdrXK/RMo4hxzmK9+X24
	 F4qoPZhACOfLxEoiER/KCfPhnIKx8qBZ0tWt964HzLz2OWlpTiqk02OOzEJyiE3CId
	 P+wDbHJSBjEA61T9k/3voiNIppADXKR7wn3vbIpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgELKnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbgELKnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:43:22 -0400
Received: from localhost (p54B332DE.dip0.t-ipconnect.de [84.179.50.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6794720731;
        Tue, 12 May 2020 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589280202;
        bh=jzCqV+SFKFhWU4aN5Ei2B+Qc7JGgaQ+Q2MhwlwDpgqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCiFJmNf/Asf1C/MPNPvg8uVzvXq6NgyDVw4+kgm+9fRrLhGZvHJPUNkG6q6MVrMy
         NVxB3abNcVx6Y024xRK8FestcO/xy9rmaHbtTLSRlQhuinfmxRft5H1mEcbVZIV76q
         bCRmo8TO8xsb16Ew6y6FmbDESkbxROQans0x12a4=
Date:   Tue, 12 May 2020 12:43:19 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: Replace zero-length array with flexible-array
Message-ID: <20200512104319.GH1393@ninjato>
References: <20200507185329.GA14436@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20200507185329.GA14436@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 01:53:29PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>=20
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>=20
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>=20
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>=20
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>=20
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
>=20
> This issue was found with the help of Coccinelle.
>=20
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to for-next, thanks! Gustavo, let me know if you think it should
be in for-current.


--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl66fcIACgkQFA3kzBSg
KbYKHRAAmXrhx9tWSk3sWXamqrmtMrkaWpfjUSFplAh5ciZIYnJXRK6kANjgZg71
4Jg9OvmnplYYo+vDCn2vkJLwcQUecWZ1kKUZ5fuEP9yQesFwNBR4HcKychcdJ7Ho
NMLiGykyMEHdDfP/sieQelJqBP1LbIDwaAf08D2JpyWdUcqHNq3KYMi6lawhqbDv
Q1vykD000oiOLJh3ZjWq4sZXeSe9mqH6ei5hn6fSk0PCTjoy7YU11AH+AtnFtEQL
wkNbmAwTrtV6LptWDOxB88FE4EGQE5n1qKlHqq0cPGUCa6pED58QzSNUByhvKQZQ
zm+qUI+n8/w13nEc840b9kR3ALi+7Jw1fd1ADThlMgAzXD2rXyfiUhGnDwtUXOaZ
IH5UfC79kZB5XALIg3yRsWsZHnMURKGMKHbXMUbg2S9gHcnsWqUcDWulbjOSVf8L
tQWvFEU1AsNS62W3KFUbG588YMwsH7TMJ9ZJPVPqRSlviOTt0AQngLv5Lx4NT9xv
b52J4/JHEagKVXOvPsOtusCLYSoR6m3RDxEpXX46zs069gxJ7IIuacMR6iyGn7Mk
RGKmEyk+yFfscDF7vSxwg4RbUSXvBERU8PFw46ay+kNNOSN934WFhbNJbeqIhvWr
KfRFvB/NaeqtkvxRshm3nPvWrtWjs8NKTyXeBkGFnMvw3f/c99E=
=CBEL
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
