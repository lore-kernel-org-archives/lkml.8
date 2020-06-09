Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3579206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQhJKdpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgFITEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbgFITEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:04:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4EC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:04:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so26471855ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oisCR5eoB1Ano2ALyfEnEvEzT9b386jf3AmXZGXZIkw=;
        b=DQhJKdpJFsY7iu3HpRZeGc7kNCDTnUk1W3NapAIbhdenq8A355MhGK3mvcroRsEyyL
         jY9OeCJgpf0OPfJnpmwELnUv8qwzECwaoAJV0LH3K7c4E7XtznAAhod4w5dyldljU7xr
         +3J/FUWTPLaHG4FBgAlw51sy6hKBn1xDyIrOWQxjsCAbpyK7UmEK3ICmcIi9E+AUX7f0
         zZtu1ZGAeUwFIUWp1N3qHCwui3cGikiQ8jgvKeVyPsB6sHg/i9f19jQVvNtJ+NTd0gll
         qEqZNAXewa/wJfCxr3E8fjJqUsef8bP9XEn/1Et3oayMx9BAxoWj+Rm5MYVWnyQCz1VX
         6awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oisCR5eoB1Ano2ALyfEnEvEzT9b386jf3AmXZGXZIkw=;
        b=HYyQJQnhHsAlNYrDGuHv51oaYbWVP7tGU5ABW1gaTtYGHuS7oCMJsm+L+iS+DbDiju
         c2ABkJfbAa8GrWBxT/Bjbl4lM8O7pe3LBWFGfV9y12gMR+Gkclw5BYr9uDScXz983lh3
         dLED62MlFKLFJyJtsW1bJJaVVUjAPOQVo8893fMsm+DgpSQ8PwUc6PQb7JQ9XelRooJ0
         ygrlGc54TcQD1dZ8lgqT4Igll1H9CNUB6R0f4qFnSPepJh7wDX0sVtB9HbG9zR2D/u2O
         RggjCU/dB7/R/7UP2JSFvH9C8H+ALdJvBeVr2XkTTz9c8rRsqOp4QFsYojfF54vE+7zR
         VMfA==
X-Gm-Message-State: AOAM531Nat+/yZaf32p9nzMxlwzsPwkA1wVb95RBXATXKBCj2VB/0tPe
        k7MeJT4QB+gWom1Fl+j6oeAKLdZ21/sJvnXx5Lio/Q==
X-Google-Smtp-Source: ABdhPJwMCKahEYIT3GU8gUBROjVOiP++BHrFUXwAO0uYkdsFppdCQ+VfAlLUe2FS0a+rq7YPBKXl7JYfN1ZyTUeUJm8=
X-Received: by 2002:a05:651c:318:: with SMTP id a24mr12370124ljp.55.1591729487457;
 Tue, 09 Jun 2020 12:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200609174022.938987501@linuxfoundation.org>
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 00:34:35 +0530
Message-ID: <CA+G9fYt-5RqDpjYn44yfiME7TsH6TO1oY6J1=qBeRvLAUucbNQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/46] 4.14.184-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 23:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.184 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 17:40:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.184-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.14.184-rc1
>
> Oleg Nesterov <oleg@redhat.com>
>     uprobes: ensure that uprobe->offset and ->ref_ctr_offset are properly=
 aligned

stable-rc 4.14 build failure for x86_64, i386 and arm.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dx86 HOSTCC=3Dgcc
CC=3D"sccache gcc" O=3Dbuild

 In file included from ../kernel/events/uprobes.c:25:
 ../kernel/events/uprobes.c: In function =E2=80=98uprobe_register=E2=80=99:
 ../kernel/events/uprobes.c:899:18: error: =E2=80=98ref_ctr_offset=E2=80=99=
 undeclared
(first use in this function); did you mean =E2=80=98per_cpu_offset=E2=80=99=
?
   899 |  if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
       |                  ^~~~~~~~~~~~~~
 ../include/linux/kernel.h:61:30: note: in definition of macro =E2=80=98IS_=
ALIGNED=E2=80=99
    61 | #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
       |                              ^
 ../kernel/events/uprobes.c:899:18: note: each undeclared identifier
is reported only once for each function it appears in
   899 |  if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
       |                  ^~~~~~~~~~~~~~
 ../include/linux/kernel.h:61:30: note: in definition of macro =E2=80=98IS_=
ALIGNED=E2=80=99
    61 | #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
       |                              ^

--
Linaro LKFT
https://lkft.linaro.org
