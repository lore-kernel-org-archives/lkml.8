Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6655C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F57920748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YhR6C9GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgCaAkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:40:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbgCaAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:40:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rr884mm6z9sPF;
        Tue, 31 Mar 2020 11:40:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585615209;
        bh=CZHucFrAv9QIXDiBJFkwfGx5RP0BlhVTNHzwpPTiY40=;
        h=Date:From:To:Cc:Subject:From;
        b=YhR6C9GL0MICjk4NnoKYYDDPR1PVJ33Fub/BdpQWkd1Afc+/aylNSgxj82g7WUaJE
         otkHHtvjFArGGw3vFhOS5GVvqiOshcO3+XFHDN0OoT7JXuFxAz7B54V8NRdO60IKqN
         hfUrY+0oAosHcsL4JIfwYlGYrQxS0TS2zaiwYMB4dfX9vPbD4divQ+sOw95D9Z5NVp
         TlwbRB1kKualxddrQ+14pe/H0wcHvqmQIw1t//ONaKaRv8jh8Bk+grcFDH4M+OQw/J
         PlwOXN3K98Kqv1XzclpnCXzJOx8Rc3OJ4lhtDjmDtNthWU/Jpdr1yZz5GQDZZeiZ3C
         gDo5UVdVE5DKw==
Date:   Tue, 31 Mar 2020 11:40:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: linux-next: manual merge of the bpf-next tree with Linus' tree
Message-ID: <20200331114005.5e2fc6f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sqxK=G7/Qf4pX0OPiXg.akr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sqxK=G7/Qf4pX0OPiXg.akr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/cgroup.c

between commit:

  62039c30c19d ("bpf: Initialize storage pointers to NULL to prevent freein=
g garbage pointer")

from Linus' tree and commits:

  00c4eddf7ee5 ("bpf: Factor out cgroup storages operations")
  72ae26452e77 ("bpf: Implement bpf_link-based cgroup BPF program attachmen=
t")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/bpf/cgroup.c
index 4f1472409ef8,80676fc00d81..000000000000
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@@ -305,10 -418,9 +421,9 @@@ int __cgroup_bpf_attach(struct cgroup *
  	u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
  	struct list_head *progs =3D &cgrp->bpf.progs[type];
  	struct bpf_prog *old_prog =3D NULL;
 -	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE],
 -		*old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D {NULL};
 +	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D {};
 +	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] =3D =
{};
- 	struct bpf_prog_list *pl, *replace_pl =3D NULL;
- 	enum bpf_cgroup_storage_type stype;
+ 	struct bpf_prog_list *pl;
  	int err;
 =20
  	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||

--Sig_/sqxK=G7/Qf4pX0OPiXg.akr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6CkWUACgkQAVBC80lX
0GxM3gf9GxcJFEsjTQK4z5pYlqFBXgzWg1PIbiU7FSICpoAUgMQSegW5h8/465ve
aD01gwgYY/eEV9K4ompqdpy4f5rK+tDX6pQ4m9lJPJax578rTYjOtUPd71HmcCDI
VbtqQj+M8zd0Og5Z0yh373nhRYMnJ/A9HBauewgBzeEuut2eZ7BObIKdLteLHW62
zXvnUo9A6LP/f+BQZrLSv/nJOoRQ8u4l2pT52RH5YRLqO8FCrhYykPNz+UqsVqXI
8yEaryMtlr3wBRQBL284tKJlCRDC2Ewge+LkMQiVQIi8/3WF1uulHEv5BgxbtPeP
/xM7vWJ7q5HEmHXZ3mmZyx2wu7wi2A==
=Kf7A
-----END PGP SIGNATURE-----

--Sig_/sqxK=G7/Qf4pX0OPiXg.akr--
