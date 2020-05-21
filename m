Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5762E207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UEzQ5pIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgEUWYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:24:38 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FEC061A0E;
        Thu, 21 May 2020 15:24:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Skgk2cYmz9sSw;
        Fri, 22 May 2020 08:24:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590099875;
        bh=7UG/0ck8m7LjoDlF4HVoIgucDjHFyP6zo05vApL+ymM=;
        h=Date:From:To:Cc:Subject:From;
        b=UEzQ5pIW5hUBmYnQCDpFUASjTsqHKabf9U/6Nx5IWSdHTkMpO67dfECTdKmBVljCO
         NyPtIpYtadOP58GB0yMMmHTXzN6HOi4pwoxMqzRP6kVoTp1E8y8+5zg5IbsOyLxAfz
         BucriDS51z7VQdOlDmxreYQ6CiRNgGNk9l7VPo4m4MmNiKdC82h9EBFLo6wT6knLh6
         KQUsANFtf+bYGSPLdptdOwghrG7DrvA/uppgbkCjf94dKViUyn7bLqlwZsWRTnbFj6
         FUARyHhkUuw8eNbk5W9epOS87MwgOyqIHJGtnOFj9qoYGez8yVvoVGYpsMLU6b3OOa
         C6MZ68mzNS21Q==
Date:   Fri, 22 May 2020 08:24:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20200522082433.4f536de1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IvXSHzRHLZYRGpsc1AlupoL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IvXSHzRHLZYRGpsc1AlupoL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  82ab9b6705bd ("dt-bindings: arm: Add Akebi96 board support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/IvXSHzRHLZYRGpsc1AlupoL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7G/6EACgkQAVBC80lX
0GxLaAf9EWgzgWFYzJys9wwd6evMVEzq283JeOvE9oecgCbCYioxmpjTBx9fMt4x
Z+txmXMofZYtQbVYxzYPrPXu5+dVZvAkszA34JxycWg7ZBeKDnoo/voKTiMujp2x
7FR8GLWERnDKWormbLGFwuiRZ80ecScswc59xURYFc3RbVmh/qmiDhaOLpSaPv4P
r0tSlgx0RHYIpOHxYx1l2Ca5bloHeLUDQkgjWSEbRrH7Ip8tcAeVHJE2LqUnoOzv
0mChkGynxqxyhetQiV7eDNPMUqMMfLfMWa2xkh0Z1PXw0NnGC4h9Q75ipkoM+L7S
NaUNKYM/br5U7F0qHVCEBzXIS6SSYg==
=ow/L
-----END PGP SIGNATURE-----

--Sig_/IvXSHzRHLZYRGpsc1AlupoL--
