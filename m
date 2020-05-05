Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4162920675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEEJix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:38:53 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEEJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:38:52 -0400
Received: from methusalix.internal.home.lespocky.de ([92.117.32.71]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MoOIi-1ilniK10um-00oovs; Tue, 05 May 2020 11:38:24 +0200
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <post@lespocky.de>)
        id 1jVu1q-0000sA-Ke; Tue, 05 May 2020 11:38:20 +0200
Date:   Tue, 5 May 2020 11:38:17 +0200
From:   Alexander Dahl <post@lespocky.de>
To:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Wolters <florian@florian-wolters.de>
Subject: Re: [PATCH v2] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200505093816.zkkpuia5ybiix5wk@falbala.internal.home.lespocky.de>
Mail-Followup-To: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Wolters <florian@florian-wolters.de>
References: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
 <20200321182823.1912-1-post@lespocky.de>
 <20200415143519.iev6r4llqs3hwtgz@falbala.internal.home.lespocky.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrgz4gzjkmengnnv"
Content-Disposition: inline
In-Reply-To: <20200415143519.iev6r4llqs3hwtgz@falbala.internal.home.lespocky.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 4a99d13af00267c6ae6cc6333d79c333
X-Provags-ID: V03:K1:MJqGDOmGW7cewISQwj1tumjefu6wXxgVFOfRVoT6Sr7lfLiKRqr
 4MJ0A5WmKCaN51fyliXQUH1aCZEvBtnxxkkpfW5wLVPrRNHKentRMOJyCiVSwUggAmN3/JO
 mcPjVNAsoJG7JpXFBCfpW6PSFwIUbXLqcrCoH/vuZXCa4+0stCJh5oTm+xE5hvTCk2Tyuoj
 xsDSQ34NfCf+USlsdcgsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HG83tyzKFXc=:Fo4ADwPRUABCwq8vdmxomP
 BGxdKLziWr6veyR8zwJ2xtf0NGG4DrgPRhucRgQqJdM/AJnfHIfj3jEWP+AxpWnT06uyp9ERx
 9StErDSYC/gYrmdjxxjUkPVmeCFd7vurkeBQOqK5xw6nzJlk9+8kaVdZRAbeQpByFqZWcGvIi
 VEs54hiZySxG+PqCXCY+d3NpURegq8Yiak/KZi6jHjcoo5Rv111MYs0lm5ROMallLb4Nf3B7M
 +xZdbP0Nd/2ajjKONcJymjXfFHLcRJmQi/SXT8m9NLC6K871EcRd7cFaItfbODufLPZUeCo0o
 86J4o3qaWQrQSBVWZSsDwZV+uBEIDgYyc1v990KXawOY4IXffwtboo5Uys6Fdh5gzUJphdxZK
 rR6QHO8BmFyTak3uSH6871qTQHAaag8Afr+hloNFJ/1SLGVJknw2CKYgaNa0RTWscdaj1jElH
 ieQzRTI9eNtJEmBFQ+FTCg+qwh4rDbnkA8Ne4m4s/EfSOwTj55Ir3wgstwob27cJdWhB7/k7E
 JcgelPsDnIbBPvDvGfLPf3BpQqxK7WoGQL134H4mqbYLY5gjjxhu5dYgPZNEELJe9ClodqswD
 EYhyXjLPjCW6oWBeEmjDraXkPlF47kRlHEWIfbHn/+nCivlFBhTuZOS6CrxYBi+wtENXERHx/
 H1V40SIA63o/i/66bRIY1UYJThCTLsFTD5oGzSJ3cbIB3cd6iuIqbDZCTeJV248KuxeqMZJz2
 pkt8l/BpCexkIrjmt6HdN1QOWzUjvzKLeiWh0sVylQtYve3TFR8FmhHBf9HNnvVo71At8J+QI
 lK3lGp6ExEjSvtEOXCT4qQzdQ6xe//tPtjeDvF6wcbv9AGdNq7UpuHkZHc0+1rdhnk8IXBb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrgz4gzjkmengnnv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

I would like to kindly ask about the status of this patch.

On Wed, Apr 15, 2020 at 04:35:21PM +0200, Alexander Dahl wrote:
> now after v5.7-rc1 is out, I would kindly ask, if anyone had time to
> review this one line patch? Is anything wrong with that fix?

