Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC98C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD0520674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCRJl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:41:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:41:55 -0400
Received: from methusalix.internal.home.lespocky.de ([92.117.32.245]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MY60J-1imdCT1A5d-00YNg1; Wed, 18 Mar 2020 10:41:16 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <post@lespocky.de>)
        id 1jEVCK-00056W-AI; Wed, 18 Mar 2020 10:41:13 +0100
Date:   Wed, 18 Mar 2020 10:41:11 +0100
From:   Alexander Dahl <post@lespocky.de>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Alexander Dahl <post@lespocky.de>
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200318094110.avr3zlsfti5yieyj@falbala.internal.home.lespocky.de>
Mail-Followup-To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>
References: <20200302181612.20597-1-post@lespocky.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ic722qmmebqodye4"
Content-Disposition: inline
In-Reply-To: <20200302181612.20597-1-post@lespocky.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: e8c5bd5a54e3cc84f9f74fb02e158981
X-Provags-ID: V03:K1:beBTNnE927QP+aKFJHcxblVneBTl0bSAcbYVv30H9JrDXwVVd89
 NLz6wJn/Pq58n10Z4+nUsOH5YKqiKur6qGO9tMOHm3UjiLK4XPv5HKy9k+adImN+BED3fG0
 9LucvGa0amgKZz+DtahkOZ7QSK7Ech9GjKrUST1Y0oJroSGSoFzZ6zBP7BYWnt9XO+mqwCM
 olrX/Q7iW96l+mF6aWL2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRzkBBApKME=:4KLz7+CRJz6fjIPJQQ2rx6
 kHasSmZfbUYwXBxpb/nUmcnQ6Df58sWg/OIuaDJBIx4mUe8RSvp4Zm00WY7n/oGphB7/vy7ic
 YeyggX0k0OazsOLFbmzZ/285iOrHcVDw9DkUlIKEsC6JmBMUHGSTifIouaEg66FyP82i+tMkk
 aoxwtE/05YMpYbglgzCteV5OgLuRFwj2xn6DaqIjDX4OL+M3fDTcyiFdWAI2PQ6U725mmi0mH
 FrNz/9X4SA402kCJlob8iRnOtbiE/30UVu8l82KWnRJpagHQIYMoDs0Ihn6m97SM4+zxLZDmv
 AOUHJWG/6GWKwFz+azwZDOwm0p4Ex8J4MA+R+TzwlD0yXbFIWMfaPQfQ/2gofdLbyZw0T5z7n
 vIEhiQdJJru/5aiS8PDNApLfZLV+MlfTI7SfaUNW3LIAyvUHL9BPD7OF+ZpjT9Zpu78SBYF8a
 F//3yVlT9ao3YxxS5ifIgwKS3hBwDyWCK9oFYBPdE9iOlFnR4grjb6ISY80C5XcSRtnw/vup3
 Iy6RUjuVVsqxzMxuL3lp/uVxIoA6ohBFna0umiionronq3OrJ0x8nwfu5OITjNT2qYRWAXKEW
 d1Bldyw/kp+lHWcfgMZOpQgmm0Y3YgBckOjDAeqNJNgd0GWgbiEpPT0NP31ePQibloabXbfwp
 sV0N4I9XmkSlScQ5dj9QCtaKhcXlD1SCOj4ZIgOgFYd933T9y2ikbi+LEgrqforD03wZR1v8s
 CsLIylSXRkNasCO0c2kZ5iROgTI9XrHozDzmu5OzL37Pj79KYXNYVmLrG+d+hVMLQK7DroreZ
 HGJJBMPn/z9xx8QaGq6k/ceVQFsND/757moS10dt103l+cOJipcQY1YXeRXIGgQq1hDQQEF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ic722qmmebqodye4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

gentle ping on this patch from two weeks ago. Did anyone have time to
look into it? Did I miss someone in Cc or sent it to the wrong lists
maybe?

