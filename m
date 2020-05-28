Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4306A20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LvnohYx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436594AbgE1V1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436560AbgE1V1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:27:09 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9BC08C5C6;
        Thu, 28 May 2020 14:27:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y14C43qlz9sRK;
        Fri, 29 May 2020 07:27:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1590701227;
        bh=vS3YZdXAUEa+9cvSj2VMaZPN9sl9lH/jFUiEJ0ngGp4=;
        h=Date:From:To:Cc:Subject:From;
        b=LvnohYx17l7ipQ76snveIRelqcYWd5FVifQ8RS2usY9yvm9hr560n3Mit46VNw++H
         yOw0vhpb1dS3TS6PE5BcNp/ZGRmV7+hdLfkJyifY988ur+ryIa+zN5f/2wYcrCenic
         Afplpy9gzV9VyU2xOZ4SevUHooRcxpQGiyoKvUA97gKbCUVWm5vMlp4rmg2g0m7DFW
         Z8LxRMIEfXnJ2rVibWDU5oD97Je7IPWsFmwWAhluuensqfQVSjWVkW0I/hAVu7KxPg
         1Ouwb6UX5dE0+nIKlzVgWbqgOU6oPImeXc3UGnJEYUyfWbowW0ekAQ6yisbS/JKo3i
         Nvv7td+K+eMZw==
Date:   Fri, 29 May 2020 07:27:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the coresight tree
Message-ID: <20200529072706.4d59e066@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eUxOSGqerFcXOX5ZR7ofCiS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eUxOSGqerFcXOX5ZR7ofCiS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  bbea49e0ac80 ("dt-bindings: arm: coresight: Add optional property to repl=
icators")
  5b79308d90b9 ("dt-bindings: arm: coresight: Add support to skip trace uni=
t power up")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eUxOSGqerFcXOX5ZR7ofCiS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7QLKoACgkQAVBC80lX
0GxuEAf/QDiFxuJ9y0ZwLkoLgxfOivSQI2UE67tNoiFNXNT8zTebjH/KTQhb6wzq
5kMtLBelqubGgLiwtfAZ1GBXYszjhiVfRN+HY0q9i+SsTAHsbwPXBKW1esHGUO5j
oIm0v7zY9A+WB/Acami16z+aMBhgSkXVf+ChtoaDsukDlq27tFTiGlSFWqS2fmga
ksInjDvf1aQdoQz2TFUt93QaMalYlmPfm5tCI6X/L8H7rcrh0XDtrBPcN4ilrFLJ
dAHV48VT3K5F99xNuPg5/4pocSNmKIYdEUOJ1SVNSXwNis6hs/26/+J+xsUlW9/R
4PJtbdScpAV9xQJirAIjWG2JAOz3og==
=Q4bI
-----END PGP SIGNATURE-----

--Sig_/eUxOSGqerFcXOX5ZR7ofCiS--
