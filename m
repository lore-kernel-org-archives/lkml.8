Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6854206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bzryWO0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgFBQRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45501 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgFBQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161720euoutp022a75f83bb94f6e800be4eb3014506fd7~UxlX55beD1198111981euoutp02u;
        Tue,  2 Jun 2020 16:17:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200602161720euoutp022a75f83bb94f6e800be4eb3014506fd7~UxlX55beD1198111981euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114640;
        bh=XgIdZFJhtuiqQmX6qvwfrKLe6TSabjjwUg6aw7gmzIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzryWO0xMcZ5wRGHhWM8ZLuTmlouXuEZJwEXmvHfrLkuzPN3n+ui1iHt6yarjY0vj
         q3bCPE4SF+c+jp68THYXL9rMDFAK4WhKAUno1MXID/MSzHFRKLob51PLx09C/mNrxD
         T1LrOhTLZ/fSN/p6LfjiI894J0ZKeXlWhud4bLNI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602161720eucas1p246c5eab5f86dcf7dc3340fe56ab369be~UxlXmdNcW0409404094eucas1p2-;
        Tue,  2 Jun 2020 16:17:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.23.60698.09B76DE5; Tue,  2
        Jun 2020 17:17:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161720eucas1p257e9e892ed4679ed1d168db34d089a82~UxlXTQgas0409404094eucas1p2_;
        Tue,  2 Jun 2020 16:17:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161720eusmtrp1effea767466bda44f98db82e7b1a6c36~UxlXSiPWh2876728767eusmtrp1k;
        Tue,  2 Jun 2020 16:17:20 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f3-5ed67b9078ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.29.07950.09B76DE5; Tue,  2
        Jun 2020 17:17:20 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161720eusmtip21cf2273238527602796cc2ce18a66222~UxlXGsAnu0295502955eusmtip2f;
        Tue,  2 Jun 2020 16:17:20 +0000 (GMT)
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
Subject: Re: [PATCH 3/5] arm: decompressor: define a new zImage tag
Date:   Tue, 02 Jun 2020 18:17:05 +0200
In-Reply-To: <20200601204127.GS1551@shell.armlinux.org.uk> (Russell King's
        message of "Mon, 1 Jun 2020 21:41:28 +0100")
Message-ID: <dleftjmu5lqw72.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSF8zrT6VAtGQrKDSqaBhPACBJFBhEU9ccYNfKHaCSio06ASFts
        KQoYixqJsllxZYtiiAIC1bKEVaVuEZRFYhVSAwJGQaoQ1ACyyDCY8O+75513bs7LIzH5hNiF
        jFLFchoVG60gpHjVy/HWtYZES/i6D18V9KNbRjGdWfZURHeerRPRb1KVtKnPIqY7anMJ2ny9
        AdGlzz9J6M89H8X0g+kmRA8bZkT05JNxnC43Xce2ypgOSzvG5CS148xU8TeMuWPSMabiSwRj
        tdQTzI+WFglTXqBnDMM2gsmoKEbMqMk1ZNEB6eZjXHRUHKfxDjosjXz/slAc89n31BfjjCgJ
        VXqkIDsSqA1QkPUES0FSUk4VIqi90TQ//EJw5c/f+WEUwTuLjUhB5NyV/MIEQb+PoM5YIhaG
        rwjS62skvImgvKC0dD+PTtQmaEtz5y0YZcOgfWpKxK92pLbDhaLOOcap1TBwbhrxbEfFQ1fj
        2FyMjPKD1IYAXl5C+UPFt24JzzLKAV5n9eM8Y5QSslqHEJ8PVD4J774MYkK1HVDy4rZIYEcY
        fFUhEXg5NF9Nw4UueriauVG4m4agKncMFzwBYG2ZIAQOhrzkHEzw28NHm4Ow1x4yq27OyzK4
        mCwX3G5Qdrl+PsUF0gcLkcAMtOZN4MJLpSOYyetFBrQqe0Gd7AV1smdjMcoDjLXegrwG7uV/
        xwQOhLKyn/gdJC5GzpxOq4zgtOtV3EkvLavU6lQRXkfVShOa/YXN069+V6PHk0fMiCKRYrFs
        nY8lXC5m47TxSjNym03qffigDbngKrWKUzjJtr1tDpfLjrHxCZxGfUiji+a0ZrSMxBXOsvV3
        Bw7KqQg2ljvOcTGc5v+piLRzSUInwrroPVl6i3XXtQlfx5jSkqEXeKSHY6DZ12GHfqUvajsv
        XbF7L3G7vyu4mTUQmnBnt9NvOpx2eo5cU3dm1rDB/Sq37n0NoVb/Sv9Q+a4odXUj6WcMMsXo
        dc+YopG4gi5Xnas+3pbhsbSOM1pC+qTW1PTEwFXu/lvCzph7zApcG8n6eGIaLfsPPotcGI0D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xe7oTqq/FGRy+xGOxccZ6VotJ6w4w
        Wdxs3M1kcaY712LT42usFpd3zWGzODR1L6PF2iN32S0ePrjBarH63ylGiw8T/jNZ/Nn/k8Vi
        86apzA68HpevXWT2mN1wkcXj76oXzB4LNpV6bFrVyeZx59oeNo93586xe2xeUu8x4cNbNo++
        LasYPT5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DLuHpsBWvBQ9OKp+v/MzUwbtXsYuTgkBAwkVi4oqqLkYtDSGApo8TrvbNZIOJSEivn
        pncxcgKZwhJ/rnWxQdQ8ZZSYvv4fG0gNm4CexNq1ESCmiICVxIUeDZASZoGHzBKbLt5kAekV
        FnCWaF15kwmkRkjAUuLp5WKQMIuAqsTLpn+MIDanQKXErYM/2EFKeAXMJbr3WoOERYGqt7y4
        zw5i8woISpyc+QRsIrNAtsTX1c+ZJzAKzEKSmoUkNQtoErOApsT6XfoQYW2JZQtfM0PYthLr
        1r1nWcDIuopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwhrcd+7llB2PXu+BDjAIcjEo8vAaG
        1+KEWBPLiitzDzGqAI15tGH1BUYplrz8vFQlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAr05
        kVlKNDkfmHbySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwnqiN
        5E08kSkz+7SG9Ve1I3MVWJb+nSHY4rHh0uJpK48cv+n2kvX3nHUs9xOmCHLzVae1JErVHxN4
        wM+ebmY0K9DuePpBfsnVN45OW/zWX9/gVoWHtrrfQmf3fxkLPitJqVr3SAiuV/Uo5jOxEcl5
        tuPRx8M/dqVkSpya8VZrXtY5A8GH0TfWKrEUZyQaajEXFScCAE5szDgDAwAA
