Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1079BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6B52071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCSPcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:32:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCSPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:32:33 -0400
Received: from methusalix.internal.home.lespocky.de ([92.117.55.187]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCKd-1ijxzP1qAz-00VCg6; Thu, 19 Mar 2020 16:32:02 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <post@lespocky.de>)
        id 1jEx9I-0001AW-FT; Thu, 19 Mar 2020 16:31:58 +0100
Date:   Thu, 19 Mar 2020 16:31:55 +0100
From:   Alexander Dahl <post@lespocky.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alexander Dahl <post@lespocky.de>, x86@kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200302181612.20597-1-post@lespocky.de>
 <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iodayy4zmltei4qo"
Content-Disposition: inline
In-Reply-To: <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 5d1699e822705c24f051c25a2c63fb4e
X-Provags-ID: V03:K1:cXX8UFKkqY3BP0w/SJ8Qky/hBe1VOgQfSpYwQ3wWO3BhAMLQKyT
 qMaCMxG5eW95fMiDqh86DxQy+xspNijXV4Q3uJ1/OI25ImFc4FxujtbJ11u+AQ1gGV567ka
 pcuaaUtu2xqpMHk3muaoI2tLNhKeqTojiZ1uCBrHHAl9y/bMVqkPNIiNpzrYyA07rXYKshv
 vDCZ3jgc70lqvX/wcAadg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8K1UPtmbVQ=:zfFGrxNZow9huDeuP1mOQQ
 ouDWGDnzdQBxAUPDYKX4hNt/pkY6G/efTqmMrjkdtq1iSSYI4sWp4u+V/k/xfTWuYS6BHFVUY
 223AHSsqZuLPUV85ssU+fiJwXJ5RCOqsG/jwONJtcASGXUoUulKLwAKxFb24Z21ZEZNgz5ZHJ
 RLgWOo1l+9zy+zHwBX4oLZM34Kbgh6LcnDXtKudoCdmzrw/gtJ/+X0rOqzqhC1B4g1TZKZyZ0
 VrgYB6FJjzglKcTeN0z2V7kyqPvl/xu4FG1ePgu0eFD+mhmVQilHEpvEuZdiMLeDmjZ/ab1LL
 CtqX2KOOh7isTa61DH0ZTYCMeYMCp0HWcYXQZwAK8VlkfgeRkm8hrg/ttffnLvYVC8x+2MyGF
 S2Bsas8hXT1FyM/1suf9+DPyVZ/WGr5X8Yy4+pOng+/3pa9NpMdoGpdhE5l8pA5jYl7MAb7xT
 xeDFQElYjrsNmpC2elgfAQY9tqZ/c9R2Uu2t4oXXHfmGXEzOQOKMo6BN1Gy33xxuNZh6xRzKC
 NXR+rmmG9OHzLeOcvmh6acG95ww+kQcbjGKBQkIfD/t04yDcP57FD+PSnJsLprpqC2wz/RMhO
 BtXyXKfH1Tzx++gThQjAvIi6x0tnYKHmyerHrNxraispxHeG/4Zm9dv122XiEIt/TacJJwHtM
 ZKd8Hho/HBnk1h2PDTFwqN4R3IRB6ed5ROjh1nIQ1i7goOAQMAgPlw4k9iUFdI0ygRiUmMhLj
 pDWiWbZDoFRwIOwrBMRCVpEMGxTCpdjW17np1NOkn0YYuDlPWjxAEmyRAvf3Z90m3o26Y1vWa
 Fda3aVNKAbNK+0fAPJLPgAi3ZsWj9G0Wz7yXzafU2icqRipRaIXyOZSZuk2JFhoXEyb/cR1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iodayy4zmltei4qo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Robin,

On Thu, Mar 19, 2020 at 01:50:56PM +0000, Robin Murphy wrote:
> On 2020-03-02 6:16 pm, Alexander Dahl wrote:
> > ---
> >   arch/x86/include/asm/dma.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> > index 00f7cf45e699..e25514eca8d6 100644
> > --- a/arch/x86/include/asm/dma.h
> > +++ b/arch/x86/include/asm/dma.h
> > @@ -74,7 +74,7 @@
> >   #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> >   /* 4GB broken PCI/AGP hardware bus master zone */
> > -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> > +#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))
>=20
> FWIW, wouldn't s/UL/ULL/ in the original expression suffice? Failing that,
> rather than awkward parenthesis trickery it might be clearer to just copy
> the one from arch/mips/include/asm/dma.h.

Both of your suggestions yield the correct result, and at least for me
both look easier to understand than what Alan proposed in the first
place.=20

I would opt for the variant which is already in arch/mips, because it
avoids 64 bit calculation, is most obvious in intent in my eyes, and
we have the same calculation twice then instead of two variants.

Thanks for your review, I'll send a v2. :-)

Greets
Alex

--=20
/"\ ASCII RIBBON | =BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--iodayy4zmltei4qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl5zkGYACgkQNK3NAHIh
XMZVuBAAiot7wus5KYr1BSz88DPoujOTs5xhPjApYgOx9xpEOlKq1GmMXbiiumEX
U55+iU1afQEvSNJbHrsaLDtWxOQtWcZOuQcBCCBE7s6+fZQ21IbdoxqUlnurMZcm
O1nAoNxqQ+IzKVsQk2g7M5LKZZpZe0xHQNrBw/Jkhwx1ePLAuJRYNzWlV2zTE533
0UiNmWQweS4tUleXtne8ErWWCyq9Gic2wtK+IMApvbG6iHbhjIggOIDzLWFUB+Zm
67KWFhKT/rbLDjT1dx4FsTw1Lve0zk2/I+nPMUpXs2uSX7vHsR0nymZ/UQrD6u+C
vIqfa3RbgBFB+McCqFDPgJIuvA0/MsXujHnSDdGjltWqVPsOcd8MV8uEi8FfZoPE
1n/29F+wSMmgi1GB2uV+mBC8/uKzzFGr2r42P1OhJwieKW7sxyigC9v+IlLPm2hE
8LxN9B9It0GViBTYt6IfyD6XDOEjFwE/e8FlhzyRBj2Bn6vsqzwSLTjBxgjxEtLg
VuGSBjCCHc9vxZ/gfIOeDzQxiBKX7DiwtbuEG4VjcIqJWOgdX9h6Un2aG8H2tXhs
q5FVUtb1IcEAKIwd+ESXGSuwvBDIP6jdl9JGKk/MhEg2THpCH3zLgZE3z1kabVE2
DSdbRJnZuf5xz7+R45KBCXI3Vyjr4o1EluQgH+kM84Es/TKIzGU=
=LvT4
-----END PGP SIGNATURE-----

--iodayy4zmltei4qo--
