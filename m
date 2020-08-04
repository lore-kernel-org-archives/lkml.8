Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3772067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0LX6W46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHDNWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgHDNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:18:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D8C06174A;
        Tue,  4 Aug 2020 06:17:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so28528215ejr.5;
        Tue, 04 Aug 2020 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Sl+XnH6r6B+TcXL1LhDcBYyJ7Wtt7he4wW3Nd0xqduU=;
        b=I0LX6W4631iOB9FrEWWgSmo6tnHLCE4WzNsDIAG126jwHQXCC05Eq/OpEKFBgCipWv
         GzuoKZfT8Pn5OIJnboP5oS4OQY4UKbe0o6hvBph22CKxzLpzC6e68TfCanB3KmE3Ad4I
         W7YAdAnky/a/FPbaQZop1blyw2vx4UAMmUZUQvqXMeZRtiNx16gM+gcYJ494rtwQTyqo
         fFfKZIuMbF3kPHwFfrczmh4miyvEE9/fSB9Tu0QzJadZ17eyLUDbSolSAy9ZvFC6KakP
         VYwwzyVUolZxhu+KtxT4s4iBQOA9DiImZivucnatjzqcwlX638fXkgpuzWmqQtjrIVED
         PpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Sl+XnH6r6B+TcXL1LhDcBYyJ7Wtt7he4wW3Nd0xqduU=;
        b=ItTupEYUyr03+xpghOz7w/j5p7c8y8GOLVO5uNTPz1rqToCak8V7gvVFkxhoM6vIm6
         v4TkHattRUjrSMrFPDfnOVMdYvwkO3p8h+DFG1exgj3hKb98I9UhKmPaqLHVkZ1IGVnc
         wZj7mTBq/lB4JRWkh143ZvM8IcHNNRlQVKInMQTacCVGhCCherUHG9XcITEVwwaIEwxq
         lQVuYsW8T0dX9djGuNziTcqYIWOhaq4GMqzPI/LVt1eF4o7XnoMwopOCrANnLRB7obJo
         XENXYW16eujUrH5Vj+NTBfOT9yyQqTq5RjJaAVrTzdsLNw2bqc1OGI4ycyGdLVVn4K58
         kHMA==
X-Gm-Message-State: AOAM5325irEgLYrwFl3MkvZBAQnvylcs/3MICPuCvS22NcR/BviMXZsN
        SksBA9xQ/3LD49MHbB4pPYIhifI8nkhFGCEQIHNEvb1i
X-Google-Smtp-Source: ABdhPJzyAN9Tav5aYUu2wKYqokVwh3hpbBMhOon9lDoajpCGWuc3ccJ6MkQTJ0jD+Gm8IKyDmTsJvhJYAPOxLU8g4/E=
X-Received: by 2002:a17:906:ce59:: with SMTP id se25mr4375633ejb.359.1596547047506;
 Tue, 04 Aug 2020 06:17:27 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 4 Aug 2020 16:17:16 +0300
Message-ID: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
Subject: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to build
To:     Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Linus git master sources:

$ git desc
v5.8-2483-gc0842fbc1b18

If built without "kernel debugging" option CONFIG_PROVE_LOCKING
enabled, builds successfully.

If I enable
CONFIG_PROVE_LOCKING=3Dy

it does not build:

linux-2.6$ make  arch/sparc
scripts/kconfig/conf  --syncconfig Kconfig

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=3Dy] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=3Dn] || MCOUNT [=3Dn]
  Selected by [y]:
  - LOCKDEP [=3Dy] && DEBUG_KERNEL [=3Dy] && LOCK_DEBUGGING_SUPPORT [=3Dy]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=3Dy] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=3Dn] || MCOUNT [=3Dn]
  Selected by [y]:
  - LOCKDEP [=3Dy] && DEBUG_KERNEL [=3Dy] && LOCK_DEBUGGING_SUPPORT [=3Dy]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=3Dy] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=3Dn] || MCOUNT [=3Dn]
  Selected by [y]:
  - LOCKDEP [=3Dy] && DEBUG_KERNEL [=3Dy] && LOCK_DEBUGGING_SUPPORT [=3Dy]
