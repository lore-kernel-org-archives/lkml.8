Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A580C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3408F20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tENOArqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHTOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHTOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:25:40 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF9C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:25:40 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x187so456774vkc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OYWkbG13B5p9B71YKEeVxt5S62yKxQXnYjptV4STu4=;
        b=tENOArqZriSj0SyY82jju1JQD7ZlLOlcNmtXAOzR+qtlshQ6p4BCVVPg3WVJ3muBYC
         iK9HCaf5WLIS9081YUbxKQBZCbRbOZlmHlZPTdhibAOmfVkMoIfGP+l0HHJHDPwCkz1q
         RuXADVa+sdN/aWp+/oeQJa+cnlKobHp1uoYNWOfUuIfeRRhPaP+ZC6zM5Ud2WTJ4UtH+
         0+WRbynFrrt5TEhetu6jTA2m5ZMBsZ2sfWig2k0r64kMw9qv7yxYxGkRJOWl3s0zrHpx
         8wPFRx891uKn8tS5cvgQxeH8TwXRZUIRVi+FefLH2XVatdlesUOOcewVFiJq65UV85RU
         lczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OYWkbG13B5p9B71YKEeVxt5S62yKxQXnYjptV4STu4=;
        b=NDWJyhyCbfjfPSVj8/bzFDtH3/EFWcmyGDb8IkLdAFv9DE2Ht8kf4CpBtozYBksH9z
         KiNPZkva7TBpp1/9KR/2vfl2to1ezYX1FC9BOc+AfJ518+LbtY+Bz7WO50Bhk78WOOu8
         U02yvz3ILh9i1CcdUPz3raTqcXaAhFfDfjzeEh7ty3ZxvFhfkKGdDjg2t6BaS9Kx26CE
         61Gr/Ls7ErCumeWoRGInvWHTgxHJUbvCqR0T0QYlifGN0UxqpVR/wPlo9m4BQuyXD4Nn
         T9nHNGkN+BAqXFMaIERtAcAkqexmlyfszASohysC3MeGmVfndlqxegLnIyCPB15DEwCp
         Uvgg==
X-Gm-Message-State: AOAM5309V4YYvH5UHr/lJGpnyFZY+jZGSlyyMjuR3p1eRfoW/LO3Jbqs
        H1a28iCX1y5t4UXZTPkgNIDVvNL9HAeiLatHdL3hG6cWIGhSgtfz
X-Google-Smtp-Source: ABdhPJz2+AIu1zzIfsjB9I4kqNiuF3H/LlEazpHT6QKXveRnbynSD+Dc2PPJ4ij4LYccu9AgNcyrU98VR80CkB7lmhM=
X-Received: by 2002:a1f:eecb:: with SMTP id m194mr1672157vkh.40.1597933537447;
 Thu, 20 Aug 2020 07:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200820092125.688850368@linuxfoundation.org> <CA+G9fYsxQEnACmjP+CUtBq9P+0nWU_19oG62tpCbKtdcGAStfA@mail.gmail.com>
In-Reply-To: <CA+G9fYsxQEnACmjP+CUtBq9P+0nWU_19oG62tpCbKtdcGAStfA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 19:55:26 +0530
Message-ID: <CA+G9fYsavGNPSKyTutADC1itOV4C-3JbidWTJmAJBv0e3rs-Tw@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/149] 4.4.233-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 19:49, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 20 Aug 2020 at 15:47, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.4.233 release.
> > There are 149 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 22 Aug 2020 09:21:01 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.233-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> i386 build failed on stable-rc 4.4 branch

The defconfig build pass but the config i am using is breaking.
kernel config link,
https://builds.tuxbuild.com/xuCFzjgiR3X6wY9KGKQKwA/kernel.config

>
> make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=i386 HOSTCC=gcc
> CC="sccache gcc" O=build
> #
> In file included from ../samples/seccomp/bpf-direct.c:19:
> /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
> file or directory
>     5 | #include <asm/types.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> In file included from /usr/include/linux/filter.h:10,
>                  from ../samples/seccomp/bpf-fancy.c:12:
> /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
> file or directory
>     5 | #include <asm/types.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-direct.o] Error 1
> make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-fancy.o] Error 1
> In file included from /usr/include/bits/errno.h:26,
>                  from /usr/include/errno.h:28,
>                  from ../samples/seccomp/dropper.c:17:
> /usr/include/linux/errno.h:1:10: fatal error: asm/errno.h: No such
> file or directory
>     1 | #include <asm/errno.h>
>       |          ^~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.host:108: samples/seccomp/dropper.o] Error 1
> In file included from ../samples/seccomp/bpf-helper.c:16:
> ../samples/seccomp/bpf-helper.h:17:10: fatal error: asm/bitsperlong.h:
> No such file or directory
>    17 | #include <asm/bitsperlong.h> /* for __BITS_PER_LONG */
>       |          ^~~~~~~~~~~~~~~~~~~
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
