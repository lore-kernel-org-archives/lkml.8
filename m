Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149EBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F2120757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QnJ+s1NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgEVF7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:59:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgEVF7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:59:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Swm54QCMz9sRW;
        Fri, 22 May 2020 15:59:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590127142;
        bh=29NSkmyyyovH3XI7e3fkxFdgNlhvgAXuPgG19MPdxAI=;
        h=Date:From:To:Cc:Subject:From;
        b=QnJ+s1NYSqehawbXFHhsPnPWGhN2DJuMNwWD+GStGCFOSMdxDD4DZ3DFT4+fpFMk3
         ZbXNCedbZx2nCBA/GTZED0urnFLh1jy2Ef7a4g8nvhp4jX7feSOF5A8SqkQiV9MibI
         XiuMt5lXN9thxdXqr7VUm6KEncOr6vRElFXLuPHD9fpnDLD3cOv0e6ds4Su68rWWCO
         6qxA9RV3JR5khYnr8s90AmW+rzulYbXW0bm/Ocu8zhX7ZFgVZSWMbtuUtRiuIAPTaV
         5mOOoYCyAQSHSNvK8g+f/Dq3jchNN59mI/HFy0WeZcboJo6fhmHkNfYZ+6FPXZxDTs
         j89rH5OVPv5WA==
Date:   Fri, 22 May 2020 15:58:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: manual merge of the devicetree tree with the pci tree
Message-ID: <20200522155858.3e349e0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YGO+ol/n4Puf1ETGgGMLFbm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YGO+ol/n4Puf1ETGgGMLFbm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/pci/cdns-pcie.yaml

between commit:

  fb5f8f3ca5f8 ("dt-bindings: PCI: cadence: Deprecate inbound/outbound spec=
ific bindings")

from the pci tree and commit:

  3d21a4609335 ("dt-bindings: Remove cases of 'allOf' containing a '$ref'")

from the devicetree tree.

I fixed it up (the former removed the section modified by the latter,
so I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/YGO+ol/n4Puf1ETGgGMLFbm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7HaiIACgkQAVBC80lX
0Gxl8wf9FCneNcAVmx8Hp4Q0zvqFNRfMQxn3xGor9TPPS0snxIGNd5IcauJFHXx9
DjoG/ux54etloKGO8q5X6wHoWv1WYcDZkAhCIRdxyK/Fn1ikQQ4ZnNqHLgq84oIs
09OVCDhTKtGUCsVFJ//oiNPMbT+alDufGOotUaoll9niRfwt/T/nNoiLL3OGHVXy
gJNdWq602kS2/vyf288fbky05zFid0qNLJoW3MBjF0VgxAYnWkcaOb5eoaZWjV3B
Q0VddWmfEIDdW0qmY7FaWrWr3S9gnfldb3rqSS9zxygDsCDrSAzupyCG/WwNvfPA
rw6ahc5HCMiWCCRqUHGudbUcMFXpOA==
=Pz28
-----END PGP SIGNATURE-----

--Sig_/YGO+ol/n4Puf1ETGgGMLFbm--
