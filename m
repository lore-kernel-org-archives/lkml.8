Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC8C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DECD2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TUJ9ZQPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgAJEcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 23:32:10 -0500
Received: from ozlabs.org ([203.11.71.1]:33061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbgAJEcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:32:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47v97D0W1Lz9sRK;
        Fri, 10 Jan 2020 15:32:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578630728;
        bh=54ImpZanYCPaDZyv+ar+KxMn/nTVY4c2NKp/1pllfrU=;
        h=Date:From:To:Cc:Subject:From;
        b=TUJ9ZQPy5NxP/di80CmJBGyXOIwel2TpKKIiqCMu2ZMIHZUZ1JVSOhvX0eDZHLzzD
         ZzWu7dOakWa3oN0+WJmsyId9RyODDKERzLAD1uNIeFxTaWxfE1Wx9xGV4SacA0cwsz
         cvAT0CE6kJuR6tXMJWfKFoD5lLWTTfKjy4GZW95CkceHoo+QIPXkmJOhX7iZ0QXOUr
         UfEeS32m3cCra3ppEXO1WCcDg2EddiJbHG4v34bIL10ddsjtwvdTWLrEFK9padwHRj
         3cSDiWVpJIHkICfWp6utABSmXXqLFsnxm/goWuZzzS8ekenAd52D9xmsEX8KKe2Yxc
         /wweWCt0nr6ag==
Date:   Fri, 10 Jan 2020 15:32:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the usb-gadget tree with Linus' tree
Message-ID: <20200110153207.70c888cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4OzTUSKr0Y6dYgSSo.j0Az8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4OzTUSKr0Y6dYgSSo.j0Az8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb-gadget tree got a conflict in:

  drivers/usb/cdns3/gadget.c

between commit:

  f616c3bda47e ("usb: cdns3: Fix dequeue implementation.")

from Linus' tree and commit:

  4f1fa63a6dc2 ("usb: cdns3: Add streams support to cadence USB3 DRD driver=
")

from the usb-gadget tree.

I have no idea how to handle this, so I just dropped the usb-gadget tree
for today - it clearly needs to be rebased on Linus' tree anyway (it
has a few shared patches that are different commits and there are
further changes to this file in Linus' tree as well.  rebasing onto
(or merging with) v5.5-rc6 may be useful.

--=20
Cheers,
Stephen Rothwell

--Sig_/4OzTUSKr0Y6dYgSSo.j0Az8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4X/kcACgkQAVBC80lX
0Gy8sQf/aL1X09wlK/pnyYK5zpF/jjDju5A4NTnErdB9ca/KyEqD+EFGnuwu4h9Z
7bYXW79wpwkXi3Fu4WRFIyimEh3YdtkAZQsr6b0MSedxOH0M03zfeWmfxdzgBamJ
nfzZE4YLy9GjCP1UgZERpOfo2P97fXcPzL0DriRubeb+0lcYrd+xLnGqmQtx4hXB
N8568aV2rvriJIx7NWb0YJ7MtG7YBV8OZ6jAE4uU3UFjPO4eFZPwSUy+v/KcBLOC
zItIqsgxUhq8LLTuy78CVAa+AYl4RmroFtCYVn8zNhI8Bj2b7Z+dADZCisjZcQQA
4yk9VVTkItLXVyfbIeRTTXD/76ajzg==
=Yl3n
-----END PGP SIGNATURE-----

--Sig_/4OzTUSKr0Y6dYgSSo.j0Az8--
