Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E0620714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q3qy06sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCQUpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:45:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40809 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCQUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:45:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48hlYg2tFYz9sPF;
        Wed, 18 Mar 2020 07:45:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584477944;
        bh=GNAt3ZfIq2TFTOzUID+8ZKmeZT9A33+B2tTcGL9o4v0=;
        h=Date:From:To:Cc:Subject:From;
        b=Q3qy06saYDBmbJOPbNk6lFJiv3lUz8coi6Db+onbUwrAv4Z+zXaXRMw//gt7/hFAa
         R6mqPDd4Z7/ptLgdw0YNR8fmjEaKgqktK5BHiJAh9dNvtklPOF2nYufvVgFWAon0Kd
         0KCtPKtYW5UTWlJpfuLJRZl3TomboXyN+ShrxmOqpVJHF7/JeLERfMBWol/xTkQIzR
         EjXzYXOJnvavIVkS83n5ZOdO1iCS93KGcnhOAZ1lVs5TjpdzHrNDpiuKR7vXsW8qNQ
         TOS7WbXrdvUQlk1q+kjJzfhoyfeXjWhOc8mUCXQGd+r+0SxbQwB5VN3Zq04tUn6yq3
         OLSrbxBf/MmSQ==
Date:   Wed, 18 Mar 2020 07:45:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the chrome-platform
 tree
Message-ID: <20200318074536.3121af53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lP=C7q9jzz//g.p/pMd+2lR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lP=C7q9jzz//g.p/pMd+2lR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6314450ece4c ("platform/chrome: cros_usbpd_notify: Fix cros-usbpd-notify =
notifier")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lP=C7q9jzz//g.p/pMd+2lR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5xNvAACgkQAVBC80lX
0Gw3qgf/WYuPDnuoGpGOdHW5QzN4aOzwq3lRZ5R1/i5qZBFhXezXC/BTvpN5/3Sg
r/jT6GFRf3pmCISngogfvdZMGCjwN9IzhR0VnCpi887smYz7kfV75JukUs2d/Eg/
I2IdRdDts7hRrR7Sl9dMXdppm/td2L2EkrpCDpwUfHxGEzwqbxAIuDp+PI32tjWf
PvSNSzvWJJ0oTwlPb96UlUg8RPz9EjywfppwqxntU9BoqkjhxD47N/xHqCcXy+Hn
c01KfVKeoTHxfqZEy2cF+l7+JtxXn3rZCPuWS5AOtNYN6jGmymlnwrfkXakilZZ+
MFguus94W0MbY0wdy+8KVCQVUT0Jxg==
=/Eos
-----END PGP SIGNATURE-----

--Sig_/lP=C7q9jzz//g.p/pMd+2lR--