X-CMS-MailID: 20200602161720eucas1p257e9e892ed4679ed1d168db34d089a82
X-Msg-Generator: CA
X-RootMTR: 20200602161720eucas1p257e9e892ed4679ed1d168db34d089a82
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161720eucas1p257e9e892ed4679ed1d168db34d089a82
References: <20200601204127.GS1551@shell.armlinux.org.uk>
        <CGME20200602161720eucas1p257e9e892ed4679ed1d168db34d089a82@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-06-01 pon 21:41>, when Russell King - ARM Linux admin wrote:
 > On Mon, Jun 01, 2020 at 10:27:45PM +0200, Lukasz Stelmach wrote:
>> It was <2020-06-01 pon 19:25>, when Russell King - ARM Linux admin wrote:
>>> On Mon, Jun 01, 2020 at 06:19:52PM +0200, Lukasz Stelmach wrote:
>>>> It was <2020-06-01 pon 15:55>, when Russell King - ARM Linux admin wro=
te:
>>>>> On Mon, Jun 01, 2020 at 04:27:52PM +0200, =C5=81ukasz Stelmach wrote:
>>>>>> Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
>>>>>> requirements of the decompressor code.
>>>>>
>>>>> Why do we need to know the stack and BSS size, when the userspace
>>>>> kexec tool doesn't need to know this to perform the same function.
>>>>=20
>>>>=20
>>>> kexec-tools load zImage as low in DRAM as possible and rely on two
>>>> assumptions:
>>>>=20
>>>>     + the zImage will copy itself to make enough room for the kernel,
>>>>     + sizeof(zImage+mem) < sizeof(kernel+mem), which is true because
>>>>       of compression.
>>>>=20
>>>>        DRAM start
>>>>        + 0x8000
>>>>=20
>>>> zImage    |-----------|-----|-------|
>>>>             text+data   bss   stack=20
>>>>=20
>>>>                  text+data           bss=20=20=20
>>>> kernel    |---------------------|-------------------|
>>>>=20
>>>>=20
>>>> initrd                                              |-initrd-|-dtb-|
>>>
>>> This is actually incorrect, because the decompressor will self-
>>> relocate itself to avoid the area that it is going to decompress
>>> into.
>>=20
>> I described the state right after kexec(8) invocation.
>
> Actually, you haven't, because this is _not_ how kexec(8) lays it
> out, as I attempted to detail further down in my reply.


Let me try to describe how I understand the code in kexec-tools
(commit 74c7c369).

=2D-8<---------------cut here---------------start------------->8---
int zImage_arm_load(=E2=80=A6, const char *buf, off_t len, =E2=80=A6)
// buf - zImage
// len - size of zImage
=20=20=20=20=20=20=20=20
unsigned int extra_size =3D 0x8000; /* TEXT_OFFSET */

