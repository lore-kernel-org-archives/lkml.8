Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67539C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBAB2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DeFs2IHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBLWZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:25:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgBLWZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48HvN61ZWjz9sPK;
        Thu, 13 Feb 2020 09:25:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581546310;
        bh=5Ozm5xx+3DdQ1zIW8D90UeqxLNEwGBSksX3PJvuTcFg=;
        h=Date:From:To:Cc:Subject:From;
        b=DeFs2IHu+DohMUfTs+AKiMIX8kwfZFWw7t1Rena1WfbpBQ+unHUqkgPirS/rKGx6T
         afV5dpbTah9UWn8BrZg+SuutXpCRNByH9gYR2x45pJbp6IhG0XaUo0Ez/rbU7AvYya
         KByT7H09bJQB8Bl7yewsi2V95lXYyQYr/oUEfI2tTONL9UwHEaHBbx1H+wJTlFDIHf
         fusATg1fPDUyjFgh5e5PVxGRdURhYGZk8J+kZTOv3prs53pnYuslAQVaz0/fZfyazV
         aUVbafBy1PXMJGJMXsCnQqWMU5bFfJOF0S/j6Azy5SBj+MLc9T+74GGDcHSqfjMor7
         /EExt5/laRDPw==
Date:   Thu, 13 Feb 2020 09:25:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Amol Grover <frextrite@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20200213092504.27fd6dc8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/65DsBl+EQgpMkEosoWHGG4A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/65DsBl+EQgpMkEosoWHGG4A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8e3a97174c3b ("doc: Add some more RCU list patterns in the kernel")

is missing a Signed-off-by from its author (but does have an
Co-developed-by).

--=20
Cheers,
Stephen Rothwell

--Sig_/65DsBl+EQgpMkEosoWHGG4A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5Ee0AACgkQAVBC80lX
0Gzt2gf+Myl4mLoqUOzhFWS9bIN4leb3kyPEcX6zFD9HUOkHGe1zFAswy2iODgg9
iXRjcnNdQYHojOUwJ/OMnySfxwI/5ojF5xt6+D6HN21JCh/RNVj/gJuP+8jk/Cat
Z9c4GxgIJQOe8KDYhDloT4j8OmFdHqMTtLrGxA1VtnSYy9+NnlxC64AjVsh2bFKw
21X0BClxyGuQemaaa5j2kYRuEDNizBbusP2BZycaW4FuRlLTRrnKba0An8YRsSPa
2yCSi5A8+2bek4cO6jEzklH5VfgplK34/K73OjU6dFq3a1kXgo/JBO16Egk91uPd
JE3GcOOVCC/AupgatHnnNiCpknqrag==
=TdaI
-----END PGP SIGNATURE-----

--Sig_/65DsBl+EQgpMkEosoWHGG4A--
