Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC5C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81F920746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="alAf2bGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEDD3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:29:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54767 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgEDD3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:29:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49FpHb69Qvz9sSr;
        Mon,  4 May 2020 13:29:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588562956;
        bh=ez7/OYtBdcVR732QXZBylySCLLbx9kGr0C7DRNMhCD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=alAf2bGYqnY0RaekS2drUbrkuOWLM3qHzVz4iglxAwSXg7JQHXwIbX+1+lUZOrMGX
         Oyeqd7AYlVhQxeOV3H4G+5mkXaQDAHdKkXt436e9a02NCwofRNXS36ObGEpcB66isM
         AMDRmC24xlOYuckAWjIRxl7Wi5bF099Nsj8lo02ToEfFkd9ot2Nl/96NkX8d/G1yI8
         XW2QTRvK+MPSPG7sY0GQTriYU5iqQEzNE2aInx3dBIdVcySAhgSp2oLumwsyJ9utob
         Gm8erTrRSdSVKpQRW+258ZgQKDVMzXGnGEu6IpU8rHWPZ0qUZHkFFH7GUJgoH728fo
         kcpApYaQ0ZReQ==
Date:   Mon, 4 May 2020 13:29:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: linux-next: build failure after merge of the keys tree
Message-ID: <20200504132914.277b0768@canb.auug.org.au>
In-Reply-To: <20200504132529.44037944@canb.auug.org.au>
References: <20200302113737.7c3fdee0@canb.auug.org.au>
        <20200504132529.44037944@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y3DkAX9Xy6AktIz_deeulZN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y3DkAX9Xy6AktIz_deeulZN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 May 2020 13:25:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Due to further changes in Linus' tree over the weekend, this fixup is
> not linger needed.

"no longer" (Monday's ...)

--=20
Cheers,
Stephen Rothwell

--Sig_/Y3DkAX9Xy6AktIz_deeulZN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6vjAoACgkQAVBC80lX
0Gw6FggAgoxfE3dXn5bO04B6vehcCiVQo/k+GZyETWhKdNZyGMhyAVHdSmitK1ZD
Ttou/1mFVsjrlvxkj9Dpfzd2p9LuHwhVJnQi7Qd+REDigUmrxsm84RhbUSSKdRBO
J4tz2g/j6AlUDMnwOrM7Sr550zqgBgEHuva1P+j8hPmOIBOeetog2GtwyIbh5eOD
i8jqXE3lUqMBhYOKpbeEJMc6y13nm/nGspRwAZ5oads4WnSeUj+D1xOkdE3B/tKW
Vk6XDiEg4zDO7IU4W5XEyMNNVh3kVel2BhakbsWMkSNxxmikynrPFJVWxS16pMqm
IDSa6o5wNnxVqJer5eO8Ao/4EMTBQQ==
=sU7C
-----END PGP SIGNATURE-----

--Sig_/Y3DkAX9Xy6AktIz_deeulZN--
