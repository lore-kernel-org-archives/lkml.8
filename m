Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E97120732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592827750;
	bh=8+Idn4njerhZdj55dzmilrDtt7BWlwIiPjViGtK9Bec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bFxbk7iCwCY7Swjrl1c60ETRzcJkgbzAfY2F8t69P7vCflBzKirQZbw3zN9ahha2J
	 zUkRjoMYepV71qNd63C0HgLRyhQ2nWle77o75YEhH7zejBbnMQbVZ2LTog/cPG6/Qc
	 bSbcp3UcLL2asCvMXyoA3LVUlNuyQ+z4cGhcb6nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgFVMJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgFVMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:09:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6F920708;
        Mon, 22 Jun 2020 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592827747;
        bh=8+Idn4njerhZdj55dzmilrDtt7BWlwIiPjViGtK9Bec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YufSqIhbppNX8i0EteJvQ+fJx/LKXRlTzimzgUaECnNZ9BgQXD3+3SqoxxGoigXo3
         +bQyd4x+WIPbwSw/Eiogr6zDrjGZ2hFdrqHrvhnFjcC9mZUoXw8xI/BiZAgOOKGt+9
         Ku7G6RLzbPdh1kmTPtZM2gOqaTw4//4XpLi0S9mI=
Date:   Mon, 22 Jun 2020 13:09:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] regmap fixes for v5.8-rc2
Message-ID: <20200622120905.GE4560@sirena.org.uk>
References: <20200622114015.60DD1206BE@mail.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20200622114015.60DD1206BE@mail.kernel.org>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 12:39:14PM +0100, broonie@kernel.org wrote:
> The following changes since commit 93b929922dba3a42b0439ef13144c6032b7733=
c8:
>=20
>   Merge series "regmap: provide simple bitops and use them in a driver" f=
rom Bartosz Golaszewski <brgl@bgdev.pl> Bartosz Golaszewski <bgolaszewski@b=
aylibre.com>: (2020-05-29 14:00:44 +0100)
>=20

This (and my other pull requests today) are unsigned because I've
automated the final checks and sending of the mails and that's not
really compatible with signing the mails.  The tags themselves are
signed so the signatures on the mails should've been redundant anyway
but I figured it was better to say something.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7wn2AACgkQJNaLcl1U
h9CpYwf+PVuglYQqaRjDuOXTccFpSK8FwtBOGK+9Vg+qv0zXKG8aouPfB6+s4vGy
yRJmTq0MdAeUVhRQjM3w15uvgFrKDdLMMYws5xf+jxEYNHTum8hH/wAADaHR0a06
qaDC98+chfhbyZAI8s9idBOBkNsoRKndJvDVmavK+d5krrRjXAnH/mFSn9Px5OQ8
st4XkWjw9dpc8sEQM3Fke0m0nt/W8EvJLaa174gplsj4SBI9CWtpUzEwzeUngsFd
aombos+PxU601d7tH6rPf3XTjzlXs8EYR2JkizJG5ZfDkVRU5KrDgziSMsx5q1mR
wxDCNtrHwcy3uNHhDe9eI/oZLss7wg==
=NQWH
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
