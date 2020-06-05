Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA286C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894DC2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qp3lqCrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFEAEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgFEAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:04:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E5FC08C5C0;
        Thu,  4 Jun 2020 17:04:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49dNDb3wT3z9sSJ;
        Fri,  5 Jun 2020 10:04:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591315471;
        bh=IslDXDWp5NFvRcdgIZ1PBYgElb0iieT/P+L1FCDKw0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=qp3lqCrlBQJhPK814HvlClukKtg+5Ismm/3xcBpeFxUrjt5Q3SCjTVuuGrXAArrik
         JX3Y0+ncYyBhh23Ob7e62MaK7juNL/cBEk9ov8dpRbtQpQEADd1Ge2l0hKGxD3dS1C
         hznmg4EOZDNAlcMbey6FmC+tIMXt1Asy1iXeyw1HYWd2/jYPgoGvikgjxBHmPnGXA5
         wyRAgoXPUgLzmNy0K/Zm0PjgmhL9Y7IA0BLMLeS3YCEqj2+yP+ur7NxxCpAUpMDK57
         QhMHaRs7Og6a2s+SPpaKc7OKoMhIx3WKKu1CL6M81fTuhKVAosBeRFFzStSSdw+D4T
         MmiTgg2j5qzdg==
Date:   Fri, 5 Jun 2020 10:04:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the f2fs tree
Message-ID: <20200605100430.0ed7de60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//UMhAluCQAedCEkRCN0ZUhb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//UMhAluCQAedCEkRCN0ZUhb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  35942e2134fa ("f2fs: attach IO flags to the missing cases")

Fixes tag

  Fixes: d58f2f658159 ("f2fs: add node_io_flag for bio flags likewise data_=
io_flag")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 4a6183fb7db6 ("f2fs: add node_io_flag for bio flags likewise data_io=
_flag")

--=20
Cheers,
Stephen Rothwell

--Sig_//UMhAluCQAedCEkRCN0ZUhb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7ZjA4ACgkQAVBC80lX
0Gx5sAf/VVRt7LKPwT/JjzcvRqSpijBG77Y/DgB/IRUmVT9nQT4lLNo3PxwJKfIX
o9GN89bPtzB+3ItFaXR8hYSE2Fji5vuILnID+vky6gn6YulLxzR9oQqINyhrq9tJ
ycHZvEFY9U5HH+X8IfM8vlbZ7o3s/LUsanOBtRcaZGBNYFDSl472q+rkJxE8jK96
uM9ty8onx/qKtCYjLtZs+d89f8rgyccRQAWK0X+xgEPB93ZPA2uDPa+m/BvP1++9
VRLtKxkh3nHESzDINDhpWtc/QGaR8FQ6XwV61xcENyLnoKA1OThyLxAcJzUnkvXa
nkxvKalga/fx5t4NQH0vbWZZ309ufg==
=pwuG
-----END PGP SIGNATURE-----

--Sig_//UMhAluCQAedCEkRCN0ZUhb--
