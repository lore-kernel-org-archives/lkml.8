Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D33520760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhMsa0bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgFJH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgFJH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:29:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC62C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:29:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so1187227ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S4520mPx6/XI4Hbtkt/4ezv66JxfySEf4E1AXaLXpxg=;
        b=qhMsa0bt0zRQ3TZyjzZYrcnCYpgkAhVyKHP/zg1YgKDY4RIMZhqOYc+ARgJALqLbK4
         t6N3Xw/kfHxdvi5n4PgsrhiC4d1LxselH+fWMbr6TW2SDZuFUzi453LkW2cXUitDPFMT
         on8oQGwWwyQyZfOyFZ1PeIRL+tYWcUMo0mv8iJQ+jZzHiPOo8q+xuf+4hSI38DdDT0bI
         6zb25NuoX3+cWMoHLw5VSMgMHryxnhgV+GdIFj3h+0qY5RN9h4hKVKvlS1/5w6e0gD22
         N+Vo7jXv0N8cHH+538ZpzdPS9lpxm67qTk0jHwALgtp1Iz0gqX3KrRviWzlESCyal3E6
         5Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S4520mPx6/XI4Hbtkt/4ezv66JxfySEf4E1AXaLXpxg=;
        b=EyawCHm6wFa8g5ZSQs+peHnudTjDEwKCb6W+/laoFy8ZvCsxgdB/h0Emr85IPunJMU
         GBI+FFoYLBWYWWj4Oc0q9HPoF/n1WO54jJ1ITB3ZWumeV3wsvtFEE08q+Q2OgU6hCRXQ
         ZsPIvHTn5wx8qjaHjq1Wp8cAg6owom5pR+6PcmhTtbm+wUlZFH5MMCEXmYIdKmWZDX3y
         1TPNKIbvHHqfKcN5KO2Ga1k7lBkETq9hfl9Hg1MCwNlH8BgSgXWjabC11TunZXPb1IdP
         8r2q1MCbGD43JKua+VgWl4+3QJ+olTZS9XD66TppWI0HUhCawZjglhtWtdICSK7FH9NM
         IWDA==
X-Gm-Message-State: AOAM531GfC8chqzHp99KVg0aK7nOqsw6/hv5qpg4PjgnKloG2AFDMW0k
        OR17A2iU3v8ivpr8B5ridZwId1tVJJCtsdlGKVagbw==
X-Google-Smtp-Source: ABdhPJyifAUzBsAhPXNjznTzv09gwe+IcDWUww83HInSZcklfsrMZQXPSTkdEHdjQpikUg8UyB0/UK+8is55wBOu1EA=
X-Received: by 2002:a2e:984b:: with SMTP id e11mr976917ljj.358.1591774181157;
 Wed, 10 Jun 2020 00:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200609190050.275446645@linuxfoundation.org>
In-Reply-To: <20200609190050.275446645@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 12:59:29 +0530
Message-ID: <CA+G9fYvZvFpS_oFjum1mv6=S0riQ0ayz=VnDozRYda2i6vg4jA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/46] 4.14.184-rc2 review
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

On Wed, 10 Jun 2020 at 00:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.184 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 19:00:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.184-rc2.gz
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

kernel: 4.14.184-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 9817cdae1b62b5a7d9c2b690e448512bbe175285
git describe: v4.14.183-47-g9817cdae1b62
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.183-47-g9817cdae1b62

No regressions (compared to build v4.14.183)

No fixes (compared to build v4.14.183)

Ran 24848 total tests in the following environments and test suites.

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
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
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
* kvm-unit-tests
* ltp-controllers-tests
* network-basic-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
