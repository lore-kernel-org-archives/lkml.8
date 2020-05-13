Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43627C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246FA20673
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9YifD/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEMJ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgEMJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:28:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C24C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:28:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so17009306lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wQxU0jyrHzKEkXou1yOIjNJHHQfsfmWMdJ2AoZ354UQ=;
        b=D9YifD/SW20ytyogAuVn9VrK0eKC+bwfpvlTRVGFjX4/WlCGcAUK8+6+pcocUtJIWn
         ZY3rWBAeBgljvsqnfct1Io+mMPT3L2HAseZ5JSaAHdu9NBzNVcZuseHblNApYRDZ2FAI
         IJT6Xa/ZprsZ838WypM1E6w4WiqkjDebPDwy3b/iAB7wkl9kAXL5YkjIcJ0R3lKDKUUV
         OTm47/l1qbqJTpQ/nqDAO7Ea/2ko42fRl9mDRTrY5fHzNxRsY9aLGdDq24Gd+Y/eOE17
         nvVYDr24QN1JkQnxIrfW7Uij3wv0nd7BO99xqhUu5uxQ/5TcBMTyYu0gDO1S5R5zO9bv
         S/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wQxU0jyrHzKEkXou1yOIjNJHHQfsfmWMdJ2AoZ354UQ=;
        b=UumQTl37vfSqE7VEAZ6itFCVtOgFDSVYl6hCReoBOvW6W2nxH4pliqwaxGBHGC4aQk
         AEGYE77V/40Td66a4GWBZvxMdqRfkuHGH3QZo4kVNlQd8TQAxk6gtdHxDl2QZAMgczfl
         NS/wZ7kbB2P7djDE1/77+oF1xTlS0wKiQ16OUMO8FE8YVps92aTOkHaOkQfczrMzpxjM
         MrsfEMxSrqtILMU0bw+ty2OV6/nPZRNoyyXKBewOst6ulkdIk84Q8KOnl8Co2bRlt5io
         j9IjXv1CXCgR0Fpwie3PYBUjSQzlgT+BqNCSjkV63p60YfPihH8y2t5Pudw0s5WtMpqx
         j8AA==
X-Gm-Message-State: AOAM532EaPOL64u2tOMzGVYlhYnUfqAvb6I+TLhcjkrHEG5tLhgPSc/R
        PCpY/yxY+8hMWqIx360puyrsCdo6l9grWN8NVySAFw==
X-Google-Smtp-Source: ABdhPJymCx/vtL0zSaB9nQywQfka98iDN4CnnB2w41wAW/txsjCb6bxprZhxbc18emb5CImBf8voznVttHoAckZeEBk=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr16869377lji.73.1589362122301;
 Wed, 13 May 2020 02:28:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 May 2020 14:58:30 +0530
Message-ID: <CA+G9fYv=uqK7qHfkE4VrGKwJ3G3E3meYH9vjzZKpS+K4sP-yhw@mail.gmail.com>
Subject: stable-rc 4.4.224-rc1/e6bc7c5d4464: no regressions found in project
 stable v4.4.y
To:     linux- stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.224-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: e6bc7c5d44642105766e5b29c57be37c6319c772
git describe: v4.4.223-17-ge6bc7c5d4464
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.223-17-ge6bc7c5d4464

No regressions (compared to build v4.4.223)

No fixes (compared to build v4.4.223)

Ran 20346 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* kselftest
* kselftest/drivers
* kselftest/filesystems
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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems

Summary
------------------------------------------------------------------------

kernel: 4.4.224-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.224-rc1-hikey-20200512-720
git commit: 55c9d63788c49cf307f7cad2e830681578e6a7f6
git describe: 4.4.224-rc1-hikey-20200512-720
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.224-rc1-hikey-20200512-720


No regressions (compared to build 4.4.223-rc3-hikey-20200509-718)


No fixes (compared to build 4.4.223-rc3-hikey-20200509-718)

Ran 1814 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
