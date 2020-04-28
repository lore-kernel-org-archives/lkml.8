Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E5DC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD972206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD1HBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:01:33 -0400
Received: from sauhun.de ([88.99.104.3]:39424 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgD1HBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:01:33 -0400
Received: from localhost (p5486CA03.dip0.t-ipconnect.de [84.134.202.3])
        by pokefinder.org (Postfix) with ESMTPSA id 1AB072C0710;
        Tue, 28 Apr 2020 09:01:31 +0200 (CEST)
Date:   Tue, 28 Apr 2020 09:01:30 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: linux-next: Fixes tag needs some work in the i2c tree
Message-ID: <20200428070130.GA2522@kunai>
References: <20200428082848.19d38b67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200428082848.19d38b67@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This triggered because the "space" after the ":" is a Unicode non-breaking
> space (U+0x00a0, UTF8 0xc2 0xa0).  I am not sure if this is a problem
> or not.  This is the forst time I have seen this.

Thanks for reporting, I obviously didn't notice. Well, technically,
commit messages can be UTF8, so not really an error. However, it will
probably break lots of homebrew scripts, so a checkpatch warning it is,
then?

I'll fix it nonetheless.


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6n1MYACgkQFA3kzBSg
KbaBYBAAlqd23QfIGLSE5/GOIVifxr8xx1DXidoqRozdr4ZzAyRYnUDkULHFtqq6
eUGdKrpNQkee9wfnQNBg6GCCP100mAu+ZY9od7MYwXm2TgkfQIs7sRSxzJduFSbl
mbTqHok7u7Ai5gb8l+EjH7uujsS5axHjn3yAuY+s4GYngtPUhQOQts4icGWzPW0n
1TaOKDRMi9N5ibQ9sbaYUNOhua/c5rxtQj8yJo3iH6YQpFuzlOJgulj9Xu1UqaYX
eovK3YeuBKrqX4JlicQcjGcoF2xTtqdkj3fEbjHq8KCYFuzbI9b4Ml0IMd1m181l
Zx2fJXeJRSnTMmrZzOFVGzJPBWPAtF7CiMwdoYMVUQvRK4Rrw5z8IvIx2isnL5ZE
hVWwLDjQlkydD4EOCqx4GGjDAl73be7wBCttcerzGFPal9fXnJ4Z07rL8drLeHea
XTkY4gR/8A2dvaH+XevPwCp+QM/6Dh0NmXrMnc+SEqzXtYfwIRIDYPB0PnX51NKG
V9oWaNx+LTp0j3lEv9zhutH1KHVWacHpNqvbb6uxSqfIBZp5z0KeUc0X2G6op0zd
OUK2IIaCvbLnefGAbMrLiKMxXAVfnRvnERg0NSiEG2bigcXu1PNBA2kJ0wSyKGOH
USSbOkL2uP2806iQUiPsKIjuw0DXWguP+rqKlfnG/SRsNFcE2oI=
=2VRM
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
