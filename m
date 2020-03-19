Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E3FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0DD2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltdEHHxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgCSSB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:01:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42080 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgCSSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:01:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so3523010ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vL2SDcgsOmgao8cRojxhgVQshxfXv34w3j2acLYfoVU=;
        b=ltdEHHxwBQSm+gNXJliir9Vl8xP5RC6WjX4jZLSicyPrCnC4A0puXTG6qfDxGGuzkf
         OyyLfSQJARmbwFaiyLxb/femvoNRIbLkTxlwqfp9XRQT62u7pgvctJghNehhVxLRm3DG
         D7h3mdDmdozMssHN3uFsq4+ITvcG+2qHT9eZsIvkDmCn4c85YlsOthve2n0/XRO5H0u8
         Fsibakta4/5VCwc6NhzKeYveEUI2ZNf2U6HrwBp1Fhe/FGQ7giRqUfI2a9qbMqmsuUZK
         ZLFPgzvKkTfzQtuac/8pjuEosnJF2iMG8PUcsM5vr9R24EL2snnk5T9B8scgYRuTwuXS
         ZKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vL2SDcgsOmgao8cRojxhgVQshxfXv34w3j2acLYfoVU=;
        b=Z5ZzLqmWIF/OCESs1wBdmtbsb+jVwZ6rig06doU6R5EH7acIJg9U8UOKb5nph+AVMB
         5je+cQtZfhg/BB+RZ9FC9g5ltyfxUifrJSPceNLrZm6IVxLv111QbkpLjZNQ+SVOL+lX
         /cEMoToM3jWWWWVxmFeczy5dTAh9hiZAMYMffrqFGUTU6XJNcluLIUcfKau2dA3DzGAE
         KAwZ7iNodN4Aglg41y7n1JTC7nZ1UkIGAddcziWl/vjkaQP25wch/czuUVgNVDX8BC+B
         U23zfYP2ptRawnHOWjsg52CQX6YnBARUz/gAH5fF4YBSWvpV11mcC/DAH6MeOkx8yYGZ
         TAHg==
X-Gm-Message-State: ANhLgQ3D+7g91BtcCLr2/FozLtsnyuVjzJC9a6xyOR5b6YpXZiaAoA4P
        eREutiEDpXkpPg2/wqtMZ1fqjr5oGoqUVigLddILBg==
X-Google-Smtp-Source: ADFU+vsi1Klgo/S/FdHxIWPK9P9ShlnthCiWV9ZZu6tRuUYnKUIrlQ/qP+es3vWg5zlmvil9LtGmfBtxpp7eEz+zyUY=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr2748819ljo.165.1584640912850;
 Thu, 19 Mar 2020 11:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200319123928.635114118@linuxfoundation.org>
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 Mar 2020 23:31:41 +0530
Message-ID: <CA+G9fYu-stvngbff5S7oKFBxqBxu0A49bXE6OviwF6=SUxa_Qg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/90] 4.9.217-rc1 review
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

On Thu, 19 Mar 2020 at 18:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.217 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 21 Mar 2020 12:37:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.217-rc1.gz
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

kernel: 4.9.217-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 8130ba7a9b6d7bce0ecd428b5d085ea493ff3bd0
git describe: v4.9.216-91-g8130ba7a9b6d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.216-91-g8130ba7a9b6d

No regressions (compared to build v4.9.216)

Fixes (compared to build v4.9.216)

Ran 20213 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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
* kvm-unit-tests
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* network-basic-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
