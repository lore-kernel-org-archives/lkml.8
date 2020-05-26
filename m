Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A822073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbgEZKmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:42:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731890AbgEZKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:42:36 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MI5YH-1jqPLa2G4F-00FFWC for <linux-kernel@vger.kernel.org>; Tue, 26 May
 2020 12:42:33 +0200
Received: by mail-qk1-f174.google.com with SMTP id c12so1109009qkk.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:42:33 -0700 (PDT)
X-Gm-Message-State: AOAM530BcTPcJK4EZHiEH4xXJb3tLEanAiVqs4t2UClNnau21RE4l4XO
        8C+kIbp50GK1cGRPrTNrRDTz/DN/8vSN5XXruB8=
X-Google-Smtp-Source: ABdhPJy11O52lrc8B45xvhlfUiKV+MBBXTbNjPreBbZC6xmm0k7o6s62D6b3tmNk4YquZpcrqDfDH+s0z6TBWxtbZ7s=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr562891qkg.394.1590489752379;
 Tue, 26 May 2020 03:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
In-Reply-To: <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 May 2020 12:42:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
Message-ID: <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qvSyjSUpK1f5XtbiEZvYVXI1Fvify93tSqpIAlVVR0TfwL0CZtD
 UBAn0GeLMPUV5uDB1fKvvzI0lokTvOP7SsCNhF27epbX2iMa/Yg5COVRA5gkdYO1X3i8kuI
 Lm2nHmg85G3zUvfg4pPNPENmMEbu2JLRhEadKI5WfrBM11OnFiXG6HkQhOrjVMIapAqQ8OQ
 XznKLxgHaCnGiXVejldHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FeDxH0tE3jk=:Stkw2TzVjATt2TWoUlijoD
 rOGSV0ETBMBr3g+Kokb7DHMLlMPzo7+3vgBZ/An+D+lvseSYmv9fN3yRlBO1PhzrCZRCJTw5K
 sigKiSJPo0qc6pJUAdiajFF3xWPV6Zp68dw3qZcN+DHfwq/vfNvPep13DJzk8D+zAuynqPqGS
 QUdYratgQMWJg7dhmz42CFVUisPGABVCDhN6TDreDX63ZUx0RIdwOfWf+mjTDDK/ZuRmX/DjL
 YbXyN1u68F60VzXv1AIQqQyYFrxHX8LrSHIzOXX83ZbloedLNTUCorANEKVDp2QYoaNBrYZPP
 moyFa44nHTT3+hptHqMUAyyy9+fgcapqXB49jqdADcngsLl2/R/6lt7TWLd/ydV8NZUQT4VRB
 yWgchqnPQj2da3neTGDm5el45TLSpxoLD03WYz4Yu2SDO1QPWKjePEuLQHJzgrfGmuiqJ36/x
 rDHqPEaybNCT/KdLuctVbsHJYP9pnd9RA2ixTwdl6U65OpM/QeCZJ7voVhR5KVyC6X2WiG9wk
 9/K1nfaPmFPvVWEydsT1b7f9e2JgcBBsAwr+R4t3KSD/GJszoS+Wmd4/3w+dvE8QrRFPWAjy8
 j5Feg7TsUxxfPtLQG+Ow+UJXMI93wNPcaVPt+2qxBZrsQKe6JCUoCP3WQEl8300b9RkSoUonS
 tocOjNd9OtLByAqCGgKBt41e1nwgdmtB9Lxl+bysFEnFb/Mv/yduxm/fweAQzZO13eNA3TFy+
 SMvGGVZKR48EY3CoEGFxXRWvw4y6pbY+1HnOisukGPf8V9hnPBOV3XlwatUh9ZLk5j5VlvH6q
 xYsd49q57qvCAfGf0u6pvL3+XCGf3KZMxe7OTMCNUfz3IlAraM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:21 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, May 21, 2020 at 7:22 AM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > It appears that compilers have trouble with nested statement
> > expressions. Therefore remove one level of statement expression nesting
> > from the data_race() macro. This will help us avoid potential problems
> > in future as its usage increases.
> >
> > Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Thanks Marco, I can confirm this series fixes the significant build
> time regressions.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>
> More measurements in: https://github.com/ClangBuiltLinux/linux/issues/1032
>
> Might want:
> Reported-by: Borislav Petkov <bp@suse.de>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> too.

I find this patch only solves half the problem: it's much faster than
without the
patch, but still much slower than the current mainline version. As far as I'm
concerned, I think the build speed regression compared to mainline is not yet
acceptable, and we should try harder.

I have not looked too deeply at it yet, but this is what I found from looking
at a file in a randconfig build:

Configuration: see https://pastebin.com/raw/R9erCwNj

== Current linux-next ==
with "data_race: Avoid nested statement expression"
and "compiler.h: Remove data_race() and unnecessary checks from
{READ,WRITE}_ONCE()"

$ touch fs/ocfs2/journal.c ; cp
../arch/x86/configs/0xFFA843AA_defconfig obj-x86/.config ; perf stat
make olddefconfig O=obj-x86/ CC=clang-11 fs/ocfs2/journal.i ARCH=x86
-skj30 ; wc obj-x86/fs/ocfs2/journal.i
  48741  552950 9010050 obj-x86/fs/ocfs2/journal.i
real 0m12.514s
user 0m10.270s
sys 0m2.668s

== Same tree, without those two ==

$ touch fs/ocfs2/journal.c cp ../arch/x86/configs/0xFFA843AA_defconfig
obj-x86/.config ; time make olddefconfig O=obj-x86/ CC=clang-11
fs/ocfs2/journal.i ARCH=x86 -skj30 ; wc obj-x86/fs/ocfs2/journal.i
real 1m35.968s
user 1m33.579s
sys 0m3.523s
   48741  1926607 36542560 obj-x86/fs/ocfs2/journal.i

== Mainline Linux ==

$ touch fs/ocfs2/journal.c ; cp
../arch/x86/configs/0xFFA843AA_defconfig obj-x86/.config ; time make
olddefconfig O=obj-x86/ CC=clang-11 fs/ocfs2/journal.i ARCH=x86 -skj30
; wc obj-x86/fs/ocfs2/journal.i

real 0m6.529s
user 0m4.389s
sys 0m2.561s
  47377  377887 4178633 obj-x86/fs/ocfs2/journal.i

So both the size of the preprocessed file and the time to preprocess it are
still twice as bad for linux-next compared to mainline. Actually compiling the
preprocessed filed is very quick, as I guess only the preprocessing seems to
use all the time.

      Arnd