&& !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86

  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/sparc/vdso/vclock_gettime.o
In file included from ./arch/sparc/include/asm/bug.h:25,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/sparc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:15,
                 from ./include/linux/time.h:6,
                 from arch/sparc/vdso/vclock_gettime.c:16:
./include/linux/seqlock.h: In function =E2=80=98write_seqcount_begin_nested=
=E2=80=99:
./arch/sparc/include/asm/percpu_64.h:19:25: error:
=E2=80=98__local_per_cpu_offset=E2=80=99 undeclared (first use in this func=
tion); did
you mean =E2=80=98per_cpu_offset=E2=80=99?
   19 | #define __my_cpu_offset __local_per_cpu_offset
      |                         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:145:27: note: in definition of macro =E2=80=98W=
ARN_ON_ONCE=E2=80=99
  145 |  int __ret_warn_once =3D !!(condition);   \
      |                           ^~~~~~~~~
././include/linux/compiler_types.h:301:2: note: in expansion of macro
=E2=80=98__compiletime_assert=E2=80=99
  301 |  __compiletime_assert(condition, msg, prefix, suffix)
      |  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:313:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  313 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:2: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   36 |  compiletime_assert(__native_word(t) || sizeof(t) =3D=3D
sizeof(long long), \
      |  ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:21: note: in expansion of macro
=E2=80=98__native_word=E2=80=99
   36 |  compiletime_assert(__native_word(t) || sizeof(t) =3D=3D
sizeof(long long), \
      |                     ^~~~~~~~~~~~~
./include/asm-generic/rwonce.h:49:2: note: in expansion of macro
=E2=80=98compiletime_assert_rwonce_type=E2=80=99
   49 |  compiletime_assert_rwonce_type(x);    \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:10: note: in expansion of macro =E2=80=
=98READ_ONCE=E2=80=99
  119 |  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |          ^~~~~~~~~
./include/linux/percpu-defs.h:231:2: note: in expansion of macro =E2=80=98R=
ELOC_HIDE=E2=80=99
  231 |  RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
      |  ^~~~~~~~~~
./include/asm-generic/percpu.h:44:31: note: in expansion of macro
=E2=80=98SHIFT_PERCPU_PTR=E2=80=99
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset=
)
      |                               ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:44:53: note: in expansion of macro
=E2=80=98__my_cpu_offset=E2=80=99
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset=
)
      |                                                     ^~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:242:2: note: in expansion of macro
=E2=80=98arch_raw_cpu_ptr=E2=80=99
  242 |  arch_raw_cpu_ptr(ptr);      \
      |  ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:21: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  119 |  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:138:11: note: in expansion of macro
=E2=80=98__this_cpu_generic_read_nopreempt=E2=80=99
  138 |   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:320:31: note: in expansion of macro
=E2=80=98this_cpu_generic_read=E2=80=99
  320 | #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
      |                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:321:23: note: in expansion of macro
=E2=80=98this_cpu_read_1=E2=80=99
  321 |  case 1: pscr_ret__ =3D stem##1(variable); break;   \
      |                       ^~~~
./include/linux/percpu-defs.h:507:29: note: in expansion of macro
=E2=80=98__pcpu_size_call_return=E2=80=99
  507 | #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_,=
 pcp)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lockdep.h:565:9: note: in expansion of macro =E2=80=98this_=
cpu_read=E2=80=99
  565 |         this_cpu_read(hardirqs_enabled)));  \
      |         ^~~~~~~~~~~~~
./include/linux/seqlock.h:285:2: note: in expansion of macro
=E2=80=98lockdep_assert_preemption_disabled=E2=80=99
  285 |  lockdep_assert_preemption_disabled();
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/sparc/include/asm/percpu_64.h:19:25: note: each undeclared
identifier is reported only once for each function it appears in
   19 | #define __my_cpu_offset __local_per_cpu_offset
      |                         ^~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:145:27: note: in definition of macro =E2=80=98W=
