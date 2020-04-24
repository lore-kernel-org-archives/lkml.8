Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C11C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197582087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="doA0MQy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDXCPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:15:19 -0400
Received: from ozlabs.org ([203.11.71.1]:52413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgDXCPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:15:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497d6r1Q81z9sP7;
        Fri, 24 Apr 2020 12:15:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587694517;
        bh=eRJg7zYNUw57ixN7xAh0iGormgcaWRRXrqOgi7X0gBk=;
        h=Date:From:To:Cc:Subject:From;
        b=doA0MQy6bhpJ+dgBp+VdA0K7ZARGj7t3+NKZo0uX7ZOLhtuGEmt+ZtcYuC+Fx6v48
         qMtC706Z68jDNPYO060gpvRsHJ1JO+XsHj8REkdGuUV1TB0Ue0w8MM7RMsRmzyxpN9
         R8NGovpvBtqVDB0oCmzuLI2AV1kyy0l+qMsL0S4Bv1fCx8+wTCmYb/IGGVHVKswYh2
         +keQe3VjI/qC3qcLEXS1TuoEyEXryUnUIZxRfOSz8IzD4Gs+Ros7SwJnwf5jekgzhI
         22Rtr0uGFfFBmwPxg4fDetkXpkIpWcMXwORuThCdjAhkXKToi3bjawtr3kITEtL/sA
         RCuIY9MWTJWug==
Date:   Fri, 24 Apr 2020 12:15:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the arm64-fixes
 tree
Message-ID: <20200424121513.0750e300@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3MsEDexF42hsAjO=MvzNnnv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3MsEDexF42hsAjO=MvzNnnv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/arm64/amu.rst

between commit:

  59bff30ad6ce ("Documentation: arm64: fix amu.rst doc warnings")

from the arm64-fixes tree and commit:

  d91589556b6a ("docs: amu: supress some Sphinx warnings")

from the jc_docs tree.

I fixed it up (I used the former version sonce that seems to be a superset
of the latter) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3MsEDexF42hsAjO=MvzNnnv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iS7EACgkQAVBC80lX
0GwHLAf9Fehi0xK7fnkneJi8pWF2DM5T13cfI/BE/7np5gNhaFqHnB0SS2D+9W7a
tDDnS/8/IG52PrHfp35cOQWWNit/vDmpuSptOD2XOKtrgYj0/ucqnpMYdywGmdzl
0HPSA5lWFTqEvmPnlGU4idGqL7bQhy4zkGOlasRQ7aKe1WFdncVITrAf5O/V+GGa
gR59nlKEgM0fN5a/eq6VrmL08F7Q016V0uEGpKkIYWwlf7/wZgwoFshlCPZThGpO
eO/Bt+h9Auu3PdVZf3Rv3/n6/81Po6AEkykq/DQvg2vptysi2zdpzRFm0CaiK8DR
ozsXvP04upe+2lxroMlfEB6ZtO+HyQ==
=Nwqa
-----END PGP SIGNATURE-----

--Sig_/3MsEDexF42hsAjO=MvzNnnv--
