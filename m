Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A0C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46DA2068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t5VqZWrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBBHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:07:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgIBBHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:07:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bh5QT48Tbz9sTM;
        Wed,  2 Sep 2020 11:07:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599008865;
        bh=rc10HIQQpnTK5EN4cSJF+avCpscBeDkBkXG75GKy6Tg=;
        h=Date:From:To:Cc:Subject:From;
        b=t5VqZWrrd+4oJvf3DK8ftbxVgrz5IZIXZWysiE0hrQrbLyCUn31XS1J0IgTH3oy+n
         gPCPSSuQCwAEiqhK0eaWlM2cPsUs17GMgDII+WRvf0GAgcoCsPOQkPFdizU2iPlTlf
         VR3rL71gKihTL8RbnruPpgPV4CUcz7TWtnrVgznye4RGP4K0XBSeNYpoWBBI3RBHr1
         JUy4liYfVVVI7vTpfehGC/g1keD64+vbBKKGFz4HGQBQl8vFhMpqBNDlgiCdcntPgA
         y4g0wb2/0QBxtfxVulhqWa0KN/uRKrxip4+ub0Vl2OsIRZPUGBLuppPwdET7aizmB2
         Q2CiNvJ8A2FSw==
Date:   Wed, 2 Sep 2020 11:07:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: linux-next: build warning after merge of the pci tree
Message-ID: <20200902110743.0519779d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jCgG4utKdgA3Au3gxVWHCTf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jCgG4utKdgA3Au3gxVWHCTf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/pci/pci-driver.c: In function 'pci_pm_thaw_noirq':
drivers/pci/pci-driver.c:1037:6: warning: unused variable 'error' [-Wunused=
-variable]
 1037 |  int error;
      |      ^~~~~
drivers/pci/pci-driver.c: In function 'pci_pm_restore_noirq':
drivers/pci/pci-driver.c:1169:6: warning: unused variable 'error' [-Wunused=
-variable]
 1169 |  int error;
      |      ^~~~~

Introduced by commit

  89a8561c63d3 ("PCI: Remove unused pcibios_pm_ops")

--=20
Cheers,
Stephen Rothwell

--Sig_/jCgG4utKdgA3Au3gxVWHCTf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9O8F8ACgkQAVBC80lX
0GwdNgf+MugVBr4j/P/oxsLZymqRKkOiAiLUdAuzBjF1IuXh32AYWZ5uIh11vwK/
rDkliTNxYfhF0DZ7NkR/KV3jx0DqeVnZUcwab1d+9elsav0uPm4TrtH3wXqvZVNb
nwKCvr5akgrslVjrpWo0KnWOjjo+wtzOSh4iPW+/iRJFnwPJLR+R4/72sVXCYoaW
J53tqR0G1TEO/xo4Rd5CY4BsqKox9ay2p45yx0q7E8dy2z0QGUV9StYlua0iZT0M
/pryoTl1JE0igAzT9B9t6HBw3d/wNffKBQ2cpQO0jVul16c9pn2iebW2ChUnkUQs
vrlIjMiKJG3rJjQaoB1JW1Jf3E9zJg==
=pFHx
-----END PGP SIGNATURE-----

--Sig_/jCgG4utKdgA3Au3gxVWHCTf--
