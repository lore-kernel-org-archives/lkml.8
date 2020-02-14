Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6393C3B190
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AAA217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mz2PKB2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBNAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:00:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:00:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48JYRr0dfZz9sP7;
        Fri, 14 Feb 2020 11:00:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1581638440;
        bh=+bF0ogXTKSBSFulDbq0Q/LY5vp9XJnDtkN1Dl7LfxWw=;
        h=Date:From:To:Cc:Subject:From;
        b=mz2PKB2cNg5619CstdtvI52ETpbWrPplje9a2IQk6p+MZaNZYBeN+CXLrQBweIbnA
         lDfV5ov5d7xlVdd5sna3CS68yCJeFoKyo0dtVG/GRc9d6GoIheNi8RM1vYofpFbRdK
         Zm2d6lwBf+8L7bJr4DY4O6a5SpO9D+KpZXjilDGYkK2L7nHwoEnsAqMfKLq1WMjn7k
         0wdxazSlLOoo43RSaPqNQ6cRaSVqQVu6pKkz3Ck34ymMNGe1pqiVHKf3v518h6+4Jn
         XqkVR1KPp95Xa4RH6RypFeojZssOLHY6T4HWwZBy7EMgmWVDMtavV45jCHbR2FwMno
         Q+/aSMvdQEkig==
Date:   Fri, 14 Feb 2020 11:00:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20200214110039.51369fae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_BOx+yha+JxtMQq8mnV==N/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_BOx+yha+JxtMQq8mnV==N/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the slave-dma tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/dma/sun4i-dma.c: In function 'sun4i_dma_prep_dma_cyclic':
drivers/dma/sun4i-dma.c:30:51: warning: statement with no effect [-Wunused-=
value]
   30 | #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode) ((mode) << 5)
      |                                           ~~~~~~~~^~~~~
drivers/dma/sun4i-dma.c:701:8: note: in expansion of macro 'SUN4I_DMA_CFG_S=
RC_ADDR_MODE'
  701 |        SUN4I_DMA_CFG_SRC_ADDR_MODE(linear_mode);
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  6ebb827f7aad ("dmaengine: sun4i: use 'linear_mode' in sun4i_dma_prep_dma_=
cyclic")

Please do not ignore/dismiss new warnings ... this one points out a real is=
sue.

--=20
Cheers,
Stephen Rothwell

--Sig_/_BOx+yha+JxtMQq8mnV==N/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5F4ycACgkQAVBC80lX
0GxOvwf+MB1EzOgp+Vo4F6r9heRIKSAI0850IsLlx/eD2f9YISEhJ4Xzxx+lSpSu
uygD61J0UcsKP089KUA4y+OeoRcDDpWY5fgFyuWXWR5v851RF16BB0XCRcdXGj6c
hqFiWxNBLpTPq/0I6itDYT2Q8N5xvmWhTsfFf5WK1zMDn7rwF2RZosftLSIlKBJj
ZD5Lgux3dofNudSZab0+V/rv3pkqLkJ/sYd150BHYyordibTZoCIecK/4LL6oPPu
j9tVuCw1iqyUPaMSCKjSH91wYHmpoFv1wvEqLkShxglwGwAyU/0ivUSs1aw6H/Ol
5Jabb3LcXz9Cwfh3gVSGg4/I5Ef1Qg==
=XPkO
-----END PGP SIGNATURE-----

--Sig_/_BOx+yha+JxtMQq8mnV==N/--
