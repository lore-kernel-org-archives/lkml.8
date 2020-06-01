Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842F62073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LPzLm4wE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFAQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:54:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53471 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:54:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601165422euoutp01ac972ea1303721040b8d4aee4b8fec66~Uecaasky-1943719437euoutp01w;
        Mon,  1 Jun 2020 16:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601165422euoutp01ac972ea1303721040b8d4aee4b8fec66~Uecaasky-1943719437euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591030462;
        bh=6ZgjVU7BxZ6n/19zSHKV0+iCWS1KtSfrC2EQXViyFkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPzLm4wEejB/RMv+knzwgNcCI+t36gBD+/WyHqPC+fyyGQcM8F2xlgKQXpYp9LNFX
         G7ki2ah2s3tdDvJVpDV3OyM/7hBiisWJr808QWjhAHZq7BW7Ts5nxfnESSOyXGqW32
         0/EgW3DeIo0Ep1GAQT7Nj4UPA6olATtTLzw0PioU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601165421eucas1p1e4f94f8546777b2c8735f45110f9a0d9~UecZUIN_81262312623eucas1p1v;
        Mon,  1 Jun 2020 16:54:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 06.E3.60679.DB235DE5; Mon,  1
        Jun 2020 17:54:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601165420eucas1p273e0cdb143312b9a621e2444c5daae9b~UecZBSPFE1190511905eucas1p2N;
        Mon,  1 Jun 2020 16:54:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601165420eusmtrp2a10cb66459ee8277bd5e890f262c37e3~UecZAivOx0416804168eusmtrp2S;
        Mon,  1 Jun 2020 16:54:20 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-5e-5ed532bdf66f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.35.07950.CB235DE5; Mon,  1
        Jun 2020 17:54:20 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601165420eusmtip10af9f33144941e47054d6b7e9c92489b~UecYzSp_K0145801458eusmtip1m;
        Mon,  1 Jun 2020 16:54:20 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] arm: decompressor: set malloc pool size for the
 decompressor
Date:   Mon, 01 Jun 2020 18:54:20 +0200
In-Reply-To: <20200601151031.GM1551@shell.armlinux.org.uk> (Russell King's
        message of "Mon, 1 Jun 2020 16:10:31 +0100")
Message-ID: <dleftjimgasp4z.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9lOy4nr9PwSSNyWHQhLZU63aSk6PQhiD6kCVkzD9N003a0
        MigvkFppLU2qaaVhuSZqLbHy0mWMIq/ZRYzs6iI1NUPTpk1zHoO+/d7n+f//z/u8vAypsNPe
        TKw2iddpVfFKiYyqeWpvW9EQ+CZyZdkgyd65VEWzeZWPCfZteh3BNp/RsObuDpp9VVskYS0F
        DYitsL6Xsp8/ddJs+WQjYof0UwT755GdYu+aC8hNcu5VRzvJFaa1U5zD1ENyxeZkzmw6JeG6
        Ouol3GBrq5S7W5rK6YcGJNzZahPihs0Lds6JkG2I5uNjD/O6gJD9sphyRzdK/ORzdPBME52G
        znudRi4M4GCwdo9Rp5GMUWAjgivGDKl4GEHwYaKHFg/DCPJyf1H/LEX5baSTFbgMQVVTqCj6
        hsD4ZHy6wTAS7A8VFeFO9MTr4EXOEqeExAMktDschNPrgcPgp7Fkhim8CGxDhpl8F5wCo3ey
        JU6W4zVgzSyc0czFa6G656NUrLvD88u2GT2JNXC5rR85BwAuYaCrrJFwDga8Baz9MvHOHtD3
        rFoq8nyYenBtVpIK+XmrRWsOgpqi37M7roeu1nGJqNkM9QVuIrpB54C7ONUN8moukmJZDtmZ
        CtHoB5Xn6mdDvCG3z4hE5uCSVU+KD5WLIH3SRujRQsN/yxj+W8YwHUvipVBVGyCWl8PNku+k
        yBuhsvIHVYxoE/LikwWNmhcCtfwRf0GlEZK1av8DCRozmv6ETZPPRu6j2j9RFoQZpHSVM19e
        Rypo1WEhRWNBftNJX26Xv0DelDZByys95aEtTZEKebQq5RivS9inS47nBQvyYSillzzoeu9e
        BVarkvg4nk/kdf+6BOPinYbC+y6EjaSpdy+bGPel5148uPjh+aQx+0Cj9ETWHEfR1HhW542P
        X6c0+1wjcib6g22tIV93HLrHb9m6R+1bujBfs+lItkPom1dvMG6zvTtpN7j2EpDS0PJy1MyF
        XhXqgicsePvxjFN6Mkq9zWXXVlPgrTFznP/GzDXVRLN7UKBviZISYlSrlpE6QfUXk78/SIwD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7p7jK7GGazbr2GxccZ6VotJ6w4w
        Wdxs3M1kcaY712LT42usFpd3zWGzODR1L6PF2iN32S0ePrjBarH63ylGiw8T/jNZ/Nn/k8Vi
        86apzA68HpevXWT2mN1wkcXj76oXzB4LNpV6bFrVyeZx59oeNo93586xe2xeUu8x4cNbNo++
        LasYPT5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DLWP33MWPBA+mKd92nWRsYJ4p3MXJySAiYSMyZfJ65i5GLQ0hgKaPEk0fTgBwOoISU
        xMq56RA1whJ/rnWxQdQ8ZZR49n4XG0gNm4CexNq1ESCmiICVxIUeDZASZoGHzBKbLt5kAekV
        FgiVWD/jGBuILSRgKXFh0xtmEJtFQFXiyYdZYDWcApUS3zZ2gNXwCphLHGmbzQRiiwLVb3lx
        nx0iLihxcuYTsHpmgWyJr6ufM09gFJiFJDULSWoW0EnMApoS63fpQ4S1JZYtfM0MYdtKrFv3
        nmUBI+sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwEjeduznlh2MXe+CDzEKcDAq8fBuuH8l
        Tog1say4MvcQowrQmEcbVl9glGLJy89LVRLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQnxOZ
        pUST84HJJ68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PP5HcL
        tGTfCqkoiIfJys174BLnezj6idaVVy6iJtXXvjLvns2dH2YUemau+vGjdTIM357q/YnqrpAS
        YAoRsJn88Ur7KYG992/PuLKc41OkeSLvT5ZnEkLMr+9ZLWxte35W+cH9uxUJKR87XcVblkZk
        szlMC1jz5BJLzOTUSw1XHMLmfprd0qHEUpyRaKjFXFScCACE9kayBgMAAA==
