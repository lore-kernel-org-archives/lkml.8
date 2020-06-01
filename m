Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B07C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D069820679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vL949fli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFAQai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:30:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50130 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:30:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601163035euoutp01b560ebb6c24728d88f50c45e80c64e81~UeHpjM1x_0265702657euoutp011;
        Mon,  1 Jun 2020 16:30:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601163035euoutp01b560ebb6c24728d88f50c45e80c64e81~UeHpjM1x_0265702657euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591029035;
        bh=NJ12csnkCeCEnRH+6I4gB9QBi4rMuNyFOgL+x4Loplc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vL949fliq6mEJ3aW34M/ROs33lx3WqXtePPtBj3Y/pcPgp0xKYGKT5t0DoLfl98xn
         yuj61wskZL5bwgfLE0Z632stT14KDCeB4CPJvXWS2vYqUmxeHyVeSRZD/GEIdbts/n
         kk1c7CaSQJOpnNiReMURVbpWnJ59H9Iauh6yFLfo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601163034eucas1p1e2e1229556ec1d85d15e640aa80c97bf~UeHpGI3EX2984729847eucas1p1E;
        Mon,  1 Jun 2020 16:30:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.C3.61286.A2D25DE5; Mon,  1
        Jun 2020 17:30:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601163034eucas1p1f9c726b605c18bf3944254cd83dd67b3~UeHoyigW92985429854eucas1p1u;
        Mon,  1 Jun 2020 16:30:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601163034eusmtrp16195f0213bf9dcf8474cb1090ba52167~UeHosZNqe1055110551eusmtrp1B;
        Mon,  1 Jun 2020 16:30:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-70-5ed52d2ac7e3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.AA.08375.A2D25DE5; Mon,  1
        Jun 2020 17:30:34 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601163034eusmtip21eedd609a2048f9bacdfd2ada29fc260~UeHoWxhCE3102331023eusmtip2D;
        Mon,  1 Jun 2020 16:30:34 +0000 (GMT)
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
Subject: Re: [PATCH 4/5] arm: Add kexec_image_info
Date:   Mon, 01 Jun 2020 18:30:22 +0200
In-Reply-To: <20200601145614.GK1551@shell.armlinux.org.uk> (Russell King's
        message of "Mon, 1 Jun 2020 15:56:14 +0100")
Message-ID: <dleftjsgfesq8x.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/099evh8utEH6FxskV0kvEjzNMfv40Nw0abuOq3RHe1u6LM
        Vs1jCdUpSlpJtGtduc5p5ynnIaSHKz1YJYmVSC1MUdH1zea/1+fzfX8e3p99WVL6m3Znw1RR
        olqlCJcxDpTp2XDt4oWLGwOXjL31429dLqH5NH0Fwb9JuEvwr84qeUNXE803mLMZ3pJ+H/HF
        T9rt+M53LTRfNPYS8QMpfwh+5OEwxZcZ0sl1EqGhyUoKV+KtlDCq6yGFXEO0YNAlMkJb0z1G
        +FpTYyeUXY8TUgb6GOG8UYeEbwaPbY4BDqtDxPCww6Javna/w4E7T9pR5KOZMQ9yElA8qp6e
        hOxZ4JaBuTmRSEIOrJQrRPC47zTCwXcErRXlDA6+ISgyNpNJiJ0oeZzhhvM3EeR3t9I46EaQ
        MFJH2EQM5wPFxbtt6MqtgrpkL5uE5PpIsI6OErbRU7ml8Pz+IG1jipsP2q5Uxsb2XCy0HS8n
        bSzhVkD/s4IJnsatBGNPhx3Ou8CLzA+UjUlOCZm1Xya2Bi6PhZwSE4m9bQL9SROBeSr0Vhrt
        MM+CKm0yhc3EgTZtOa5NRmDKHqKwxh/aan4xmNfDUH0pjfXO0NLnguc6Q5rp0uRNJHDmlBSr
        PUF/4d5kF3c411uIMAuQYe2cvOc5BMMNFUwKmpP1n52s/+xkjbcluQVQYpbjtDfcyPtMYl4D
        en0/lYtoHXITozXKUFHjqxKP+GgUSk20KtQnOEJpQOPfsGqscrAc/agPsiCORTInSWnH60Ap
        rTisiVVakOd4p/elRXXInVJFqESZq2RDdVWgVBKiiD0qqiP2qaPDRY0FzWQpmZvE79qnvVIu
        VBElHhLFSFH975Vg7d3jUV7M1Ytyj0xHeYfW/4vVD4xbfh37nH6jeAvtEfD0Vgdy9pph3LGZ
        9W1uadJ5vV8X1Zg97+NBP8XRmNcF+drt5lbVztYT/iOXCfGnpawgeE+qaVfwVkdJc2VX4WqL
        t5v3U2p2ZWFwWNCK20M3xfgu+XRZqdPGKfU7HXMTF5nnVvsEySjNAYXvQlKtUfwF18zoA44D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7paulfjDI5tE7DYOGM9q8WkdQeY
        LG427mayONOda7Hp8TVWi8u75rBZHJq6l9Fi7ZG77BYPH9xgtVj97xSjxYcJ/5ks/uz/yWKx
        edNUZgdej8vXLjJ7zG64yOLxd9ULZo8Fm0o9Nq3qZPO4c20Pm8e7c+fYPTYvqfeY8OEtm0ff
        llWMHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJal
        FunbJehlbD9yl7HgoHTFvnmNjA2MZ8W6GDk4JARMJA5PE+9i5OIQEljKKHHw01IWiLiUxMq5
        6V2MnECmsMSfa11sEDVPGSVuHznCDFLDJqAnsXZtBIgpImAlcaFHA6SEWeAhs8SmizdZQHqF
        BYwkTuz9xApiCwlYSuz495QJxGYRUJWY/HgiG4jNKVApcad5BzOIzStgLvH+2FIwWxSofsuL
        ++wQcUGJkzOfgM1kFsiW+Lr6OfMERoFZSFKzkKRmAZ3ELKApsX6XPkRYW2LZwtfMELatxLp1
        71kWMLKuYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzjbcd+bt7BeGlj8CFGAQ5GJR7eDfev
        xAmxJpYVV+YeYlQBGvNow+oLjFIsefl5qUoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQF+nMi
        s5Rocj4w9eSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDsOeTj
        ei/M6+m3PddXJj9rOGeSeS0tXcLQcPPUH0ePx3h9ExR5c/Cn1tqoui8z96w5oxdlfqQm8pRD
        Iec3+Tks/mdUVVLz7rMXXvv7KcCSV2eOUIrNYXWDyQmZm9m3blcw9z0cP/kNX7fn/Krvx/Sj
        Aw7Vt08t1c600Varlwu4F7KLL/+h0RolluKMREMt5qLiRAB+jGvSBQMAAA==
