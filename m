Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4374C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D92D20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycvUl+MI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHTOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHTOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:19:19 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4841C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:19:19 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j188so1156118vsd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnDxdkuxYRmNtyk7Y2huayEumQNpEwRvmtnxfMXB4XU=;
        b=ycvUl+MIZkhh4i8WXE15mw8LqxN3ey4UI3XKE1PFm+ioTX5Rxxs+bUZCMNTmMhB6Yo
         +OyB4iENr/YC0+7OkuV1mdJL8vkMNBAuYS27Zb3CMuhpLDUtztBi07B3oHaHAAlw4LAv
         faPtW4aLGLuDBfUflYkU+HQlompO0tg0AGLkCj0AP+bAJWs6tRSMjaGkrHq6OOY/tncy
         BNxP1x+p0RKupWOa0A5i7DKeLHY/+GX8xnh1UGwsFhZhQTAlqI3i365iYGvFMCzQg+qs
         gPqFOssA/diIZdAwWejMobS56aGInUxXfr6vX3f3NjBZwZJZzMUPveJu32uGeqOAQu6l
         +1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnDxdkuxYRmNtyk7Y2huayEumQNpEwRvmtnxfMXB4XU=;
        b=DuajESu/taELGYNm136xTXcoFQS8cem7fzh1hLaqEbfWczfoBORBnowED/gIkpllZ6
         nC3cRrUvrIsYirsOoinV4DLducmejUkg4JfJkuvkELsz9K8RaBPK8y/BBhaIxSbIb9Y6
         Ra+nkrckMnemq9GCKCfS/PB5oAdZYc15OniSInrjcclfGUxvwg8p8Ku3auab3ZN6HJJJ
         fv7jC8c6dj6z8gR0lTUJtcWWemoBNZSDSJsuRDOCzgUm6wSWABo1VS03B1BzFow8fOy5
         v35atilz6Ka+iqzqhhTwqXU0/QbMuR3nnRJcX9fAW6ZhyNhVOwCrUlCW5Xc44LN+m7Lb
         arNw==
X-Gm-Message-State: AOAM5322DrV+UmoF3yQyQlpt6KveIxLYVE/5bmCoh6wANdPaXzoNCs8r
        dBIzfhZBp/lCY7YZe8/Jrr7CVon5wkhR0LRE67pqMg==
X-Google-Smtp-Source: ABdhPJwuYHKqDHqKwLv8/8PxuHVAGY/r1uoCFi8obd0CL6NZntClddlPGruInNtIRyyIkgjWiazXUfLgaWFjk+pxu8Y=
X-Received: by 2002:a67:6996:: with SMTP id e144mr2120745vsc.185.1597933157760;
 Thu, 20 Aug 2020 07:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200820092125.688850368@linuxfoundation.org>
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Aug 2020 19:49:06 +0530
Message-ID: <CA+G9fYsxQEnACmjP+CUtBq9P+0nWU_19oG62tpCbKtdcGAStfA@mail.gmail.com>
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

On Thu, 20 Aug 2020 at 15:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.233 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2020 09:21:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.233-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

i386 build failed on stable-rc 4.4 branch

make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=i386 HOSTCC=gcc
CC="sccache gcc" O=build
#
In file included from ../samples/seccomp/bpf-direct.c:19:
/usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
file or directory
    5 | #include <asm/types.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
In file included from /usr/include/linux/filter.h:10,
                 from ../samples/seccomp/bpf-fancy.c:12:
/usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such
file or directory
    5 | #include <asm/types.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-direct.o] Error 1
make[3]: *** [scripts/Makefile.host:108: samples/seccomp/bpf-fancy.o] Error 1
In file included from /usr/include/bits/errno.h:26,
                 from /usr/include/errno.h:28,
                 from ../samples/seccomp/dropper.c:17:
/usr/include/linux/errno.h:1:10: fatal error: asm/errno.h: No such
file or directory
    1 | #include <asm/errno.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.host:108: samples/seccomp/dropper.o] Error 1
In file included from ../samples/seccomp/bpf-helper.c:16:
../samples/seccomp/bpf-helper.h:17:10: fatal error: asm/bitsperlong.h:
No such file or directory
   17 | #include <asm/bitsperlong.h> /* for __BITS_PER_LONG */
      |          ^~~~~~~~~~~~~~~~~~~


-- 
Linaro LKFT
https://lkft.linaro.org