X-CMS-MailID: 20200601165420eucas1p273e0cdb143312b9a621e2444c5daae9b
X-Msg-Generator: CA
X-RootMTR: 20200601165420eucas1p273e0cdb143312b9a621e2444c5daae9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601165420eucas1p273e0cdb143312b9a621e2444c5daae9b
References: <20200601151031.GM1551@shell.armlinux.org.uk>
        <CGME20200601165420eucas1p273e0cdb143312b9a621e2444c5daae9b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-06-01 pon 16:10>, when Russell King - ARM Linux admin wrote:
> On Mon, Jun 01, 2020 at 04:56:40PM +0200, Lukasz Stelmach wrote:
>> It was <2020-06-01 pon 15:46>, when Russell King - ARM Linux admin wrote:
>> > On Mon, Jun 01, 2020 at 04:27:50PM +0200, =C5=81ukasz Stelmach wrote:
>> >> Move the definition of malloc pool size of the decompressor to
>> >> a single place. This value will be exposed later for kexec_file loade=
r.
>> >>=20
>> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> >> ---
>> >>  arch/arm/boot/compressed/Makefile | 2 ++
>> >>  arch/arm/boot/compressed/head.S   | 6 ++++--
>> >>  2 files changed, 6 insertions(+), 2 deletions(-)
>> >>=20
>> >> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compre=
ssed/Makefile
>> >> index 9c11e7490292..b3594cd1588c 100644
>> >> --- a/arch/arm/boot/compressed/Makefile
>> >> +++ b/arch/arm/boot/compressed/Makefile
>> >> @@ -125,6 +125,8 @@ KBSS_SZ =3D $(shell echo $$(($$($(NM) $(obj)/../.=
./../../vmlinux | \
>> >>  		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
>> >>  		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
>> >>  LDFLAGS_vmlinux =3D --defsym _kernel_bss_size=3D$(KBSS_SZ)
>> >> +# malloc pool size
>> >> +LDFLAGS_vmlinux +=3D --defsym _malloc_size=3D0x10000
>> >>  # Supply ZRELADDR to the decompressor via a linker symbol.
>> >>  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
>> >>  LDFLAGS_vmlinux +=3D --defsym zreladdr=3D$(ZRELADDR)
>> >> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compress=
ed/head.S
>> >> index e8e1c866e413..dcc1afa60fb9 100644
>> >> --- a/arch/arm/boot/compressed/head.S
>> >> +++ b/arch/arm/boot/compressed/head.S
>> >> @@ -309,7 +309,8 @@ restart:	adr	r0, LC0
>> >>  #ifndef CONFIG_ZBOOT_ROM
>> >>  		/* malloc space is above the relocated stack (64k max) */
>> >>  		add	sp, sp, r0
>> >> -		add	r10, sp, #0x10000
>> >> +		ldr	r10, =3D_malloc_size
>> >> +		add	r10, r10, sp
>> >
>> > This says "locate _malloc_size in a literal pool somewhere, and load it
>> > using a PC-relative offset".  Are you sure that the literal pool is
>> > sensibly located?
>> >
>> > Would it be better to use a definition for this?
>>=20
>> I've followed ZRELADDR way. I think both values should be handled the
>> same way (it makes it easier to comprehend IMHO). Is there any reason
>> not to?  Should I change ZRELADDR for v2 too?
>
> There's a good reason.  ZRELADDR can be a constant that does not fit
> into the ARMs immediate constants (8 bits of significant data plus
> a multiple of a 2-bit shift), whereas the size of the malloc space
> is guaranteed to fit.  So, ZRELADDR has to use a literal load.
> This doesn't.

Indeed this is how TEXT_OFFSET works. Done.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl7VMrwACgkQsK4enJil
gBDfbAf9E/+1XlAikLuLNaz4QhyCt0WykeEitrgvcfQT6lz05PVpKQaHBtOl4NvP
/aoknGqVvcuMHFW+fxlP19imDiHVkOz0QesqAEbdDojL0FwD/N2ZvzAQGKejtqhm
0BSnWmDiypyovDUozC1ke/BOV1conOH0Rtkh8ly0KyH44FYHXgCvwQ/CsSuay7dH
8+sr7ojqvwYiG/mAZEqEddnPKgaX86GqCJ4a3YGOquso63XKlMwuUVMlMUV7eUC8
9MLLkVUwSKBn9D+nKcCspTT9DMNXa2WT5xIjgG08/U7n1UEMb4VqMYbDCB5fowqn
ORLGwD6BaSupWTUL4t7iJr3vXevLLQ==
=bReY
-----END PGP SIGNATURE-----
--=-=-=--