Did it maybe not reach the right maintainers? I used
scripts/get_maintainer.pl to get my recipient list.

> (I added the current fli4l kernel package maintainer Florian to Cc to
> let him know I'm still having an eye on this.)
>=20
> Greets
> Alex
>=20
> On Sat, Mar 21, 2020 at 07:28:23PM +0100, Alexander Dahl wrote:
> > For ARCH=3Dx86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cb=
bf4
> > ("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
> > a dependency on CONFIG_SWIOTLB, which was not necessarily active before.
> >=20
> > The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
> > something against MAX_DMA32_PFN to decide if it should be active.
> > However that define suffers from an arithmetic overflow since
> > 1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
> > first made visible to x86_32.
> >=20
> > The effect is at boot time 64 MiB (default size) were allocated for
> > bounce buffers now, which is a noticeable amount of memory on small
> > systems. We noticed this effect on the fli4l Linux distribution when
> > migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
> > ALIX 2D3 with 256 MiB memory for example:
> >=20
> >   Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildr=
oot 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
> >   =E2=80=A6
> >   Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 16=
60K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K high=
mem)
> >   =E2=80=A6
> >   PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> >   software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)
> >=20
> > The initial analysis and the suggested fix was done by user 'sourcejedi'
> > at stackoverflow and explicitly marked as GPLv2 for inclusion in the
> > Linux kernel:
> >=20
> >   https://unix.stackexchange.com/a/520525/50007
> >=20
> > The actual calculation however is the same as for arch/mips now as
> > suggested by Robin Murphy.
> >=20
> > Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
> > Fixes: https://unix.stackexchange.com/q/520065/50007
> > Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Alexander Dahl <post@lespocky.de>
> > ---
> >=20
> > Notes:
> >     v1 -> v2:
> >       - use the same calculation as with arch/mips (Robin Murphy)
> >=20
> >  arch/x86/include/asm/dma.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> > index 00f7cf45e699..8e95aa4b0d17 100644
> > --- a/arch/x86/include/asm/dma.h
> > +++ b/arch/x86/include/asm/dma.h
> > @@ -74,7 +74,7 @@
> >  #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> > =20
> >  /* 4GB broken PCI/AGP hardware bus master zone */
> > -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> > +#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))
> > =20
> >  #ifdef CONFIG_X86_32
> >  /* The maximum address that we can perform a DMA transfer to on this p=
latform */
> > --=20
> > 2.20.1

Greets
Alex

--=20
/"\ ASCII RIBBON | =C2=BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=C2=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--lrgz4gzjkmengnnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl6xNAQACgkQNK3NAHIh
XMZaTw//Vm6+AxC5/54mr0ZgbZ1IZH2rVpJWWbHU1w5G+ImgXZ+fn+2bKJdcR7Wg
C3MyXSlHkJzYjUmntUV5Au+eQkSc7K53QdhVXUCQKvcim2UumyvBFWO/thcs5PSz
J2k77Txqk6A8TCvCtMsbW3376GtkKoi6/NA9Vw4ITPamjC0zKbsf33poFaIFVh8L
f2tAuFelBJ4CxoydHaLHo3haXcuml6GvfeWZ3/75QkmtxMvjjzMFbZgkq4UI4VsO
QS/tF2u4NTIYaOj9zGzlb9EFx+yqxeA0/BcDiZwNeJcstsjpPJP7hgbI2F+7O+g8
sSkDuTSpk1teRe9VdB/eUtIvWk+81WOlRiJHrp8/PkHo355jgG34r6iBgkTAhP3M
/DumsoVAgYWMOmsDQQ+7TURy80wgtzzBk3ILZd/dJti5s9F2xCNDQjFM7J8midAu
Ugti66aBL0hUuZ0wk8SQHxla3TE1M7vZhFbfJp8DspH075ZB49/tTSGgej7RlrAL
4jeX6Ym97VgUzIAxzWpneDl0Dbr6N3FOObOg6z8acq9zGodfTLQxtQOnPVO2WhbO
q9K5mlTMCrezl8YWOAuJWd/pJb2285wWu7goXr85NLEuVc2WbL84mGqAxESMjClh
QpUqQ2rr2OUtqOSB94cQdQlG7HUmALV4hNgYVS+zbClFioKGuEU=
=sC2d
-----END PGP SIGNATURE-----

--lrgz4gzjkmengnnv--
