Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F593C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CB1207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ta5CPKxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEGDUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:20:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgEGDUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:20:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Hdxr2VhBz9sRf;
        Thu,  7 May 2020 13:20:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588821618;
        bh=E36HXKogWcq48J39JyUpLXPeuF3K69/Cf5yAaSXQREE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ta5CPKxGLLq4MNL6Y9KGaLm2SjYGXTbStvA4ukTzv4MiD2FEVpTX5T5ULI+bnjAwn
         FcajaIWRIIhCxumvqfjsEjjTC19FpYyu9vTWtTNwtUNLKGD/ai6c151HwJTinTW77Q
         uU7LQ8sY6myuVFOuXQgdF0//BInyZtHirQetRThDbJ50sd12om7WTAiJEwySnAt8RG
         pIKpaVNwZ8IleuBArZfCa6oFQnWjo5kWSvpP8d/J1Tglu0aC4xiXkE+bMr3NIVsp4u
         Fp7uuOylBi9Kjz7h4aMZ+6cgKz7FlISjurcyLUj0vF9KVVCOv8+PHR2WVOA3CmUBFp
         NgAh5dj6mNaxA==
Date:   Thu, 7 May 2020 13:20:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
Message-ID: <20200507132014.1ac14bf5@canb.auug.org.au>
In-Reply-To: <39E953F3-BBA4-43BF-AA0D-B1BED21F9A4D@lca.pw>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
        <5BAA0D82-555E-4E72-966A-A147472271D0@lca.pw>
        <39E953F3-BBA4-43BF-AA0D-B1BED21F9A4D@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cLs680_ssQ0hh7TDv_eZLiW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cLs680_ssQ0hh7TDv_eZLiW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qian,

On Wed, 6 May 2020 23:01:54 -0400 Qian Cai <cai@lca.pw> wrote:
>
> Andrew, Stephen, can you remove this patch from linux-next?

Removed from linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/cLs680_ssQ0hh7TDv_eZLiW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6zfm4ACgkQAVBC80lX
0Gwrggf+JKjb9eq0UPd4rQ8eCnRiUPlXsaIKa6SR+FW3CxUPU6zXpb57aIyOb7yW
j0S6aoOiSedibXajq7hFnyGwXCaUr/zoxSLDHd0uLvJKeW0WJRm3fnzPVImvaNov
WoCHxdn0MSX8oV+PzEHaxleOZDocyTlaYwdN1F61swa3QZA1hGVji2l3qjepOs3U
UnZSeAriGQp5/FKRQ5Qj1dEaIJHMdkKXdZRXRx2OdC0XWgD+rKdcRLhocGy+9/Rm
EVTqW7ozQV6uIhwdaqY2W1HF+9BfSbehPOoLPfymkQpC1cHwIajNqIM9l2pFLUkW
y7zvv7suNN+OPKBYbKXWU6nSW61K2w==
=zFpw
-----END PGP SIGNATURE-----

--Sig_/cLs680_ssQ0hh7TDv_eZLiW--
