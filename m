Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E815C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E8120714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGZH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:58:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36010 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:58:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 586551C0BD9; Sun, 26 Jul 2020 09:58:28 +0200 (CEST)
Date:   Sun, 26 Jul 2020 09:58:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     jack@suse.com, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] udf: use common error code for unclean filesystem
Message-ID: <20200726075828.GA26460@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Use common error code for unclean filesystem, and warn when
incosistency is detected.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index adaba8e8b326..8e74c7b5b8d0 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1395,7 +1395,10 @@ static int udf_read_inode(struct inode *inode, bool =
hidden_inode)
 	if (iinfo->i_alloc_type !=3D ICBTAG_FLAG_AD_SHORT &&
 	    iinfo->i_alloc_type !=3D ICBTAG_FLAG_AD_LONG &&
 	    iinfo->i_alloc_type !=3D ICBTAG_FLAG_AD_IN_ICB) {
-		ret =3D -EIO;
+		ret =3D -EUCLEAN;
+		udf_err(inode->i_sb, "invalid allocation type: %u\n",
+			iinfo->i_alloc_type);
+
 		goto out;
 	}
 	iinfo->i_unique =3D 0;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXx03pAAKCRAw5/Bqldv6
8sM0AJ49jsPbBFlJqe22EPicSoQKkk0zBgCcCJmxCteAsi8FiDXX6xxxj0o0Soc=
=JAtz
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
