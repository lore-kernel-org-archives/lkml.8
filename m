Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93809C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648A4208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Li0uakGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEBAa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEBAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:30:24 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE986C061A0C;
        Fri,  1 May 2020 17:30:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49DVQ44S6Kz9sRY;
        Sat,  2 May 2020 10:30:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588379420;
        bh=fYxS9M3q6OMWjxgrlaKJf0bhnQHnnvVCJ96++Kf9K3o=;
        h=Date:From:To:Cc:Subject:From;
        b=Li0uakGM1x+Oz2k9uqY2JBrPbk0a3pCluAHpeEQtD8aDZWZSW42aXQYxNzk4rzQR/
         R3moIUr06CidltZMSl2Wwng9fIawbiRW9PRHtWBgWWlUTsoe0trhIaqjdQZxey26VK
         SoFWLN+yUSBG4Na0X6JFZkg9iPGfWhNbR6Wqz6/gAithZkdEKvuKjj7kyxgobTr6ju
         MvlZgldpFyd+T6LNMD3/EY6QaHm0RY76Xc+avCRm/ZgZeVd1FJwsn89XHw/XZCpGOx
         p3qwr5iZsAIQOK/+i1L1CUlMnRFjcp0TYKbUkOZUtmLYAHoMqvlODzQNATabYgIcW2
         ghVfDkNTYnmtg==
Date:   Sat, 2 May 2020 10:30:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: linux-next: Fixes tag needs some work in the vhost tree
Message-ID: <20200502103018.07774059@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cFdCRGvZF2BYZ5Gr31EMEcd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cFdCRGvZF2BYZ5Gr31EMEcd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ab8be610c87d ("virtio-blk: handle block_device_operations callbacks after=
 hot unplug")

Fixes tag

  Fixes: 48e4043d4529523cbc7fa8dd745bd8e2c45ce1d3

has these problem(s):

  - missing subject

Should be

Fixes: 48e4043d4529 ("virtio: add virtio disk geometry feature")

Please don't split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/cFdCRGvZF2BYZ5Gr31EMEcd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6svxoACgkQAVBC80lX
0GypJQf5AVeTqJ/E937Sk6kaOgBSLGfztmr+PjeCLdXvMoFcJhypdFFkfVCtuwWf
y/1CoWFCO+i1NYbOk9vzhtHkadhXYwh8mf+UkasBk33q6cLV9Bra0xLyyRLivoff
Qg3VCdUygyjApeUd88Rldbd/MsUQISbZ/b/ERpdc5CTCvqRfWXj+TVZTPpKHtsQd
W0qzYLdRyz4V07/N3lpahBo9Pg0P7XAY29/75O4fzBP2n/Ybdm6nvYza2vDHMbka
n0KQ4b9Uox4z8eUM/qF7hYW5/dG5AbcJkd16+ZwLfo1PBbwP/hFGblGnGlu3lBxq
RDel1WiYzRjP00BaEU9AtDaEM/98Fg==
=byE5
-----END PGP SIGNATURE-----

--Sig_/cFdCRGvZF2BYZ5Gr31EMEcd--
