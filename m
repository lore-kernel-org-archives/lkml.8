Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB05C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CAA21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDK9kCkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBDREj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:04:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43292 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBDREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:04:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so19360707ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nt7CE8qs1Z/UFG2lKpIThN+DMppMwf6bhXCmE+krseE=;
        b=rDK9kCkLe1zZbD6nNr5wvuOWv50YVDMFMKyi1xpZrM/8c9Ixoj+hP/F5TGE1jgbNpX
         BlIZuFuQEg6MeUpcSCLbFCWr1w1+CcTvgEnqGGg2N//6ASflIKZD98Z52etlQmA4YZ5P
         aM91B+8shpB131KwUa0HbcxK5imZ2fTne4XmQ/c7U6BYb+rnNbjhR2BLFJiPyamK1qkc
         kMLnG+QNlvt1ENPxmNa2A2ep4hnyRMXJwDJGyZpKOiJ/gxGOkYO4SOChfnluYZsRZqr8
         vFQlK4y89DRdft22WzyUD4LMf133UbMWWW9FQcdZJVplIj8YuYOIH+9ffaOHhTfEj9N6
         XSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nt7CE8qs1Z/UFG2lKpIThN+DMppMwf6bhXCmE+krseE=;
        b=slOgbK5TVjMKILRRcQplRSy0bmnuItd80Gg6zlqI6xT7RgsGYyd80hFJ8DEpa5ZiER
         J2Rjp1x6NxUQS74v+t3DiV39I4I8G8S9h60T/trLSQNlKNZZOfIqeie6XGO2qu2lgcLv
         GiT2zy/MoK96fLmMdRAsYH3sYvG2Klh0QtVkEHkCPg50Ji88jKsEGnPUIp7zLd2Jy03c
         lHiWmb/tsQ8TdD2gB5MwGbMl5uGIItW6F/KOcxC03XizGtmo3x6dKwRCCe+Qt10M8pEG
         wLtMDLxU8k8K4nmJLRW5qzbsygKpdCv4fYEIb/VCEnOO5K/5h4gDhe2qKWvfwk1Ll05z
         JcHg==
X-Gm-Message-State: APjAAAWKJhKOPTPxBpZHgYspgen6++8Y5OSKeiymzQEbaIO3rmWYQaFC
        IRebO4hZ3aq1wti/c375+Pt+XB9XbPt5ph6KgFv1Op936AU=
X-Google-Smtp-Source: APXvYqwKjoM2CReeoU99n52JalOT+ZG+hYUolRReR/VFzI9vW6bCRE9Zx5z+tXFptEhWd7DeBsIJoSX6k+rI56a2KB0=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr17156736lja.165.1580835876578;
 Tue, 04 Feb 2020 09:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20200203161917.612554987@linuxfoundation.org>
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Feb 2020 22:34:25 +0530
Message-ID: <CA+G9fYusNeJtrBBHL=dUFP3Z=-7Ri6qk6u8a0eZ=euQWU6=O4g@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/90] 5.4.18-stable review
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

On Mon, 3 Feb 2020 at 22:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.18 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.18-rc1.gz
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

kernel: 5.4.18-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: a59b851019bc15226d5c7c31ac4e0452e9a57d13
git describe: v5.4.17-102-ga59b851019bc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.17-102-ga59b851019bc

No regressions (compared to build v5.4.17)

No fixes (compared to build v5.4.17)


Ran 11805 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-cve-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
