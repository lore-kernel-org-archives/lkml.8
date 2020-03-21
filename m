Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 05:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8C720714
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 05:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bEqBqNkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgCUFQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 01:16:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgCUFQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 01:16:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48kpl16KbCz9sPk;
        Sat, 21 Mar 2020 16:15:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584767758;
        bh=PzS6kPfDFVyEagUJo9o+V+LDp4II7WmyCvh+bJcWhjs=;
        h=Date:From:To:Cc:Subject:From;
        b=bEqBqNkf1S+5IC0JuS4JVBtgfKtuATZQbTU/kZ3UlBSLwMrspeiiFzWImy487g5Dr
         8efgz5Pbat0ks9X7TI7WQKd8sPYgRNXxIpETz3S2dOIKim5Q+i96V+94oFwz8s0LvN
         SjzVhVHlHpVwOZ95PnKnDK3Woj8QVp7vBCwCN96fEQ/9eFMuFxlrarBU+hnkbcwrWv
         XoGE5sN9y6Sq1wRwYDAhFrpm0kVkBUo/hQ/4HS2Du9FsKawXpIs1JTAtfHLR1Ycc4Z
         JDxEDZwKpX4Zm6P/2NFbU3XRGO2E+0vVdZ149iYk/4Cjgp93OLnJq2MpAUSsftJlkb
         dXjh5+P2KqVXw==
Date:   Sat, 21 Mar 2020 16:15:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the thermal tree
Message-ID: <20200321161556.212a9fa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a5VTmt_PvdiNrn/yTj.vc3q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a5VTmt_PvdiNrn/yTj.vc3q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  791f2cfb145d ("tools/thermal: tmon: replace error message SIGINT with SIG=
TERM")
  65ae2fb88af1 ("thermal: int340x: processor_thermal: Add Tiger Lake suppor=
t")
  1bfd0bd3f6e0 ("thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.=
")
  c17ea0c7f386 ("thermal: stm32: make stm_thermal_pm_ops static")
  45921a2ac8a5 ("thermal/x86_pkg_temp: Make pkg_temp_lock a raw_spinlock_t")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/a5VTmt_PvdiNrn/yTj.vc3q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl51ow0ACgkQAVBC80lX
0GwKJAf9HoGHF52z3EIQGWQ3+52sBk2rBcN3TF+oOXGDROUuKBCJzwPlqjxpLCnW
uAsHLSo+FPVJsyDF22WWt0nKAOUYLLpB6eK8addubFVMNk60eJCiIDj0TPbyQB+d
V6zD9gAvy6ESu5F2kYQjqKKWiRzdygbj+1aJKWV/6ceqPIbSstOQDE2o53F0LN+F
YAMFypG3C87gfXXsaFJvTiyB9mhqmPncB8bicjvkgGA/HEd8iBIvpo7gITGnzYGu
Pf3nyAt4zWthPFzSAnyTHzxz6/vD+zUcS6utHHxNG0pkzBY/sew/FXxek23G4M3T
ikDFiycp98UA5EP9lm122YnP+WPeeA==
=XKPj
-----END PGP SIGNATURE-----

--Sig_/a5VTmt_PvdiNrn/yTj.vc3q--
