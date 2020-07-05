Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0600C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F1120826
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 03:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NQP0XXp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGED0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgGED0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:26:18 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70023C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 20:26:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49zvHV3yXtz9sRf;
        Sun,  5 Jul 2020 13:26:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1593919575;
        bh=ck06iISBamx0TCobZ4Y5nDeE+ArGM/pO5d78tIPSA9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQP0XXp/C4X/X/tGuIolLqUQbsYqjWD+XQSPY0XlxtHnhqWMP9kDnbDVjTZZk0wPi
         64iAqo9U6FzGgsQOABrX6xZV5aPr84UPJJuM5MtfFePQEuO9IeqIl5DGlVsSlnXu7c
         oEq7dMZ2kyY+1+UsIWyS+V7XMtalfI3C0nODGsLgKDLeSOnrOyrAKtg9bGtKT3S9E+
         gbZVqelIqRZP+pyRCOW3hfWzUxdvcjNYBtXe6BnTX/JsoXpT8fB31zfdgyrE1RcnPW
         TaxmlcgG+qeR+98H3NlzMOEbg4yn6wRBzQUQd6nXN0p/9rwSQL4PpgKu5E3hPM9LNU
         jcoxduV6+mLLg==
Date:   Sun, 5 Jul 2020 13:26:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200705132613.3144031a@canb.auug.org.au>
In-Reply-To: <CAPM=9txud3xg+++205X9s9R5wnxobpNSJWLUu=bp8BOhnX_8hQ@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20200705064348.71d4d51f@canb.auug.org.au>
        <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
        <20200705121216.2ce2dd46@canb.auug.org.au>
        <CAPM=9txud3xg+++205X9s9R5wnxobpNSJWLUu=bp8BOhnX_8hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iL2lz/+KwJs.0itw5NirmW.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iL2lz/+KwJs.0itw5NirmW.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 5 Jul 2020 12:56:23 +1000 Dave Airlie <airlied@gmail.com> wrote:
>
> Sorry I misdirected what you said a bit, and I did misinterpret as
> Australia also has it's own indigenous slavery issues,

(and non-indigenous :-()

> I was trying to stop the "white slavery" is a thing crew from turning
> up on this.
>=20
> Apologies for accidentally implying something what you hadn't said.

Sure

No worries, mate :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/iL2lz/+KwJs.0itw5NirmW.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8BSFUACgkQAVBC80lX
0GwH9Af/TC7R70v0PqOHnYyBqPSLekDlnoxwiUwuxlQZFDfRpbPsV0HZ/STVOrcn
SM/OWPrJ6noid35LZlU3C/SwL+9Z/RT3qN0bFlR8EzTrtKWgIY7SpU//KAFgoHZq
7GtoBZljNLJz0EED3TdDy2RI+1soMhhCTFsLRY7uEmCsPtRTHgqZDR41EYOeZ9Ok
EBT8J3Bm/1FcNIIhEfd1SIjKQqHMZc5CBBP0seqlLf7QNP9nzBrGZKkjoE6+E5UG
7hyFF0bS6vlcGTXDsNg8J+HsixvlmeeLSyf++5Z42wacZux2+HdPFACVmIqGiJrc
weQDx7Kap/TQKEtnePE8ZLWcj3aStg==
=iD9c
-----END PGP SIGNATURE-----

--Sig_/iL2lz/+KwJs.0itw5NirmW.--
