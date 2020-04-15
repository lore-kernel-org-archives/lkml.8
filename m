Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4901EC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AC3206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415709AbgDOQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:22:45 -0400
Received: from sauhun.de ([88.99.104.3]:56374 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415627AbgDOQWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:22:39 -0400
Received: from localhost (p54B33507.dip0.t-ipconnect.de [84.179.53.7])
        by pokefinder.org (Postfix) with ESMTPSA id 38B962C1FF1;
        Wed, 15 Apr 2020 18:22:37 +0200 (CEST)
Date:   Wed, 15 Apr 2020 18:22:36 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com,
        Chirag Parekh <chirag.parekh@xilinx.com>
Subject: Re: [PATCH v2] i2c: cadence: Added slave support
Message-ID: <20200415162236.GA2830@ninjato>
References: <20200106104336.101987-1-radu_nicolae.pirea@upb.ro>
 <20200415125850.GD910@ninjato>
 <d7bbb013-aba1-6623-f656-46b3f5689834@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <d7bbb013-aba1-6623-f656-46b3f5689834@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Michal, do you want a second look or is your SoB good as-is?
>=20
> It should be good to go.

Thanks, Michal!


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6XNMgACgkQFA3kzBSg
KbbAiw//RBrtmb0bH65DgAGQFsaUex9274i1aOt2WRAxBxxsU9KYpjYXZTJtJIPM
H+rQ2NZORdTz4Vbk7zWzL5cPWVgTgayyAEgTUWmggvji1mahB9ATMMhRV+YT8IT8
lfyLZ8jr8pkanVFa6FE0aC5fwY/O8mCLesPbIwV3UhFv4CkTgh9HZcBOs0zzyqFd
gkSBkmn5y8A9YnovysL+Rq7HAfd05UUGdkGPca6zW5RzwdELizUC+Nh7ZREhyUUr
w7IjyE61kxdxSs10+IEyKzv9YLdsBfWcDbjYwLCeyadeSwjPyW+quD37TdGxHjPM
xdBKCnOffArucQz8PhghU52AUkjEWMhEdNE2ri9PlfsaodT7LweoqIRtpyinWH4D
uPdsX071f/GA6I9nGtvbJRh/ogVYySTAZgRfxeMMexWptKcOp60Ta7q1Pkbh2Ryl
E7b1eYm9wNriBi5vHpRyvSpLstfcJUL55fxlfdwlH+zGOuHP9ayDn5i+5T4b7HIu
6QdGkeYQRoVCEbeTk1vlkAhE9q0dgeAWldtDrxrCWHx5VAJi0+PeR80avDwLXfyM
78dA+74416jx2MEXu1LhAbQU1ep5P+qhtcQ5HHctU2hVdC0tMKMs6E9gT9sqdZaR
/14imMDRUa6Qqu0gVJQBvAh7PsxoYPTd7tMBuyvJEuwfJ8SX41A=
=orf9
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
