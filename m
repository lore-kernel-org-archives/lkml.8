Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C4D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgDUHf0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:35:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:35:25 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MCsgS-1jZYra1yoS-008v6w for <linux-kernel@vger.kernel.org>; Tue, 21 Apr
 2020 09:35:22 +0200
Received: by mail-qk1-f169.google.com with SMTP id n143so6796329qkn.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:35:22 -0700 (PDT)
X-Gm-Message-State: AGi0PuYxdGFY2R0ngs7RwAR8quS3ROqOkpoWYvkCWAv8AMcVW924uOzT
        XjF4JPYS4nt3YyQPlDt5KZjFR/xaqqeqxSetkQQ=
X-Google-Smtp-Source: APiQypKjNuE0ov8Q5Kh3Qj5sUqm6RehBU38JdwRRhHvt/JhsbR78RtqaPmzF8wumGWq33NI4eFIPzDfFc/G5Q1axl8w=
X-Received: by 2002:a37:a046:: with SMTP id j67mr20340914qke.286.1587454521357;
 Tue, 21 Apr 2020 00:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587401492.git.christophe.leroy@c-s.fr> <CAK8P3a11t=piuDq+TuGMo0xDiN06OLMxsym0PGiWNv5qYSUXLQ@mail.gmail.com>
 <268ff4cf-2f30-fead-fef5-e8e5f8f17aba@c-s.fr>
In-Reply-To: <268ff4cf-2f30-fead-fef5-e8e5f8f17aba@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Apr 2020 09:35:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3iHf3TAZtiBH4L23LqyfVUmTpKk339Wtv+d1FcuYRD6A@mail.gmail.com>
Message-ID: <CAK8P3a3iHf3TAZtiBH4L23LqyfVUmTpKk339Wtv+d1FcuYRD6A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] powerpc: switch VDSO to C implementation
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:+NXhwR+g6f2LBoPf63M8lAvdF1EK0T/j+rUyUO+vAgUe8HF9DuL
 1pyoeIwILXYvijpjro/h2ihvAFZx0Pz0GGeCXV3Ih8FLNE6/3A24tryfvOBfPDaplliwve5
 Ptj+7XdEAqMEhZ5HXvu1Mm3quRIoKcriTwfG0t/CSIea+fZ7a22OzuvbcXugaG9UqXYkmhm
 oZ59ipJ+lFjZJ4ucAwBqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWQn3M4F/qo=:9mciG5WrnPf7Bc0IA6ccts
 5e4bs3lh4+pqO96T2FOEhbwK4iPNJDp5ZZS6aL5QCLmBAAx+dGAytb3JwTpsZhyQKqFC9dTrD
 13KI8mcdUGbsLhu+napFnwCRto7N2RbaBCh2aeqNEWuTwg3LLi8LXbo2WnwRfCNfAsAk8ovSM
 C6m360Qg6+53l0+gA1BsMyZI00wzPklBIybI04h85rEWi9n2rl2L7aua/Bp5l+1mQgRghqQEh
 GXbJ2oNr+LKduP2ikqIwebeUKwe5BHQUyROVgQVSEoPwXTg9HUUxuSidsMV7FoVb3IEWYEWYA
 nNUqOJXPMvOC+2D4ZDboEcMG93axhegIUZ40RTaL3uwXBY4lWplqVJPZjlL1kckQD1A3YOkFv
 OmnAxpLSg74UTyDLnpPGeptOMmCkMBs1M1j24ke6gi7xo7vcc9MIeP6bS0A1jES+y3Odypv61
 BFongLcZbI3cbwWvcDvjNcqz47oWwzuKzRN+5hvqHBmSPep4vwTNpYRGh4q/dJwV49K8kK2MM
 UjoLU5lipIWyvKKbhCU7tlaUluQqZulD6uF3boc8xeeIZyI+IX2itG3BbDJVIUNM1UFTVdT5y
 uJhStMP+I1YdfJ+nhlv9bxWpQCYlFqNCmF+ZqygYH9VtICdubY4FjSvY26WR0duEU4LJJ0+Hu
 rUHDCvbyGU84CvDhH8nfSdwgLPTHAaynxzwj6WvbktqsIcpKYZQBuzS4sVaFLGdzLcowjBLLo
 0urIiNi+e0t0i/Yc14PxPncNgdH31BadTAhWM02M7Q6mQtnyRESkrg+8X0WcFtxlNSXJ8PQ26
 j8olqCmFGb7FczGfxr235PDvMG9VbYjUWJVfW5dQWmJ3M87YLY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 8:56 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 20/04/2020 à 21:57, Arnd Bergmann a écrit :
>
> Yes that was one of the objective, be able to add that as a second step.
> First objective was adding the missing clocks and increasing
> maintainability.
>
> I can add a patch for that now, it looks easy, but how do I test it ?
> vdsotest from Nathan doesn't seem to test that.

I wasn't aware of vdsotest, but I suppose it should be fixed in there
as well. It's only one extra call that is supposed to be available on
all 32-bit architectures.

The other thing to try is musl libc 1.2, or any distro based on it.
https://distfiles.adelielinux.org/adelie/1.0/iso/rc1/ has a ppc32
image file.

I think this is all you should need to do to enable vdso in musl:

--- a/arch/powerpc/syscall_arch.h
+++ b/arch/powerpc/syscall_arch.h
@@ -92,3 +92,9 @@ static inline long __syscall6(long n, long a, long
b, long c, long d, long e, lo

 #define SO_RCVTIMEO_OLD  18
 #define SO_SNDTIMEO_OLD  19
+
+#define VDSO_USEFUL
+#define VDSO_CGT32_SYM "__vdso_clock_gettime"
+#define VDSO_CGT32_VER "LINUX_2.6"
+#define VDSO_CGT_SYM "__vdso_clock_gettime64"
+#define VDSO_CGT_VER "LINUX_2.6"

At the moment, the vdso is just disabled for powerpc because there is no
__vdso_clock_gettime64 definition in the kernel.

> > Without it, any 32-bit user space has to go through the system call
> > for time()/getttimeofday()/clock_gettime() when built with a
> > modern libc.
> >
>
> How modern ? I have glibc 2.28, the only symbols it seems to know are
> (extracted with 'strings') :
>
> __vdso_clock_gettime
> __vdso_time
> __vdso_get_tbfreq
> __vdso_getcpu
> __vdso_clock_getres
> __vdso_sigtramp32
> __vdso_sigtramp_rt32
> __vdso_gettimeofday

Mainline glibc still doesn't have it, I don't know when it will,
presumably either
the coming 2.32 release, or 2.33. There is a tree at
https://github.com/lmajewski/y2038_glibc/commits/y2038_edge that has the
necessary changes, and it is slowly getting merged upstream.

       Arnd
