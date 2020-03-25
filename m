Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7DC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195EB20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWgQMAhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgCYFqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:46:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37593 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:46:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so755450lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BdWwuudDDflDUrOfnNR3mxZhc7/oi348l0qXQ6eq/t4=;
        b=qWgQMAhR6ho3NklTShbVjNah0x6FOkq5Y64Bfimo2OgqP+UcKx6mTgKrNhFkwX/Vno
         b7ANCo3xvTJ/oaMVn4kBMAhm3CwYKAFKYr30pxb6Z85KwIXQ5kIQU75xExmTey4I4Qli
         aKuJoaLHqUaiBTamgq5W9eKXSQtrhjYuPN4MGDw3Dy8zuA5HwoBuSnbfa8X78fg4T8FJ
         xHv7Z+ChtI6oSc8WyLjFp1HCyHBLB3z5vdZT5xDVrB8StiXd4HMYbFi9qNmDry1But+P
         NZrMAOWB8Ur0zLBwPzVrTp50edOEBbgjlyvEPaOwpHQMaDrgrxfC3zu9rZGGACPNz2OU
         y9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BdWwuudDDflDUrOfnNR3mxZhc7/oi348l0qXQ6eq/t4=;
        b=KhneRCPNSM+TRFcUjkyMynW8mISDcG9nJaNNYl7vhnF/6thAzYZHpBj4WXVqrghZ0a
         Ts7HPLUqh/tOtTnHc648GjxfBEAmWEjVD/zadqreyTPRyYDzv6X9sPSYdhIEjxnXSejU
         8c7FCfWhWjSbyozAdwLjKgRcCqi4UYeYLaty0eTFTW66utIN0iAdAAIze6q10P4g2HRy
         ijcO0hdutxR4a5su20sgtYUw6cqOudZgm/xmrLNV0KBBIO/jSuu/DLxtuBuyjKt4T0Cu
         5VyFvAt21tiKZvAgSJnKqOeCqlbhWDasbXj4ZH9Mnrq/TthknOUDNQzr5Mpgx6PodzNK
         lS8A==
X-Gm-Message-State: ANhLgQ3Thw1AZhkVP8C47EuTAPyoswMqhMdfqKynj48mrfxFqN9+eWge
        BFYyKdSGXUoMUuRFWMOwZ4H6sy5WvuOSfmVxyCgOVw==
X-Google-Smtp-Source: ADFU+vuoZx3N5XKpGlvd0t8IbCuneNsKG1DsN5LbuUGt5DRZyoA8wTzaw8QkRZlKRdTSOAHlN18wbuT3WmGnrbvoAGw=
X-Received: by 2002:a05:6512:21b:: with SMTP id a27mr1119123lfo.55.1585115193952;
 Tue, 24 Mar 2020 22:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200324130808.041360967@linuxfoundation.org>
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 11:16:22 +0530
Message-ID: <CA+G9fYvNRXe7phaXrUeAtx+KUnmRXG7ic=suN9Ek7dgDdYOv6Q@mail.gmail.com>
Subject: Re: [PATCH 5.5 000/119] 5.5.12-rc1 review
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

On Tue, 24 Mar 2020 at 18:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.12 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Mar 2020 13:06:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.5.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: 738ff80e1bc68169f717060d4bca7cb6098741c5
git describe: v5.5.11-120-g738ff80e1bc6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.11-120-g738ff80e1bc6

No regressions (compared to build v5.5.10-55-gbea94317c526)


No fixes (compared to build v5.5.10-55-gbea94317c526)

Ran 37203 total tests in the following environments and test suites.

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
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* perf
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* kselftest
* kvm-unit-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-ipc-tests
* ltp-math-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