ARN_ON_ONCE=E2=80=99
  145 |  int __ret_warn_once =3D !!(condition);   \
      |                           ^~~~~~~~~
././include/linux/compiler_types.h:301:2: note: in expansion of macro
=E2=80=98__compiletime_assert=E2=80=99
  301 |  __compiletime_assert(condition, msg, prefix, suffix)
      |  ^~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:313:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  313 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:2: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   36 |  compiletime_assert(__native_word(t) || sizeof(t) =3D=3D
sizeof(long long), \
      |  ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:21: note: in expansion of macro
=E2=80=98__native_word=E2=80=99
   36 |  compiletime_assert(__native_word(t) || sizeof(t) =3D=3D
sizeof(long long), \
      |                     ^~~~~~~~~~~~~
./include/asm-generic/rwonce.h:49:2: note: in expansion of macro
=E2=80=98compiletime_assert_rwonce_type=E2=80=99
   49 |  compiletime_assert_rwonce_type(x);    \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:10: note: in expansion of macro =E2=80=
=98READ_ONCE=E2=80=99
  119 |  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |          ^~~~~~~~~
./include/linux/percpu-defs.h:231:2: note: in expansion of macro =E2=80=98R=
ELOC_HIDE=E2=80=99
  231 |  RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
      |  ^~~~~~~~~~
./include/asm-generic/percpu.h:44:31: note: in expansion of macro
=E2=80=98SHIFT_PERCPU_PTR=E2=80=99
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset=
)
      |                               ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:44:53: note: in expansion of macro
=E2=80=98__my_cpu_offset=E2=80=99
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset=
)
      |                                                     ^~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:242:2: note: in expansion of macro
=E2=80=98arch_raw_cpu_ptr=E2=80=99
  242 |  arch_raw_cpu_ptr(ptr);      \
      |  ^~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:119:21: note: in expansion of macro =E2=80=
=98raw_cpu_ptr=E2=80=99
  119 |  __ret =3D READ_ONCE(*raw_cpu_ptr(&(pcp)));   \
      |                     ^~~~~~~~~~~
./include/asm-generic/percpu.h:138:11: note: in expansion of macro
=E2=80=98__this_cpu_generic_read_nopreempt=E2=80=99
  138 |   __ret =3D __this_cpu_generic_read_nopreempt(pcp);  \
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/percpu.h:320:31: note: in expansion of macro
=E2=80=98this_cpu_generic_read=E2=80=99
  320 | #define this_cpu_read_1(pcp)  this_cpu_generic_read(pcp)
      |                               ^~~~~~~~~~~~~~~~~~~~~
./include/linux/percpu-defs.h:321:23: note: in expansion of macro
=E2=80=98this_cpu_read_1=E2=80=99
  321 |  case 1: pscr_ret__ =3D stem##1(variable); break;   \
      |                       ^~~~
./include/linux/percpu-defs.h:507:29: note: in expansion of macro
=E2=80=98__pcpu_size_call_return=E2=80=99
  507 | #define this_cpu_read(pcp)  __pcpu_size_call_return(this_cpu_read_,=
 pcp)
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/lockdep.h:565:9: note: in expansion of macro =E2=80=98this_=
cpu_read=E2=80=99
  565 |         this_cpu_read(hardirqs_enabled)));  \
      |         ^~~~~~~~~~~~~
./include/linux/seqlock.h:285:2: note: in expansion of macro
=E2=80=98lockdep_assert_preemption_disabled=E2=80=99
  285 |  lockdep_assert_preemption_disabled();
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:281:
arch/sparc/vdso/vclock_gettime.o] Error 1
make[1]: *** [scripts/Makefile.build:497: arch/sparc/vdso] Error 2
make: *** [Makefile:1757: arch/sparc] Error 2


PS: previously reported build error with v5.8 (
https://lkml.org/lkml/2020/8/3/222 ) is fixed with
48017e5481ce85ba52c4cff082cad5f021c4b413
