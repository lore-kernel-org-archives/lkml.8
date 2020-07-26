Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3092C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1D320658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OV68xrOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGZVfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 17:35:53 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E74C0619D2;
        Sun, 26 Jul 2020 14:35:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFGSz5qCmz9sR4;
        Mon, 27 Jul 2020 07:35:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595799348;
        bh=U4+doO87YfiQ8TfrG68gHFASpqd3gJZjpLl0g3Og/cA=;
        h=Date:From:To:Cc:Subject:From;
        b=OV68xrORyrLwaNgu5F9lhr+Ew57WFjwijvKI1mo5+y3BQgP5J9f+4WcDQx+1CVvE2
         WZRvPWgcA2fEew3F9j9M1RRi8Mf/7EjyUerOT9X1kgOYF5/tfBsiUl7s4PtvlePdWM
         k/JR4A9qJNtVlSzuSnAwmoLtYOiGMmM+ADjpz4ECylVqa+4n+H35umLeGTwxoNgo3o
         MUok8ZogjTdxqISULcbj4BcygOV0zG0U1hnu9gqu8CkObzxkC5AqdJlR+X7hIiDYEd
         iBvDB1qymTSeSCcWuLA+fZjTfJxJ6iDHwTP6HXeWJ9DwLZLVYKhfoTwklYzZ+RdmYl
         KWUwE83JGrU8w==
Date:   Mon, 27 Jul 2020 07:35:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
Message-ID: <20200727073547.5c556e10@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qDztKMFnjS8ntfQf.Q_07a7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qDztKMFnjS8ntfQf.Q_07a7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  16730dda542e ("ARM: mstar: Add dts for 70mai midrive d08")
  22a30e8035c6 ("ARM: mstar: Add dts for msc313(e) based BreadBee boards")
  b6d785a8410e ("ARM: mstar: Add mercury5 series dtsis")
  34a6a898b3f4 ("ARM: mstar: Add infinity/infinity3 family dtsis")
  b968eee1862f ("ARM: mstar: Add Armv7 base dtsi")
  d1c7f6eb7e48 ("ARM: mstar: Add binding details for mstar,l3bridge")
  9c2387eeba44 ("ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs")
  04c7bb3695ef ("dt-bindings: arm: Add mstar YAML schema")
  97771c5bcbe7 ("dt-bindings: vendor-prefixes: Add thingy.jp prefix")
  9f9b6e5560fe ("dt-bindings: vendor-prefixes: Add 70mai vendor prefix")
  13fd6dfd3503 ("dt-bindings: vendor-prefixes: Add sstar vendor prefix")
  cb0d5cba0294 ("dt-bindings: vendor-prefixes: Add mstar vendor prefix")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/qDztKMFnjS8ntfQf.Q_07a7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8d9zMACgkQAVBC80lX
0Gy67gf/X0b8NsmgXXqGN6/nQaYNXlIVWWQsKstkf8wyc7Ono+skiCDQjo7PJgna
nsa3IZ9RHnJpfmszZVUZOhjklhDWxjYbF33COVrJH9Wl/h+CD/JMWplVWXbxlWR/
xmiQvI+H1pB8zswPXMELa+YnlBum9At5T3AmeT/EIRu87ynXwCAIuMkIRZnVGPX0
sWmlIsoGkLXtJDMkKUJgdBvDR+zDmztfwdG7s8gYCWBdm+tfcHLo9WF0xuVSArZh
AG4qQvACN0LcDbc3QsVvGSKU8YU2SqAAqycuaUf2S3yRLixm8dcxTtaZTLu10ga7
4aPSBGmFBOYHVuS7//BZ+/gB/s0z2Q==
=QnKX
-----END PGP SIGNATURE-----

--Sig_/qDztKMFnjS8ntfQf.Q_07a7--
