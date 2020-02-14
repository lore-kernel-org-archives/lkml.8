Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF951C3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9222314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuhprleJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgBNKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:22:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42158 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgBNKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:22:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so10119480ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPCFLwe5w3L0r6Lzka90B0ur8EggWQsgDuJCl9NKRBE=;
        b=LuhprleJbTIo/s0Ng4elmsTIJsZIWypgwpqLVXC8WFvPWPVKD8Bap49OQUDfBUsFsh
         lxyPJhLktS6rzlEQqhFNaFXtGdHyMgL+dglU1XV204FHVrCViAmZI+tyMxU0168SqKTa
         CnZps/sjeL+XevF7EWu31hoG9vEi6d71FZ3StGB1M4fJ2zFu8ZTSWBXlKuQ4rwmFwffw
         Hr5+4DVaaf0dzBDSicd6nZNiqtqHWridGfx5df/xNjM396P57rRgg35pLH3IsXr/VbZ1
         qrJxnOOPPVdabwsXAEe9+Zzhrdzoi1m7+mRIyHBv0I5dvFFKOqTESY9C6gw/vSGRo04I
         hEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPCFLwe5w3L0r6Lzka90B0ur8EggWQsgDuJCl9NKRBE=;
        b=erSG8TFnjUFNEyQ5lfoWeYAFWFEX3v5pKaAVvSIA7h3vPawp71O3d+TKEYyzgPLyyq
         ZNWmfIHTCKtyk40qwEw/jsLulXDO4yAzNAh1dz+sFCUgFviHD25wbq2qYHvfrnzVH5/j
         00OM280aKhdWJfJCB4vjfgpTlHkxuTzk26Hp/7SRm8JU4vWWdzSG4Wc/iEPVLiQTqxSN
         tYaNKSX/A01qdKQp07TRAuGjfbOOCaPoQomyl6gXtM39mDcQMO3pxYhXu1VRjHUMHHz8
         P8wZWTdri+i9lhWNaSe/ZxC25jgk5vaJTcUv7Ulo/bhCO5zmKae0lEg2CpeuYbB+Qwn6
         qUBQ==
X-Gm-Message-State: APjAAAVJrFKANfHqq8QQ8defaA14A5CZZ4sIv3j80OMfWf+ByhU1T0wj
        3shaWcUgFmUkIbEV84ZJp0ADFdM7rBxixPPNjWKt3g==
X-Google-Smtp-Source: APXvYqxoD9CTD5Joi5wkVeOv9lhITuc1Xukrd6KKsR+7iyuMQyfJAWQNzc/ay7+tE4S6Srw7XfRRgqbWi2kGMm1Qoog=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr1665200ljk.73.1581675747774;
 Fri, 14 Feb 2020 02:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20200213151839.156309910@linuxfoundation.org>
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Feb 2020 15:52:16 +0530
Message-ID: <CA+G9fYsO+buQ113cN3rKMUXF7bFXZHAdyf2D-408Tr6FD3d2sQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/96] 5.4.20-stable review
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

On Thu, 13 Feb 2020 at 20:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.20 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2020 15:16:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.20-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.20-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: b06b66d0f2c4879cebdf5de3d93f4245d1470a70
git describe: v5.4.19-97-gb06b66d0f2c4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.19-97-gb06b66d0f2c4

No regressions (compared to build v5.4.19)

No fixes (compared to build v5.4.19)

Ran 24660 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* libgpiod
* ltp-fs-tests
* ltp-ipc-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
