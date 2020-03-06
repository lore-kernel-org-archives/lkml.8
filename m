Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11663C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8CB20726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Rxnahfru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCFK7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:59:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:33151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgCFK7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583492337;
        bh=kuyvtVf1FO6LxH5diXT7XM0zj9zhQlps+gmZqb1gbrU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RxnahfruR9TaTAw3hDrZVCKsoV9p8qDnQR/foPPk817OrF0gMoFgeZaHTQGFn4zMB
         /yUkkWmX/W3xGz63IfjPxPqpespnVflyL0AkMlFLwSJYs+bSCcZDflHS/bo3s8TjS6
         LZKaCqr5e7maaHO126pYRwQKsyOEYnYxoz72tHsg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.201]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1jURXE17BB-00tR7j; Fri, 06
 Mar 2020 11:58:57 +0100
Date:   Fri, 6 Mar 2020 11:58:56 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: cros-ec: Fix indentation in the example
Message-ID: <20200306105856.GC2376@latitude>
References: <20200305223631.27550-1-j.neuschaefer@gmx.net>
 <32848672-85ab-5ed2-731c-bfd4dfa62760@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <32848672-85ab-5ed2-731c-bfd4dfa62760@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:l//dY32oPOvq4IGyJ0ElGcieLs6OXSQ/K01CiZeQTDxAkxrH6tl
 jMq+m7gufeBLjddkRrhNEZU3Jur695WDaEbiR99/Q4/xUfBxjiOJ9CdbJGS3Ude6xWgcLTS
 t7MqMWg1AMR2bVHRVA42g6+0RCNKGzq3n8K2whaTCZrFzw0l8pL08LhKy5uNK9hxvuv4nCh
 JN8sjdyKD7tdbVWR2NF6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nfhchYzS+Ug=:ztBB6afWMeKU0ebrRI2/9M
 upVcaI6A0E6dYcfjY40fWwYAUhRyLpEqlb/BZUaX1f/fP3gjBjj6BrcWJiZo+lElA7AvJPFmv
 CSMul3ooKercjhOz7F5XBJE9nLLrw8k2cQuConaslxhfe6Rw2kDrqHUk0qQEM5iD3M+2zWypS
 J1vQj+mSgxpDH0SSI/A+0/Uokgjf85W5Iv4FZX1CHGG42FUB0omOH+/Dy2hol6ftl+4QfvVbD
 210tPiBUOI11y9g2HvT/jWWWfuQWOxZe0Qt7TWZxsAV5+x6iAxXNyXZnXPUX4hdY8mYZ4wtVZ
 zgBETyX0x5uSyfARZIxIwGb8m0fhLvvcHGllDaKhrT7rPQDgEGUoh0xJe0dzT5UnVIs+hYSsO
 OmT9MasttE+XWW3zJO33/Ab8OHsa6AXhQei+MdqSjGmiqkNgB1cq+DmuQSjosaZdsw1DCpXfv
 wvRhOdBLS7K2zJ3Ut+jryv39Tb71Gq5jlEKkX4XQp7YgnW9pB9ySqUDaqgZVtF3KwHuyw1hhB
 10zTI8NI+8iIq6JiN0fEny46a4O7Rm7ZJQT/+tBb725JGUTyVpLkL3aGT3+68sHG6CPqQ6ikJ
 n/FYoHiqpw5w7vnbc0sSeSbTvqUyfSNqcv/LgH43FSJwCUmNNnaRTLmYZgTaH7rUWJp0L5gmE
 5ohtw9YrIx31oR53UQJfJ9zJLIv5n3AvhM3BcO0yqODQyUfmOyANhXSLEJyjO4brL+iwNZ+Sk
 tGL3LwbRn+naDmvcre4m8ZuPgKjr610D/Nzucv01xFvnP+MEAqsqyFEgfizSQrdQNJP5ZfVJj
 66WKh1NVX59lLk4jlV/5AliviK0KH2IFDsID5OKmN1tuIkelAfZQEqcoeShpCGJVMZ+6l1pXD
 KhDwjagxNuh9vm+Q5zczQFM73/peMQsXeapDAaleHxU4MxYBYGkmnfepz/ASk5ymNvANpli2k
 pghVA6GANc0AovLgTSdTRmyH1NzDs2572fSsft2rAjrmLG4zGUSYJF//9pYy8FS9UZkDLeTTV
 FkFoMH/DszGOSXsHnemz+FOpo8VtZyY+VRfIH8OHrTV0DO4CoQnAWiQhl71sTmXVvqZwK77ji
 NneCYDhR41/8R95DG4ogB23QrdZ062GfPxpUsEm0Dn+ha8QEWnsY6vksKpHpPW89VaB8ZcKUC
 oH17p9RLrSy82IWyihIzn+yOvJTRhoy320h6JHxIGKy/flgIjXKQnk4GHo3adG87KmTMixDzU
 66E9wu8h9ebTaeEdM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 10:07:31AM +0100, Enric Balletbo i Serra wrote:
> Hi Jonathan,
>=20
> On 5/3/20 23:36, Jonathan Neusch=C3=A4fer wrote:
> > Properties get one more level of indentation than the node they are in.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  Documentation/devicetree/bindings/mfd/cros-ec.txt | 6 +++---
>=20
> Thanks for sending the patch but the binding is in process to be converte=
d to
> json-schema right now [1], and this change will not be needed.

Alright!


Jonathan

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5iLPAACgkQCDBEmo7z
X9up7A//dlfuIqCNhvRSO76nhi7XPY2dbDiukYmO3bWzTeSoFjp1+qE7fJd9ox7m
jrh6sl90RCP7TbfGSq8eOJ4e7MIQpF14XmBCns+pqrewGH3cDm41wyTlnYyXXeh0
Jyg+k+h+0qtSgWtC0S/Y4eqzv7d5pORXNc4i48KeOmlNoyUHX/YnTM89oBuJ13R6
B/RoXC0lAl39fuvT+x6cKoNfCeB5p82+//bIEGnZcOW8Tu6yc+OdOTtPv4JgSKhi
D79Ti4bqzaD7KxNpGbFHFeWn7VV4fKDB7eKG+pYMAWh3TN0UB4Y5oSZN7NSG3Vz/
ZCOHYpSzIVc/q9QDvhDXAg9XLKt8kL/lHtLd9cyJCWdNiCjvuYjwkk9TkUgd3YyU
Fgo4RmH8fiPM0+sZKG4NOK/BUNNslM0RuLmsHRaLewIx9wgzGM7NFJPJxmP5qdN0
qks5Qtt7JLUtzgStXl9tEPByxs/JUhn5zVq9MJz9V/ceWUZAYEEwb0vAhKWgFA+m
IFfclflG+UCckKNxEWuiX/yww/uOfSlBGO8JpyiPWu2Vb5Etnu/J6r9psvkTqWC2
/zKS5L3aXLW5gw+WUmprtPDrkqwP4QWG9OcBfkRBB/cVOrPq7tU/yKVq2qZ5XlHf
gbGmTwqENNNio6gv2OpwyCXnangWXjqSbdGPNapM5ny4Fl2fgdk=
=1HWf
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
