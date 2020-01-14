Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED11C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737DF2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l0LdRAiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgANFmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:42:21 -0500
Received: from ozlabs.org ([203.11.71.1]:36877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgANFmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:42:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47xfVL6Bk9z9s29;
        Tue, 14 Jan 2020 16:42:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578980538;
        bh=7poh02xTRO6wfo0XB/ilDDsHGirN92XbvbpYK6uKkBI=;
        h=Date:From:To:Cc:Subject:From;
        b=l0LdRAiKc5WcixYKBiz5S0Jp4BovSaAk41ooR+eVZlAIq6in0yulJK2T3glbKjtZx
         190NFsKIdsEh8iL8NH5bMbcgbFhXtTQFeFtdRUo4860b8+1x04qNcMnmyjD7isyGA+
         Mk120iCzTNw8PoSFQojhiln5WkRHayu4G2zcGCqKnD5dIzc3O2M729aiTY8NWBqYz5
         M8ZDgwGpSZm0Ol27yLT7eA6fmqAPfgszbiKEvHpbv+cmx5SR2UFTFUstl1kK72a+7D
         qpRm4uxAc4JhkDkNzl4L65jcME6LYGcVA6jdzih38njEOjhBU/pFXjZqwmIeT8uDgn
         XhUlSbRSZHUTw==
Date:   Tue, 14 Jan 2020 16:42:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200114164217.55c2425b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rJPFmu9=LUV=/KtcSaEPkkI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rJPFmu9=LUV=/KtcSaEPkkI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'lmb_to_memblo=
ck':
arch/powerpc/platforms/pseries/hotplug-memory.c:217:14: error: implicit dec=
laration of function 'find_memory_block'; did you mean 'walk_memory_blocks'=
? [-Werror=3Dimplicit-function-declaration]
  217 |  mem_block =3D find_memory_block(mem_sect);
      |              ^~~~~~~~~~~~~~~~~
      |              walk_memory_blocks

Caused by commit

  eca658f58c58 ("drivers/base/memory.c: get rid of find_memory_block()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/rJPFmu9=LUV=/KtcSaEPkkI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4dVLkACgkQAVBC80lX
0GwH/gf/dlbfgIFR0q11bhtv09iauxBxgTLsKnR8kgkTogtZJD8MQVcr/OsL10py
EinfidS8uuk+cFBzwxuqc4wcA/VnNhEjrrNmf3WtlhFqQ02XnW7JCLuNQNGJjJJ4
TU28ghuf03UY+lUGYH0AEvqGST43fnBTp064GZoewAxGeMw6qrIAiBeYlmCaPdVF
oK/tGLwM0sByUD0nG+7IuGWgXlynMMTWWH8QJGR61KM2jbvdVH3ZpvdyTmbxLvPr
uqx01G/XPKo0wqUY35VECPmeW7mjJ2Q9n/9pbymp3nLkd85DNHK+QNRMdVoTwn0J
Mtzf2DwAekXPni2DmaoTjQuwXoQzYg==
=+w3p
-----END PGP SIGNATURE-----

--Sig_/rJPFmu9=LUV=/KtcSaEPkkI--
