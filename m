Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E57C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C02072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu9oSfB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgDGQdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:33:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50260 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726833AbgDGQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586277222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rD8P04UnIv/oN2rFIj08883qC9fZ4KyL2UEjThZTqbE=;
        b=Xu9oSfB58K4Rtw5o1S9gFU2pXMkWdo3ypBuhc0680K7NNNUwOuseN9A/80MfSSmR6KnXen
        6TB9EOTev5UaUcTnK3J77aniuHt5lMqoI0dLHK8+U+5wjrc286WnxXL/sLGWTEaiXfSBtu
        TDeHS6VZ6E0Y3669VFmGEV0uUVATJbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-Nm2Pj_kKMi2juzgFlyppbA-1; Tue, 07 Apr 2020 12:33:39 -0400
X-MC-Unique: Nm2Pj_kKMi2juzgFlyppbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F58118FE86A;
        Tue,  7 Apr 2020 16:33:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44E7E10021B3;
        Tue,  7 Apr 2020 16:33:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 037GXXVk011116;
        Tue, 7 Apr 2020 12:33:33 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 037GXWKg011107;
        Tue, 7 Apr 2020 12:33:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 7 Apr 2020 12:33:32 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: [PATCH] memcpy_flushcache: use cache flusing for larger
 lengths
In-Reply-To: <583AD128-5B10-4414-A35B-FEACF30B7C5A@amacapital.net>
Message-ID: <alpine.LRH.2.02.2004071223130.7791@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <583AD128-5B10-4414-A35B-FEACF30B7C5A@amacapital.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-410240676-1586277213=:7791"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-410240676-1586277213=:7791
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On Tue, 7 Apr 2020, Andy Lutomirski wrote:

>=20
> > On Apr 7, 2020, at 8:01 AM, Mikulas Patocka <mpatocka@redhat.com> wro=
te:
> >=20
> > =EF=BB=BF[ resending this to x86 maintainers ]
> >=20
> > Hi
> >=20
> > I tested performance of various methods how to write to optane-based
> > persistent memory, and found out that non-temporal stores achieve=20
> > throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflush=
opt=20
> > or clwb achieve throughput 1.6 GB/s.
> >=20
> > memcpy_flushcache uses non-temporal stores, I modified it to use cach=
ed=20
> > stores + clflushopt and it improved performance of the dm-writecache=20
> > target significantly:
> >=20
> > dm-writecache throughput:
> > (dd if=3D/dev/zero of=3D/dev/mapper/wc bs=3D64k oflag=3Ddirect)
> > writecache block size   512             1024            2048         =
   4096
> > movnti                  496 MB/s        642 MB/s        725 MB/s     =
   744 MB/s
> > clflushopt              373 MB/s        688 MB/s        1.1 GB/s     =
   1.2 GB/s
> >=20
> > For block size 512, movnti works better, for larger block sizes,=20
> > clflushopt is better.
> >=20
> > I was also testing the novafs filesystem, it is not upstream, but it=20
> > benefitted from similar change in __memcpy_flushcache and=20
> > __copy_user_nocache:
> > write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
> > write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s
> >=20
> >=20
> > I submit this patch for __memcpy_flushcache that improves dm-writecac=
he=20
> > performance.
> >=20
> > Other ideas - should we introduce memcpy_to_pmem instead of modifying=
=20
> > memcpy_flushcache and move this logic there? Or should I modify the=20
> > dm-writecache target directly to use clflushopt with no change to the=
=20
> > architecture-specific code?
> >=20
> > Mikulas
> >=20
> >=20
> >=20
> >=20
> > From: Mikulas Patocka <mpatocka@redhat.com>
> >=20
> > I tested dm-writecache performance on a machine with Optane nvdimm an=
d it
> > turned out that for larger writes, cached stores + cache flushing per=
form
> > better than non-temporal stores. This is the throughput of dm-writeca=
che
> > measured with this command:
> > dd if=3D/dev/zero of=3D/dev/mapper/wc bs=3D64 oflag=3Ddirect
> >=20
> > block size    512        1024        2048        4096
> > movnti        496 MB/s    642 MB/s    725 MB/s    744 MB/s
> > clflushopt    373 MB/s    688 MB/s    1.1 GB/s    1.2 GB/s
> >=20
> > We can see that for smaller block, movnti performs better, but for la=
rger
> > blocks, clflushopt has better performance.
> >=20
> > This patch changes the function __memcpy_flushcache accordingly, so t=
hat
> > with size >=3D 768 it performs cached stores and cache flushing. Note=
 that
