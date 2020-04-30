Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD6C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA91E2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD3NmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:42:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD3NmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:42:15 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M8QBa-1jYXAL3BjM-004RtD for <linux-kernel@vger.kernel.org>; Thu, 30 Apr
 2020 15:42:13 +0200
Received: by mail-qt1-f182.google.com with SMTP id g16so964559qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:42:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuYOazZijcSuAhUbg/nw6Zu6/4yHyut7ZAhVjN5Sms2riC/WSo6/
        VMVoIYN442WT05ymysHBKrZbYmabTPL48pq7v2o=
X-Google-Smtp-Source: APiQypKtOO/ZfauUGm+ABkeiz7iJLlhr2au83fGJcXOOthpqGp50UcYm+bt8hGjwRBrguqh9OoLzr5D8YrZvkcucUHM=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr3674578qtv.142.1588254132622;
 Thu, 30 Apr 2020 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble> <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble> <20200429232835.yw6ajtjyleob3lmz@treble>
In-Reply-To: <20200429232835.yw6ajtjyleob3lmz@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Apr 2020 15:41:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
Message-ID: <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dMv4inXN9XoUiO2bqFVUf3yRKL48G2gaNh/Yg/4rI6vQhrZ4nV5
 CZ1qpXzRKP7yQVPXXZL1MHXFFzTb0BiUC4GEyNkTyBec6T2ipqGoLY6RuW39rIrEopcIFwV
 b9J89cTkHF+BLl6690FD7kgTC/H6uiA8LPUPvze0WOxJoE++mcpOTEQEGJ1kcxCMoXohJM9
 /rjYF5+JwtDkKDC+CbMeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zc0HBRAFlEU=:QXTxxifnC/t0/v/sdsGsMn
 Z5bpMVwovf4ZmJ8zgU0vPJw6jdwq4RRtfHQYr+S+uS4Eta/JOtINds3dkT0G5KB979jkuqQS0
 o0mWo/Aawl/XHmQNUN5RvhYd52Qce6GURgr8zUAlw7PjFJ+WG6IIeBDz5erSZKKFXv00HKLAf
 TdEBZsIH618JkBVN1ZhZAyLrwZgacDueTwQ49BwYxUFGi1NzumAiFA/rjvWXMQwYtfzMT/srd
 ZEhtrbZZc3pLbT7fKJSuz3ccFHhJKqqB9EDCkSn81g9p7zGMNuDZpxB50CV8SjBy3vjGzgPTf
 6X4fwkyLYhCnL3ugiP7ZT1ozgLon2DehEQLbAxxt6DF2fMeoxH/s5z9niA6slbN4mpWn9Zdtm
 HjIplyFyNdPyq17LYva+9Ky9s2Sf9tJZ3rw2F+W7QKD2rHJZnP/RMR7bftR5Kybdnnl8U8xIv
 57kwXzLSyUktvq9MZlmPPvh5gqis32v/erzdn8wD+Lrkxr7bkmg6/LdyTfeqlufbhL05TRLoJ
 o+kJYLbvX7LmwSL/DGnGIDSD8dAj5HRDwWbURMg8kRp62FnvD/94e7s0nskKCOIL+8vtBtJII
 WkmwPjKFT8a97NuFc2hAlhu1U1upXqEQFurkeMnDP1uEp6BnMWafIW8PoVregM+Eu6SSlNMI1
 COgLihIBuqFu6FwDgJ9ByymVIjg8KAvR/m1/7+c+VkLUsXyOGuoiSCbD2Utjo/fqo+opSNy9F
 pa0hvBtsczolsKeC+zmLOMICnvA5u0bLNjmosX1BO3JrcGymModffUjoSvvvP/8sxblsyCWtT
 TjrtEO9Wb16n0pQD+jI/AZiVexJZEclxZRs/5VVEVeewAgHLaM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 1:28 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Apr 29, 2020 at 06:11:15PM -0500, Josh Poimboeuf wrote:
> > > We can probably move those SYS_NI() instances to kernel/sys_ni.c,
> > > which does not include the header, but it's still a bit ugly. I'll try
> > > that tomorrow
> > > unless you come up with a better suggestion first.
> >
> > Oh I guess arm32 doesn't have SYS_NI defined.  All this syscall aliasing
> > stuff is a total mystery to me.
>
> Another idea would be to split up syscalls.h into two files: one for
> SYSCALL_* macros and one for sys_*() function prototypes.  It sounds
> like the latter aren't needed by most header files anyway.
>
>  * Please note that these prototypes here are only provided for information
>  * purposes, for static analysis, and for linking from the syscall table.
>  * These functions should not be called elsewhere from kernel code.

To me the main purpose of the header is to ensure the calling conventions
are sane, so I'd definitely want to see the declarations included whenever
a syscall is defined. I would also expect to see a warnig from sparse, or
from gcc with "make W=1" when an extern function is defined with no
prior declaration.

How hard would it be to change objtool instead of changing the sources?

      Arnd
