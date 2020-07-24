Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57919C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392FE20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGXJFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:05:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39068 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGXJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:05:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0AF5A1C0BD2; Fri, 24 Jul 2020 11:05:32 +0200 (CEST)
Date:   Fri, 24 Jul 2020 11:05:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     christian.brauner@ubuntu.com, oleg@redhat.com,
        ebiederm@xmission.com, liuzhiqiang26@huawei.com, guro@fb.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] signal: fix typo in comment
Message-ID: <20200724090531.GA14409@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix typo in comment.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/kernel/signal.c b/kernel/signal.c
index ee22ec78fd6d..6f16f7c5d375 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -719,7 +719,7 @@ static int dequeue_synchronous_signal(kernel_siginfo_t =
*info)
 	 * Return the first synchronous signal in the queue.
 	 */
 	list_for_each_entry(q, &pending->list, list) {
-		/* Synchronous signals have a postive si_code */
+		/* Synchronous signals have a positive si_code */
 		if ((q->info.si_code > SI_USER) &&
 		    (sigmask(q->info.si_signo) & SYNCHRONOUS_MASK)) {
 			sync =3D q;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8apFsACgkQMOfwapXb+vIGfwCePKACX4JlT6eagiqVy1ITBk/q
M9oAoLGKtDfBfxtYfAgu5u6x29pSVu01
=R3iy
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
