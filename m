Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20BCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92F820885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLkKB0zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHTR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHTR4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:56:45 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:56:45 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z12so825429uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgiutXLHMHYwKl6gTd5bSz260gS5O0hGMgq+KKN2AeU=;
        b=mLkKB0zWmiQ/HoYu35geu0ex5DKDgF5MR2QLSvaMXdIOCBU3XO77arfBR3QdsqWpAO
         c11G+vE5NR6Rj1JFgBcVPwqQ+2Fk4E75v4nXqFe0ja6Ng3DBZfbcgFyxS4XZEtXQBNyn
         g3K9QqvGk517qYl7MbhHMjxjYLXjojO7GMSiud7D8lytywff09DSaXeg2x2Y6OBqaA3T
         gxN5rZorC5LBRnLOJyEnPJLOhgrretXqtBEQpQgFlWpxRly5YNjNVTYx4yK6rVhcLvbq
         z3uAdYrxSa9hLDV64xnfvwSAuJb6OeGfvuklHLEtUzIWJmUdv0eR5Cm4kLnLoPeapGl9
         P+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgiutXLHMHYwKl6gTd5bSz260gS5O0hGMgq+KKN2AeU=;
        b=hWRb5YAhhpJRD2J4NfhChCCR6FZngE2E8+XcfTIv1EJSQYeKQE7ok5Of3cdktHxTyx
         Qj6NwSt447/smYpDN6f/IKQaRcZjeRmVC1+bQtPqUrr/+MG2Ao+2AbyVc4WpTNrakRLU
         MeaumFtiO8OKoHJY+d+UdUwemmmh9QaxOZOfPIukki3T0UqH7qpA86SJcdMFCEBM6JUs
         ciD59/myCkCm7J0ec1W6SQ1zjrWUBgmLqtqBNPpdHL0pNXLovvb6JqGDMOk2niR/+Htf
         Cwkp7H7FEi8LYGc4I/aCXb+MlhVSXPek0BZOLqE6zUxaRVSMwIFPzYrDUlcCaiiGTzNr
         L4Zw==
X-Gm-Message-State: AOAM532eDtuRWrCzNjrqTWSPQ4Gis8lJMH+Vt56dmsjHm6uz0hzW4byh
        W0ObAh3oSznbMZjR+JS2zwD84D2mZ5pUvSXNR5m0yA==
X-Google-Smtp-Source: ABdhPJxsxkZL9YHnt0g1WWraYFoUA0nZDhd4o65VY6m6J2caapOqzm82s1YNFV3bsc62hg0CvoM4M8fClziMIBPQkiM=
X-Received: by 2002:ab0:4029:: with SMTP id h38mr2620594uad.6.1597946202546;
 Thu, 20 Aug 2020 10:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200820092125.688850368@linuxfoundation.org> <CA+G9fYsxQEnACmjP+CUtBq9P+0nWU_19oG62tpCbKtdcGAStfA@mail.gmail.com>
 <20200820150848.GA1565072@kroah.com> <CA+G9fYu9r8wfWVLmyMC+bbnCbJH1Zzr7ps_4N0coybYEUenUaw@mail.gmail.com>
In-Reply-To: <CA+G9fYu9r8wfWVLmyMC+bbnCbJH1Zzr7ps_4N0coybYEUenUaw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 23:26:30 +0530
Message-ID: <CA+G9fYv=aMoHJs2ToyhPyG13qmcN6o26MHW=zKnJwmevyKCo3g@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/149] 4.4.233-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, danieltimlee@gmail.com,
        masahiroy@kernel.org, ivan.khoronzhuk@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 22:09, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 20 Aug 2020 at 20:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 20, 2020 at 07:49:06PM +0530, Naresh Kamboju wrote:
> > > On Thu, 20 Aug 2020 at 15:47, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 4.4.233 release.
> > > > There are 149 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sat, 22 Aug 2020 09:21:01 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.233-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > i386 build failed on stable-rc 4.4 branch
> > >
> > > make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=i386 HOSTCC=gcc
> > > CC="sccache gcc" O=build
> > > #
> > > In file included from ../samples/seccomp/bpf-direct.c:19:
> > > /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
> > > file or directory
> > >     5 | #include <asm/types.h>
> > >       |          ^~~~~~~~~~~~~
> > > compilation terminated.
> > > In file included from /usr/include/linux/filter.h:10,
> > >                  from ../samples/seccomp/bpf-fancy.c:12:
> > > /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
> > > file or directory
> > >     5 | #include <asm/types.h>
> > >       |          ^~~~~~~~~~~~~
> > > compilation terminated.
> > > make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-direct.o] Error 1
> > > make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-fancy.o] Error 1
> > > In file included from /usr/include/bits/errno.h:26,
> > >                  from /usr/include/errno.h:28,
> > >                  from ../samples/seccomp/dropper.c:17:
> > > /usr/include/linux/errno.h:1:10: fatal error: asm/errno.h: No such
> > > file or directory
> > >     1 | #include <asm/errno.h>
> > >       |          ^~~~~~~~~~~~~
> > > compilation terminated.
> > > make[3]: *** [scripts/Makefile.host:108: samples/seccomp/dropper.o] Error 1
> > > In file included from ../samples/seccomp/bpf-helper.c:16:
> > > ../samples/seccomp/bpf-helper.h:17:10: fatal error: asm/bitsperlong.h:
> > > No such file or directory
> > >    17 | #include <asm/bitsperlong.h> /* for __BITS_PER_LONG */
> > >       |          ^~~~~~~~~~~~~~~~~~~
> >
> > Any pointers to the commit that caused this?  I'll place odds on one of
> > the random.h changes :(
> >
>
> This config is causing a build break with gcc-9 on stable-rc 4.4 on i386.
> CONFIG_SAMPLES=y

The reported problem is not related to this stable rc review cycle.

Recently we have started running LTP tracing testing and added
config fragments from selftests/ftrace/config file. From that file

CONFIG_SAMPLES=y
has been enabled and the build broken only on i386 stable rc 4.4.

Sorry for the noise.

- Naresh
