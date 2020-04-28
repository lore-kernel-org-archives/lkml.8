Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCCDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22398206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgD1Otg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:49:36 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgD1Otf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:49:35 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MAxLT-1jIlMa1wHh-00BIxw for <linux-kernel@vger.kernel.org>; Tue, 28 Apr
 2020 16:49:33 +0200
Received: by mail-lf1-f49.google.com with SMTP id l11so17140785lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:49:33 -0700 (PDT)
X-Gm-Message-State: AGi0PubepukpLjKJFCSyfJ563YSPYd7H8rRgVWmWkzjb58eexCUTPCRY
        9KtD5uEkrc5Zha1tZQYlF60Qc9B4XpIwymPmBqY=
X-Google-Smtp-Source: APiQypIgn/QnLQwwzv7K+EAOxxIYujQot/0Ahzey/nbfu4xUbJGAphNWjW9wOhBQ9sygb9FZ/D5ga4QVIdAT7/Icn5g=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr19644722lfl.125.1588085372765;
 Tue, 28 Apr 2020 07:49:32 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Apr 2020 16:49:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
Message-ID: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
Subject: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nYMxGuIre/Wd8c/2NBLGKpZuVT+GzEVFc93a0m6I7HNaGHA3czI
 xszTIYFCQ+4UyzNwsjRngR1OgCS+uJ+SbUnEzWPOgO4fF840+LSzq/kmfRhtaWTltdmQEIv
 /yYoBys2zs704mWFXXAnhiVP4AESWMej2LcBXoy2VktqT5dZOoiLOrCkCbp/mFbEHJG8G0B
 +PSr8lQ6bvMRojA6raurw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rF1lpXrjtDI=:w8b0vWpAyEEzNnTNleLykq
 0VioRhnZl22WZIax/VEGD2P29va9C48U20OkUOa1Cm2aoRD3W28bppUjJXshxBp9SBWtHKDcK
 jq/XQ6K1imje/gAAu9uSItlimcc8ChB4uTxbrdq6CwdlYZQ40SdiAZE8eksdHF/hDmehf+uOb
 OqsYW6OdF6YtH7lE0GiKzDKoWt2mo+Fh8ii+dquSqBoZ2pmij6nnecquZvjRxLWgbAOOLx+vZ
 z8oXefhUJTUJVLyKS/d464ctyuNl1W5l8jIf/pUJvlHrYYLkbVyAobEqZFve3S5kvvGAumuyA
 jEKJrb3rsTd6rkpPg7nCnfl82PJ51mnWgQ+rQ7PZT9A1B1MtPeuFdFdaIYFYrR8QMvNCax6Vr
 Ocb0UnnHDeGjQWVc4+//10oU62++F9lOY2Dl0BWpemQO9oYC9TQs0LxUyViJBL/YU+VRjv6c7
 SdXa2d+zxhwIc36UknfNZtR6inI8fUhuxLtAK7ktJnfOQspdsojQA3cCvM8Oqa3uvvbQw3UCm
 M8RtWyjYekh3SVCykPtFdytVJymqrSdqZ+u9xYJWA1kZG2o6BwotCJOMNRGjqsENfccNWwQET
 pON+3cbP5EG5cVQcm5XPJ6mORyqC17UraW2Ai3XHbamf49HAS0DWoOQmo677YEFd37zcKFK/6
 pg5EBMzrHCbRz4EZRHq9Eb9qm22468bbyPvNnPj7i9LWjDTljUSqEJOlitc3AQkHQWT+lo1B1
 EcF7B46dXLWoqPdI6UzhuYUE4utGiXoIRNyTMuZ+Gc5wMoYcEuB1oWEVyUGthXpVL2GRsbpqa
 2tfb0LDLrZXcjke5L7uygCXC+MyJ8V8Gg8KletQvyZZNSixK8U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the number of objtool warnings in randconfig kernels have gone down
 recently, maybe it's possible to eliminate the remaining ones?

Here are the ones I ran into recently, using gcc-9.3:

==> build/x86/0x3D2B5D6D_defconfig/log <==
arch/x86/kvm/vmx/vmx.o: warning: objtool:
vmx_handle_exit_irqoff()+0x24: unreachable instruction

==> build/x86/0xE0F2ACFF_defconfig/log <==
kernel/time/posix-stubs.o: warning: objtool:
__x64_sys_timer_create()+0x23: sibling call from callable instruction
with modified stack frame

==> build/x86/0xFD7B7323_defconfig/log <==
arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x991:
unreachable instruction

==> build/x86/0x2EA4CE4F_defconfig/log <==
kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to
check_kcov_mode() with UACCESS enabled
kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call
to check_kcov_mode() with UACCESS enabled

==> build/x86/0x500B1B82_defconfig/log <==
kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x1269: call
without frame pointer save/setup

==> build/x86/0x7942F24A_defconfig/log <==
samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0:
unreachable instruction
samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0:
unreachable instruction
samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0:
unreachable instruction

I've uploaded the .config and .o files for each one to
https://drive.google.com/open?id=0B_XQwQ5KlfJAbUtrTVJaRmJIZUk
Let me know if you need any additional information.

Note that I used a modified linux-next tree (including many build
fixes) for creating
these, some of them may not actually happen with mainline or unpatched
linux-next
kernels.

        Arnd
