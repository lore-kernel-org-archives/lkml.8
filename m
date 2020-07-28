Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9994BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F40206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mXf6epIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgG1MYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1MYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:24:55 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF251C061794;
        Tue, 28 Jul 2020 05:24:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGG8L1ZzLz9sT6;
        Tue, 28 Jul 2020 22:24:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595939090;
        bh=xE5KgJ0KYm9OWgxJkU6eZprqnvo190SKhgw0C7eXmTY=;
        h=Date:From:To:Cc:Subject:From;
        b=mXf6epITzmy0iFNTWgFA97LO3GepqBk4wICqbhK1p4K8172mdbK1KoL8cBSMCUSxc
         7qzvSCcOMNYAP7qBA/20xd/QZFTVKp+LoivQNc5ytDvonwHN8zw6N9kpHD3qRAbY5I
         EGi8oKTNgORMU3dlEhUHZG1e9i103ZGHHruyx4uxQlG1KCNO86h7VavhhEi9bFcGrB
         3+sJqU5b4dhh+o7d8dOaN6fey1UY2Bo8IES0RYIj/2GN3E9tAvWcDKIMImRmpuv2Vq
         02ZmTQ+KsLVQ2SsnvVV8R6jDp2+vBuNW64GPpJwe/6sQduPDz5lRTX9DnzZF3ZSn74
         99YOTOX/e4ugg==
Date:   Tue, 28 Jul 2020 22:24:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20200728222448.035e6280@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ynG/Bd_+_8L9q2AR0CQYUUy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ynG/Bd_+_8L9q2AR0CQYUUy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluet=
ooth controllers")

Fixes tag

  Fixes: 81cac64ba258ae (Deal with USB devices that are faking CSR vendor)

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/ynG/Bd_+_8L9q2AR0CQYUUy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8gGRAACgkQAVBC80lX
0Gxcugf9FeyKqRKK5dCNA6QP7AVQdEBDEB80YCCQ3HgY8e2X3Ar6aO9O8GoGDGqF
0ILhXiQrG131CeP2Np+axsy/HEEBpL0KxO0tk5fRW61V3RvgjsYIJuTwNRiwQ504
oZGTh5nhTig7XhoxbxlyjbMSL1dMYyfMZqE7aP9Q/qoxh3o4HA6lVslwbCLtQfLC
6vCcDKGMf4ySPyPXdt2Y6/FZTGUrxo6G4lRxvFSwj13nS2T0DN0rhQqL2whOo9x9
IodFrMhRKjzUFWY2XPXoXdIQGUq+DKdWBVSO9p55nL0L37dUWEMrVEK8C26DG416
JbnykkvTCZDF0PXJyo+gix3kZ0xq3Q==
=uLLz
-----END PGP SIGNATURE-----

--Sig_/ynG/Bd_+_8L9q2AR0CQYUUy--
