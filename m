Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF26C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B0B20639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRJkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:40:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48018 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHRJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:40:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AC5A41C0BB6; Tue, 18 Aug 2020 11:40:26 +0200 (CEST)
Date:   Tue, 18 Aug 2020 11:40:25 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+96414aa0033c363d8458@syzkaller.appspotmail.com,
        Lihong Kou <koulihong@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 027/168] Bluetooth: add a mutex lock to avoid UAF in
 do_enale_set
Message-ID: <20200818094024.GB10974@amd>
References: <20200817143733.692105228@linuxfoundation.org>
 <20200817143735.099152549@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20200817143735.099152549@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Lihong Kou <koulihong@huawei.com>
>=20
> [ Upstream commit f9c70bdc279b191da8d60777c627702c06e4a37d ]
>=20
> In the case we set or free the global value listen_chan in
> different threads, we can encounter the UAF problems because
> the method is not protected by any lock, add one to avoid
> this bug.

For this to be safe, bt_6lowpan_exit() needs same handling, no?

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9a75f9b00b51..2402ef5ac072 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1304,10 +1304,12 @@ static void __exit bt_6lowpan_exit(void)
 	debugfs_remove(lowpan_enable_debugfs);
 	debugfs_remove(lowpan_control_debugfs);
=20
+	mutex_lock(&set_lock);
 	if (listen_chan) {
 		l2cap_chan_close(listen_chan, 0);
 		l2cap_chan_put(listen_chan);
 	}
+	mutex_unlock(&set_lock);
=20
 	disconnect_devices();
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl87ogYACgkQMOfwapXb+vLXHQCdF5AaFPo+xALJJPE8kIFePbu0
AqUAn3XCRYpjpqB671mtKEkGruvlVKB8
=sLE0
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
