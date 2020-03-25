Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E0C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvnkhHvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCYFp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:45:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44189 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:45:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so1104847lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lYD4gV2aiMtygPtwbX++wP+dM6O7K0V0RGjep/0vOgo=;
        b=tvnkhHvm4PdvQZoTz5e5X+Zuh1SFtGki8xsPdRgux9SuV490qyjLdAXhHXfl6YUc7b
         TKA6AB+0uG0vcllAzYR41yl6Uk3pFSL6KpsvlEVd7LvAyBb2oAIwhBNVNibfYH3Eu1mI
         +W+Zm/S3JCVEiXosbVrpeyegBqZQRR2dyZG+mWK1IAuFfIHqLb1/egL8DarnDe4yfsGL
         l6ejO9jXdwKHZXGaUKbKYLAoESeEk3PNkGTm5zfbI78CaA8waQiHOfPVzwftKJCKKkrZ
         oTPheye5pAZndL+1O6AGancWuRiU9OUpEz7aNX+rxmRAbqcdgKomLFCf75wpTs9NIFln
         9+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lYD4gV2aiMtygPtwbX++wP+dM6O7K0V0RGjep/0vOgo=;
        b=ZTFVADlnSuA2H0/NiSB1nezE8fVFAHKw5eLiEOxE5dFqrui7wDZvMYj60Gb++7KZwR
         OCfFq3uWR3vUx097d98afimTxOLP0461kNuLWk/0M/7FAUnO38OEvQ7bJvJ1WVL9JyS3
         EgEzzYDqROTrMB2YjtSMAEjaiqueSeCXzO4OVCFyKhbVc8Ffq4TitfNnbrU9CYzOUqCM
         +XHekOYQDLk3IjpftzQH28Wy7JMx9h8xROiE9o84gEbr2ObeaQXk194+BvAa3kohiy4f
         8l4pcGeBnuevl+B2PuZmjjwHYqCpFNxy79JIQx8eBH+KdcEZxa2svhsQiyp4h7mm8Tsf
         lhEQ==
X-Gm-Message-State: AGi0PuYH1JHetfEbXKWP0LEJ+mpin/EvX+kOA3jeQwv/2U3WgmZ6mndS
        5a/f8ForfsI+3Tuy48S0ma641bscfAMWiDTUtjVF7Vh1+/krtg==
X-Google-Smtp-Source: APiQypJEZ5vvAF9MO4gXQ+t7bUi6zsTgvnRPAe7WZWydS2OyyM8x5YA29XYUAWgjrddMaB02h7sWA6m1G5a7LVftCtY=
X-Received: by 2002:a2e:990b:: with SMTP id v11mr856142lji.243.1585115125736;
 Tue, 24 Mar 2020 22:45:25 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 11:15:14 +0530
Message-ID: <CA+G9fYuAib1xN5gKwr1_xrjPd=zE-qsAA53VZL6npvZWgJ_fTQ@mail.gmail.com>
Subject: perf failure list
To:     open list <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dan Rue <dan.rue@linaro.org>, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been noticing multiple perf test failures on LKFT test plan.
I request you to investigate these problems.
Please guide us to enable missing Kconfigs and userspace tools.

The listed failures are from stable rc 5.5 branch.

arm beagleboard x15 device [1] & [2]
----------------------------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
Watchpoint subtest 1: FAILED!
Watchpoint subtest 2: FAILED!
Watchpoint subtest 4: FAILED!
Object code reading: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
Merge cpu map: FAILED!
time utils: FAILED!
DWARF unwind: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
Watchpoint-subtest-1 FAILED!
Watchpoint-subtest-2 FAILED!
Watchpoint-subtest-4 FAILED!
Object-code-reading FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!
Merge-cpu-map FAILED!
time-utils FAILED!
DWARF-unwind FAILED!

arm64 Juno  [3] & [4]
-----------------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
Number of exit events of a simple workload: FAILED!
Object code reading: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
Number-of-exit-events-of-a-simple-workload FAILED!
Object-code-reading FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!

x86_64 [5] & [6]
-----------
PERF_RECORD_* events & perf_sample fields: FAILED!
'import perf' in python: FAILED!
LLVM search and compile subtest 1: FAILED!
Session topology: FAILED!
PERF_RECORD_*-events-&-perf_sample-fields FAILED!
'import-perf'-in-python FAILED!
LLVM-search-and-compile-subtest-1 FAILED!
Session-topology FAILED!



[1]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311723/suite/perf/tests/
[2]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311723/log

[3]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311746/suite/perf/tests/

[4]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311746/log

[5]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311665/suite/perf/tests/

[6]
https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/build/v5.5.11-120-g738ff80e1bc6/testrun/1311665/log
-- 
Linaro LKFT
https://lkft.linaro.org
