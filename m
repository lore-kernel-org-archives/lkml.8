Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66863C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9C52071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RixzmimK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgA2VfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:35:04 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgA2VfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:35:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 487Gwj5vrBz9sP6;
        Thu, 30 Jan 2020 08:35:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580333702;
        bh=eyqY0mX0PpMaEAdMEpXg3iL7rJwWR82QGrbDc86uKi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RixzmimKY9L05wQIdgnb0QTs3Hs23KiKVcOFVnJ/haklsMLLioCCEpy3IN3k3uLuj
         Q0LjvOjEreaZHePDJ2GNfPaWmytM3B+BAQdIwlz5jppGHMrM069FJVjdWJOZAc1kWe
         786eBW8xLts309Stl8GWmXIpS1qzNUPq9fK6kibtzYVWTM+Pm6ZVITO7i+H647afWW
         VpERWXxo3z6SoyfzeBSfM0Ug4CDgHnQnd8N0yxoIdQTFHESZB9CVM0d3eEb1+hDaky
         8DaLWXlkxiUxRkZlCx+2lqlGUIKiHIoQqXqMg0JMYvAE35qtq3Xynn1wTR7tFemlvD
         r5y9chlNxWxFw==
Date:   Thu, 30 Jan 2020 08:34:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
Message-ID: <20200130083459.206fc0d9@canb.auug.org.au>
In-Reply-To: <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
References: <20200129101401.GA3858221@kroah.com>
        <CAHk-=wgwBfz0CtAFZMDy=A_Wz0+=dzrfWWiHESUD9CxnV=Xyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hv/8lCC5NcF2=3iM0zHgW3F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hv/8lCC5NcF2=3iM0zHgW3F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 29 Jan 2020 10:11:26 -0800 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> Stephen, does linux-next perhaps miss these config-time warnings?

I saw it when it first happened and reported it, but since I merge the
ic2 tree before the usb tree, the warning went away for me after the
fix was added to the i2c tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hv/8lCC5NcF2=3iM0zHgW3F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4x+oMACgkQAVBC80lX
0GxB6gf9GfpZmBKW4JuE0Us6SJ7R03W90WIp5GKHm1m8RMUKR6kGUe+Qi+EihvYC
H2o9mTQch46KzQBBzZTRumnBlvzv6QpuygvNEhKOgI4+deAYCWDYTO0nKXW2FUFU
FXqcNzUEdo98bjiZftz+09iL52/9TOw6zGY47UTLX4ZprlIPr+UHfA0oZ9XW0aAI
KaDfoJviDNIoL4k8wRWCFYmur5L/qxbUJeydVa0J14euXePRHFnn7QkpAyXksISu
P1aMf5Q2bUG4e6Xth0EhNeA2KCbkrjLxuwJ2B0Ix+njk6J2aRck22g0rS0g+x7ba
eDsBdsHewA1i9y3qzOYlAWWkoItpyg==
=pk4o
-----END PGP SIGNATURE-----

--Sig_/Hv/8lCC5NcF2=3iM0zHgW3F--
