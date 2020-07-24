Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96E420767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGXMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:44:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54924 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGXMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:44:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 820931C0BD2; Fri, 24 Jul 2020 14:44:43 +0200 (CEST)
Date:   Fri, 24 Jul 2020 14:44:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     trivial@kernel.org, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ocfs2: fix unbalanced locking
Message-ID: <20200724124443.GA28164@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Based on what fails, function can return with nfs_sync_rwlock either
locked or unlocked. That can not be right.

Always return with lock unlocked on error.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 751bc4dc7466..8e3a369086db 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2871,9 +2871,15 @@ int ocfs2_nfs_sync_lock(struct ocfs2_super *osb, int=
 ex)
=20
 	status =3D ocfs2_cluster_lock(osb, lockres, ex ? LKM_EXMODE : LKM_PRMODE,
 				    0, 0);
-	if (status < 0)
+	if (status < 0) {
 		mlog(ML_ERROR, "lock on nfs sync lock failed %d\n", status);
=20
+		if (ex)
+			up_write(&osb->nfs_sync_rwlock);
+		else
+			up_read(&osb->nfs_sync_rwlock);
+	}
+
 	return status;
 }
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxrXuwAKCRAw5/Bqldv6
8mMZAJ9ImD3Zna3EbjqRkZmQ9g+j2FIR+ACfVSoDxZcmWOs5QfVBWyriyW1cD58=
=ULHo
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
