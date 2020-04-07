Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09129C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59EB2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="oz8DXwmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgDGQJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:09:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45679 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:09:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id r14so999504pfl.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HIeYEWjY9iLocedwaESC/3JzT9JqTWW18TyKK7LlFo0=;
        b=oz8DXwmJRPxZ2/QTLvmIMl/gMc30YeDPMNbeKfIrJRC3qeN4A+iMQrSM8wMLA9fVSq
         biyUpj02ziwvSILA0VzjWou34CgCcLJnxH8TA5aZPuaDXuTzC+F6LihwD8Iw3DYUhc+4
         LKjpydRtWpUVyRlJQu7NmpnCZZy9J8z6JDrlBYUV8AX3OMgC61cBe4k1LblM2sOpSNxj
         sWVMXs+SNA29w9JeMKfTFfZKdyZRwqLVdRgoK7eIvxv+Z9uzyzlbPhrRCNc+fj1/oayo
         Hzno0k2Hdb8QUPzK6qQ6izsF/BSKTLwpCrz4Yg/3zDh2iNQVLSuxRY9TOlncYJJJWZDk
         i3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HIeYEWjY9iLocedwaESC/3JzT9JqTWW18TyKK7LlFo0=;
        b=iSE88ieXYK8M7tHwlHX8AK5ZhnZXhyIYB1LY5M7WSMMwtsnUCAV/nf4gTCMBbLXKie
         344wiYyCF9QpAZc/dPT8bjthOAXHUa4sDiy197FzesED7JimCxgGAMxWpOdxaJ3d/viJ
         uTCvRGTvTMrPjWtmDSxkLT+CFgJf7VZk3y88I7e+0SLY02dloNnuntvjU0+XwFGQx+f8
         KGlmvXlugxYLZK2p9c+RtKOFCjZw/dACNvQKM2qcBZlyGJ18vP+YYk5nPSQoErIo4+jB
         tf2s/4tOcgY59r0E+30yEfjludUuefaJaDQ51OoMpgXATY70BNHDl+exd86CQaWydL7x
         cS6Q==
X-Gm-Message-State: AGi0PuboIIkXVkg9xjVLkXy28GlvK/e9bOngadatfZ/uDM73LzYt1rtp
        7IKu/3aottMn9krblzva/zT/tg==
X-Google-Smtp-Source: APiQypITLm2s3Uh+Vl98RIEnmimFYjTaDemspyulatAWPiC2koBxBlFKkhN0zl0/vWOglnAZkOiwGw==
X-Received: by 2002:aa7:9695:: with SMTP id f21mr3288671pfk.93.1586275772707;
        Tue, 07 Apr 2020 09:09:32 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1546:cd03:cc4:c9fb? ([2601:646:c200:1ef2:1546:cd03:cc4:c9fb])
        by smtp.gmail.com with ESMTPSA id r140sm1175662pfc.137.2020.04.07.09.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:09:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger lengths
Date:   Tue, 7 Apr 2020 09:09:30 -0700
Message-Id: <583AD128-5B10-4414-A35B-FEACF30B7C5A@amacapital.net>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
In-Reply-To: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 7, 2020, at 8:01 AM, Mikulas Patocka <mpatocka@redhat.com> wrote:
>=20
> =EF=BB=BF[ resending this to x86 maintainers ]
>=20
> Hi
>=20
> I tested performance of various methods how to write to optane-based
> persistent memory, and found out that non-temporal stores achieve=20
> throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflushopt=20=

> or clwb achieve throughput 1.6 GB/s.
>=20
> memcpy_flushcache uses non-temporal stores, I modified it to use cached=20=

> stores + clflushopt and it improved performance of the dm-writecache=20
> target significantly:
>=20
> dm-writecache throughput:
> (dd if=3D/dev/zero of=3D/dev/mapper/wc bs=3D64k oflag=3Ddirect)
> writecache block size   512             1024            2048            40=
96
> movnti                  496 MB/s        642 MB/s        725 MB/s        74=
4 MB/s
> clflushopt              373 MB/s        688 MB/s        1.1 GB/s        1.=
2 GB/s
>=20
> For block size 512, movnti works better, for larger block sizes,=20
> clflushopt is better.
>=20
> I was also testing the novafs filesystem, it is not upstream, but it=20
> benefitted from similar change in __memcpy_flushcache and=20
> __copy_user_nocache:
> write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
> write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s
>=20
>=20
> I submit this patch for __memcpy_flushcache that improves dm-writecache=20=

