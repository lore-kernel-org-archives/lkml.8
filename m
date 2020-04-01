Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A9C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC941215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tMTP3OEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgDAInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:43:46 -0400
Received: from ozlabs.org ([203.11.71.1]:44103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDAInq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:43:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48sfqh5YxJz9sPF;
        Wed,  1 Apr 2020 19:43:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585730624;
        bh=5Lu4xFxkVuEa3u64hrRrVtYmPq4JWIpNgibLdD4r30M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tMTP3OEeL5B0FN2ZU2ypKkJmy0fqi/rRpTkP/VXQ1sxsiqoQ9bcCjpQ5ywx1ScMiI
         bUHmicZ2bKilll7c1WmnzwHegAgg5rx9qOc1FavpatraTwTRga9jzoqRAwJA/Vc+qL
         fVJYnDvAVvnmONILnMxa2oyKgHc4XVDTSHdPmmpwqpggj1rNHmcmvvguTAf59uWjV1
         0Zq/Rdhy+QNHJ3RV4tHUGAsz56tMyc1vYhYut5c9f3iVqno9B8kXamqFgRCs/SXynu
         zrEiDBPiwe41n4X7o3ygCF3UzeYv97VYsf4E++PEvYO7ajLQSA6DELCQXzQ+9GHP5R
         f/6MxX4/pP2Jw==
Date:   Wed, 1 Apr 2020 19:43:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: turn of_pinctrl_get() into a static inline
Message-ID: <20200401194343.776a5738@canb.auug.org.au>
In-Reply-To: <CAMuHMdVqexMZKj8xtMb3NdV64xrq4ppiq0sLMfHdtft4stZZTQ@mail.gmail.com>
References: <20200401190810.7a2cfa07@canb.auug.org.au>
        <20200401191810.1c06ead6@canb.auug.org.au>
        <CAMuHMdVqexMZKj8xtMb3NdV64xrq4ppiq0sLMfHdtft4stZZTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/enELNp.kJVGkB2/Zsu0Vi7x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/enELNp.kJVGkB2/Zsu0Vi7x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, 1 Apr 2020 10:26:58 +0200 Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>
> Just realized this myself, while reviewing your patch.
> Sorry for the bad suggestion.

No worries.

--=20
Cheers,
Stephen Rothwell

--Sig_/enELNp.kJVGkB2/Zsu0Vi7x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6EVD8ACgkQAVBC80lX
0Gxzjgf/ZzoNjpeWmGqWdBueI6Oly3QBLW43GrMximPJi2KidEzTg8sI9qy8k6Sw
vR4HMdYqvQgg8fNhJzgvG+dr1i3fP/ho28S1NeP4ML2RYqaKWrhx0UWlD7vZT9qZ
5SR9foWPc313t3MZpki9DB2iDVQeD5AiUkXv3qJxZk8JfHNkQ92C0EqTeKRjCiyS
Fs6Yl6Bd8jFiRe3mGQP7qdJbdyU55zHSIZpobrYdYIgg3IIoyxZRExBJjAAhGxmv
hUdRmbaSKAa9tDE5DE0dG9f6OT4IOihljTpKFPjfkw3pcdDW+4qzQtNLZq4dz2Se
Kzo+qXV9ua3zwJIVDWCWByV74DtDKA==
=O61X
-----END PGP SIGNATURE-----

--Sig_/enELNp.kJVGkB2/Zsu0Vi7x--
