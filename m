Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34272C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EA12074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 04:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Wy7URnbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgFPExg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPExg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:53:36 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FACC05BD43;
        Mon, 15 Jun 2020 21:53:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49mG720jgrz9sR4;
        Tue, 16 Jun 2020 14:53:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592283214;
        bh=ct3fCwHaVbHlpxxgdfqVhSWLrtnmkJJEKjJqt5gyalQ=;
        h=Date:From:To:Subject:From;
        b=Wy7URnbRFpaPLukArTN1U4gwPgY8MEpNJ9ULwRm9qsqSwbXdPMgIjwCIoZDzLZd4G
         o+yrP/0JJrtIUtLIRblumpfzuFatzqALszRWWEHDcjPL4pcsSleT6qqYWXUYJ61Xuk
         OiDKLMKeAJG+idNkOSfrAR4GG2qNXCAZR2CKfm/oqEBwcjdu15foQo7CC2bx8eBPCv
         b/idesfzr/jmfwDGHV1l6che0Kez9oFi5WHnnlDS9eKS2TWjB1EqK1+g6/N0SZUpF1
         rzcz1FVWBcVEgKhTuZvtGpz8xf6EmDxh2LDj47zo45SD3hYG/7kWxCugMU+nEGrpoa
         l92nUM5tcDhsg==
Date:   Tue, 16 Jun 2020 14:53:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Tobin C. Harding" <me@tobin.cc>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: removal of the leaks tree
Message-ID: <20200616145333.40ddbce5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ilDg_CMmKoo=xakaRmLgA0q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ilDg_CMmKoo=xakaRmLgA0q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I have removed the leaks tree
(https://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git#leaks-next)
from linux-next because it has not been updated in more than a year.
If you would like it reinstated, please just reply and let me know.

--=20
Cheers,
Stephen Rothwell

--Sig_/ilDg_CMmKoo=xakaRmLgA0q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7oUE0ACgkQAVBC80lX
0GwJ8AgAhxHE28+ZDD8euZVatLputim1YCSnWOh9DjnA2ZW6q6dCwJ2Qrvj6WgMv
kiPUEcH8uU4l1AM8tgeQF4m5+cLQ7Sq6RV/tghVeNcXrFxlnpJ5Ji63fXY1oZ+lO
TEvKPmVfOKJzL6wT7ECpj/1TQWexSrJnpEpDsuvG4J7/5bGyB0koAT9EFxB9TZzM
DZaqPjFt18vCb8sYddIW9KMjy2209ZLeQ+tYs+X/foari4Q+FGuYY9HrzIR6Ogz+
xVrd42lcNSb/Ob5YiM3yrBBaiJDWQbHsQVG1+EPg6RYtUF6qd/sQ/mnK7x+a19Nv
o4I1qbZId09Udl2uTRSWHhZXl/YbrA==
=1ZcF
-----END PGP SIGNATURE-----

--Sig_/ilDg_CMmKoo=xakaRmLgA0q--
