Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F7EC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17FE21883
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iyGCw9x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGNAC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:02:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgGNAC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:02:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B5LL869l6z9sQt;
        Tue, 14 Jul 2020 10:02:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594684945;
        bh=Xp+Eo/m3I8eKIUvfRsFIWO3rOV+11Cuyv/nck9WM+1k=;
        h=Date:From:To:Cc:Subject:From;
        b=iyGCw9x7WPqiMb/+Ny/AL533qX2ZAITiJp5jcnrBsWXJxmzi8Qe/SaUCEtgI/jf5a
         0gx11CyiNe5OoRM3PiPBZMQ7rUzC+0ndD5Pu3cCPLUwHQefkwyHFFgVorQXz+q0XB+
         POOYHPNb0b0ndM2QTQnSpJSnRLfCt2YXh0L+uN29mP9XVEOBKd74L3r244E+f/Jaom
         tT1dS5PDZTOcZAcP0idp0smLbwzU8Mj54rzWGYuaWuPNRw2rt6+ZOCqtgL9L+quGSq
         9TTWLwto5GVFadE9zXZqth8NfLDKsdB42vnJ/hE54AffrfhI57ByCk9CUbpxjd0d9Y
         YhGwyOD0fp3Cw==
Date:   Tue, 14 Jul 2020 10:02:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20200714100222.46632daa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CWVboPbRpdIQzY+9SpYhZlC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CWVboPbRpdIQzY+9SpYhZlC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  736fe23d544f ("drm/msm/dpu: request for display color blocks based on hw =
catalog entry")

Fixes tag

  Fixes: e47616df008b ("drm/msm/dpu: add support for color processing

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not truncate or split Fixes tag lines.

--=20
Cheers,
Stephen Rothwell

--Sig_/CWVboPbRpdIQzY+9SpYhZlC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8M9g4ACgkQAVBC80lX
0Gx/qQf/Y0gIaG1+QSAWd63BiAFiwNhPDvltXSLUT2gjT4LdpKQjCfWFxHjAjmPI
8nZpg1hlLYvUfH0x7FYM6+oyZSsO2oyz4rS2dThr+ccYGI4fLcUuhT+CdhY9tag8
PBfMedWdA6Ue2WCXcOoEIWE2pKWk5Rxtuct+icn1F+sjpP3VifWJlnTnPmhkxcIB
wf/tUmRdJXBHh+kdRqtdvjDeQziAln19DpzmwNl+JIQPNSzTAZ84ayWLGKOSqGxk
LQq89/IFmdm2BKMEyoh3h3VGyuFXx5tWOEqzltB6j8GFBHBWeIZSsEudZILMWLrW
CJ6r9Xsc4tMbJ5u6sV4IC1tSQ5oQMg==
=iaYL
-----END PGP SIGNATURE-----

--Sig_/CWVboPbRpdIQzY+9SpYhZlC--
