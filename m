Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F9EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03BA20736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KoQcPfiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgDWXaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgDWXae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:30:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF8C09B042;
        Thu, 23 Apr 2020 16:30:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497YSk0pSxz9sP7;
        Fri, 24 Apr 2020 09:30:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587684632;
        bh=rnq3dwn2lk/sv+azbNzSu1ydlrGwjtjrbefECvgy2ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KoQcPfiVkXQdKkYmcvix3GvhiNKsYsAZjIaVE9QDu3ktV77Tayr7cieBP4gmGDcRu
         mJLmSaAChToFtyGKNRk8qo6fmbJk448KpRcFTelOO8o7Mpqw2CYZIaEnoliQ06sAf7
         qkvrIXgRZwBDLp8pmoIy7Z3XGQEUh+RK6SQGu7RwRvv3aqxwBeFFhgJMYUiGQUWRPC
         9qAPmsKk3rewL9Za+8iLVcOGkaFZr7i/bmDpyfHI9IY6SS5FK3H7ATQnei47y7AF/l
         08ETZFofVny+WqcZj1INiB6K5viJBOJqcnMUiXfegR4RLX+KE+MY5FeAd6ITJXcvvR
         SlxelBWK1jA4Q==
Date:   Fri, 24 Apr 2020 09:30:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: out-of-bounds in pid_nr_ns() due to "proc: modernize proc to
 support multiple private instances"
Message-ID: <20200424093028.6f4d7547@canb.auug.org.au>
In-Reply-To: <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
References: <06B50A1C-406F-4057-BFA8-3A7729EA7469@lca.pw>
        <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DY4oAsYly4OlQuerhuaTNig";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DY4oAsYly4OlQuerhuaTNig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qian,

On Thu, 23 Apr 2020 16:11:48 -0400 Qian Cai <cai@lca.pw> wrote:
>
> Eric, Stephen, can you pull out this series while Alexey is getting to th=
e bottom of this slab-out-of-bounds?

I have removed them from the akpm-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/DY4oAsYly4OlQuerhuaTNig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iJRQACgkQAVBC80lX
0GyPNAgAgHzDVwQQImvhen/7YJNJKJzHBeEqTVgSwdnLeTOMxfaeR/qc4S/ObT17
oFHKnNI37t7qYTK/GQKVouPqr9Oj9M/FcnEymqEPavYytRI2sQoQXIKYiwBFOVsV
LBndN75T65oi3tnYHK/A3VXSit/GWLLN06rQ2xn7C6e9Y+AcfoQ1dkQ0wyJi+TqD
15K8TDVhooiHnis/gODioATHtI1jOEkVDbpk4EJehrz/QnGtEm8zpdHD/J+MuCc2
n/Ibl1t842T8aDG4Ds6EJCeKqiBPLJ2taN495OdzHvhmk7uQNwqeMc7fKPua4wSZ
n/Bf14ctABD6klCWzJ51ClM7cr24VQ==
=j4fl
-----END PGP SIGNATURE-----

--Sig_/DY4oAsYly4OlQuerhuaTNig--
