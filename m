Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD31C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05262072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jRn9Iidl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgCFG65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:58:57 -0500
Received: from ozlabs.org ([203.11.71.1]:48413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgCFG64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:58:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Ydkk0LZpz9sPK;
        Fri,  6 Mar 2020 17:58:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1583477934;
        bh=pxyWfuCIMqjBgePFrMlMkR5TQacWajrnphmdy8mtvKc=;
        h=Date:From:To:Cc:Subject:From;
        b=jRn9Iidl45h9jqesHgujAnhq1tHTbw9bm4jGeJG8PAMpk9K1XdjnAPG/Mn0islokq
         ozjPhV2F7eujDPxor5zYZt2YGWO11aLPsAYg1kIldaSBgnNqxq/uHG9zG/CJq0mZeY
         A4Nujo2whnOeYeRgUH6jueTkphGbHkF6nF5+y6/G0neT3RLIKDiLjwvvVXJMxyS+e7
         X9y4KKYEpRqZfL64jI3VYunm5EO10kptUUrzY6YMgPQxJ7+0RauG3xpUWTemM/kPLu
         +AHrTCy1l+NN7Hej3eJotcw0uza2o4i/uCVJUwrsHuXur0bxGOZ/FmGBzt6WUEEIbU
         fu5utIONr1RyA==
Date:   Fri, 6 Mar 2020 17:58:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: linux-next: Fixes tag needs some work in the clk tree
Message-ID: <20200306175852.5f5c74f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aE8HQkafehcTjX8JXg0/4y5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aE8HQkafehcTjX8JXg0/4y5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  55c13463b652 ("clk: rockchip: fix mmc get phase")

Fixes tag

  Fixes: 2760878662a2 ("clk: Bail out when calculating phase fails during c=
lk

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/aE8HQkafehcTjX8JXg0/4y5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5h9KwACgkQAVBC80lX
0GwPjQf4ufRZzgYVv0jUkV77z2RCqiCZ/vR1Eor9cWx66UcN0ZPCEQcjeFMmDVAW
kgHmb2wK2dA3IRk4Yz/hkBwhKapeXZZANbmww02miAfVcoIDaKUojPXIH1oh8o/e
AGV9ExlFnp2uQ7/i6YVPWc2M/nt8YzEDS71Jhps/m/0IpsCmleQR+YyQoCVs1B0T
T8iMgO/pr/o53dtyI8gGqg+M1+lHbCVZJePUTcx8YsRlVszbcIZUv5KPiWB3qjQ/
/7FLtnmxjEOxcGirndLHBlu9UlEfjfx2QUpEOfWf/laB8hV36TA8gX52ZTs4qZOB
ZZXj5PkFJ04PJBqQKy7cnCKkrPRk
=toMN
-----END PGP SIGNATURE-----

--Sig_/aE8HQkafehcTjX8JXg0/4y5--
