Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFEC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894D206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LTg9ika+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgBUP74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:59:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:41707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbgBUP74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582300755;
        bh=d2ZkK443d4BHT30ZFEmF6Y8U3raLXQ/NQ1CVDMenM0M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LTg9ika+vD8hPIt//SK4kmSd46v43EK/4HE+WJEEURoF/pDD/29GRFGH7iGOhrMsJ
         VJjq6S9UZkotp0OlzayL7dsMC4svIhVIwUpF0CG7oXqPkNOjGT6SKXtjOt2XRj95Rh
         pNskVbStFZl7QYGFbOGZ7E5ww7v6K+9HCqiALX6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.18]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAONX-1jAu0u1dVL-00BwT3; Fri, 21
 Feb 2020 16:59:15 +0100
Date:   Fri, 21 Feb 2020 16:59:12 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] docs: ubifs-authentication: fix Sphinx warning
Message-ID: <20200221155912.GF2031@latitude>
References: <20200214170833.25803-1-j.neuschaefer@gmx.net>
 <20200214170833.25803-4-j.neuschaefer@gmx.net>
 <20200219041758.3b7316b8@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <20200219041758.3b7316b8@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:YbDiWGoUlkw7KYFFvHP0EElkU/3+yZiQU6F1r601m4IhkiTOywM
 n4oxuP6TIHheM0ctLm+MSoLeEfLR9cakqC5W/UB1kuLb3lba3cUj81OIxmgq022idQwYIc8
 OY8+jOOE7oV0VYU8ryop5YuvWEf1Y0zh3fj6YMEfMiXtpDc5RBwUBmJjqAsWuVE/fIs3UBM
 bs65IMAAIibW7Dtf1AsEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fAoSyRD/Elo=:3ud0ELJ0bSkRjL4aJnhrFi
 pMcEN++i6Jg7h71t8nR4u/z8NS9UrRQqAJi5aMEb2sX2yviRm6VgtnZ5YB+nfYWg2z2Cvs+oo
 P/iCFxuA2kk0oX2icRUSZFodntAS56U6GTcdGz3ZAdMJM9eLlj/GQvDDOkxwryEfQw5kfFr+Q
 Y6eydFu5a8EdJyxcjp2N0vsrah1u7gAdt+/oyQN3+S68DF5sjKQkH1EJP/Af/ci/4tHrbAaO+
 6vcqIqG+552ZmiSYu8y20svUhV9NXAJhZwc+C3tQ416HfbXtyDxhrtwirKyeym3uq8mgl0xA5
 6G0ZAR3Jij+1qKLaHXg9dC8YGxMT9jfFpICrdHaWzfs3plPryhef3ooAaIUflJtY6Bj5cwI6n
 ZNxNI55sl/Rf45GjIluOktV+90EHSDpWPfByvtrIp+2Hl/1+/WXa+95qVmV+nD8CSu7OczCll
 7KdQ/qkBVZt3rEHi14IvlUTylW9duUMhlkGBkae4TZYbr2ANfROMPecLdfF3aNLtVjX4BJhyG
 Xj3qezWmgAhZEnCnTHwkkiIWrXx7PWDnKz4DMN5ouRy0acGdS6S7NIfdYqxwnQZ4bzZvmJ7wa
 X6ZzZLuLN09QbXa/wPyuTj2OpOaeblQ1+FiCOquEbVFMHiSERNfx4Iw5P7f4aA/tHCwFjdJdu
 zd+r4Ci7fGzUbGvhydH+wK8mwbx1X6nODfqI9x+p06AXB4NSssWH/iAxap8mWQVTeBeBtHf9O
 PEhWLtZGqwVaEJrrGqFgPTpWhKDwf9Wp9k3saf42lXI+DnxmZGBUrc/FiP1b4GRfTKeZDYNxP
 0l4BQc+6XOi0G42cMi0U3hs9NI8j93MF1+Ao6/DOBGKdUHQej1KZgsWlJ63E7K+6J/97nTKhB
 Wwd83kpjKU4nj0ihtEBTnbufA3g2+M9WOiuhOgN9FboIgbrr/zdzTcZHkifVjViG2/xTOX0l1
 VK0O9YEPezqW4HS1T0u0mc+z9D0IW8zcHX7FSmsdwPk6TrPEXkHwbhVRU+rfFwqkIJ10hzBhX
 OitVbf9dpxS9+88oL9IACwFLXAWmgn+1yXtdFzP3Jb2iyVJoA4bKEOwenWQMpoE0Ljmj6iq9W
 7LeAUrQGY4In2lzoUOZ7Q90PjHIvnzfV6k4pDlIm8yhkNXWmBb18VbkcNyf1LvvDphJI/w5dI
 IRIYBbMD/ovkLJ+e1E9Ne3rwS0vmUAECrifZPC+Jybe2iEPkogwnJCmr4OLVkbpQqKO5S9SLT
 8k6UFNmCdzAzvdb16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 04:17:58AM -0700, Jonathan Corbet wrote:
> On Fri, 14 Feb 2020 18:08:07 +0100
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > This fixes the following warning:
> >=20
> > Documentation/filesystems/ubifs-authentication.rst:98: WARNING:
> >   Inline interpreted text or phrase reference start-string without end-=
string.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>=20
> So this, IMO, should be fixed in patch #2, when you're touching the file
> anyway.  I don't see a lot of value in adding a warning to the docs build
> then immediately removing it.

Good point.

> Also, please send a cover letter with multi-part sets like this so we
> know what the overall objective is.

Ok, I'll remember to do that more.

In this case, I just saw this file and wanted it to work better with
Sphinx.

> Note also that Mauro is also playing with this file (and ubifs.txt, which
> really should be included as well) at the same time.

Hmm. I only saw Mauro's series after sending this one.

I think I'll respin this series after Mauro's is merged, to keep the
potential for merge conflicts low.


Thanks,
Jonathan Neusch=C3=A4fer

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5P/kgACgkQCDBEmo7z
X9sf0xAAttAMODr7tW1ee559PLozbCkEl7bXel6cTaK1qGk/qmoVN+eSJJZs4c7t
8sXO26osJt/lzIejt6aExNH9KmPhcGYpjT0Dw94H1KScLKBUnRFaP1IJOMJsIgVK
NNWM2HpAM04Eycdv8/T52G8hGa9NwCV3woS0zxFOAlyzedRvjt1BEZ2w4RwbhADO
tdRy5QqdVM9WNsT3oyHA21EDNr45xPPtBTfgCAYsKJTpdX91l6KzutTxlCvU+Dwc
Oy1YDorPE4H6oj5o7LPZ3hqY9Ek2yfEPgzy3UZq29AfrH1atgSlHmT3hp3o05VQN
bKYbtgAUl48xL76iay++F3Nm7rUzWSV3HI2ASSu/D/fL6CQXxHUhhbpvQXMp7RMp
fdlY2zzYxmRH+iheFyEEzK5umZM8CfIREVwDoho/p64bprszXoKHio+icumOQ5Wc
c7HTkoCJLL93rzJc9qfMAWCJ2pnyMb/iR5SBhmsFtY7lWuoFJBpQ0H6QKAv9lh2h
t5+IbzBwpG0tCG6zNsGbgZl+/X9BFnmGyP49iTiEv6vqEyaoh4/QhknQ3oE4gj/e
hsQYWEG58KT1iHmWpAOzuSd5Yg66Mdl0od5KQg+/D89LCdG/e+/pD3/p9dXgXQUS
UlXU6ZpqdDDBMBaowopT7+BcdJcuXYItawdDnIs02mhLFI/H56I=
=t+dZ
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
