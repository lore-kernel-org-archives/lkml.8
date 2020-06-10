Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E792020737
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TFucXMhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFJDob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgFJDoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:44:30 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607FC05BD1E;
        Tue,  9 Jun 2020 20:44:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49hXt31FByz9sRh;
        Wed, 10 Jun 2020 13:44:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591760667;
        bh=SaSa9M+j2Bz+I/hYTyOzhlCqV7+UkOQLUzDnf8Sh9W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TFucXMhCiKJEZKaf9yLOlxt+cMqT2cXGh7phWQnLbg9VujB1glPrdfCGDXTzc7qwD
         bR9TCz4d1AwTpF5KQb4RzWryUvpLvyrgQ2Zd3+uOEbEQcDBR69Er0nnxBLTSYtRAMx
         uqGo/XRx2U4nbiRz5UpOAV9br0/bCoOxPIm9XIsRioAUYSrzoE12+O6vGleNwdIB1R
         cTSLzzW31muZfybB/8sFtSRr8+1pgRPe/ncHg0EoHuhpFjVXozJy6CtaoGIXbNMTKW
         COl04EBix05f8LtR9vbNDjHMYP401/bO1LpmWMEdl3XMrproQLQNNCqgnpqW1wcyB/
         YZPhGuYZtvsPQ==
Date:   Wed, 10 Jun 2020 13:44:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200610134425.6dd32bf6@canb.auug.org.au>
In-Reply-To: <20200609224252.1704eff3@canb.auug.org.au>
References: <20200609224252.1704eff3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jaRZYoXuK+k4sGWRv9mqKWI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jaRZYoXuK+k4sGWRv9mqKWI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Jun 2020 22:42:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the akpm-current tree, today's linux-next build (sparc
> defconfig) failed like this:
>=20
> In file included from include/linux/mm.h:32:0,
>                  from include/linux/memblock.h:13,
>                  from arch/sparc/mm/srmmu.c:14:
> include/linux/pgtable.h:74:27: error: redefinition of 'pte_offset_kernel'
>  #define pte_offset_kernel pte_offset_kernel
>                            ^
> arch/sparc/mm/srmmu.c:144:8: note: in expansion of macro 'pte_offset_kern=
el'
>  pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
>         ^~~~~~~~~~~~~~~~~
> include/linux/pgtable.h:70:22: note: previous definition of 'pte_offset_k=
ernel' was here
>  static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
>                       ^~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   292aa65ed13a ("mm: consolidate pte_index() and pte_offset_*() definitio=
ns")

This breakage is now in Linus' tree :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/jaRZYoXuK+k4sGWRv9mqKWI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7gVxkACgkQAVBC80lX
0Gygfwf/f9zlK/nQUK9XJiSnVO/yPBctU35cxudvmjb3+yVZyLZIx3JO0pptaEwT
jdNEH5lT9HCL36n2Tl7lvaGMPa2p1djBml4A8GsEiHj3oO6OGcola2FW/Av/4vWL
cNiv9YvGPu1IMK6icNDV0clcFr0jk64VrYQSV23fvvrQFZBiPRdVkC3BtPMK+6Ii
pCliCW2D6SfrTvk2yyemYLICJjrpVvvigsRqqpfc5R88x2+o7AaTqjCmd9esje1a
02+3qEL0bHK6EJFbIKZP5CrOqcBMwXlrnA/gVfSV7FNF7AE02zwoTzyEzS/1tjwl
W5OB+HbZT0GaKV6t3VFoY+yuTktaQQ==
=ydyO
-----END PGP SIGNATURE-----

--Sig_/jaRZYoXuK+k4sGWRv9mqKWI--