> performance.
>=20
> Other ideas - should we introduce memcpy_to_pmem instead of modifying=20
> memcpy_flushcache and move this logic there? Or should I modify the=20
> dm-writecache target directly to use clflushopt with no change to the=20
> architecture-specific code?
>=20
> Mikulas
>=20
>=20
>=20
>=20
> From: Mikulas Patocka <mpatocka@redhat.com>
>=20
> I tested dm-writecache performance on a machine with Optane nvdimm and it
> turned out that for larger writes, cached stores + cache flushing perform
> better than non-temporal stores. This is the throughput of dm-writecache
> measured with this command:
> dd if=3D/dev/zero of=3D/dev/mapper/wc bs=3D64 oflag=3Ddirect
>=20
> block size    512        1024        2048        4096
> movnti        496 MB/s    642 MB/s    725 MB/s    744 MB/s
> clflushopt    373 MB/s    688 MB/s    1.1 GB/s    1.2 GB/s
>=20
> We can see that for smaller block, movnti performs better, but for larger
> blocks, clflushopt has better performance.
>=20
> This patch changes the function __memcpy_flushcache accordingly, so that
> with size >=3D 768 it performs cached stores and cache flushing. Note that=

> we must not use the new branch if the CPU doesn't have clflushopt - in
> that case, the kernel would use inefficient "clflush" instruction that has=

> very bad performance.
>=20
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>=20
> ---
> arch/x86/lib/usercopy_64.c |   36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>=20
> Index: linux-2.6/arch/x86/lib/usercopy_64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/x86/lib/usercopy_64.c    2020-03-24 15:15:36.64494=
5091 -0400
> +++ linux-2.6/arch/x86/lib/usercopy_64.c    2020-03-30 07:17:51.450290007 -=
0400
> @@ -152,6 +152,42 @@ void __memcpy_flushcache(void *_dst, con
>            return;
>    }
>=20
> +    if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) && size >=3D 768 && likely=
(boot_cpu_data.x86_clflush_size =3D=3D 64)) {
> +        while (!IS_ALIGNED(dest, 64)) {
> +            asm("movq    (%0), %%r8\n"
> +                "movnti  %%r8,   (%1)\n"
> +                :: "r" (source), "r" (dest)
> +                : "memory", "r8");
> +            dest +=3D 8;
> +            source +=3D 8;
> +            size -=3D 8;
> +        }
> +        do {
> +            asm("movq    (%0), %%r8\n"
> +                "movq   8(%0), %%r9\n"
> +                "movq  16(%0), %%r10\n"
> +                "movq  24(%0), %%r11\n"
> +                "movq    %%r8,   (%1)\n"
> +                "movq    %%r9,  8(%1)\n"
> +                "movq   %%r10, 16(%1)\n"
> +                "movq   %%r11, 24(%1)\n"
> +                "movq  32(%0), %%r8\n"
> +                "movq  40(%0), %%r9\n"
> +                "movq  48(%0), %%r10\n"
> +                "movq  56(%0), %%r11\n"
> +                "movq    %%r8, 32(%1)\n"
> +                "movq    %%r9, 40(%1)\n"
> +                "movq   %%r10, 48(%1)\n"
> +                "movq   %%r11, 56(%1)\n"
> +                :: "r" (source), "r" (dest)
> +                : "memory", "r8", "r9", "r10", "r11");

Does this actually work better than the corresponding C code?

Also, that memory clobber probably isn=E2=80=99t doing your code generation a=
ny favors.  Experimentally, you have the constraints wrong. An =E2=80=9Cr=E2=
=80=9D constraint doesn=E2=80=99t tell GCC that you are dereferencing the po=
inter.  You need to use =E2=80=9Cm=E2=80=9D with a correctly-sized type.  Bu=
t I bet plain C is at least as good.

> +            clflushopt((void *)dest);
> +            dest +=3D 64;
> +            source +=3D 64;
> +            size -=3D 64;
> +        } while (size >=3D 64);
> +    }
> +
>    /* 4x8 movnti loop */
>    while (size >=3D 32) {
>        asm("movq    (%0), %%r8\n"
>=20
