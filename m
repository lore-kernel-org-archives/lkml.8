Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1CFC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E6F20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAd3NejF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgDWQW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:22:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D7C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:22:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so6851010ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w34dDWOvXQm5HMAoUFj55JSLOl65xl3iabYd8dS63XM=;
        b=DAd3NejFDEiIu0cJl/NJ8/ym1tbwrrbkTgHRXeQO2k4fZQCSYafE4f6D2iHTtUb+2F
         /mmGB2A92Djo8rpbcyFh6nE6FRTpKVuwCANh/G03qYT6HT4hwF1fkkY11tglys65bvgY
         1ycVlHmKCAvsTbPF7QB3Gl0ssK0JDVTgIJvaiw1wnmetBEZPliL1tAqwfTECJ2DjZ6Pn
         /UBOEUC1z1h6n5D5+mqoPEW5K83E+nWKxoKByZEJoLo3h+/CNIEZlvsgml79/7/KlSH3
         DwP3VlWKjq9FQL8145qGCXEKqgiZ5LOFcYSBaHpTp2saPhKe5RmyN33CCFqE+J6gGzFh
         cfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w34dDWOvXQm5HMAoUFj55JSLOl65xl3iabYd8dS63XM=;
        b=OW6rH/THHHyLbx7BOEkYItNx1U7W7dvNOdFQqoYnscYjpkXcwyg/cP/VI/fM5+MH0Y
         m/weobHzni5rZoW+FCNiJpa4d9cB1b/b5WfKN/qs239fH+Kf/xw0bHlq0+T3ypA+0Ddm
         5QsZqulvA/O5wCNdjD0Yqvf1h574bc/fAPDBQ4m+BscjkqO5JPcQbaFLBKoEd8awsAlK
         lXiaAzadhKUg8m9OW1dWjI37elYYaakWrFoLGjCawwjANG+sFzr1ymM/dfj0Ac91KT/S
         oG4CmWj2kmjeABBfiFB29AYG5SKfbwkNsetRBvfH7K/JT9GbuwAyltVdNS7Pqzyykjiy
         PG5w==
X-Gm-Message-State: AGi0Pua6XT9xTVHTjinkwlqiXMrF2SM/C9+jcwjt04PFFrUF7M70URwB
        SEt473I3NshOrf/gXQWgaPJ/H2hfzaBsCVYe2GX9oA==
X-Google-Smtp-Source: APiQypJE+zCpr7eDkKlUDwHR751ytOTh3cjA4+7Lr1ufzP6qhxRyb/S1gJpux81PY/M4rlOEPk3K6UrN+z1CTHUMtZY=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr2778258ljg.217.1587658975058;
 Thu, 23 Apr 2020 09:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200423103335.768056640@linuxfoundation.org>
In-Reply-To: <20200423103335.768056640@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 21:52:43 +0530
Message-ID: <CA+G9fYvR8eLJt_PYePC0xY7yWeubCqt2Y-wimX9JWE9VtujnAQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/198] 4.14.177-rc2 review
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

On Thu, 23 Apr 2020 at 16:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.177 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Apr 2020 10:31:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.177-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.177-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: a7097ef0ff8203c8e25ad7d3b996e030c083a81a
git describe: v4.14.176-199-ga7097ef0ff82
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.176-199-ga7097ef0ff82

No regressions (compared to build v4.14.176)

No fixes (compared to build v4.14.176)

Ran 38632 total tests in the following environments and test suites.

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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* network-basic-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
