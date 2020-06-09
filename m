Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3052C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EC52068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3J4DviE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgFITBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgFITBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:01:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF4C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:01:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so26464626ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VAEh4u66db4pSNovW/A8Cvie0VZiNtfT/2/kRKGulxw=;
        b=k3J4DviEwMIak3uXNfFrsxAmxDpoyv2/3smOqdag9qlLXBJ4os4Mi4De2WqPMUd6tf
         oxDQnkVKD3Nj1OMXqZi+0l9jeJfsXxTI6Mmz3L3s5Qx3d2uUJo3dNhK38i2GtOA74tdB
         fy7GZBvoDCXz36h3HOrg1loIPQDZtBomCHHDhwKIICvMaU3s+H5m7qJxWioQ76TB6usV
         5hE1E+rQsLVwUydxaAvgUe/GnR4hKQRSlt/OF+9jfWI7CtzWKORtxEp5Ei64pg+xqQVn
         +BhRijqYNXRMgD7h+vcs/DgvSs1KK8gvnZzCEkWKx7b/6hT+jNpJyBgmW9+tm5KgGny7
         k0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VAEh4u66db4pSNovW/A8Cvie0VZiNtfT/2/kRKGulxw=;
        b=jt8SfeO6q37gNFMmw/Ofvl4norv0ZsAMBW5hhYMwupvxo+zAGwHDg7cv92HwEb7jDP
         6OZAS3ZQXjXidkJ4w3i1uW8a5GFkddh0L/gUotgJ3lCB7K6iK8TPEzKlQT5SscVtAjux
         qDs64E6dJf7A3UmHTL2WnV6PJS1rvw4k1+nZne2ztFtXVwnxlGYFYuskVHCNqAdSe4Qe
         zo4U10bYEVCHYc1neGt98hkYYJLTlHStJXZHvVuRNWwmvUeCq1NKx+/WY/1p5cI0I3Xr
         cp0oGpOTwEpcS2a/1Gt16O0ADS4GSavR2+AiK3PiYXpIH546zJplILpf5YGadJmYxeTC
         BkYQ==
X-Gm-Message-State: AOAM532LVi9c3fhJ2P1o6W6HjRJ704nGBDRGsi8Qng4D066YPQJIhAku
        2RTEJ/r5LbURXdA729JzMstJCCWNpnz61CeDhH/yEQ==
X-Google-Smtp-Source: ABdhPJwe8KI5CMjzs9md4aYyeDnpmI50MG/ft/bINCYlq7VcXqD2XHy3kYeFGn+CgcYDrYPD81hCirFjVFyDdToEGBY=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr2697180ljp.266.1591729300719;
 Tue, 09 Jun 2020 12:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200609174048.576094775@linuxfoundation.org>
In-Reply-To: <20200609174048.576094775@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 00:31:29 +0530
Message-ID: <CA+G9fYsxjJpM-bw_VamAH0Beri66aC+-kqZ-RiCWVqm4N=t4gA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/25] 4.19.128-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 23:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.128 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 17:40:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.128-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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
>     Linux 4.19.128-rc1
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "net/mlx5: Annotate mutex destroy for root ns"
>
> Oleg Nesterov <oleg@redhat.com>
>     uprobes: ensure that uprobe->offset and ->ref_ctr_offset are properly=
 aligned

stable-rc 4.19 build failure for x86_64, i386 and arm.

 make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dx86 HOSTCC=3Dgc=
c
CC=3D"sccache gcc" O=3Dbuild
75 #
76 In file included from ../kernel/events/uprobes.c:25:
77 ../kernel/events/uprobes.c: In function =E2=80=98__uprobe_register=E2=80=
=99:
78 ../kernel/events/uprobes.c:916:18: error: =E2=80=98ref_ctr_offset=E2=80=
=99
undeclared (first use in this function); did you mean
=E2=80=98per_cpu_offset=E2=80=99?
79  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
80  | ^~~~~~~~~~~~~~
81 ../include/linux/kernel.h:62:30: note: in definition of macro =E2=80=98I=
S_ALIGNED=E2=80=99
82  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
83  | ^
84 ../kernel/events/uprobes.c:916:18: note: each undeclared identifier
is reported only once for each function it appears in
85  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
86  | ^~~~~~~~~~~~~~
87 ../include/linux/kernel.h:62:30: note: in definition of macro =E2=80=98I=
S_ALIGNED=E2=80=99
88  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
89  | ^
90 make[3]: *** [../scripts/Makefile.build:304: kernel/events/uprobes.o] Er=
ror 1

kernel config:
https://builds.tuxbuild.com/I3PT6_HS4PTt7EFgJUIPxA/kernel.config

--
Linaro LKFT
https://lkft.linaro.org
