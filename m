Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46573C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BA820784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S/5RCSh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgDWWxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:53:21 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D5CC09B042;
        Thu, 23 Apr 2020 15:53:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497Xdn53wlz9sPF;
        Fri, 24 Apr 2020 08:53:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587682398;
        bh=x0w7oUCCEQQaNXgYFMhfQ6J/k8PNpFEYUJKaAXgD3Ck=;
        h=Date:From:To:Cc:Subject:From;
        b=S/5RCSh0gKcPlFD+/v5SoMZcDFqPRxsi0RMvynBWK73tLWRAxtxbIr3fjyXrwMchJ
         Dxh0wFPBMbswNhjBzkk9VAxcNta6FsDsIwAAI2iq9/4eE5EzW48secdVEXV5YyvkQJ
         8bH3yZDIEqJy3ZcTUjievuFj1PwV9doC74+Kh6M+JmHW7VFjetI7j4z/gnsS0BEPSA
         a/+GXLzxeGffhPZPBnHJaGxlRcVn+5jQPbKkGbpt0P21pSNCBnQR+OFS39Qa0+/jXE
         lEGkiWuq44s27JASLf4QL0Oex1SwuMQtTNtUB7GfTokpct6ELSGZyjHLX5QQ13qYBz
         f3DFiScJC3RpQ==
Date:   Fri, 24 Apr 2020 08:53:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Archana Patni <archana.patni@intel.com>
Subject: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20200424085315.36876e01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_Cky_yl9Y.1BGXmTncwXAy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_Cky_yl9Y.1BGXmTncwXAy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  92f62e696851 ("platform/x86: intel_pmc_core: Change Jasper Lake S0ix debu=
g reg map back to ICL")

Fixes tag

  Fixes: 16292bed9c ("platform/x86: intel_pmc_core: Add Atom based Jasper L=
ake (JSL) platform support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/P_Cky_yl9Y.1BGXmTncwXAy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iHFsACgkQAVBC80lX
0GxQOQgAmhsG/ddohFrPJhY6EiKFTFnROBlMxOQUM1VKXoLR5xKlpKyGW/RfDJow
GTC+dd4iopPlbJHJi0rneZshAhTp3QfVnpGl4x9UdM8RLki3crDamAtgu58tWY13
7z+2Sk4iXN+XHbdlFmV/gGBX0d28zKfVtuYR7W7O+0XcSjZJCjA4ZP4GgeMF1iCr
ziDBre48kZmkfs9C+SzcbuxJ60fwKHW3F7XnZ4xdKbrLzH88VBb6cHShTaD2EwzO
EcOqY9OgkAO1Bmabb6xTNUZ1oMAaepsn7mA/coGw/hCYSNWuC4K7iRb28BTbIuDL
E6HFhNu0mN3TLHXbbri5JMLOZMTk0w==
=LDfN
-----END PGP SIGNATURE-----

--Sig_/P_Cky_yl9Y.1BGXmTncwXAy--
