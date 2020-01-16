Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A98C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF902084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jYpcmHZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgAPB6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:58:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:58489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729615AbgAPB6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:58:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47ynRc5D7fz9sR0;
        Thu, 16 Jan 2020 12:58:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1579139932;
        bh=4JZAwZ59Suehyvg/lm3+eFiWAc95gZ7xB9b5uP1d9nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jYpcmHZNzdZb2cjU5hszNgAyZYViwYym5PNTqdc9srJfKpc89QNwHne7Grn8lwZdx
         oRYSDF6nTYbzxYmug8WZ/rpXpAYBYwvx2WGEuX24nfLIZfWP7DZ5EPxf3djewSl+za
         +whrMbZhX1/zsKldIGHmQyoUtidxZvswT4kl+YbAbsRzxxbLPiDAcv+joTIrVvn1+1
         Uhx/xSPBnvryQ640aPG2cj6n1kE5w0+DEe+iDhnUUj2clcQJoCEuApi5HcmZeo091V
         dB7dr6bXh3zSlfUO2msWnCJCI2LBlWsVrMzaFf4SadTxd+MScn9fmaYvGe38oBj1Af
         7PGcwNPJgnRSQ==
Date:   Thu, 16 Jan 2020 12:58:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the usb-gadget tree
Message-ID: <20200116125851.474f3021@canb.auug.org.au>
In-Reply-To: <6b984328-b3f4-a23d-efb3-7e7955ad165a@linaro.org>
References: <20200116070726.7e2ef8cc@canb.auug.org.au>
        <b7ef5047-c8c3-42cc-d049-fb72563d3544@linaro.org>
        <20200116124100.58af81d5@canb.auug.org.au>
        <6b984328-b3f4-a23d-efb3-7e7955ad165a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/huonceTZNqlibvvDjigJ7kH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/huonceTZNqlibvvDjigJ7kH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bryan,

On Thu, 16 Jan 2020 01:45:25 +0000 Bryan O'Donoghue <bryan.odonoghue@linaro=
.org> wrote:
>
> On 16/01/2020 01:41, Stephen Rothwell wrote:
> > Hi Bryan,
> >=20
> > On Thu, 16 Jan 2020 01:19:22 +0000 Bryan O'Donoghue <bryan.odonoghue@li=
naro.org> wrote: =20
> >>
> >> How should extra long fixes like this be divided up ? =20
> >=20
> > Just let them run on even if they are too long i.e. don't split them at=
 all. =20
>=20
> That's what's in the git commit log though isn't it ?

When you add a Fixes: tag to a commit, you quote the subject line of
the commit you are fixing which, by definition, is a single line.  We
want to keep it that way so it can be searched for easily.

So to create a fixes line you can use this:

git log -1 --format=3D'Fixes: %h ("%s")' <commit being fixed>

i.e. in this case:

$ git log -1 --format=3D'Fixes: %h (\"%s\")' 40d133d7f5426
Fixes: 40d133d7f542 ("usb: gadget: f_ncm: convert to new function interface=
 with backward compatibility")

--=20
Cheers,
Stephen Rothwell

--Sig_/huonceTZNqlibvvDjigJ7kH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4fw1sACgkQAVBC80lX
0Gy2PAf/WL3pfUxjVtZDLgF86x94Aua5GC5/WvZV2MJgsuGYmdiWwsCpuUlHbnuE
IIW+zUfRgab3VATHXkYyEwHUbx0+Fgo9fPQHMD6wMsjD/uTfvBU2upyJguMrO77A
t7dbl7kjbiDbJdFQ4hYFKQRPhhrMNQ0XcnP4xTeandYksg6ZMen3R3TIzOxN+y1t
OQzOyp5jFdx+iDt/TtuNbt5NaAT2XAPMgzxcL+LwPYMgzWWiNL46ifVvbr7HVIr5
9bWLsbjk97oBwF5r/S7fwH/ariM9RBKpGVgAfGKsswiyobNJuKVEDm6xoLhXN40a
V7rxK2sS+FjQNxDKq3452fI+d7HyTg==
=zHWz
-----END PGP SIGNATURE-----

--Sig_/huonceTZNqlibvvDjigJ7kH--
