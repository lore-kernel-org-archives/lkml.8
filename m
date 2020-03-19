Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DFC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C3020787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gv9AZwIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCSSfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:35:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35847 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSSfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:35:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id s1so2498390lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kd0d7/UfgwdvzHgvQenbYu5RHBauEJYzFS+JlGbid/Y=;
        b=gv9AZwIsp1SJvB8Uk8IYTA1I48DAvESbD2oisd+5qNE88yL+mOAz0lj+jetszcOq9l
         1QY6yjLxg3Is4w1ijCI9nkI1KL98X/6cZlkdtbJas14J63ElMysDPGDMZ/TfguU3K3OS
         +gfPIFY1uMS2dsPrRGKW753q6III1KbEUTB7wLZshby8ciA1zlbERhdJDVyteK81wTBe
         R/+U5IFcRFNyj7BsfqpcSCJ7e/5ygsrBaEmTOkySWr19Tr0uj2aB03xQQPKlhKeeQNFM
         mqeJIM2YWT9FJ5bP6/6Ff0PDYTm6o1KOfH5sqn7B8mhhIFgDYgjAzl++3BL16lTnnoBg
         Gdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kd0d7/UfgwdvzHgvQenbYu5RHBauEJYzFS+JlGbid/Y=;
        b=tnrlj6iMgpUwOA7CijYUxNZ++6aTCSDBemcRZHsBB32HKuRt3PKPb+YBYWqMfc27eH
         /tyW4AtzziZ18upevlndVxFKNkMJDPCpkqpynXIvQD407M8MqVw/y3Xb9kKJ+WQdsY/6
         IGlH6Z7Q0OVHd3lg41T0e6F79m5Gs7Rob1vhYoqN+VNXWFM5K+031K6P8nZDulD+OUFb
         wmEt19kPyeFE/Bccrc1PSPQ4mQTskf8Dv+QTuHT0X529IWoNO3yrQhomEFNCtvxJtPdp
         87FuMKOS2bTwjJI6RixdAf2bomPIPFFGXOLCsfstYmglcN/SmXT4F1Ie7enlQcl5aM7C
         KfeA==
X-Gm-Message-State: ANhLgQ1D8B3vg55HsdeqdIGRAAI2tzwiJC1a/eLJ/mSUZPYZALY6CYd4
        xY3B8Po2TPbs/X3O/nrkGBttVnBXixlwhmYa4zW/Pw==
X-Google-Smtp-Source: ADFU+vsbYsLejxTqmEHzkijtasIdRdQgtLiOSPjEqw+aZF2q8n0i4zqspGp0HuHbBHSB+MhrtBk0e+HZEyPsGRoIbMA=
X-Received: by 2002:a05:6512:3188:: with SMTP id i8mr3048513lfe.26.1584642911614;
 Thu, 19 Mar 2020 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200319123941.630731708@linuxfoundation.org>
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 20 Mar 2020 00:05:00 +0530
Message-ID: <CA+G9fYvGcBzFuGFT=NsRb_uWZ_Sn04-MxKgLU9NGmrMSUNegFA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/99] 4.14.174-rc1 review
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

On Thu, 19 Mar 2020 at 18:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.174 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 21 Mar 2020 12:37:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.174-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.174-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5510299b1b08a51cf5805bd223de3e9453900d9b
git describe: v4.14.173-100-g5510299b1b08
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.173-100-g5510299b1b08


No regressions (compared to build v4.14.173)

No fixes (compared to build v4.14.173)

Ran 22239 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-sched-tests
* network-basic-tests
* spectre-meltdown-checker-test
* kvm-unit-tests
* kselftest
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
