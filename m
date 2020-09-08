Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C33C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1421741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s8WJM4Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgIHCLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgIHCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:11:37 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835EC061573;
        Mon,  7 Sep 2020 19:11:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BlpYL2qfRz9sR4;
        Tue,  8 Sep 2020 12:11:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1599531094;
        bh=HLnxUEsN4jtlio8BiweoeszpyAofnT5Xx6AYfXs5j6I=;
        h=Date:From:To:Cc:Subject:From;
        b=s8WJM4Fxu8qTZzZ8n5kKqgUmea0HlzaTpMNuLAdIyjtt5LeWi5fwfvYapfZw/LQdS
         LpQeiBvh5dezC3Hqg6ipYqvvpXD3jX056SMcM6evJ4SsW87THmCvaS90V5aDXuMzMd
         +HzWtaImRkb5Gr2UAFJ/eHP4/OnJgZlWfy/V5iPWl9Ellfl7sKqDDkb8pfK7/c3/MJ
         2ERPFF/TE25rlt7N9+L9+sDkxtcknlileU9wIoRsP5movIvrRO4tZc/kkzCpCjuMG3
         /jk7odE4vdDTtkiXpRpihxulp9sGUEfuzUITPnMJwQNkVVBDVKbp/kr8QZ4741nLC9
         PjWwrC3zZf4Hw==
Date:   Tue, 8 Sep 2020 12:11:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20200908121133.7cf400d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HB_4KZ/yH6E1RbsTGB=pUa_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HB_4KZ/yH6E1RbsTGB=pUa_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/media/test-drivers/vivid/vivid-core.c: In function 'vivid_create_de=
vnodes':
drivers/media/test-drivers/vivid/vivid-core.c:1318:11: warning: unused vari=
able 'i' [-Wunused-variable]
 1318 |  int ret, i;
      |           ^
drivers/media/test-drivers/vivid/vivid-core.c: In function 'vivid_create_in=
stance':
drivers/media/test-drivers/vivid/vivid-core.c:1885:47: error: 'cec_tx_bus_c=
nt' undeclared (first use in this function)
 1885 |  ret =3D vivid_create_devnodes(pdev, dev, inst, cec_tx_bus_cnt,
      |                                               ^~~~~~~~~~~~~~
drivers/media/test-drivers/vivid/vivid-core.c:1885:47: note: each undeclare=
d identifier is reported only once for each function it appears in

Caused by commit

  62c6b4c9e3c8 ("media: vivid: move the devnode creation logic to a separat=
e function")

I have used the v4l-dvb tree from next-20200903 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HB_4KZ/yH6E1RbsTGB=pUa_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9W6FUACgkQAVBC80lX
0GxPqgf+MsVF/aNFfC/xK9PFDhAcgSwjLuBkfrqMit+Tw7zA93EKbFSlt28ZMB1a
rkIN0l2kJSZ8HWEb6TChhk/hk9rJ4f52X1xsGryBLA/6PCHXRJ7e3244E+WZCjp8
U7QbkyAyLriOmrqyCiDrn4/QqHlpt/51q4pNmA4ILgRULJOT6N1NADQ0wU/nfRIY
RIRT+6ZIymSDQBMvBX7VO9h2k2WvNcNAE1+i0SDJbjzQRZtlIqBb+1WQjtvNZ8Vw
H1W1+95dEqLAvQ3hWUHR1Kjdlb+8VR0qTFIrskuA8i9q+m2Yj8ZY4HshlhA0AExT
MF8ZdisnOeHbZdcoytAaScAOkykDhw==
=yP0M
-----END PGP SIGNATURE-----

--Sig_/HB_4KZ/yH6E1RbsTGB=pUa_--