On Mon, Mar 02, 2020 at 07:16:12PM +0100, Alexander Dahl wrote:
> For ARCH=3Dx86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
> ("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
> a dependency on CONFIG_SWIOTLB, which was not necessarily active before.
>=20
> The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
> something against MAX_DMA32_PFN to decide if it should be active.
> However that define suffers from an arithmetic overflow since
> 1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
> first made visible to x86_32.
>=20
> The effect is at boot time 64 MiB (default size) were allocated for
> bounce buffers now, which is a noticeable amount of memory on small
> systems. We noticed this effect on the fli4l Linux distribution when
> migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
> ALIX 2D3 with 256 MiB memory for example:
>=20
>   Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroo=
t 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
>   =E2=80=A6
>   Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660=
K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highme=
m)
>   =E2=80=A6
>   PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>   software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)
>=20
> The initial analysis and the suggested fix was done by user 'sourcejedi'
> at stackoverflow and explicitly marked as GPLv2 for inclusion in the
> Linux kernel:
>=20
>   https://unix.stackexchange.com/a/520525/50007
>=20
> Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
> Fixes: https://unix.stackexchange.com/q/520065/50007
> Suggested-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Signed-off-by: Alexander Dahl <post@lespocky.de>
> ---
> We tested this in qemu and on real hardware with fli4l on top of v5.4,
> v5.5, and v5.6-rc kernels, but only as far as the reserved memory goes.
> The patch itself is based on v5.6-rc3 (IIRC).

We had no complaints of our fli4l users, since we applied this patch
to our distribution kernels.

Thanks & greets
Alex

>=20
> A quick grep over the kernel code showed me this define MAX_DMA32_PFN is
> used in other places as well. I would appreciate feedback on this,
> because I can not oversee all side effects this might have?!
>=20
> Thanks again to Alan who proposed the fix, and for his permission to
> send it upstream.
>=20
> Greets
> Alex
> ---
>  arch/x86/include/asm/dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> index 00f7cf45e699..e25514eca8d6 100644
> --- a/arch/x86/include/asm/dma.h
> +++ b/arch/x86/include/asm/dma.h
> @@ -74,7 +74,7 @@
>  #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> =20
>  /* 4GB broken PCI/AGP hardware bus master zone */
> -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> +#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))
> =20
>  #ifdef CONFIG_X86_32
>  /* The maximum address that we can perform a DMA transfer to on this pla=
tform */
> --=20
> 2.20.1

--=20
/"\ ASCII RIBBON | =C2=BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=C2=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--ic722qmmebqodye4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl5x7LEACgkQNK3NAHIh
XMaF3xAAp8sNaWZsUbnNjftUCPAj9ymsbuY/vafpAsck9ijxVFpseaSQaGpiyobF
xF9E3fFvTJIqI1kkRizNUKp3CYrygmgqkVitwgQk6cAFyAtiIZnTvbrHqdSRBN26
lgnuXnRcpJvYIe5M4LStj++QgV1UavVowuEtJkilKG3zdoV5oGuUJdmbp9YMm2yb
Z6ysEKBlL26aOjJHepN7uQj//hkCKsyZuz22gmAgUKlWXgzhKgDI95NfaPbQwxft
pzGa0GFhuhw3a4bjlpZ4uWOb2NR9a8md5ml5TUWouj97tw73vJ6zwRpwn40fqSJQ
HGmCkN3Qzqd+RKzC4YPr4ZRd9p5oIvd9mKEe3Q8DCMaAdv1itu5yfWsA4CtgESaX
LUSLslE5rdEnob3YXZ3FhNe5Tuea0ayrFIpKUPZmAgnsGLKxpuGEWpHDSX+G3zTa
Z3wvzJ0LMPmCrgFXmg9jrgNC7MUNwb6IYgPzcM2WV8QRsYH0MGYsMAia288tEPz/
ynxfr3lDHDYWjccUyHBarh6UmkeZ9QbXSmE+aFZk32PQT2XqmzTNVTKwD26O2eiR
b6s9K5qmtojPncvhu0uPCE63nu23+/C7HlyxETktaB6WTqoQNRCUyM8QGD3s1dxe
NL+0rwGbDa8GYfxXlUrv4TRwucNsRjsMVLWMlU7ybVnrfeUsFbg=
=Ijam
-----END PGP SIGNATURE-----

--ic722qmmebqodye4--
