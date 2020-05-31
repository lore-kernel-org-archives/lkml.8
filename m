Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6005C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED28206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O4m6tGKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgEaSGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEaSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:06:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD3BC061A0E;
        Sun, 31 May 2020 11:06:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49ZmT40wRpz9sPK;
        Mon,  1 Jun 2020 04:06:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590948376;
        bh=B9vweJj02hybxmeJPgZz++LIDHIcQC3lnqaWDp/+a1E=;
        h=Date:From:To:Cc:Subject:From;
        b=O4m6tGKGNfRyPgNQJr8WhsGRQKNVcLY4PlJenX1Go8406WoR5DKD06qPwfS6Kb7Y4
         fuPINvpv3qovWoaE0WRcd0KlTROZO2UwGNsU1FnqE82ZSQbiLkdwot8QBmTPQe0j+S
         gBVo6wlbaOdmYpzQdw87IiCJyXgif0UlzR+XAlJONRATvHmUO97QYE1qaYL3CzLJni
         YAeA0aLdSWsrKxzxfM/PN1dx941wrpUoY8TgqfkzMcgJccvHhwzWO4LxxOQeF3pATZ
         X/0qXKlC5/vbwb/JkrTQrZzBPAtBkClZmhxgX8GvjabMFERNoS3gu8BGu7efJ/bFjP
         RNEEjOuaOEv+A==
Date:   Mon, 1 Jun 2020 04:06:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: linux-next: Fixes tag needs some work in the irqchip tree
Message-ID: <20200601040615.34394a6a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TX70PQ63dji.RjFHgoRWKUm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TX70PQ63dji.RjFHgoRWKUm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8abfb9b77d87 ("irqchip/loongson-pci-msi: Fix a typo in Kconfig")

Fixes tag

  Fixes: cca8fbff2585 ("irqchip: Add Loongson PCH MSI controller")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller")

--=20
Cheers,
Stephen Rothwell

--Sig_/TX70PQ63dji.RjFHgoRWKUm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7T8hcACgkQAVBC80lX
0GwzZAf8CSdA6PG60eVsW/icODKRD/t1iSEiLJUxdeBnqdbUk6wZmwyzuITgkans
xe9kYHzycjWX8gfX5PLSwQhf2t7x1fsKt3AQbPUCb5mFJ1ZI89sv5wWgy8UxJApu
NhNfedkPjnTbpTYz8CaXjvNKRGWSz53yZRavtwffYArAXDm2UwWZ/eUxYqAWlV84
UI3RMiLPa+18lIO4Su5On3d+vg8BGDzGz/cq7dLej6hCjFd19KJeC2wHi+D2VcGU
dEwm3+Ou8oAH5ih7+fzgqhh6PJWnymGETfGEg8lYvLy39RrjBsY9o07J0VbcaZck
eZBwz1yRcZGGV/eNPh+ZFxtZOcxJMg==
=EAh2
-----END PGP SIGNATURE-----

--Sig_/TX70PQ63dji.RjFHgoRWKUm--
