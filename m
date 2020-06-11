Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A36C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B7B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tJUsUmSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgFKBEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgFKBEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:04:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09518C08C5C1;
        Wed, 10 Jun 2020 18:04:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49j5HR1WF0z9sRh;
        Thu, 11 Jun 2020 11:04:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591837491;
        bh=9SbvOldnk3HdDzJ99pzZwFYv2zPgWhNNTx+EqZMeH+c=;
        h=Date:From:To:Cc:Subject:From;
        b=tJUsUmSZLzPHh7kKlK9YcH/r63foYNjTvdxyF4wexBJYCfhwFuttelJVtR/wU1j3z
         NSl+WKLbc9+e32emefq64Z3ob9FN7jQqoZSq8/8IrCi34jKoJIcF9NTDmf9KcSBAxO
         RlpH6BzmoFf9OrVXFuI5F0xoh2rEq2xGIPB1Q2HsrKyrBb6oA2OCIMQcwc7Et5Zix3
         OQr9exkvPcyNKQag26rE5ZUFFIlVBoE65OHp4jJH5JVw+LD6GwH4Eq7is9vBjMkSYx
         5+iFdcljX9TdNQflP00O/QFWwu9V7Lm7xVvK1q5QVgCmrOaWr6geHdMzfU9XVl89Ox
         JbMVJEuSDpHDw==
Date:   Thu, 11 Jun 2020 11:04:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm tree
Message-ID: <20200611110450.364e8e7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k.aEEGcxG7d.WWW+XcTG4+3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k.aEEGcxG7d.WWW+XcTG4+3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b112f8184c50 ("KVM: nVMX: Consult only the "basic" exit reason when routi=
ng nested exit")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/k.aEEGcxG7d.WWW+XcTG4+3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7hgzIACgkQAVBC80lX
0GxSyAgAjKlt4zHw2DJSi6J9vD9SMKG8bHioHeKK7lsX1PAUGTLSa3QFKwrXnqmH
D55LnCA1Fvu6sWXkAnUT0xdhXq6tQ25v1ZfiZo/0wbC/jdbtXNcJQ1d8UPNDzpP8
Bv45fVqDztYMC/2Jlhz2UxWIstqOmE5K1zyT9DxGa0M01gqv1S1x9H9XOLMKigqC
VHwl5GALN6ZcNtP7m35B0xdoeltHZbl4/l8oN1wbYgERjoMKWoJBORYwMTOAENgM
85X/kcgB8WXjslaFL6aTABIddEhbHXXq/kbng8R7GNWc8h4r5tEn0bkR6SVAZyqh
FnwM+mGy+1lWELZ95rbGF1B24Rltzg==
=EH9N
-----END PGP SIGNATURE-----

--Sig_/k.aEEGcxG7d.WWW+XcTG4+3--
