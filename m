Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67459C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3246720780
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="htcvcK+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCWAJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 20:09:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgCWAJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 20:09:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48lvqv0Pmfz9sR4;
        Mon, 23 Mar 2020 11:08:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584922139;
        bh=ACWBe2oMssP/YXGsVmDDBnwhrVKVcmLPP/x9O78bYn0=;
        h=Date:From:To:Cc:Subject:From;
        b=htcvcK+Z+cuM9hMMVWFfFCwW8Zj9ruG/bppuA7faIPOsEXbIHQS4BBjHir+HNlEnO
         hA+JovUQdxm2SaHKqRz1bl+Ey7Z/209xOmf6/u4zuSACehg8Oe2KH6uDt9rclG0TLL
         XUEs4AKruoCGdcoJPQ8+yPB2ipXPBBOkJ2ziqOsOfrSbS/g9ZFMOiRYWqSVdKsm+Xl
         Ypd4R1/aGSETan9sJrfjJNg2azHBas8maACkhiRKupsJWCO2++ZUSH8qEC+lhfvoNM
         zxrZDZIPbjGOQ8B/x4AAmb8rMDsw2LHVVQd5kzs4PfOJ1NjDzotwGVhp/9MIpvE/K4
         Q40//kGMVm7Rw==
Date:   Mon, 23 Mar 2020 11:08:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andres Freund <andres@anarazel.de>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20200323110852.1f08e4f1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d0pCu5gVhX4E70F69PYcKFQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d0pCu5gVhX4E70F69PYcKFQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/thermal/intel/intel_pch_thermal.c:306:2: error: expected '}' before=
 '[' token
  306 |  [board_lwb] =3D {
      |  ^
drivers/thermal/intel/intel_pch_thermal.c:285:18: note: to match this '{'
  285 | } board_info[] =3D {
      |                  ^

Caused by commit

  16cd95bab00f ("thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.=
")

I have used the thermal tree from next-20200320 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d0pCu5gVhX4E70F69PYcKFQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl53/hQACgkQAVBC80lX
0GyOvQf/ZFpiGgLq3KpQLnH3ng2eFPohH0X/43kpVM4WQYnUgvY/3tgOAxh2R9lR
55zotLxYbY5O/hqeT5cfOlpoFwTlcY8+5KLTLVfILLkWrSh/8PBu+OjuUxb5pw7c
2bAKXs2CQv8TMqs1rNvsujqEjXDRKF8+H2KlysVy/Qe36PdE3dyzGJ9t5gLXOaPO
RgrfQ+zO18PbAZ7vTty20VmDNcousImAYznh51nH/hdJmIwaUz+Og38hNVA8wb3d
J4C1/V/2A2oQbnZXiCNIqtCiD7gu6mhguJJx5IrnonGt/rCfY2gWZNCyjrlOGlP1
Yre7TUJttF59tUJj7EQB8elKbUpc2A==
=VxOa
-----END PGP SIGNATURE-----

--Sig_/d0pCu5gVhX4E70F69PYcKFQ--
