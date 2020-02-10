Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C12C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5520873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syhLQK94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBJSwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:52:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40552 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBJSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:52:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so8501561ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 10:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQnnriRE8hfXL28O7IPHDyR6WZy0RczXyOOEFd6qQRg=;
        b=syhLQK94xQBnzcQdB5vKv2q9vw2GA1RQI+O/AKB29sWu2b1C6QJuOra8rrYlzWE0lm
         YFnkVfquxu22gexAsO1VLOfvdo5YozqOXQKTWACSM+j+KxkXS+yl6YHtTxkxGU5ANiOB
         25UuQyEmKVN0e2MXTRaZZgvrG4Rg8FtFZupCW7dW4Kg5VEzT8rmm+VHFhhvUu/TT0hWp
         WGcR76BLLSmvTQ3h6IpoVQsRyJ+WmjiXeKNx4e7U8dYCaMwQJxKHFXla5ZSz8A9hvzpj
         DtNz0BhMPRLdCmswuqZtc/LMJxjUmOL3Mk5kWewvdcNZyCjb+Y/l96mdKAgylVcSsxoa
         gXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQnnriRE8hfXL28O7IPHDyR6WZy0RczXyOOEFd6qQRg=;
        b=k4IgEqvedmaPbOpEbLc9Yn1pSudLzaahPHPdrySX3Jq/1m+lzr1Uuon7XZ4xABItVU
         a5aSMzWQ7MyouLCYhK83FTE+I4qffoxzibFiuX549/4WRxIgSuqkawkopjt0BvXns2Ju
         V+Fn81FLsAHt0DdyPN372IdR6TLd4sGUtzYuhxzzec76cO4otoAIeUvN35p7V3TUh2jY
         ptsREaH3KUC1LK4RBes1ifFsUOx/ZfgxyW5pxIWZCe7OQaiEBVelvvxpRym/LumHAMX/
         ym6cL/yCBL3u+IgO5eNyv3/+xStTC9GuItH6shMoVEZWjsH9YXirsyw/rV74RO+Gh+bb
         8Hgw==
X-Gm-Message-State: APjAAAV6bGT352xiYyufodRNaNednPgvuND4M3LT+1HWolCCQL4GYBLD
        CNrFaV03m3n/KGRBu+lc5KQvNbo+uoXMDVGUN9mN7ceGUe4=
X-Google-Smtp-Source: APXvYqzSZ/VnJuUeM9+63vQQUwQqQGphQoE1fpA+4VUpABlouJjRtre4X7yLtQSVJh3tLAjdTQb/GntPGqSpC05wXfI=
X-Received: by 2002:a2e:e12:: with SMTP id 18mr1789678ljo.123.1581360738381;
 Mon, 10 Feb 2020 10:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20200210122305.731206734@linuxfoundation.org>
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Feb 2020 00:22:07 +0530
Message-ID: <CA+G9fYs8tMCHvCmKBFsZZkXJvnhdFkbop8haLYU6r=k86X9rCw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/195] 4.19.103-stable review
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

On Mon, 10 Feb 2020 at 18:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.103 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.103-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.103-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: f03ffd764aed19a09925f1d0e2df9241fdafbcc4
git describe: v4.19.102-196-gf03ffd764aed
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.102-196-gf03ffd764aed


No regressions (compared to build v4.19.102)


No fixes (compared to build v4.19.102)

Ran 24769 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-fs-tests
* ltp-io-tests
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
