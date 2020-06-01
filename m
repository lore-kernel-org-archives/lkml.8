Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26412077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PqZLL/Xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFAO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:56:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39941 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:56:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601145653euoutp02ce40dd99c548978f260d57699a1d0f8d~Uc11do3Is0794507945euoutp02K;
        Mon,  1 Jun 2020 14:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601145653euoutp02ce40dd99c548978f260d57699a1d0f8d~Uc11do3Is0794507945euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591023413;
        bh=pFHvgtdW5tEy48aYEk+P6nIjiw/yYHWSkOkK7To/nIg=;
        h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
        b=PqZLL/XeovGcW7wExSbdWywVo5FJAZPEoPTCOghx2beKKN0pMX4I8yMyeNahJ/mbr
         X1N55ZZleqVvPGaud/nH1gIezklkkoF8pr7zva0Yo5U8mBBdgCjKPG7PDWozy/Xgwy
         SkQskgLy3ju2ryTSnuz7zIaUNf3wi+sx/e3zYabU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601145652eucas1p1b92f880e80e832c28348c91c3eaa2f60~Uc108IV3p1807718077eucas1p1l;
        Mon,  1 Jun 2020 14:56:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4C.7D.61286.43715DE5; Mon,  1
        Jun 2020 15:56:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601145652eucas1p11dcea1cea21824d0a6bfe6ab38c1cab7~Uc10na14d1814418144eucas1p1j;
        Mon,  1 Jun 2020 14:56:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601145652eusmtrp11d6ac325df9fba98f1fe288c16e84cc0~Uc10msjWJ1617416174eusmtrp1U;
        Mon,  1 Jun 2020 14:56:52 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a5-5ed51734b5a2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.6E.07950.43715DE5; Mon,  1
        Jun 2020 15:56:52 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601145652eusmtip28eb4aeba31f422f202e37fba19343bdd~Uc10bPXsD0501905019eusmtip2L;
        Mon,  1 Jun 2020 14:56:52 +0000 (GMT)
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
In-Reply-To: <20200601144607.GI1551@shell.armlinux.org.uk> (Russell King's
        message of "Mon, 1 Jun 2020 15:46:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 01 Jun 2020 16:56:40 +0200
Message-ID: <dleftj367eu95j.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOtqO1ejczHyxChkUaqVHUsRsWQSeCsA9RBK2mntRyMzZX
        KoTrQpZprZmpS8NVlM1LOk3MJukotaylVqakruxi6byk2X2Z8yj47fc+z//5PxdeipD84XtT
        0co4VqWUx0gF7mRF3S/bspVer2RBhfW+dGnWHT6tL67h0e3H7/Pop+cUtPl9K59+UZUjoK0Z
        1YguetgppN+9bePTBf+eIHpIN8aj/z74RdJl5gwiRMS8aG0mmCvaZpJxmj4TTJ5Zw5hNZwVM
        R6tFwAzYbEKm7EYSoxvqFzDny02IGTEvDJ25x31dBBsTfYRVBW7Y7x7V4qgVHHbMizek2Ukt
        KvVIQW4U4JVQ05PMT0HulATnI7CfuCh0JST4G4Ky18e4xAiC5w25aKri8pNBIZe4haBrMIvH
        PXoQGEst4yqKEuAAKCra7cK5eA00pS5xSQjcT0Cz08lzGXngXfA13zjBbjgB+qovES72xMFQ
        /tk+MQWJF0FtZu6ERoRXw1B7NcGxGB5nfyBdTGAFZD93IFcDwEYK+gpHBNykm+FH0ykexx7Q
        W18u5HgBNKankq7hACdBun4VV5uKoCLnJ8lp1kKH7fekz0Y44bRP6mdDW7+Y6zsb9BWZBBcW
        wZnTEk7tC8UXLJMu3pDWmz95NwZuW2yIO1UagrvaFkKHfAzT1jFMW8cwbktgP7hTFciFl8JN
        Yx/B8XooLh4k8xDfhLxYjVoRyaqXK9mjAWq5Qq1RRgaExyrMaPwbNv6rH65Eoy1hVoQpJJ0l
        KrG/lEn48iPqBIUV+Y47dZcUNCFvUhmrZKVzRZueNcokogh5QiKrit2n0sSwaiuaT5FSL9GK
        a1/2SnCkPI49xLKHWdVUlke5eWvRYj+nJ1UwM/RkiXn77yBVj0/Y2OvkoBUNpm3iB9cqtLq2
        Vv9Cu25H72jy4ojhoDwmadnBHv9HdVdvvtc7dtfMeBwcWvXmXkhvSJ1fZ/M+sl64I35nZbfC
        2ZU6VnDDkNhiGnY4PoXX/hj4qA83CG9pxJbkrVbx6JzQq2nHvssObLkuJdVR8uX+hEot/w+W
        cAMvjgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7om4lfjDJ6t5LPYOGM9q8WkdQeY
        LG427mayONOda7Hp8TVWi8u75rBZHJq6l9Fi7ZG77BYPH9xgtVj97xSjxYcJ/5ks/uz/yWKx
        edNUZgdej8vXLjJ7zG64yOLxd9ULZo8Fm0o9Nq3qZPO4c20Pm8e7c+fYPTYvqfeY8OEtm0ff
        llWMHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
        FunbJehlXHpzkK3gjVjFrN77LA2MG4W7GDk5JARMJKades/excjFISSwlFFiaus6ti5GDqCE
        lMTKuekQNcISf651sUHUPGWU2PX2NhNIDZuAnsTatREgpoiAlcSFHg2QEmaBh8wSmy7eZAHp
        FRYIlVg/4xgbiM0pUCnxeu8UZhBbSMBS4uXCRiYQWxTI3vLiPjuIzSKgKnFw+lywOK+AucSH
        m3uZIWxBiZMzn4DNZBbIlvi6+jnzBEaBWUhSs5CkZgGdxCygKbF+lz5EWFti2cLXzBC2rcS6
        de9ZFjCyrmIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM5G3Hfm7Zwdj1LvgQowAHoxIP74b7
        V+KEWBPLiitzDzGqAI15tGH1BUYplrz8vFQlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAv0z
        kVlKNDkfmHzySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw2qed
        1F/l15zP48/z0+mKzPvEyzE3F/ue1+6t3r/nWknbl6iEPfLCaXMWnNmTOXtXQGKZ/olXOkLL
        4rsluf8+q5ScV1FhN7t144H5jMuXr87OKpl/LGLuQcb5lycbPVUPnPbC4dT8YNfPad52ia+Z
        l6yf8EDdf5ZCZE35i+KX3JFBfxKZc9SZlViKMxINtZiLihMBt18IUgYDAAA=
X-CMS-MailID: 20200601145652eucas1p11dcea1cea21824d0a6bfe6ab38c1cab7
X-Msg-Generator: CA
X-RootMTR: 20200601145652eucas1p11dcea1cea21824d0a6bfe6ab38c1cab7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601145652eucas1p11dcea1cea21824d0a6bfe6ab38c1cab7
References: <20200601144607.GI1551@shell.armlinux.org.uk>
        <CGME20200601145652eucas1p11dcea1cea21824d0a6bfe6ab38c1cab7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-06-01 pon 15:46>, when Russell King - ARM Linux admin wrote:
> On Mon, Jun 01, 2020 at 04:27:50PM +0200, =C5=81ukasz Stelmach wrote:
>> Move the definition of malloc pool size of the decompressor to
>> a single place. This value will be exposed later for kexec_file loader.
>>=20
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  arch/arm/boot/compressed/Makefile | 2 ++
>>  arch/arm/boot/compressed/head.S   | 6 ++++--
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compresse=
d/Makefile
>> index 9c11e7490292..b3594cd1588c 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -125,6 +125,8 @@ KBSS_SZ =3D $(shell echo $$(($$($(NM) $(obj)/../../.=
./../vmlinux | \
>>  		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
>>  		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
>>  LDFLAGS_vmlinux =3D --defsym _kernel_bss_size=3D$(KBSS_SZ)
>> +# malloc pool size
>> +LDFLAGS_vmlinux +=3D --defsym _malloc_size=3D0x10000
>>  # Supply ZRELADDR to the decompressor via a linker symbol.
>>  ifneq ($(CONFIG_AUTO_ZRELADDR),y)
>>  LDFLAGS_vmlinux +=3D --defsym zreladdr=3D$(ZRELADDR)
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/=
head.S
>> index e8e1c866e413..dcc1afa60fb9 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -309,7 +309,8 @@ restart:	adr	r0, LC0
>>  #ifndef CONFIG_ZBOOT_ROM
>>  		/* malloc space is above the relocated stack (64k max) */
>>  		add	sp, sp, r0
>> -		add	r10, sp, #0x10000
>> +		ldr	r10, =3D_malloc_size
>> +		add	r10, r10, sp
>
> This says "locate _malloc_size in a literal pool somewhere, and load it
> using a PC-relative offset".  Are you sure that the literal pool is
> sensibly located?
>
> Would it be better to use a definition for this?

I've followed ZRELADDR way. I think both values should be handled the
same way (it makes it easier to comprehend IMHO). Is there any reason
not to?  Should I change ZRELADDR for v2 too?

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl7VFygACgkQsK4enJil
gBBQ5gf/Z97VHBrrpf500wYfXRxGAn12p9Ybn5LmsEWBSJL0J2JXjlyz8VNslrWf
g3hs5SxB/UToqJGlTU+K1kTZ8Q+JHhz9SDG3a3iT3uwjyUgftF33Wu293QK13RKF
fEEL3C06R7VYMM/Hix8QbhbQJNtVzXoR0ibZIdzX9iP7nLCSUO6gMkX2e5gXGTcW
eHfYHnCVxai/0sOnhkIRuHdQzXPcsKNSLUHmmenW+NdXP7rncFJsiEQ0paNU5l0M
fIPHcLZRh2VFPhusfY74qIlUYg6AHKRC2BleoDoCrBImqfcDf9JBDEuBPFBpTTIB
GDJt+mqIiWYFbxWXQwiCtrRRS9DVXQ==
=MSGU
-----END PGP SIGNATURE-----
--=-=-=--
