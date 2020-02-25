Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CAC35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C40D2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJBKheyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgBYUw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:52:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34526 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBYUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:52:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id f2so1380938pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAoYW3jtAWCjdGaJXCm1P0l2hukH5ekAbYDVhrn3FCI=;
        b=kJBKheySLFt0Q1njT7UpJ8+EDt27CVBBJHrvJ0UtSvuHFxIIjGi22GqBUgpH2nAHdI
         JY5jrCDf3PIG9COk+pwYByEiwkOKxIApV/ovtrc9wrCaKya9UoDMEVp3Rz9kOWYFJgZ6
         LFrubn4k0J3ci67mSNf1jdg3j0c2vRI3NMo0hVWrLh5JRtR2Ea45SlATQTxbUKChv5wX
         4xOYXRcY5SQJ59KF+n2sYezpKSTZ/7kWy6dPhVgzAu1h6Pl5XBxt8qUPbxgM379BZ/Oa
         /iM37C2zdp+gP8bAXtXgNbQc3SdKilus0OLnBjt0xT5I3zkOQcbj5sMbfKPzqlA7Sd0v
         mZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAoYW3jtAWCjdGaJXCm1P0l2hukH5ekAbYDVhrn3FCI=;
        b=FvdzY2B+Nd9iRLuzCQ/8w4omL7Gffq4ZgaNgVJM+yTtg1Dal7omLjWXsuFjyjwfvpY
         anTktUe+KnX0PeDe7870j7zVqAyvq4LiDmaxVMYXRV2K7Her+vPd9fZoSGWqNSGmMHWA
         v0c2L7uoDp8gGbMgfo4vqkvZfqjKf9fWJAvI5qYBRVzrGzKckH3n5WO4s9Mn81+HCX1G
         hbXrRd1C9X1sAZE3uHcOdTGtXeoUbooPYlEcBiPEpfgvV0QBPvc7+B7jNo6DYRc2FB/4
         GyQvY7AYf08jnmn/yL+WSHKdRjb9TBJRdx3J/4h1FovwVBEOOdb/h4MrT2JzY+eZL3pO
         0Gkg==
X-Gm-Message-State: APjAAAVE7hfkabuz0f3DB8d+tmuGm1vI+xHGqsfcUwIysDnFuoCHubXX
        6Iu0DV0mLoQYX3stAwwq8wrbzaz0b07hl6aZQ3i/BA==
X-Google-Smtp-Source: APXvYqwmB04vyduuyJu/HEN0PY3Yi4sOxYmfQoRVMJPmSpkr6VIiN9TCWrQH4VKDHGWrnSeq/vTIXr42Ie5xms8bARw=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr353457plo.179.1582663947479;
 Tue, 25 Feb 2020 12:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20200224174129.2664-1-ndesaulniers@google.com> <CAK7LNASNsOmyqFWYtJHB4UcHAed5C_isWvMJ4MKHu0O=yUy=8w@mail.gmail.com>
In-Reply-To: <CAK7LNASNsOmyqFWYtJHB4UcHAed5C_isWvMJ4MKHu0O=yUy=8w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 12:52:16 -0800
Message-ID: <CAKwvOd=mPg79CrYnDm8=z0iJpKL0FHm9J5qZF0_A6BFXBv8Dow@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: add documentation on building w/ Clang/LLVM
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 4:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Feb 25, 2020 at 2:41 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Added to kbuild documentation. Provides more official info on building
> > kernels with Clang and LLVM than our wiki.
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
>
>
> Perhaps, is it better to explicitly add it to MAINTAINERS?
>
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4118,6 +4118,7 @@ W:        https://clangbuiltlinux.github.io/
>  B:     https://github.com/ClangBuiltLinux/linux/issues
>  C:     irc://chat.freenode.net/clangbuiltlinux
>  S:     Supported
> +F:     Documentation/kbuild/llvm.rst
>  K:     \b(?i:clang|llvm)\b

I'm happy to leave it to the maintainers of Documentation/.  Otherwise
we have a file for which there is no MAINTAINER, which seems
ambiguous.

-- 
Thanks,
~Nick Desaulniers