kernel_mem_size =3D len + 4;

// locate a hole to fit zImage + 32kB as low as possible,
base =3D locate_hole(info, len + extra_size, 0, 0, ULONG_MAX, INT_MAX);

kernel_base =3D base + extra_size;

add_segment(info, buf, len, kernel_base, kernel_mem_size);
=2D-8<---------------cut here---------------end--------------->8---

Therefore, zImage is loaded low and always requires relocation.
=20=20=20=20=20=20=20=20
ram     |--------------------------------------------------------------
zImage     |----k_m_s----|
           ^
           |
           kernel_base =E2=80=94 TEXT_OFFSET or higher

Next goes initrd

=2D-8<---------------cut here---------------start------------->8---
kexec_arm_image_size =3D len * 5; // or passed on command line

// if the tag exists
kexec_arm_image_size =3D max(edata_size + bss_size,
                           edata_size + len); // len - zImage size + 64 kB=
=20

initrd_base =3D kernel_base + _ALIGN(kexec_arm_image_size, page_size);

add_segment(info, ramdisk_buf, initrd_size, initrd_base, initrd_size);
=2D-8<---------------cut here---------------end--------------->8---

above whatever is bigger (kernel + kernel bss) OR (kernel + zImage + zImage=
 mem).


ram     |---------------------------------------------------------------
zImage     |----k_m_s----|                   Where kexec loads zImage @kern=
el_base

           |.............len * 5....................| Fallback
kernel     |.....edata.....|...bss...|       These are just calculations
zImage                     |.....len+....|   zImage will copy itself here W=
HEN it runs

initrd                                   |--initrd_size--|
dtb                                      ^               |---|
                                         |
                                 initrd_base

DTB, of course, goes next

    dtb_offset =3D initrd_base + initrd_size + page_size;


Stuff marked with "-" is actually loaded, "." are just calculations to
establish initrd_base.

>>> So, while the decompressor runs, in the above situation it
>>> ends up as:
>>>
>>>
>>> ram    |------------------------------------------------------...
>>>                  text+data           bss=20=20=20
>>> kernel    |---------------------|-------------------|
>>> zImage                          |-----------|-----|-------|
>>>                                   text+data   bss   stack+malloc
>
> Note here - if the initrd was placed as _you_ describe at the end
> of where the zImage ends up including its BSS, it would be
> corrupted by the stack and malloc space of the decompressor while
> running.  Ergo, your description of how kexec(8) lays stuff out
> is incorrect.

Is my analysis above accurate now? Do I understand this?

As you noted, my intention is to load zImage after edata (dotted len+
above).

>>>>>> +struct arm_zimage_tag_dc {
>>>>>> +	struct tag_header hdr;
>>>>>> +	union {
>>>>>> +#define ZIMAGE_TAG_DECOMP_SIZE ARM_ZIMAGE_MAGIC4
>>>>>> +		struct zimage_decomp_size {
>>>>>> +			__le32 bss_size;
>>>>>> +			__le32 stack_size;
>>>>>> +			__le32 malloc_size;
>>>>>> +		} decomp_size;
>>>
>>> You certainly don't need to know all this.  All you need to know is
>>> how much space the decompressor requires after the end of the image,
>>> encompassing the BSS size, stack size and malloc size, which is one
>>> value.
>>=20
>> I agree. However, since we are not fighting here for every single byte,
>> I'd rather add them as separate values and make the tag, even if only
>> slightly, more future-proof.
>
> It doesn't make it more future-proof.  What happens if we add something
> else, do we need to list it separately, and then change the kernel to
> accept the new value and maybe also kexec(8)?  Or do we just say "the
> decompressor needs X many bytes after the image" and be done with it?
> The latter sounds way more future-proof to me.

You are right. I changed it to a single value. Done.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl7We4EACgkQsK4enJil
gBC8Iwf/WZzz0WgGYVgQzAMKfMYySvrG8k4aomwnNckckoVYX3WSJhDiTWcMEMEV
7hLjm7OcHvTbjaNk0Z+UOu4cRJDiO2sTBDwlftlp5iEF4VVyl37JKZqKcPy/QmGS
6GNl7n0xUp8vYfYFQIp9CYRg6G7Q+e87kFIUmZCneRUfFjyN1Kg1ao325SMi4th3
P2jTwYPK6mb2N3rD6gzsjlqvjWJH7CvKwoUrRiNzeMqGJZPJvzK+1PskxZe/3gGp
Ew+OiQB+NavqYKAEC521hZD0hny0f+q+5yizzyGa6SaEF3Y9i+YLbhtqSK1HYAoK
MXXRyj47FeCThHDjmHLh2ttXVKM4qQ==
=Hfov
-----END PGP SIGNATURE-----
--=-=-=--
