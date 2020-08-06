Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEACC433FC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED1122D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDn2Fk6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgHFIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgHFIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:52:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3D0C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:52:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so29004425ile.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VaSV/iOvU4KTpuYFNqKMq1HFqHP5k5kT1iej1ya7KdQ=;
        b=tDn2Fk6RhwRhI/ZdCNLFMXX8oTnr1BGydvcryTFZLifDcdTJ33JCpN+J6BYeM6k9KO
         KFJHdLqpNuisjDFG3rCZd2ReM2Ho8wGVuZXeISHpl56E18GE/M3qz7Oz3a3MBkfRcN62
         p1kdotbeYQCoOX9pepWkSv0jP8T/nqmFBaUUQ++cxyOUgmyFmA5kraGMewqOKpjAXw0o
         /x3EwYzg+AC3ywQdAUCNWUnilEdTNQDJktiVhls1MdZ02dqfXUmWuylPb8YbjX0PqKrH
         yLU8Hm1PU0lxGm17SbjBihDIV/NWX4X/tTj8lxQfcrxLiNnBtz61+WBs5rkAoZqOaChG
         +eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VaSV/iOvU4KTpuYFNqKMq1HFqHP5k5kT1iej1ya7KdQ=;
        b=EG//mfmG4GSjdCxWFdCnRF83yAMA8SogndbWa9moMMay1gqbyt8dTmulPEnDYfmWxB
         R69fxVa4u6v+GWuexDfaRdknA0PWYwfS/SfBMkuNdHmy3sxmUJShS0GYtib4UGYZZp0l
         9JZr4S9VUDVGx62pRdUZHGseZtwt7erL2r4bpCOGiPtsG4L/YxUGevePfi2ypM/0VTY8
         99eakmBwvHEvuHGmimFTG467OzI+/HPZ+emzKpsisYBPkVOtVr+rIVdnRyfzRqq7UB8u
         vp7Pwahyjc1cPOLwMyj8NbrPbIMVHMsQs/tSCc7oqqqVGq34/dyrhrZEIVER1w3GV+7X
         yHBg==
X-Gm-Message-State: AOAM5321jJ0KedBkeaG4X8A/l/NOsK+mnDwt4r5TKR+r6mlRgpWUvkJi
        o9ctdMhQ5w4Es8RNnIW6l6bnjQUqf2ykX1O/+/3H95wicR3J/A==
X-Google-Smtp-Source: ABdhPJzGpNbmtnmC6ma4yk3rvNm7OdHnI1PDjmt9Qpv76QdRLXqmmEKMgXT9m4eEF1glYKlS2oM8/jelYTGC7QG/uZQ=
X-Received: by 2002:a92:1d1:: with SMTP id 200mr9616426ilb.71.1596703919933;
 Thu, 06 Aug 2020 01:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153507.053638231@linuxfoundation.org>
In-Reply-To: <20200805153507.053638231@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Aug 2020 14:21:48 +0530
Message-ID: <CA+G9fYujKYgN1r168ot8Kvx2SNtYOgAj8gBCYxQ6ek9mUzndrg@mail.gmail.com>
Subject: Re: [PATCH 5.4 0/9] 5.4.57-rc1 review
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

On Wed, 5 Aug 2020 at 21:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.57 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.57-rc1.gz
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

kernel: 5.4.57-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 1c4819817cd892724f91e5d253eec5f746243602
git describe: v5.4.56-10-g1c4819817cd8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.56-10-g1c4819817cd8


No regressions (compared to build v5.4.55-87-g47b594b8993f)

No fixes (compared to build v5.4.55-87-g47b594b8993f)

Ran 35321 total tests in the following environments and test suites.

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
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-math-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* network-basic-tests
* igt-gpu-tools

--=20
Linaro LKFT
https://lkft.linaro.org
