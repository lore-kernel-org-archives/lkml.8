Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E0C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D6520772
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fOU5M8ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:42:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42429 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:42:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so32387679qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g8SM4+GJrKXRfJOz1PiPHllLIJiBt2WtdBhWM1LyGD4=;
        b=fOU5M8ZYIU0+/kMvxA0q9LiSvGw3LIRwcRVmFuSCEbFdfFEILopHnjJVPOm30blKhY
         Tk2jVgVHqPhCE5Ylfonljj+zxns0HmRK4audTg31I5DGAuFt7DLd8mlBEKhFSrk1SLNG
         dsKFVOQsNq4xfNOI4scv4cui6pcz90JKLi7oT1HOt89C1SApgmelPEyXjR1vFmsaSRC5
         ao2YDD8/0SEd8YGVQUqsvurc+zebn7jJ2qYHv+gv/XxiEiUW7qSW2sVaiYprEnE5A6B+
         QHmySNPMcZcd0aZEHrZr38D0JOk+nloqrQbUh/m/ZcHUFOCCoUOirAOun3hqk+Gis8Ux
         xy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g8SM4+GJrKXRfJOz1PiPHllLIJiBt2WtdBhWM1LyGD4=;
        b=BfJeUHwHaKGDeqRan9bWdJ5qL3e5dS7uw/FhCh8KiG4Ww7Dp9+7AK2JTA6Wwidt8e1
         GcWAa/gOPFUkhG1CEiIfV2fTgZBzX7I9zqUZlj+Sl/5RppBP5s4ryJLOc4tx3WQjtScr
         jaj+wgPzZxeGHxkOHaaxdeNW5yaxeA0JT/w832K2W+uu5limHXHSEPzyCG+zzQDDmdHg
         iTNX48oY5xUuHSNardB3O24SmmHCm0CPZLJrAWTb8eXgsAMb6LaPNyiB2jOIRXVGJVKJ
         UpDaIiP6wz4pP2o3TBQ9rilX9A1jjtWPER/Wv/q3bRGtvRMaDJMGrhTUAcNVAroVcCAy
         B+3w==
X-Gm-Message-State: ANhLgQ2XKjK91qPZ0iFxInVE63xWgB922HUm2QE70XUilBEFZHSwDI/q
        XHKj+EM5BRuXXTcHL0ntzlNRoA==
X-Google-Smtp-Source: ADFU+vthFtY6b7T1Vkx4yHfqZALgml32qjSXFqoHWq/xSO3/X9QqQPg2PDPC9p9Te+RKHumPhsxL9w==
X-Received: by 2002:a37:4a16:: with SMTP id x22mr5061924qka.88.1584452539857;
        Tue, 17 Mar 2020 06:42:19 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g7sm2069446qtu.38.2020.03.17.06.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 06:42:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next] mm/kmemleak: annotate a data race in checksum
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CANpmjNPRTEsaTxDeMnz8T6BtfEx5yzgFCYNP2KZkedZ2kq9ZUw@mail.gmail.com>
Date:   Tue, 17 Mar 2020 09:42:17 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B4A327C-D7DA-4CCA-9CA5-F63035ADBCAB@lca.pw>
References: <20200317132157.1272-1-cai@lca.pw>
 <CANpmjNPRTEsaTxDeMnz8T6BtfEx5yzgFCYNP2KZkedZ2kq9ZUw@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 17, 2020, at 9:31 AM, Marco Elver <elver@google.com> wrote:
