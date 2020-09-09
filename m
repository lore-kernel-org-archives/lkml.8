Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E79921D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UljvDt04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIChS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:37:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41003 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgIIChR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:37:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BmR4S3g1Vz9sTS;
        Wed,  9 Sep 2020 12:37:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599619033;
        bh=FL5nwqAWFyPt4AMztoRWQ0zk8xgjuSYriYFeHSMcZB8=;
        h=Date:From:To:Cc:Subject:From;
        b=UljvDt04Ms50mGKijhgnNZ37d2MnUoimZGJlGULAmFw68Mt+xIvosHWmJDCNmpmDa
         R4GHWW+0ezQjOH4gaay0pIAXUQXLujLuZc8QC2zz4ty70SojrS9PWRqGljMWcPfRwO
         Iv9Pfez18ESZ0ooZcPIY9N+LeoqE9bplGWuoJis3NxuMNOUnHb23wAyG/aCuXBUVhp
         gzI9m1Akix4iWQtD2FJhpxfta9uGwsXq2OtxMH8ZlHm6lHev72Vk8AXsjs9Xvy8km7
         sYcwn5RuhMwBmpNn6IXcaxUSPJ2Uy/eVxI4AdTQERljW6rBU2k2g8of2a9yOP2bE5T
         AbIMz5WK/ePGA==
Date:   Wed, 9 Sep 2020 12:37:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the pci tree
Message-ID: <20200909123710.50b16d37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x_Kj6nw1HxNxyZoRhN7ikuo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x_Kj6nw1HxNxyZoRhN7ikuo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/pci/controller/dwc/pci-dra7xx.c: In function 'dra7xx_pcie_establish=
_link':
drivers/pci/controller/dwc/pci-dra7xx.c:142:6: warning: unused variable 'ex=
p_cap_off' [-Wunused-variable]
  142 |  u32 exp_cap_off =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
      |      ^~~~~~~~~~~

Introduced by commit

  3af45d34d30c ("PCI: dwc: Centralize link gen setting")

--=20
Cheers,
Stephen Rothwell

--Sig_/x_Kj6nw1HxNxyZoRhN7ikuo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9YP9YACgkQAVBC80lX
0GxYDgf9HwE0AL3bNIZ2iNsV0hHFKEXpNzlXet0XFRNM8ccvH98vD4bn1xaXAjeW
CLTMnxPBq8GB+leO+vC+cIsJ+fHieAfDP4LlZtScaAqUVnyLj+Ck4fLG2NA/iuAb
cSpF4Lepad7coLuM5awB8hdSxnxXas7x3qnuV51Nkgo6+ZEY8qoHEKsHP0BhX2vy
5vqhjWKxTIWHuSLr80idXzTt3a/r6zW4ErVCegwtR9QGHVsOEi4cbeaUxVwnSpFx
If/IM1MYxO7SI6BQ/e77VC7LoywPNNs+Y5iI8XyxX350ccPOULUJgxx3BRWigrjR
XCyd2Ac+JeUexHtZ2pCS2WQc8msjcQ==
=zdjR
-----END PGP SIGNATURE-----

--Sig_/x_Kj6nw1HxNxyZoRhN7ikuo--
