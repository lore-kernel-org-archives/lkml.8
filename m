Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E3C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623C220575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4w3N3ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgEMJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbgEMJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:58:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A6C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:58:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so13087891lfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QVzV5rgAKRFLnrKE0lJbzXSpE3rN8Jlxj84Ec0l/m1U=;
        b=s4w3N3neypSZVWtFzWxvzBWW9J5S3/KZuiB6uukj2z51G8yOUXROf1JURtaQG9/OCX
         D9GKaAoNxOhzl7/akBnNAztr39/MOlYIPc6YyTXZNtawBlnI+Ii5r07FbVDhqPnnclir
         fVtWk2FztIEsXuKLohGd53fOxYvlI81QphKg49HmV3tVeSgsbzZYiI7ajCwIPWW409ul
         BNR/0EJ7G4cg1+F4B4ddB5u9v1aBfM2hLo5BvBptipSDNqjqSz6Bl1REKsQtc5Y5bEMb
         J+gV3nbfuY++Cwq24IU7oF5TqGLerk/jqMB+l+cb+1Byy1aXSrUn0AyuQUER0o4CeiGW
         /3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QVzV5rgAKRFLnrKE0lJbzXSpE3rN8Jlxj84Ec0l/m1U=;
        b=hIjQSmtQjsjHOl6Fq4dAUnss0q9ggx4jXoTXMjqLOu6fb4MsR4ytL5lr/CoNAQCZ0f
         e24cgpGlz4qOXsj/r+kzFSqtZdNzUkoPHSlqmq6Rcku0xKAJgCshdqaJIHFPWQzUIlqX
         lsVL6pV49g5i28SEsFYagEgBQX0FVOUmGA95v9MOZqfqAgOGE16Akkve+wIHmRrtegSJ
         U9Nm8xu+EYdXX51Y7rd9gVWoD5LsGQ08/+bUhR5IPn0AXQ0+8Z5Lz6xlaIyNiPjPdj0L
         IFPWBF2ZfGA8tsUzVGEcMkrYUyk4p9ZPuHTwOJB9csH39zUfCf91kWBu7TBZYVJUnePw
         y2Qw==
X-Gm-Message-State: AOAM5334SscYBWUAjr4MEpP9hdifmqFoeQ7t64DgaIKRxqMsN7ynUYC2
        afoezB9Zdx2lLzO6f2KULkvMg5WYTp+GFu/bhR5L9g==
X-Google-Smtp-Source: ABdhPJwB6GIpoGVDfUPp3bFbnQLmfde/k8Ba5FyIsp53nA2AQhciGm5/ExoRkWxYm22IoJcmrBj499q4rE/pdoqvYSM=
X-Received: by 2002:a19:40d2:: with SMTP id n201mr17415998lfa.82.1589363925582;
 Wed, 13 May 2020 02:58:45 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 May 2020 15:28:34 +0530
Message-ID: <CA+G9fYt_J5azOTM0P2kO3kfoGQCDPU0sQ2mc+e8Udmsoh3FN5Q@mail.gmail.com>
Subject: stable-rc 5.4.41-rc1/4fdbdad79626: no regressions found in project
 stable v5.4.y
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

kernel: 5.4.41-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 4fdbdad79626096482a9a6f79dbcc6e1df35a589
git describe: v5.4.40-87-g4fdbdad79626
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.40-87-g4fdbdad79626

No regressions (compared to build v5.4.40)

No fixes (compared to build v5.4.40)

Ran 27181 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86
- x86-kasan

Test Suites
-----------
* install-android-platform-tools-r2800
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