>=20
> On Tue, 17 Mar 2020 at 14:22, Qian Cai <cai@lca.pw> wrote:
>>=20
>> Even if KCSAN is disabled for kmemleak, update_checksum() could still
>> call crc32() (which is outside of kmemleak.c) to dereference
>> object->pointer. Thus, the value of object->pointer could be accessed
>> concurrently as noticed by KCSAN,
>>=20
>> BUG: KCSAN: data-race in crc32_le_base / do_raw_spin_lock
>>=20
>> write to 0xffffb0ea683a7d50 of 4 bytes by task 23575 on cpu 12:
>>  do_raw_spin_lock+0x114/0x200
>>  debug_spin_lock_after at kernel/locking/spinlock_debug.c:91
>>  (inlined by) do_raw_spin_lock at kernel/locking/spinlock_debug.c:115
>>  _raw_spin_lock+0x40/0x50
>>  __handle_mm_fault+0xa9e/0xd00
>>  handle_mm_fault+0xfc/0x2f0
>>  do_page_fault+0x263/0x6f9
>>  page_fault+0x34/0x40
>>=20
>> read to 0xffffb0ea683a7d50 of 4 bytes by task 839 on cpu 60:
>>  crc32_le_base+0x67/0x350
>>  crc32_le_base+0x67/0x350:
>>  crc32_body at lib/crc32.c:106
>>  (inlined by) crc32_le_generic at lib/crc32.c:179
>>  (inlined by) crc32_le at lib/crc32.c:197
>>  kmemleak_scan+0x528/0xd90
>>  update_checksum at mm/kmemleak.c:1172
>>  (inlined by) kmemleak_scan at mm/kmemleak.c:1497
>>  kmemleak_scan_thread+0xcc/0xfa
>>  kthread+0x1e0/0x200
>>  ret_from_fork+0x27/0x50
>>=20
>> If a shattered value was returned due to a data race, it will be
>> corrected in the next scan. Thus, annotate it as an intentional data
>> race using the data_race() macro.
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> mm/kmemleak.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index e362dc3d2028..d3327756c3a4 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1169,7 +1169,12 @@ static bool update_checksum(struct =
kmemleak_object *object)
>>        u32 old_csum =3D object->checksum;
>>=20
>>        kasan_disable_current();
>=20
> Suggested:
> + kcsan_disable_current();
>=20
>> -       object->checksum =3D crc32(0, (void *)object->pointer, =
object->size);
>> +       /*
>> +        * crc32() will dereference object->pointer. If an unstable =
value was
>> +        * returned due to a data race, it will be corrected in the =
next scan.
>> +        */
>> +       object->checksum =3D data_race(crc32(0, (void =
*)object->pointer,
>> +                                          object->size));
>=20
> This will work with the default config, because for word-sized-aligned
> writes no marking is enforced. But this will still cause a data race
> if the write is e.g. due to a memcpy.

I saw this spla atmt but just decided to reuse an old one to save some =
time.

Looks like that "head->func =3D func;=E2=80=9D not aligned.

[77392.095571][  T839] BUG: KCSAN: data-race in call_rcu / crc32_le_base
[77392.102066][  T839]=20
[77392.104297][  T839] write to 0xffff898ea73a8748 of 8 bytes by task =
114682 on cpu 79:
[77392.112111][  T839]  call_rcu+0xe8/0x4b0
__call_rcu at kernel/rcu/tree.c:2701
(inlined by) call_rcu at kernel/rcu/tree.c:2777
[77392.116084][  T839]  __fput+0x23a/0x3d0
[77392.119970][  T839]  ____fput+0x1e/0x30
[77392.123852][  T839]  task_work_run+0xba/0x120
[77392.128257][  T839]  do_syscall_64+0x7d7/0xb05
[77392.132753][  T839]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[77392.138544][  T839]=20
[77392.140760][  T839] INFO: lockdep is turned off.
[77392.145478][  T839] irq event stamp: 0
[77392.149270][  T839] hardirqs last  enabled at (0): =
[<0000000000000000>] 0x0
[77392.156307][  T839] hardirqs last disabled at (0): =
[<ffffffffb0ab4d42>] copy_process+0x1122/0x3240
[77392.165348][  T839] softirqs last  enabled at (0): =
[<ffffffffb0ab4d42>] copy_process+0x1122/0x3240
[77392.174384][  T839] softirqs last disabled at (0): =
[<0000000000000000>] 0x0
[77392.181405][  T839]=20
[77392.183625][  T839] read to 0xffff898ea73a8748 of 4 bytes by task 839 =
on cpu 46:
[77392.191088][  T839]  crc32_le_base+0x67/0x350
[77392.195498][  T839]  kmemleak_scan+0x3ee/0x9f0
[77392.199992][  T839]  kmemleak_scan_thread+0x9f/0xc4
[77392.204921][  T839]  kthread+0x1cd/0x1f0
[77392.208894][  T839]  ret_from_fork+0x27/0x50

>=20
> There are already markers for KASAN around, so the most reliable thing
> is to just disable KCSAN in this region.

OK, I=E2=80=99ll test that a bit first.

>=20
>>        kasan_enable_current();
>=20
> Suggested:
> + kcsan_enable_current();
>=20
> Thanks,
> -- Marco
>=20
>>        return object->checksum !=3D old_csum;
>> --
>> 2.21.0 (Apple Git-122.2)

