Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CA4206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SQwyib3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD1G3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgD1G3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:29:18 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC2C03C1A9;
        Mon, 27 Apr 2020 23:29:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BBZ06QC1z9sRY;
        Tue, 28 Apr 2020 16:29:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588055354;
        bh=GnxcI0kkLzQz19bJb2kB7GvBixqRVImJBSF2kt9g9tk=;
        h=Date:From:To:Cc:Subject:From;
        b=SQwyib3KHot5j38pdCwwNfttpWYV9gx+jbRIrpYQCURiZ+iNde27t4Zru33nz/Yid
         GvtZ431uyw+CXFogxZiUYsAkyo3wtbnPG9/MjJ153ikeezXdneMnvP03uJOT+Sg9Bg
         YCx4KpK/8oZtt0mGEbfK+aUs6m87h8vJMGhkVLLN6MmFtouLyzutfYwVeNqDMprm54
         MGmNdTysamxHafxdeYZ4TazY44VTTkbhOW2EMIBWcIkJClzFD2k3JHFuy0y1p3mafF
         mX6EeDUfDUyuMYTuM2aF7X4ejJCTDvz4plnEdzO6WSBSXkNY9vOk+v0f7+rafRNjev
         132ZGFZtAnLmQ==
Date:   Tue, 28 Apr 2020 16:29:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20200428162910.0dee6f52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HHh.isL9q9ZPyWaPWYipMyu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HHh.isL9q9ZPyWaPWYipMyu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
produced this warning:

arch/x86/kernel/unwind_orc.c:29:26: warning: 'cur_orc_table' defined but no=
t used [-Wunused-variable]
   29 | static struct orc_entry *cur_orc_table =3D __start_orc_unwind;
      |                          ^~~~~~~~~~~~~
arch/x86/kernel/unwind_orc.c:28:13: warning: 'cur_orc_ip_table' defined but=
 not used [-Wunused-variable]
   28 | static int *cur_orc_ip_table =3D __start_orc_unwind_ip;
      |             ^~~~~~~~~~~~~~~~

Exposed by commit

  153eb2223c79 ("x86/unwind/orc: Convert global variables to static")

This build has CONFIG_MODULE not set.

--=20
Cheers,
Stephen Rothwell

--Sig_/HHh.isL9q9ZPyWaPWYipMyu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6nzTYACgkQAVBC80lX
0Gxr2Af8DtURpiQP8RSDSzqWrGJVXcZcmVG3bzN3fY+x6rt2qxz2KvWszV5uSvNN
ZrS0anFoWP/GCqD5OQtVQZy2EXrVwHT9z/7zKCnU3R8ckpbilmvRRNkAKHx4+PLX
wslr2WkgHg5DWgSqUoR2bGlOXMPwbn3wn/NVV+cHslAOJpDl+fFSfF30p01Hiccz
dYtucOHViDLqLxvZG7be8Hmw7mreaJqIbesFAuwFYf3a2zqFhc/qQIZMRmNFEcly
YUateOoP5TFsH2BCH1w9KPx3tk29I0mXDe3Szb3XGeOrLqa7yDGzHAgvBu6O76dx
b/rOzW6wSsGD62FfCWzoLyM3G3IPqw==
=bs8r
-----END PGP SIGNATURE-----

--Sig_/HHh.isL9q9ZPyWaPWYipMyu--
