Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35515C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1570F207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IFKFTQDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407541AbgE1VFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:05:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407439AbgE1VE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:04:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y0Zc6qDVz9sRK;
        Fri, 29 May 2020 07:04:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590699897;
        bh=W9D3NlUd6bS1YP3JzQU9dUV/4I/5H4tWP9Jq3NIKG0c=;
        h=Date:From:To:Cc:Subject:From;
        b=IFKFTQDHWdsEM1kHC1fkxq+tR8v0bAZmJtou81pkN2d/ryWE5Vz/ZOePbJnGvCkU8
         NLy6Vqw29kY7aZ5W15kVrCHdJkMn5+5ohFqWcjHpqDH+eCNW8r4IZcRWJ01i3+MyuL
         i1/uBMmI82QI31xOAzBWdJjQPHTGRPyfBR8vgCqhJ++mc5XlFIYSzmmcoap2RH5E+8
         7e/lgkiTcC7Wx0cWMAhrpcDKUtJrTNM3vXYr4tusKTf12kXuk1h/M7/i9CMiVpsR5Q
         osR8+2iunSlhPVeMXTJZkya3hFBLFxruQfZiDFXB6COyJezgFmQLh9UiXQfzhLGrM4
         qCxgzCC10p+TQ==
Date:   Fri, 29 May 2020 07:04:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: linux-next: Signed-off-by missing for commits in the gfs2 tree
Message-ID: <20200529070456.0cf00c42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NP3WIGjLhCkKwUSsy7eCFq2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NP3WIGjLhCkKwUSsy7eCFq2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  97f1bb642510 ("gfs2: Allow lock_nolock mount to specify jid=3DX")
  b554330a6165 ("gfs2: Don't ignore inode write errors during inode_go_sync=
")

are missing a Signed-off-by from their committer.

These were rebased with no changes :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/NP3WIGjLhCkKwUSsy7eCFq2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QJ3gACgkQAVBC80lX
0Gzlywf+KEkVAEQPyOHHki4iZP/zoXjZfAK9P0o0O5AOaRRKUNXHHS67y0rF92tx
swrGOlA5AvXBAYVLq0AZ2JseH2oImQuwwv0y+o2x5d5P12XtUfrJiDylX0Fl6ufc
BW/OwSFI0RkfZHJLQFiy4WiVQRCtim+C0nF23yu77ByXMRfGHTLTNNhmle/0tRWl
PFyMog7g1wBfvvuZn8yR2bNFdekp1x36OEu31b6mMH3v0c3llLByR5wAeM0qS4p8
AxAdql8j5uwSXSC0P/bjQ+Pu9KFaeON1plbhZZWXLe2plRYxl5DclqZu77JyWQJD
AplyYYfh/+IShyObaeCqEdo4J7if0w==
=ZKeO
-----END PGP SIGNATURE-----

--Sig_/NP3WIGjLhCkKwUSsy7eCFq2--
