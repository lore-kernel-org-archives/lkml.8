Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB7C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D44D2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="npT8sRBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502852AbgDPIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441458AbgDPIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:39:51 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E2C03C1A8;
        Thu, 16 Apr 2020 01:27:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 492smK4CFPz9sP7;
        Thu, 16 Apr 2020 18:27:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587025666;
        bh=/ecLQujCj7PCtPflbT7k6//wSNSBSiYzqTmN62g5shA=;
        h=Date:From:To:Cc:Subject:From;
        b=npT8sRBiGiJ1JZe4wcevWxdTxWyoV/sJ4YgNL7XQCaSOr07D1J4i52sRmx5t1KzwX
         dMBUpzPJGS0vkQL4fRwcZ0eKX+1SGTxiaJhp+FRlLzm86eNcU293/FmlB4VTtt2ZxK
         koQoSpUoLFR81AM2lYG6Hi/5ljt9wl+XtkEF6yRYTSjujNRoWJGbOANL0LBVqZubVg
         hMDTFiK4zvivThmSjd+EsGTFgcl3j7ru9O8HZwdnoTgP9GZAgYSpYS/W/0EPq9K0Nf
         RRTDU6cScj6N13ut0v7LSOYuwp6CRiG+FLGLN7bfPYuPntrLAQbQygq9fKGzDjmqOr
         X9Mb/ZIpC7iLA==
Date:   Thu, 16 Apr 2020 18:27:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20200416182744.12d69766@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MbzpMfz80_1fnMH_TAOt4=s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MbzpMfz80_1fnMH_TAOt4=s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (s390 defconfig
and other s390 configs) failed like this:

drivers/pci/Kconfig:16:error: recursive dependency detected!
drivers/pci/Kconfig:16:	symbol PCI is selected by CEC_SECO
drivers/media/cec/platform/Kconfig:100:	symbol CEC_SECO depends on MEDIA_CE=
C_SUPPORT
drivers/media/cec/Kconfig:27:	symbol MEDIA_CEC_SUPPORT default is visible d=
epending on MEDIA_SUPPORT_FILTER
drivers/media/Kconfig:25:	symbol MEDIA_SUPPORT_FILTER depends on MEDIA_SUPP=
ORT
drivers/media/Kconfig:12:	symbol MEDIA_SUPPORT depends on HAS_IOMEM
arch/s390/Kconfig:722:	symbol HAS_IOMEM default value contains PCI
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

Not really sure which commit caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/MbzpMfz80_1fnMH_TAOt4=s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6YFwAACgkQAVBC80lX
0Gxtxwf8C3jwl907GDofFWk1dgBfETM9z9Jra1Ir1b8VtootQDdpDcmylA4HwiFN
GKFXLR4f49A6vjMGaI8XLloA3o6lkHEfLpPvGl25l3jfpdp2bdD8o0mSRuSadSoA
IxLeFClM6Sa+uE0uQZntZdaLLD1SWAVNJIooRn35TFRxGBG8DLOv12L7WD++u8kd
Wa0fmz38IDl0pQs6o/cI402SZ9lhtsyS/Y785seqJIhbC4ZVG9+0NylMaeygojJS
udN7GiKYkIDA45i2BweR8fu6YZh4fsMmtzEoayOwuyjYQYix7gMaqhxMFSxQzlr9
Y/uloHLPlyJjndglUpAlSqotQW2DzA==
=a5ZY
-----END PGP SIGNATURE-----

--Sig_/MbzpMfz80_1fnMH_TAOt4=s--
