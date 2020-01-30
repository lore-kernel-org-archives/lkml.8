Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6807B20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ScHGOJlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgA3URm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:17:42 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56153 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3URl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:17:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 487s8w6YGRz9s1x;
        Fri, 31 Jan 2020 07:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580415458;
        bh=83JhuBz9F3cfqx6bDq/W4iA71Lq90LSjI0cH7aloKA4=;
        h=Date:From:To:Cc:Subject:From;
        b=ScHGOJlgvLAT82YJpBH2RpkE4ZSgZ4Kn6ksKJ0Xb4pEHZco4L6w/E4xd2RdVOHjVV
         4HMnJ/QP7k7OskzhinDwVZfXUS+uctznh/LFbIZW7bdcq5/2hBt5cOx9m9CNNfnTmy
         odZsOJabjOcB7+qTXLTYzcrzwRv5a7GymjA0Mx7t0Nbgs9PiemQTdfmfQsAEwCG6Yw
         nHY8E6n9FHZeNj+MQZwiae1dtYiZoGlpd5NF296C78bLMnBsiOQgpnYEMT7KTxF0oM
         aF4lgZ7FUHtJc1BDWC8z/H/Q9u8W/bFmycNOWofnN38N3bAuz7emKqJttaDs0MpNNT
         KIfhlt+bbY1DA==
Date:   Fri, 31 Jan 2020 07:17:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20200131071718.248da483@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_ZodzN52BC0tg_nT93OvKJq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_ZodzN52BC0tg_nT93OvKJq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4d99abce8ce8 ("riscv: Use flush_icache_mm for flush_icache_user_range")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/_ZodzN52BC0tg_nT93OvKJq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4zOc8ACgkQAVBC80lX
0GzJgAf7BXge93R4baEL0VVRBd8xZM5T7i/3pRPXM3peeSjTS6M8lcaNrJV5/ZpN
oCupml+gsiNuf4KEA4LZOlRS2C096dAnam23tSZlZ5BRNgPUX7Mj2X0TZ/bG/MKe
JwoeExoJ76iO84pj62ipvTtnGXD28WCRfADFIqIhsp+gzmOMh59cEVU18YkkFUnc
Xx7tVWd/bVfidEb/jIWmmQy5jxMj3GKmHI/ik9zYubEU1sJBQTnxBzDeAYnXO1dY
kFaN2EkJZkmAG7SEQm5mkgWJV0HxWp/V+1+6ErRJ7WbkiwjbEx+TcXWMiWl6bXPe
0Lta6XTuRjmSIElaIDOhf1eo1HKxhA==
=WB+5
-----END PGP SIGNATURE-----

--Sig_/_ZodzN52BC0tg_nT93OvKJq--
