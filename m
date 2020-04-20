Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DEAC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2441214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="scyXYztl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTBMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgDTBMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:12:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF442C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 18:12:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4957vx0Lm4z9s71;
        Mon, 20 Apr 2020 11:12:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587345133;
        bh=Zcq7i7X/WujlVV3NVDtu9cMV4w1Xz2llS4db1JSEK20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=scyXYztle+4omR3vTQ9sokzMctckNrTRN9qLvizleV6CjyRknTAIHDCuC5VNr97ex
         FGT8Gwu7LgVxKu4xN8s+dm+1pAORRd8VKUEVRVLezXsT/r73yIyR07xH6QlPt8CcMi
         HRJ1wpT9srYlTk9R0aZB3z+jyLog6DhFQHKpyI3j44UFig03x61FHW1VVFen154M1E
         CXwFYDaYAdTtd9/2ehxH1rSyQzMQMltEQzj5e2XZvhDKY8hj7uRBP8hhyCawiuR43l
         GKek1AWgXZDud0o/dd9YMkA1OIXqfi3M98PZOsC2bT2eFKx/gQxIdgBQbhIkTkYdyZ
         Q9Ti/B7mH39Vw==
Date:   Mon, 20 Apr 2020 11:12:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] flexible-array member convertion patches for 5.7-rc2
Message-ID: <20200420111210.50737f67@canb.auug.org.au>
In-Reply-To: <20200418213828.GA10666@embeddedor>
References: <20200418213828.GA10666@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XwN28VMI3c_s+U=eocsa4JF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XwN28VMI3c_s+U=eocsa4JF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Sat, 18 Apr 2020 16:38:28 -0500 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> Notice that all of these patches have been baking in linux-next for
> quite a while now and, 238 more of these patches have already been
> merged into 5.7-rc1.

Except that you rebased these just yesterday :-(

I understand why you did that (because there are still three earlier
patches in the linux-next version of this tree), but please try to
avoid this in the future.

Also, please clean up your linux-next included branch to avoid
conflicts in the future, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/XwN28VMI3c_s+U=eocsa4JF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6c9uoACgkQAVBC80lX
0GyyMQgAoy8u4jonEyPBxWxwk0pNXRMJ7iQ407eCEaD36J7KJmqdiDC4C9Mpth6A
7/Rb9Pt2/wiCoHu7LUAkLLREwgtQtVAoPX/kFN7DWZvywXAGXwjDR+rXHwWwjHVM
1xQV0xrpLYkYc2rh62GbAYiyhFxqyi/h3uIYc8R61PLNjVCPeFconqCa9ohGp/Lv
P4txcrfYB5UPZwp8Iv94ruuAXiQGkgu3oBIC+8gzog7vCIabmm3aeI/jdik08acI
5IEaRNX8LzDR2GuDrWYsZYbo43KvxZoTfpWKPJUaKRDD8z/DX0z03YtLNTrYfm87
nv46GlMKCSYZxwHGMoRYcqKTjx2lag==
=G0Nt
-----END PGP SIGNATURE-----

--Sig_/XwN28VMI3c_s+U=eocsa4JF--
