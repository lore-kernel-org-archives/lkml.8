Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0961C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F0E20786
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKxd4d2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIBFSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgIBFSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:18:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA963C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 22:18:04 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a16so1911840vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zJ3a1CRJV+7fxasgMykvqa8xqbnuraayRBZc80JsMEI=;
        b=eKxd4d2F2VdE7gfHAI/dEV9na+W4P2zSvAwyEgxJmXM2hkWkYC58a0hC+FdMfJbT8W
         PLvs/Aqu2bBpizq/pzEM5qdv439TudmNs3GzD7/Gn2FPdSaVr8Xzr0i5t+4RhtfBRrC3
         +QFDnK6TZHKzI4uZKDb0nsZ4hgp0re2zQpNBu7eugWUjZXA45ZZEwf6uk9cYwlm5ekhF
         yJA/kTNvmmdzysJzh+oumx4Gq58eJy2M3v89mH1FZHyLE82rMjt84cL8UkyqZVgcLXhX
         /iFJDonnC/NK8rDfnqlOHwFw+TA379AI1AkNZBHPtFWD7XuTpG7jJ/XOmSo/KJs657Tf
         ptLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zJ3a1CRJV+7fxasgMykvqa8xqbnuraayRBZc80JsMEI=;
        b=JhQz5897HwUgTwMXP064Abtxr7M/wc9w7mOxsV94XJ+gVSkLGVvDMIEHJpvCYjHUvf
         vZfFN3H1Gmeg8DjRq3eT8E18J6vinTJhfCJRTgTClS6M4IZhu4kPbU8uKwxzSpSpOWai
         Ok2Dxh4RgFuY5FNzMAHEFkD2WqTInAGTpYsS+plBdo9c+FW/Wm0E26nUJ7gB0Y9vqhF4
         lnWGEtuiETDHs0OFED5Q0QQINIuuKzJZhC0DylSw1Ude9VEVabqDT/gC29XuZHTCtihH
         QDFow4Tx4ETgMoxK124xWEf087/2zKHNPodpIZuDAWizXF9JPz3jemXpgTWS7Y7gg1el
         eDbQ==
X-Gm-Message-State: AOAM530XIk/d2Q8uvCjmHZV2Qp6Q9qD7jJU9VYsC9fU1V00/X+iZEoIC
        Xr4ACPR2KPnTXa9alyP18qZWTuo/GGPp4IQkF1x6VA==
X-Google-Smtp-Source: ABdhPJzTI6yI0sgigh5knK9fSxCILYGU4r2D2EaAYXHA5LDwR4SuhmFqaF6nykK0Wm0kLJ/JMMa3KCGsmhCE7to+MpM=
X-Received: by 2002:a67:e9d4:: with SMTP id q20mr4082829vso.83.1599023883523;
 Tue, 01 Sep 2020 22:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150952.963606936@linuxfoundation.org> <694f63b6-c5a0-f434-5212-27f1cb7b5f2a@roeck-us.net>
In-Reply-To: <694f63b6-c5a0-f434-5212-27f1cb7b5f2a@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Sep 2020 10:47:51 +0530
Message-ID: <CA+G9fYtoxNSRKncYBnc=LgYVJTW51rQGAgnLaWwhYZT==VeqAA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/214] 5.4.62-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, 2 Sep 2020 at 00:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/1/20 8:08 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.62 release.
> > There are 214 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> > Anything received after that time might be too late.
> >
>
> Building x86_64:tools/perf ... failed
> --------------
> Error log:
> Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs fr=
om latest version at 'include/uapi/linux/kvm.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs =
from latest version at 'include/uapi/linux/sched.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' =
differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/unistd.h' =
differs from latest version at 'arch/x86/include/uapi/asm/unistd.h'
> Makefile.config:846: No libcap found, disables capability support, please=
 install libcap-devel/libcap-dev
> Makefile.config:958: No openjdk development package found, please install=
 JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>   PERF_VERSION =3D 5.4.61.gf5583dd12e6f
> In file included from btf_dump.c:16:0:
> btf_dump.c: In function =E2=80=98btf_align_of=E2=80=99:
> tools/include/linux/kernel.h:53:17: error: comparison of distinct pointer=
 types lacks a cast [-Werror]
>   (void) (&_min1 =3D=3D &_min2);  \
>                  ^
> btf_dump.c:770:10: note: in expansion of macro =E2=80=98min=E2=80=99
>    return min(sizeof(void *), t->size);
>           ^~~
> cc1: all warnings being treated as errors
> make[7]: *** [/tmp/buildbot-builddir/tools/perf/staticobjs/btf_dump.o] Er=
ror 1

This perf build break noticed and reported on mailing list [1]

>
> Bisect log below. Reverting the following two patches fixes the problem.
>
> 497ef945f327 libbpf: Fix build on ppc64le architecture
> 401834f55ce7 libbpf: Handle GCC built-in types for Arm NEON
>
> Guenter
>
> ---
> $ git bisect log
> # bad: [f5583dd12e6fc8a3c11ae732f38bce8334e150a2] Linux 5.4.62-rc1
> # good: [6576d69aac94cd8409636dfa86e0df39facdf0d2] Linux 5.4.61
> git bisect start 'HEAD' 'v5.4.61'
> # good: [6c747bd0794c982b500bda7334ef55d9dabb6cc6] nvme-fc: Fix wrong ret=
urn value in __nvme_fc_init_request()
> git bisect good 6c747bd0794c982b500bda7334ef55d9dabb6cc6
> # bad: [81b5698e6d9ecdc9569df8f4b93be70d587f5ddf] serial: samsung: Remove=
s the IRQ not found warning
> git bisect bad 81b5698e6d9ecdc9569df8f4b93be70d587f5ddf
> # bad: [973679736caa8e1b39b68866535bdc7899a46f25] ASoC: wm8994: Avoid att=
empts to read unreadable registers
> git bisect bad 973679736caa8e1b39b68866535bdc7899a46f25
> # good: [1789df2a787c589dbe83bc3ed52af2abbc739d1b] ext4: correctly restor=
e system zone info when remount fails
> git bisect good 1789df2a787c589dbe83bc3ed52af2abbc739d1b
> # good: [ba1fb0301a60cbded377e0f312c82847415a1820] drm/amd/powerplay: cor=
rect UVD/VCE PG state on custom pptable uploading
> git bisect good ba1fb0301a60cbded377e0f312c82847415a1820
> # bad: [1ef070d29e73a50e98a93d9a68f69cfef4247170] netfilter: avoid ipv6 -=
> nf_defrag_ipv6 module dependency
> git bisect bad 1ef070d29e73a50e98a93d9a68f69cfef4247170
> # bad: [401834f55ce7f86bf2c0f8fdd8fbf9e1baf19f1c] libbpf: Handle GCC buil=
t-in types for Arm NEON
> git bisect bad 401834f55ce7f86bf2c0f8fdd8fbf9e1baf19f1c
> # good: [ccb6e88cd42a9cb65bde705f7f8e7c9822dcb711] drm/amd/display: Switc=
h to immediate mode for updating infopackets
> git bisect good ccb6e88cd42a9cb65bde705f7f8e7c9822dcb711
> # first bad commit: [401834f55ce7f86bf2c0f8fdd8fbf9e1baf19f1c] libbpf: Ha=
ndle GCC built-in types for Arm NEON

[1] https://lore.kernel.org/stable/CA+G9fYvsNkxvs7hdCB3LC9W+rP8hBa3F1fG3951=
S+xHfiOJwNA@mail.gmail.com/

- Naresh