> > we must not use the new branch if the CPU doesn't have clflushopt - i=
n
> > that case, the kernel would use inefficient "clflush" instruction tha=
t has
> > very bad performance.
> >=20
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >=20
> > ---
> > arch/x86/lib/usercopy_64.c |   36 +++++++++++++++++++++++++++++++++++=
+
> > 1 file changed, 36 insertions(+)
> >=20
> > Index: linux-2.6/arch/x86/lib/usercopy_64.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/arch/x86/lib/usercopy_64.c    2020-03-24 15:15:36.=
644945091 -0400
> > +++ linux-2.6/arch/x86/lib/usercopy_64.c    2020-03-30 07:17:51.45029=
0007 -0400
> > @@ -152,6 +152,42 @@ void __memcpy_flushcache(void *_dst, con
> >            return;
> >    }
> >=20
> > +    if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) && size >=3D 768 && l=
ikely(boot_cpu_data.x86_clflush_size =3D=3D 64)) {
> > +        while (!IS_ALIGNED(dest, 64)) {
> > +            asm("movq    (%0), %%r8\n"
> > +                "movnti  %%r8,   (%1)\n"
> > +                :: "r" (source), "r" (dest)
> > +                : "memory", "r8");
> > +            dest +=3D 8;
> > +            source +=3D 8;
> > +            size -=3D 8;
> > +        }
> > +        do {
> > +            asm("movq    (%0), %%r8\n"
> > +                "movq   8(%0), %%r9\n"
> > +                "movq  16(%0), %%r10\n"
> > +                "movq  24(%0), %%r11\n"
> > +                "movq    %%r8,   (%1)\n"
> > +                "movq    %%r9,  8(%1)\n"
> > +                "movq   %%r10, 16(%1)\n"
> > +                "movq   %%r11, 24(%1)\n"
> > +                "movq  32(%0), %%r8\n"
> > +                "movq  40(%0), %%r9\n"
> > +                "movq  48(%0), %%r10\n"
> > +                "movq  56(%0), %%r11\n"
> > +                "movq    %%r8, 32(%1)\n"
> > +                "movq    %%r9, 40(%1)\n"
> > +                "movq   %%r10, 48(%1)\n"
> > +                "movq   %%r11, 56(%1)\n"
> > +                :: "r" (source), "r" (dest)
> > +                : "memory", "r8", "r9", "r10", "r11");
>=20
> Does this actually work better than the corresponding C code?
>=20
> Also, that memory clobber probably isn=E2=80=99t doing your code genera=
tion any=20
> favors.  Experimentally, you have the constraints wrong. An =E2=80=9Cr=E2=
=80=9D=20

The existing "movnti" loop uses exactly the same constraints (and the=20
"memory" clobber).

> constraint doesn=E2=80=99t tell GCC that you are dereferencing the poin=
ter. =20
> You need to use =E2=80=9Cm=E2=80=9D with a correctly-sized type.

But you would use
	"=3Dm"(*(char *)dest),"=3Dm"(*((char *)dest + 8)),"=3Dm"((char *)dest + =
16))...
and so on, until you run out of argument numbers.

> But I bet plain C is at least as good.

I tried to replace it with
	memcpy((void *)dest, (void *)src, 64);

The compiler inlined the memcpy function into 8 loads and 8 stores.=20
However, the whole function __memcpy_flushcache consumed one more saved=20
register and the machine code was a few bytes longer.

Mikulas
--185206533-410240676-1586277213=:7791--

