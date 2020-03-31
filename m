Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F91C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F220781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jp6L2Wk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCaGXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:23:41 -0400
Received: from ozlabs.org ([203.11.71.1]:55061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgCaGXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:23:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rzmV3gywz9sR4;
        Tue, 31 Mar 2020 17:23:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585635818;
        bh=DKwvoyZfpSqHC0FSx4sxi26RxC3nIH/Csn6E+yW23WY=;
        h=Date:From:To:Cc:Subject:From;
        b=jp6L2Wk47qXSQiHx7JslvuSVDzijVgX/0XTcNfFchAlwPe2qI9udlRLSdJ2Uafwxx
         YeQ1AoPTdFcsBxSoGJlCPAfhUrMwojd8Uj7OjSkFUQDvmxDM2aLcBjvtToZ1c3Iwhd
         6LQBInw7Y1b7cVMLDfTZc+Xb3m4V/Mmzp7wZi+wxilVusnQwFNNoSTbpeAqPdaIE80
         xKena7+AxZD+GyJI1dCMsNVsu0HinaZmdyMN7Q8FH8/3v45iThDq14JifArzVZtq15
         XiAyBk+dqDi+0XsILk+7zVXG7zT/DNIT/AIgd1N/nHxNGjd1cYr46rRIOcwTF1/p28
         5GEdpOBMhu1Fw==
Date:   Tue, 31 Mar 2020 17:23:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: linux-next: build failure after merge of the hyperv tree
Message-ID: <20200331172335.2f71021b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IkVd2zwsszL6kSNj3g2+w43";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IkVd2zwsszL6kSNj3g2+w43
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hyperv tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "panic_on_oops" [drivers/hv/hv_vmbus.ko] undefined!

Caused by commit

  a6a5aa4b0179 ("x86/Hyper-V: Report crash data in die() when panic_on_oops=
 is set")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/IkVd2zwsszL6kSNj3g2+w43
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6C4ecACgkQAVBC80lX
0GwU5gf/e+XdKSplUrfXzdUT9h1RQsimOrR38LwqlN4pm3Be6YiaenDGSHvVGn1D
rrdhcPnbpN/uE4PJ1ZVC2hIlke5vXjKwBl1YaHhdG0G7eIAW8Bpd6pYN6pEZUVwq
2dcSxZUNyxUQ72rraSATU8ewPXcorG91ntc+umF0yG/lUnuXNa8dY941zY65BpeG
qGCfZnyVTudqJTIOV5GHwEK0l2/6EHKXgXbNqJ9lLCVOxDIPUbQtFmP8Pg4upSmn
GA7T3Oh2XzqQzsQCv2TB3tLM7i6h1Dg468jvt+kSImmCNx3GkljQPED5pPDLLg7W
T/Hmo31Dc6bIECPlbFKpYoyXSmWqyQ==
=uVjV
-----END PGP SIGNATURE-----

--Sig_/IkVd2zwsszL6kSNj3g2+w43--
