Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECE220870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD3VAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:00:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3VAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:00:03 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXop2-1jgMhB3zRM-00Y7WU for <linux-kernel@vger.kernel.org>; Thu, 30 Apr
 2020 23:00:02 +0200
Received: by mail-qt1-f174.google.com with SMTP id w29so6343999qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:00:01 -0700 (PDT)
X-Gm-Message-State: AGi0PubQb41EYCOfFE5fQc9dJeUZ6RoDrDIcTqPzU0DcMYlIx5yI53HO
        dsm6r5TK1usxcVo4wamBLcKWi9wRM3G9eGxx5DY=
X-Google-Smtp-Source: APiQypKmtHGtD1tKNxNdN3qG8SXaY9CsFLu0gLsyCuiF7fJOJ+iQ0mrJupaeBcmHvlzcMCkV1Ol5vIvIJQSJ2catxNQ=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr483791qtn.18.1588280400860;
 Thu, 30 Apr 2020 14:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble> <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble> <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
 <20200430143350.qezebqmx2xwdxqxq@treble> <20200430194630.jkwysx6eftkaf6bu@treble>
In-Reply-To: <20200430194630.jkwysx6eftkaf6bu@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Apr 2020 22:59:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3rPDzv4PfOArvkQ6=6b+rWX=ppnJjUaVCWMgF9dntWsA@mail.gmail.com>
Message-ID: <CAK8P3a3rPDzv4PfOArvkQ6=6b+rWX=ppnJjUaVCWMgF9dntWsA@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hzjXtPBsY2hOz1lQEuSTS0/praVnnlXY5Se9BujJ0xNOVAHNtKO
 LuW6CE9DnG/jmcXAl5/N5AYZ8vMcbJcIyvFMEEqO8cO9cmBOtNd7/xHZJ/slMgvTmhKkbDW
 dvGzFFfWM276U+E2wNcko83ZdOqmIU5Q9qroZiLHo6UyXoqI8x7KF7/LD3m4jBwIVW8xy6L
 u6DG7VQynuQVPFLCF+4JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWYXMygvva4=:CmPHy3ktG5t+pgBXGXyXIf
 AFwpIpm8WqgMJ0IUrHN3USaibGOXjJD5Ic3uZeHtQ7/o8Cc4wkYBF/Z5LX7juOkgH/ApP0b4v
 2OIlpyNXqjRyodBVq0YT7uGzAP9JjlTzMU73YrJeAn2yZ/gYsiQTe0Y0l6eOCHrKbn7pkzCIi
 jNohNJxdZqPoqJOxYvwzM33e0YCVvAhSebifmuwhU5XrrdqjHKOPZStfDpvU7xN0rlpz6r7zi
 Ttmj7eqoQ5KLWs4y4XCWzwlNoNBueJZWIJgsXB8Y9vbMUV36F9P+9tQqk5s42R739DOwcXgKj
 Xs0y1qyARGaFQc970nI6zlAnI8191NBfvI/1d4DOpwhoqhpYjxBRCe0ADk4r88RARbZ3lpc4N
 7bGlOPLz988dRSxKniEIrey/cHaXC/E/6rPyETwLNxdJ+WbIEASspnE4Dr/H60+lBwSy1tj5R
 A9A7IilSQYml+VqXGSyfnO3j6jUBXfoJC0sMiJwbssvXtGRHaqm6lM3l4PeoEs6ABVRGUUN9O
 A0OGvb1/IoDJ8kCMCIh/OycsA/59aMpduIbJzPKfy1BPFGM2BZZTO5Qt5cdzYPBBr8Azl2167
 PXk5z8K9aLJwpFbU+eis02EHLMaaJE4ey62lBz1K37LwnC+ElhfzCgPbq+UzpHSHbhN+0JOWh
 XNBweENMrIE1lTFVC9PW+f9lPB5hLKappRCtPC1Tr7Rxw9co0PleWNmvoPgYDyfvpd6lBjPbp
 VFwcayxDPTVFOjNOYAjFyJ6Hy8kdmpkPV05BORo85KGBEeLqw4L4XxSMB2STe9jIHljS5pPVy
 +h/wsjA3rXD04kKaSyYRQ/abe9F1ZHQ3QJYd1PObqZx9lva9uM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 9:46 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Apr 30, 2020 at 09:33:50AM -0500, Josh Poimboeuf wrote:

>
> So there's an easy fix below, just define an x86-specific SYSCALL_ALIAS.
> It also requries moving the syscall alias macros to syscalls.h, but
> that's probably where they belong anyway.
>
> But the objtool .cold parent alias function detection is a little
> smelly, so I might end up cleaning that up instead if I can figure out a
> good way to do it.
>
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..abe6e633f8dc 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -79,6 +79,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>                 return __se_##name(__VA_ARGS__);                        \
>         }
>
> +#define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
> +

Right, this should work in principle, though I suspect it needs to be
changed to include the ABI name for x86, as there are separate
entry points for 32 and 64 bit.

      Arnd
