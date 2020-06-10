Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D02C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C895F2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YNiJjab4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFJWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:13:47 -0400
Received: from ozlabs.org ([203.11.71.1]:53849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFJWNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:13:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49j1V10Kjrz9sRW;
        Thu, 11 Jun 2020 08:13:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591827225;
        bh=f85Zj11U4S4abcn30iaPbbqLxTLz22NkKa5GewWoc5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNiJjab453ttflnmz/JDtkV9F7Bx7JJdbsrXtt1r+Ic07KtYg+KaZp0HSi+NeFrL+
         ISdIO0yK0ukZ7GrRLcoWDKNqkVsdTMSSi5BkiFdgrKHyMK94KCiLMnE6ZYUV2A4zgS
         tl27NkGz9FgnTDN05g8Ot4Hycl9Gbroy2wZOLppLi4KADmWL+YnGK6gbLIQ3SNX8m3
         M/dTMlU7KPRKeuQhSvC+ejfBus1f/V202rutykW5J/Urlk3O8MiPxR6HLIO5IWC+s6
         ceXFi0IELdtSFg5skWBweaIaUC/PFvJqRhCeK/ICXc4nIgEXcj5affQLx4V9ETUoUc
         OPRmGxGJu2xnQ==
Date:   Thu, 11 Jun 2020 08:13:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: consolidate pte_index() and pte_offset_*()
 definitions
Message-ID: <20200611081344.56d96113@canb.auug.org.au>
In-Reply-To: <20200610204212.GA4595@roeck-us.net>
References: <20200610204212.GA4595@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bvWntBjFCc+_gLOumE4.V_y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bvWntBjFCc+_gLOumE4.V_y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Wed, 10 Jun 2020 13:42:12 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Building sparc32:defconfig ... failed
> --------------
> Error log:
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> In file included from include/linux/mm.h:32,
>                  from include/linux/memblock.h:13,
>                  from arch/sparc/mm/srmmu.c:14:
> include/linux/pgtable.h:74:27: error: redefinition of 'pte_offset_kernel'
>    74 | #define pte_offset_kernel pte_offset_kernel
>       |                           ^~~~~~~~~~~~~~~~~
> arch/sparc/mm/srmmu.c:144:8: note: in expansion of macro 'pte_offset_kern=
el'
>   144 | pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
>       |        ^~~~~~~~~~~~~~~~~
> include/linux/pgtable.h:70:22: note: previous definition of 'pte_offset_k=
ernel' was here
>    70 | static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long =
address)
>       |                      ^~~~~~~~~~~~~~~~~

This was reported on Tuesday (by me among others) and is fixed in
Linus' tree now.

--=20
Cheers,
Stephen Rothwell

--Sig_/bvWntBjFCc+_gLOumE4.V_y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7hWxgACgkQAVBC80lX
0Gyp6Qf/ZE+lc6PE5Y9th06E0/LPOnIGl++JACOEeSsuI+oXuG5jr0t4JihHLFBo
RiAPSjMxCSEzBT0Yk6T6SKZIdfRHinlJ/ni3oI4k6/5uphS7p/C1YkD6+sKTzJJS
G08lIcv18G0zfpbseMm5wDQWHdCcxbRQ8grw4E7xCQpzG7wqhD5HWSd1/iLO4p/o
uQv7ibXSCKHWmzq5M5BBhd33qQOk9w3ud3S7D1Qom9RXL59llRpzBKIeBdQF1H/w
nd9ZGRN3kNQJ0Rb9tOlWn28A0jGRD/srOf6Ze/0JWP9OCpk1R2QOIXDkp63lIDoj
tCZx5MLWQbgE2SbQT5uQreMT/9BMZw==
=yTco
-----END PGP SIGNATURE-----

--Sig_/bvWntBjFCc+_gLOumE4.V_y--
