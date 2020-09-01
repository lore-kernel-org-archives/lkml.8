Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FC1206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ann/U089"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgIALr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIALhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:37:08 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A1C061244;
        Tue,  1 Sep 2020 04:37:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BglQx0Xdfz9sVS;
        Tue,  1 Sep 2020 21:36:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598960217;
        bh=X2AOCk9qYtjLeZjaIex/QURofxG//gHKvBaq5S3Bc+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ann/U089AHfpcaJN4/WnMcalHbjlISUBy7txIp+rAH0l7Mmwj7rj0EkSlplBhDWAk
         xj4EjaPq+AHskUGgXdkJbtlM2hzD0/4CjazKZEZNWeDdJWCqVNv/IvJkr+FMuR51iA
         KS+8QOOEnVdXwr/3AMuKtYwDGyU4YLYkPmULcOXNg/Y2eZ+DiBan51wmCFOXUMUdjj
         2V6dnZouL516w0kAX4o8PLu8cRi+II0dzfGBNPlHu5xMu3VMDCeCGWCrjZ9DaXUjnp
         HYe29WPo5pFqnFnJhvQUNYB1q4FeHFCo44Oq73a5Eg+xI0wIWX7KiDSC5dv5cDtwAd
         HJ87bmSIAl9XQ==
Date:   Tue, 1 Sep 2020 21:36:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the arc-current tree
Message-ID: <20200901213656.4d216c83@canb.auug.org.au>
In-Reply-To: <20200901091308.GD424181@linux.ibm.com>
References: <20200901184928.057f6082@canb.auug.org.au>
        <20200901091308.GD424181@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4NiKzVlbgkJ/OxsV34ZCyqO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4NiKzVlbgkJ/OxsV34ZCyqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, 1 Sep 2020 12:13:08 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Sep 01, 2020 at 06:49:28PM +1000, Stephen Rothwell wrote:
> >=20
> > In commit
> >=20
> >   7000c9462d1b ("arc: fix memory initialization for systems with two me=
mory banks")
> >=20
> > Fixes tag
> >=20
> >   Fixes: 51930df5801e ("mm: free_area_init: allow defining max_zone_pfn=
 in descend ing order") =20
>=20
> It's line rewrapping:                                                    =
           ^

Yeah, wrapped and then unwrapped with an extra space :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/4NiKzVlbgkJ/OxsV34ZCyqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9OMlgACgkQAVBC80lX
0Gw/RAf/aG6bOhhvVioMf2cq8jdQzC5320dYK7dVjTElpSYW+sDGorYeI/dRyrZC
8MGgZePpt6y0VCdLQ8fCqPthSAIJCEn0R4Jf3MmnfJcchgSiXF8kEis+1Vs1+j0Y
+xhCdy+bn2ORH7m3CefIV1+wOohlzJo1bz0LtBHC1ajc91YPeQv89p1xJhVGh/Gs
xfT4fcDP6eD3jHuQlyMfCz8qtKagXK8KxfdmGlMZQCoYAcMzCtZdMtINgTuQFv54
Ym0PYfRraSIHECu+Cg6nroTBfe6jWY1SUeHo1IC2c2pXFdGwTw1ZR80LBOYitSUI
zgsrDNgX7cJQFo9pp0EHidP715lc1A==
=r6G+
-----END PGP SIGNATURE-----

--Sig_/4NiKzVlbgkJ/OxsV34ZCyqO--
