Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077DC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACF32071C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gSw0lK9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgDVAlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:41:37 -0400
Received: from ozlabs.org ([203.11.71.1]:53389 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgDVAlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:41:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 496M7d67ZSz9sP7;
        Wed, 22 Apr 2020 10:41:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587516094;
        bh=L2zA9Fpnr/Jts8P6O7HcJoD8e8snLFFp1fERp3NLm7U=;
        h=Date:From:To:Cc:Subject:From;
        b=gSw0lK9Z23LMn+5DG3eU+g5AZMMQf8r03UOos3WGgKbtXs+P/G/pFbUEFsVnENYTp
         IMGrgPgtXwFD9pjtrMyGuxwuMKjB3RXJUTABi3z5+IxN/XRoYt5LLTiWSU54JwYolC
         hHRPeCBbTpc1m52q3iVayaHJSHrONHzhT+Xv7C5wpjJCK0pPhXd0s3echr9N3KpHJU
         ZP9jFQ6OSA1IqviLaf8Q+1pkQfTjD1ohvq5SqGjTDWMgyYkD1/u0GhUrtAGzSOVA8q
         OAuuGkS1nmKnqvGkth9TtvoduWzOvsmkdoGuI8k/7dAF1++/eNZuQufQCu8cgmY9HY
         //J3aUZCgWItQ==
Date:   Wed, 22 Apr 2020 10:41:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20200422104130.28d34c28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kG7t0=QmNTqDD6p3gjGiolI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kG7t0=QmNTqDD6p3gjGiolI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/media/rkisp1/rkisp1-isp.c: In function 'rkisp1_config_isp':
drivers/staging/media/rkisp1/rkisp1-isp.c:294:14: error: 'struct rkisp1_sen=
sor_async' has no member named 'mbus'
  294 |    if (sensor->mbus.type =3D=3D V4L2_MBUS_BT656)
      |              ^~

Caused by commit

  4d0b43804c12 ("media: staging: rkisp1: remove mbus field from rkisp1_sens=
or_async")

I have used the v4l-dvb tree from next-20200421 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kG7t0=QmNTqDD6p3gjGiolI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6fkroACgkQAVBC80lX
0GxsnQf/bjgsyR8siWaQc70j2+tkNnbgo+v8k6UpiRKsJRO/V99I1rmkb1IOK7ek
lQU+OeHRCA5EKOlBp+r/k9xF9JNxRBHkkLgXTyGuPwKRTXKY+HZKwZBdNsgqgwfN
pCwAsMJ5/UPMrkncYcinDgJNbZBzepusaABbkpbYtI8/+RJHr5CRYyx3pJCUpEw+
hJHsIRlzo+7fwMzukIr+WQDcizikbxDpiqOdRJJSzHZogI0MTZli6ygyn6kp3CpY
0G8Ykk23jt63Er+cS+0tAPeJj7c7PIIpIMmKrAV/a2d26aVH4S2//mTBUCfxA08J
WudiG9LNnOK4OBnBvI0sxcv0Qss0Ig==
=jTI/
-----END PGP SIGNATURE-----

--Sig_/kG7t0=QmNTqDD6p3gjGiolI--
