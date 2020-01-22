Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0AC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CA024673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er1BCnrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAVOhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:37:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43686 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgAVOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:37:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so7040972ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c13zs8955RjOwO1R68Yo+jLBYdPImb6ylKEnAaJXyfI=;
        b=Er1BCnrp9pDvNyImzTqxasJ+FYW8/qO7X6bhQUhS6CQLwAfmG9cXbpfioOahR9qOrF
         /yIDow0U2JjXN0EnFsfK74W2eiQYgVwfeUa3ettvfdOTXIsy7jT0su4soPNOuPcczkto
         3pQMzKhoFOh1OhCl/1PtV/HZXUVyrYHLw5lrpa6eUpvftZNoPuyFkFp3fdfpT1wATepV
         SOS6Y9ilqaC/goEQ6aRfc5sYHNfe12bmF4/w+ZB8fQ8HbeTyIADc3I3W4RM0lp8dHXDL
         dKHEcpCM0QECJ61cfTQyYCtOvS19tlSglws3Q9ANtu1fei+xCYALxdzY6A8FaM9ax9jb
         7h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c13zs8955RjOwO1R68Yo+jLBYdPImb6ylKEnAaJXyfI=;
        b=t2AyGZgZdUtz7jo6S5WWP6BGNIEq1RlkW7T0bgSD+/4m/c8votAX1liA30MLsLGkvt
         kpkQuAHmQ2cw1NAUExDNRu2c0fLuXPTyLPcwJ6CEvgl0ddillUVwWEcflNJx+miv6WkQ
         2bKkdGxsRgh1xgjrHluK3cpxEsEoGosih5run3ooB5OcpX29Aw0PSnXKDMph3goa+oKE
         2KcKh60dIwzOTwZSwLGwhmCKvflO+KVP5XacU0ypGQzuaBHivaJFgMOZmp/+VxkypSTd
         Lkab2zaH2Lk4f9+3P2zGUIsDs6+erUZ53HDAf9SO3nR4vyqvyDVbt6GmggF0afqqsAHm
         W5MA==
X-Gm-Message-State: APjAAAVNbc/vlF6krCD4HGNN0uJhrsLdmk7KK4MyGSQVed0/Fzog9QVl
        KvK6Rt/Y0Ci6sPCiHez870aPPfrQ/dcy55rVQXaGfM6zLkc=
X-Google-Smtp-Source: APXvYqywzF2CDlmaQcEQ/h0GK7mqNcY3nemKFbD/fkL3KGrztNcgnnWKbJ0mlhX1LotfCWETqxh9T1ckkUhB/Tx1rn0=
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr19310123lji.11.1579703825148;
 Wed, 22 Jan 2020 06:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20200122092755.678349497@linuxfoundation.org>
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jan 2020 20:06:53 +0530
Message-ID: <CA+G9fYv=neoAU80UdcQ_dRv78x02AXvkUX5y0kY2ZZ-meWQKQg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/97] 4.9.211-stable review
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

On Wed, 22 Jan 2020 at 15:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.211 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.211-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.211-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: c10529b210d19bdf8fca0385b4e1e6374401dd5a
git describe: v4.9.210-98-gc10529b210d1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.210-98-gc10529b210d1

No regressions (compared to build v4.9.210)

No fixes (compared to build v4.9.210)

Ran 21111 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* spectre-meltdown-checker-test
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
* ltp-syscalls-tests
* v4l2-compliance
* kvm-unit-tests
* kselftest-vsyscall-mode-native

--=20
Linaro LKFT
https://lkft.linaro.org