X-CMS-MailID: 20200601163034eucas1p1f9c726b605c18bf3944254cd83dd67b3
X-Msg-Generator: CA
X-RootMTR: 20200601163034eucas1p1f9c726b605c18bf3944254cd83dd67b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601163034eucas1p1f9c726b605c18bf3944254cd83dd67b3
References: <20200601145614.GK1551@shell.armlinux.org.uk>
        <CGME20200601163034eucas1p1f9c726b605c18bf3944254cd83dd67b3@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-06-01 pon 15:56>, when Russell King - ARM Linux admin wrote:
> On Mon, Jun 01, 2020 at 04:27:53PM +0200, =C5=81ukasz Stelmach wrote:
>> Add kexec_image_info to print detailed information about a kexec image.
>
> Isn't this already visible through kexec debugging?  Why do we need
> to duplicate the same output in the kernel?  Do we think that the
> kexec interfaces are that fragile that they don't work?

Because:

    + kexec_image_info is required if we want to show information for an
      image loaded via kexec_file_load (with kexec-tools or any other
      tool e.g. u-root),
    + this is where both interfaces meet and it is easy to compare
      their results,
    + I consider showing results as close to the end of a code path as
      possible more reliable.

>>=20
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  arch/arm/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>=20
>> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_k=
exec.c
>> index 76300f3813e8..c10a2dfd53d1 100644
>> --- a/arch/arm/kernel/machine_kexec.c
>> +++ b/arch/arm/kernel/machine_kexec.c
>> @@ -31,6 +31,32 @@ extern unsigned long kexec_boot_atags;
>>=20=20
>>  static atomic_t waiting_for_crash_ipi;
>>=20=20
>> +/**
>> + * kexec_image_info - For debugging output.
>> + */
>> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
>> +static void _kexec_image_info(const char *func, int line,
>> +	const struct kimage *kimage)
>> +{
>> +	unsigned long i;
>> +
>> +	pr_debug("%s:%d:\n", func, line);
>> +	pr_debug("  kexec kimage info:\n");
>> +	pr_debug("    type:        %d\n", kimage->type);
>> +	pr_debug("    start:       %lx\n", kimage->start);
>> +	pr_debug("    head:        %lx\n", kimage->head);
>> +	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
>> +
>> +	for (i =3D 0; i < kimage->nr_segments; i++) {
>> +		pr_debug("      segment[%lu]: %08lx - %08lx, 0x%x bytes, %lu pages\n",
>> +			i,
>> +			kimage->segment[i].mem,
>> +			kimage->segment[i].mem + kimage->segment[i].memsz,
>> +			kimage->segment[i].memsz,
>> +			kimage->segment[i].memsz /  PAGE_SIZE);
>> +	}
>> +}
>> +
>>  /*
>>   * Provide a dummy crash_notes definition while crash dump arrives to a=
rm.
>>   * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
>> @@ -42,6 +68,8 @@ int machine_kexec_prepare(struct kimage *image)
>>  	__be32 header;
>>  	int i, err;
>>=20=20
>> +	kexec_image_info(image);
>> +
>>  	image->arch.kernel_r2 =3D image->start - KEXEC_ARM_ZIMAGE_OFFSET
>>  				     + KEXEC_ARM_ATAGS_OFFSET;
>>=20=20
>> --=20
>> 2.26.2
>>=20
>>=20

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl7VLR4ACgkQsK4enJil
gBC6eQf/eqqnY56vEEOYXLzN+Cdf7laqLXyMrIF+iZHmELaOBjTYAmR/agGv7t3I
rAzRO/W02Cpm8I/S6lzK7b5va2N/YZoab/aBED8fycSYqgr+odY6cX3Vt7nxH8jv
KvrA/J9nix5aEfWCZ86/PtjFV7zdm/NzCT7yQf26kCEOcqy6Zcq19J0niXyYjv5b
WFF749oXXL1qUjqbRLwKWMMz/HTK8HH8PeUnxKg+s+9SLEVoUrIJubPkBkMCGOZw
M62/M2Rc6YjB2lNAPr7o3uzpMHA5MQuO4QSI+mZ1IeeEEXboqThutOMt48aOPhWl
NWrCLQiU9ViHkDVZ57Wx9UuLzHumHA==
=5Li0
-----END PGP SIGNATURE-----
--=-=-=--
