Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B825CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5AA2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V4w74ltL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgGOEZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:25:43 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A63C061755;
        Tue, 14 Jul 2020 21:25:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B647S2kkwz9s1x;
        Wed, 15 Jul 2020 14:25:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594787141;
        bh=PIR4MD77rwKLqJ6yQ8k6FdIRDzr+gc5sZZ8je9CemGI=;
        h=Date:From:To:Cc:Subject:From;
        b=V4w74ltL0Rr9F9/FhUKVV/qjSOzXk4tOwnRcKX1RPmuP7SRfQso9jZY5lNhm2QR/b
         8bvl4KhRr5orrFfXrjesddkri8FzLP7QilCkyo5N4RPYZwmNgXv3umFxVsykOaOxt0
         KuuAgVd9iHf6IQhIVW9r+85VT13H3oj/lGfA1se0W/hAaMC7IXuwqpnVuSo1IvGqNb
         eNfNeTntz1PsRtQV2p7ss+1K8BCoMx7VGyiU7kOykVz9H1t//7kPNfv8vV0y3yUNIZ
         qfq9KofgHcVKbCtcHES2JSeiDeCebIMFd12DdhXpBHmgGsfZ6FDQRXGKrr0MjF7dWH
         n+796OowKykJw==
Date:   Wed, 15 Jul 2020 14:25:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Andy Gross <agross@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: linux-next: manual merge of the tty tree with the qcom tree
Message-ID: <20200715142539.4a3b34c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g3erc/IK63cHOMtHNP1g9s9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g3erc/IK63cHOMtHNP1g9s9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  drivers/tty/serial/qcom_geni_serial.c

between commit:

  650c8bd36a66 ("serial: qcom_geni_serial: Always use 4 bytes per TX FIFO w=
ord")

from the qcom tree and commit:

  3550f8979a7b ("tty: serial: qcom_geni_serial: Clean up an ARRAY_SIZE() vs=
 sizeof()")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/tty/serial/qcom_geni_serial.c
index 07b7b6b05b8b,1ed3d354e16d..000000000000
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@@ -768,8 -718,8 +768,8 @@@ static void qcom_geni_serial_handle_tx(
  		u8 buf[sizeof(u32)];
  		int c;
 =20
- 		memset(buf, 0, ARRAY_SIZE(buf));
+ 		memset(buf, 0, sizeof(buf));
 -		tx_bytes =3D min_t(size_t, remaining, port->tx_bytes_pw);
 +		tx_bytes =3D min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
 =20
  		for (c =3D 0; c < tx_bytes ; c++) {
  			buf[c] =3D xmit->buf[tail++];

--Sig_/g3erc/IK63cHOMtHNP1g9s9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8OhUMACgkQAVBC80lX
0GydPgf/XJg53cpOA6TVJuAbToLebJbagnAjG0ItAiKoahhkmy4bJlqWuROGzGsW
UF5TK3SpHEtx20K96bxggB9WRwQNYMzW8kS6IMvyY4xA6KPIfDkpHLUQNFxhZYMz
dZzPAqDkaW6tTMrzTGukiEC5zjGXelKD03W3DRB6OI8wlWE1L4FbPBn+CwtCx6pz
020vYjNlahbBi+PGyZ0425hN6U1vFXEzStXR2DyWaRxOBv+jLeps+ASGUwt1lyCJ
PLrjN0poWN36OMUArGxawLHxwhrLy9fBB6uZHIK2MC572LHlLcNppNBRBaZoasFR
63M/9ltzaBmJzP+l1yTRJVXH1F3L9w==
=0bez
-----END PGP SIGNATURE-----

--Sig_/g3erc/IK63cHOMtHNP1g9s9--
