Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5AC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCBD2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 22:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G5aYRIYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDSWN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSWN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:13:28 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055AC061A0C;
        Sun, 19 Apr 2020 15:13:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4953xc47Ynz9s71;
        Mon, 20 Apr 2020 08:13:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587334405;
        bh=wLVpaNSxTtVI5w3cfiCfglkr8HdHqtPyrVsLSqIPPAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G5aYRIYeBqAkKNBDhJS4UyWkmVlho5rWFXGYsjfvXOw0T3LV1HCVyRrqbRZRrj29U
         UZ/FuLVlYrzYUgx1gmFB74iAKfaiq9FCaE9JZnAikDWq9Th6HOh2Wu0dh3tvK7Dl7R
         cAcSJJi9GgsrKbk/hpb+QAdRKtzMHQSC3Kf8xqBlURWbP84MkgrjNCqXBS6I3CjbFA
         A0wx05cb+lH4LhpEHPXidq6KdesPvJutSl/RhNV81FHR8b2HoguqNxhQytvymKtFvw
         /kdWHwSvoD9XD8Dth8DNeVhRQCJpEjXk76dXirDemn0CYRssgGG0r+OaaiaA43oaG4
         93oiZogp0C67w==
Date:   Mon, 20 Apr 2020 08:13:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc
 tree
Message-ID: <20200420081323.4fb9889b@canb.auug.org.au>
In-Reply-To: <20200420081154.597ffa59@canb.auug.org.au>
References: <20200420081154.597ffa59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.6Jav1OWfrSdugNA3N4SosL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.6Jav1OWfrSdugNA3N4SosL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Apr 2020 08:11:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
>=20
> Commit
>=20
>   512e8d40f91d ("ARM: dts: OMAP3: disable RNG on N950/N9")
>=20
> is missing a Signed-off-by from its committer.

Sorry, that is in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.6Jav1OWfrSdugNA3N4SosL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6czQMACgkQAVBC80lX
0GzVYgf+LH0ceV/2XzPHskkEx8/eSOjbfxkqrqIddxUvltjUUKSb+sUI4TUST+66
cElZ9LG1RDhzD21bhD9zRcKsYZ9RghB6MRI9pAZePh1bSQ0Qng/1+ySLMhsbLO1d
PvYuxw6QUunDHmhaSnj65q83UyqysTMVSVzf3QOkDpRp4DfC0pgK1nkFIl9YpvIB
x9PCDUhWnbE8ltsaW8t9PqN8YpQBClRpHuwfaN1syV9o1ONrhXAXci5e0DQxzT3x
bwAu/tCyQ9AU9bKPpt8Nr8Adzo/QkiGpgHzl/Rjv/KlI3XrdZSLyjrukR5hlHARq
OZmoyhjnnWd4EqZRryXKWG9w5+VIhA==
=5Jpb
-----END PGP SIGNATURE-----

--Sig_/.6Jav1OWfrSdugNA3N4SosL--
