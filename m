Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99734C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C120708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tF7Q2jEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgGIJLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgGIJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:11:17 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17624C061A0B;
        Thu,  9 Jul 2020 02:11:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2Vlh6qk4z9sDX;
        Thu,  9 Jul 2020 19:11:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594285873;
        bh=eKKoa9UiaTun/mZu3cBLZr4GwLJ5z0u8yViLMEtWqZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=tF7Q2jEXpsygtx14D8Or+ZZEAh9Llz+lMJv1ssVoPiFfuiesY2pszLOFgG+gKhn/A
         rNL0lL0SB8p903FzlYpUB7EKsa5Jh/oYzVkSGl4dZ+EE539wop1QWQitNi0hIUYmmw
         4fOTtbNjWOK/iH9kobAnR+h8KpcWpnBXutUY9/CT4wYWEE46GleZ0WAAgEv+fRWvHD
         D9S+sgcVKF22oOixIeKjtQyFhpaAMlrTKmPlpE9u71hXBt2tKGq176d3faNqk1mrW/
         Y/7BSr+olfkvsKl9o3JBu7VAIBHFDTFSyoJ0c1SolNwsUVvk4giIe0trgfhzQtqckM
         KMB/8UP9/esaw==
Date:   Thu, 9 Jul 2020 19:11:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20200709191111.0b63f84d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bw8uQ8Y4eFgkGjZ4vGn6bcG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bw8uQ8Y4eFgkGjZ4vGn6bcG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (i386
defconfig) produced this warning:

mm/hugetlb.c:49:20: warning: 'hugetlb_cma' defined but not used [-Wunused-v=
ariable]
   49 | static struct cma *hugetlb_cma[MAX_NUMNODES];
      |                    ^~~~~~~~~~~

Maybe introduced by commit

  c70205bf186e ("mm/hugetlb: avoid hardcoding while checking if cma is enab=
le")

--=20
Cheers,
Stephen Rothwell

--Sig_/bw8uQ8Y4eFgkGjZ4vGn6bcG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8G3y8ACgkQAVBC80lX
0Gy56AgAlijdLI9UPsK1qR2wEj+EEko4wpIMBUfOtLvKC1ab3hxe04eyMc70lgfn
C2PZFn4a3fZMmi+f6EaeeVami/TghWs7Y5Q2I73i43GFFc1+wFV5QTo3BXUdlZNp
zXood1FciSdxQHkC8BBgwPSxFCkalSf//6/xwe9hlplRO6h4c0cW/ZOAN0Eb5dma
H1rxtnyaSHF5845di0JIj22/SsfxtS9E6YLdDhfHPLd3sDDksx1bgCoGGxGEDiij
w871U91pQJA6AIh5LupBaew0p6qq67dpvrJttcE+bJstUFuoxiYK8Jj6DxqE12gQ
dhsG+67CDUTFJtwit1Hw9OdB/T7fBg==
=HWiM
-----END PGP SIGNATURE-----

--Sig_/bw8uQ8Y4eFgkGjZ4vGn6bcG--
