Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350C522CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596665329;
	bh=ZsUFr7FgM2XpxfbHCeXrW7JvL+WBNx4Wft3trEEd5RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCHETSdQHbgFpJJOvGyAhq6hgaC/wj+ZIONRKqPp6znarxEOaos2CAWkluU76TAPB
	 QFgQI8pbpWr4LD32cvVl8hZsEpAmiEiREDM3tYQ3Swt75PddNyT9iqWjTgvAW7lu8o
	 fXRhj2hZNxcJCbBnc398UxXwKhz+m4Th9ERgMvpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHEWIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHEWIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:08:47 -0400
Received: from localhost (router.4pisysteme.de [80.79.225.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0461E2250E;
        Wed,  5 Aug 2020 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596665326;
        bh=ZsUFr7FgM2XpxfbHCeXrW7JvL+WBNx4Wft3trEEd5RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeLnj6w40Jhp8B6cMdZcEEyuXbQtdP0eCmymnX0/SZfKSKd0zowpWbUMFZrSCeBzj
         Z2skU+VDD/EiTSQAdEUDOXb9o8QCXVMZoUO2remy9zqeQ/WW9LyEDlhxIVZcfwhRnL
         T0wh1MrA1+dtwZAnYgy5QqYFC/el1me+OQJbf7H8=
Date:   Thu, 6 Aug 2020 00:08:42 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: windfarm: fix spelling mistake "detatch" ->
 "detach"
Message-ID: <20200805220842.GC2182@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200805104337.16104-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20200805104337.16104-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 11:43:37AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are spelling mistakes in DBG messages. Fix them.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

These comments can go entirely. i2c_detach is long history. And for
remove, we have debugging output in the driver core meanwhile.


--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8rLeoACgkQFA3kzBSg
Kbbf3A//dxQuXCMIP+fM3FpsD9xa0D6BvZJ9uye6lcytP3aB4nYwiyQH1Xa2chW4
DJPf0EYPgesQtRj6/VeAwrjt3I/a4TJcsPrTEPh42f+5lnBtdrjRPWI71ng37Ex8
PftsLWt0XWcveo/b1dfw3v33xLSGDq/+Ivz3perRsQjbW1+YdMXIy3WnfyxkLJDr
ZapgqtZAjIuJNGMym3RYIe6JYzHVJHzBXyNOB5IA99IdG5CvCu0IEMsX+35bCMhD
iCnA9Vnltejf73dv+ELfn5HjBCU2h813GxhZ/Wejl4E5sdgh+a0P+35ML6zOiq2O
wggmD98tGLXgshqnhJE/zEukOZY5b1rLWGvE9kWT6IMn8Z80pbgUloiF7RvddnP7
4LsG8z+soDJh0hZxDcWBZOgEg4xb97MF+7+0vS3miv8SYLqS8fwAjsJgOG/slaiC
aRCd68ndJIC4z25jkkjDIMBbY9yDI2vxUjG4igilXMUJEIEsDFGvf81uuXyZ496I
RBci3lH9ERyT5KW7xkd8WTfR/JxxHp39kOdD3g4NTh52J47YT5c8Io2StwQj+fxQ
NdQGiGR9d1oXVOXHcO/k/T8qoTUMctb5uOc8rfSUYycw0v2TgMb+AwgISq4ovw6L
2t+THEjAWKxIcej9U6b69Bj+DskSo3zoRHZZf4AukUr8awGp1NA=
=luwO
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
