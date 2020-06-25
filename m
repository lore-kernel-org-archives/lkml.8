Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F86F20709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aHFI318m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406780AbgFYVps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404502AbgFYVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:45:47 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B5C08C5C1;
        Thu, 25 Jun 2020 14:45:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49tD8m29pdz9sRR;
        Fri, 26 Jun 2020 07:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593121544;
        bh=aDjKVLnzb134O+bV8vA+mfyP1Hq64P7ButQ9muYwHnc=;
        h=Date:From:To:Cc:Subject:From;
        b=aHFI318mo7T1xtl+FtWAMilmJaKZG89iBz0T83kbaeOgn6/WbgqvhBHMCA7uX4Ip4
         n8qdqexZNGp0aty2P5j+KlVL+HBXNuF5MgEFmY+5Hr1feI9kxf5bC6zvA79Zfsadth
         6fnPAH4SO6xNc+K3sq4UbJs0K1uYIXytOwROMaEXvzjSsQgTmUm0qHjq7LtOYHfWUC
         Kd7NxCIdd6iNPHFoJhWT9vbGsniltUOBrWTHbXD0kCz7S4wCcNxnwBVLQ1PVwe9XCI
         Dns3cpkmR8X/19tPRn6YONwThRVqFnHa0kzLb0ngcNIttBK5DNaJQnvJbO8/0PI6Mk
         vwQb/kuhUF3JA==
Date:   Fri, 26 Jun 2020 07:45:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: linux-next: Fixes tag needs some work in the hwmon-fixes tree
Message-ID: <20200626074543.2d1d95e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/COu=8co51qCF3zV+hBexdlc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/COu=8co51qCF3zV+hBexdlc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a899847a6012 ("hwmon: (acpi_power_meter) Fix potential memory leak in acp=
i_power_meter_add()")

Fixes tag

  Fixes: commit de584afa5e188 ("hwmon driver for ACPI 4.0 power meters")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/COu=8co51qCF3zV+hBexdlc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl71GwcACgkQAVBC80lX
0GynZAf/coTBfCYIMcyYoWgm0KepXh0W0ZsoZEeIO9XuUVH/q8ApJqvtHdGJKU1I
zJtfMQcy3tjSumyShjIgZ+MZ5cJcdHC3Fvt16jTSfETRakof2LLkBtNxImUjhBlN
ygBp5FyyoaPODfX8DcF7uAWa+trdFeM0KBrQPOm4gd759d3TuHtSIqu+TX+qOhB8
s1ybOIwQwOKyci47Ry/4gvbVOW/nM0waG4CMLXK8hADIGBYHEztDCP9hy17DuOU5
B4g016Nuga+DbLIa/if3Si/STEGiHxzz49uWy+LJeeq+POIVwprjW5gWfryt+MxJ
mdjFjOeKsdSnnTijD2uN6AqsHb8KgQ==
=uUFJ
-----END PGP SIGNATURE-----

--Sig_/COu=8co51qCF3zV+hBexdlc--
