Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F627C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3864220678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8oR9weK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgDBKcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:32:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41882 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbgDBKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:32:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id z23so2264151lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ro0CogBYYjuA62vAbM80wVHB24xVv3Q40zimujI6KXA=;
        b=r8oR9weKNXCqbqE5ekp0DK/F6D89bSUiMNlHkA9R6oOobeN9BJyvyxUkfvRWKE4FrU
         btv2h9XEiEIxh1IUccBaZcVzuRUvf75I2f7K5t7U1sNTIcuxRWkLs3GE8wZLGyVFnVGH
         AM9ZcO+oywRQxOmI9t2WQVzgv5vw0lbAqO9bLo6ogb/Ta7T2lGfTmsIFY0ws6+/A94lV
         /f1eRD1Fc9hzpaBtkxbgf/BfPGDWo6lSjYZwmjhV19BTmtXi6yK8MFxRa8ZYGCgB9qa1
         uyqwaZT/IR9a4/CdvYzVqH/JWtAgUgHi4enBeEbVef8i39JUHT7L31qiwu5x8VQE1gxF
         9BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ro0CogBYYjuA62vAbM80wVHB24xVv3Q40zimujI6KXA=;
        b=ddu6oaI2wAFDC5Wku17StDj3/7EVB3TwsvnX0pVY0tiMAOt1pN5h9Xxp0IMexnmDLa
         C+HwL6szmIH13E6yUO0WVLY+3TfvdFARHP1ZTdDDyRBVG3yAdiF4S7OiyAsmdK405Aqw
         nxGy/8kYRdOo9QS4isIQ4TQ2X/5vc7CVESL3Ghvj6cDlNAH45Qyn367dOH5arqt7lUi2
         QgThnbFIoUFKqRFbYw2P2uhues5w/SGmMiO5yJk0/w+94wmiKqiaGO+vUR3BDpYdLpzi
         MKaJLV8n1JiQIe45QInJhxYCpHwv/kwk8LAuPOEbn2zA8ZYsSayVLEUQdHNi3THYmbRk
         SPFA==
X-Gm-Message-State: AGi0PuaWtwx4wWtMviusV7ebo3aHqtAFwylw+43BM0cQmryAu/f6dvEM
        SNDsb1C9UUGEsCPwwSVivxv2nDiEBa2ozfINSyDrsg==
X-Google-Smtp-Source: APiQypK23l3GKZs4THJ0s9wkxNxcLM/eSwKmnKXkDhGaM4XYH2BrHPHCEZEjqEGPZRYdFSRbCIw+bW4ntwRelVKFgww=
X-Received: by 2002:ac2:5211:: with SMTP id a17mr1729763lfl.167.1585823526830;
 Thu, 02 Apr 2020 03:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200401161413.974936041@linuxfoundation.org>
In-Reply-To: <20200401161413.974936041@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Apr 2020 16:01:54 +0530
Message-ID: <CA+G9fYv=2KC+Gx7wv2iDtsNBcKG2PaXndtLuT+FRmqyk7bEX3w@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/10] 5.6.2-rc1 review
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

On Wed, 1 Apr 2020 at 21:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.2 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.6.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 6c8d51f98078987586685d72fd3d66b88f3f965a
git describe: v5.6.1-11-g6c8d51f98078
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.1-11-g6c8d51f98078


No regressions (compared to build v5.6.1)


No fixes (compared to build v5.6.1)

Ran 18887 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2800
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* v4l2-compliance
* ltp-ipc-tests
* kvm-unit-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-open-posix-tests
* ltp-sched-tests

--=20
Linaro LKFT
https://lkft.linaro.org
