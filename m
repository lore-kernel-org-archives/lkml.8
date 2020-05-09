Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1959C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6BA218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QuxExV91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEIDOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:14:52 -0400
Received: from ozlabs.org ([203.11.71.1]:50103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgEIDOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:14:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JskN5rBkz9sRf;
        Sat,  9 May 2020 13:14:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588994089;
        bh=Sr12Ya6sNtsYbXP7Gz0Y0ESEGjjzqQ70flvfpUON8qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QuxExV91rxC96TVgaI9oTgNWRCiOCtkAQQl5asAhoQLFJXb/hESqI/CSglCV7nKwi
         KgXl3aLh+dtT6O21IVlVcwcjMwTtDzzY5VDpEaf0XANiknL183EMmQ76jfH9jQ3ysm
         ct566+72mGrBZhdDAMCPD6b5oSIx+zmdt5najo6E5biM1ffJkC1h7fhL/CBzdYTMrp
         G5ChFjzjNskDG26IObGff6KL6C+RRB5Ko2YwhM8LrCx5tkqZcckzB/Zt2ikh2w0rcG
         GGeUxfzCopQ14PYa8IZoFYu2YwQw7PIzbaXT4QqsN91A6JWe0b22yEdeOkEJ8TLLpe
         Vyowd30OjrvyA==
Date:   Sat, 9 May 2020 13:14:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: vmwgfx: include linux/highmem.h
Message-ID: <20200509131434.27ddccb9@canb.auug.org.au>
In-Reply-To: <20200508220150.649044-1-arnd@arndb.de>
References: <20200508220150.649044-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LruK9RrFyqBl+3yphC.Izb2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LruK9RrFyqBl+3yphC.Izb2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Sat,  9 May 2020 00:01:31 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> In order to call kmap_atomic() etc, we need to include linux/highmem.h:
>=20
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c: In function 'vmw_bo_cpu_blit_line':
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:377:4: error: implicit declaration o=
f function 'kunmap_atomic'; did you mean 'in_atomic'? [-Werror=3Dimplicit-f=
unction-declaration]
>   377 |    kunmap_atomic(d->src_addr);
>       |    ^~~~~~~~~~~~~
>       |    in_atomic
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:391:5: error: implicit declaration o=
f function 'kmap_atomic_prot' [-Werror=3Dimplicit-function-declaration]
>   391 |     kmap_atomic_prot(d->dst_pages[dst_page],
>       |     ^~~~~~~~~~~~~~~~
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:390:16: warning: assignment to 'u8 *=
' {aka 'unsigned char *'} from 'int' makes pointer from integer without a c=
ast [-Wint-conversion]
>   390 |    d->dst_addr =3D
>       |                ^
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:403:16: warning: assignment to 'u8 *=
' {aka 'unsigned char *'} from 'int' makes pointer from integer without a c=
ast [-Wint-conversion]
>   403 |    d->src_addr =3D
>       |                ^
>=20
> Fixes: 46385a895322 ("drm: remove drm specific kmap_atomic code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_blit.c
> index 94d456a1d1a9..1629427d5734 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -27,6 +27,7 @@
>   ***********************************************************************=
***/
> =20
>  #include "vmwgfx_drv.h"
> +#include <linux/highmem.h>
> =20
>  /*
>   * Template that implements find_first_diff() for a generic
> --=20
> 2.26.0
>=20

Added to linux-next for Monday (in case Andrew doesn't get around to it).

--=20
Cheers,
Stephen Rothwell

--Sig_/LruK9RrFyqBl+3yphC.Izb2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl62IBoACgkQAVBC80lX
0GwnAgf/UN+9W0C6W35cVuOUG1IADDrDP9dNx5i7CYj/hbyhYDo3V4Y7B1gtANBP
YIKfKxM4GuolXI6HhF6hj8ukF+UX3cI45+6adqA+1wD2MfHa8694yyrgj4sWE9wn
t4/7W2DTjKMuh0YDZOjs2ufEAECwgTOUIOH+AZiWvko4bqRwSjK6lqIqsbhZf842
mq7MGEs1R8Ke/Q2BpNGLvoj8HRw4/zdrTy+uR2nDdpEshacKE05UllaEcvOg8iWo
hAaakwFXIg44JuidWrwGH3pdr81cK3vBnYubx5rHdyxxlQ8GeIsIMrtcbvtMwWxQ
OaLntmpT6n0hTJKeFYoR5Zg7nXsHRA==
=0wW0
-----END PGP SIGNATURE-----

--Sig_/LruK9RrFyqBl+3yphC.Izb2--
