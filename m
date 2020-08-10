Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269302076B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHJQhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:37:21 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:47400 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHJQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:37:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6737A1C0BD6; Mon, 10 Aug 2020 18:37:18 +0200 (CEST)
Date:   Mon, 10 Aug 2020 18:37:17 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com,
        syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19 06/48] ALSA: seq: oss: Serialize ioctls
Message-ID: <20200810163717.GA24408@amd>
References: <20200810151804.199494191@linuxfoundation.org>
 <20200810151804.528955642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200810151804.528955642@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 80982c7e834e5d4e325b6ce33757012ecafdf0bb upstream.
>=20
> Some ioctls via OSS sequencer API may race and lead to UAF when the
> port create and delete are performed concurrently, as spotted by a
> couple of syzkaller cases.  This patch is an attempt to address it by
> serializing the ioctls with the existing register_mutex.
>=20
> Basically OSS sequencer API is an obsoleted interface and was designed
> without much consideration of the concurrency.  There are very few
> applications with it, and the concurrent performance isn't asked,
> hence this "big hammer" approach should be good enough.

That really is a "big hammer". And I believe it is too big.

In particular, do we need to drop the lock while sleeping in
SNDCTL_SEQ_SYNC: =3D> snd_seq_oss_writeq_sync ?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8xd70ACgkQMOfwapXb+vI+owCfQmddRMmcmzR8eZPLBZ+wUZ4E
LJMAoIUocqpHQx1an8GYl2ZNOkFDfd8G
=cdfu
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
