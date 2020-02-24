Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0BC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6020658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9dov9AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXEYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:24:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33995 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgBXEYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:24:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so8512435ljc.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 20:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrhnLhFbW+fdvfBMAqRskaBbHVZAIsNvMbf8wfengAw=;
        b=y9dov9AMvYV8Pxi1Hadtwz+FKkbfO9Hua8zZPNRv0gA74ecQ7VFdmSLYG9NvHeijUw
         Yz3ZRxI2wTmYrgFC5SwRVN6Odbp+G1ab6Q5clGXV7osmJ+1z4h20wV4HhryZYwaf9+OE
         qWgsT+dxGdj+B1hmHQNZiHNq+HiUXfTpjhW9DYNHQi7eikOK9yDdCxNq28FD/utaZZCo
         N7ewkzckr+UpKR8VfQhLLUSgMhxxiAsQhUwFAD9HuNoWUzkvQ1lxJFCUgPCDxbfxDtBu
         KyY4mQNUkbGsRXEDkdxS9msDqEg1O+wWGLUjjI8D5SwpJig/Sw1PJ8IoAFu/LkTFIjG8
         e+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrhnLhFbW+fdvfBMAqRskaBbHVZAIsNvMbf8wfengAw=;
        b=lmj5l6HL6WLgMfUJ6e0iGwBIwdtBjzAhReWhYQOoWGfUD3kv0WbSkKHEIkcdrFhP4v
         9MMheDcPQBmSP0fRkdWYiC1Ek1zayVWJcsoPTUsMpZDXEnofypoUMFuuwQKOoeJ93mMy
         L43BlvJu8Of3ZWLnjKxxXkME9ATsrXmesvJ723QO37848a4mxNc5lCmrM3GqpFA4fmKL
         bRAm1A1A91L+b4A9JsppHn9Eyqo+4Ylq6Zet0ZBLFp/Ze/ivHA3EfrPoXViFzT+MbQvV
         6yi1IrUTS7esHmeNUyQNkHMiTuneuEMtpMM5fwj4MQZbCh8Oz9pFkY/Xi6X5t3D63599
         6FUA==
X-Gm-Message-State: APjAAAUzeplKPrTxbcyhmZrEPilid9xbc3qGbmvL2q/g9asgm85oCg3w
        gtuKZBwIp6zNcuOJKKqlIwfFhfOD7HAzqHQSW/Fuqg==
X-Google-Smtp-Source: APXvYqx+pWYHpXMdStz7hfn1G1V+Ky6Ob/qeQhcIKsMe21mDhFskaaTTeOQhW9hd+tTiafi5Wyd2fbNte/0LQQIh6sQ=
X-Received: by 2002:a05:651c:1072:: with SMTP id y18mr29835061ljm.243.1582518287981;
 Sun, 23 Feb 2020 20:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20200221072349.335551332@linuxfoundation.org> <20200223154049.GB131562@kroah.com>
 <20200223173142.GB485503@kroah.com>
In-Reply-To: <20200223173142.GB485503@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 24 Feb 2020 09:54:36 +0530
Message-ID: <CA+G9fYvdHV3pACCHXhBLSkXmrpB1OALFVYHZsyTWNwvOy1Zj8g@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/344] 5.4.22-stable review
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

On Sun, 23 Feb 2020 at 23:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> -rc3 is out:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.22-rc3.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.22-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 3b5dde2478ad5b400cc44737c1a26e9503608360
git describe: v5.4.21-338-g3b5dde2478ad
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.21-338-g3b5dde2478ad

No regressions (compared to build v5.4.21)

No fixes (compared to build v5.4.21)


Ran 27869 total tests in the following environments and test suites.

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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
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
* ltp-fs-tests
* ltp-fsx-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* ltp-cap_bounds-64k-page_size-tests
* ltp-cap_bounds-kasan-tests
* ltp-commands-64k-page_size-tests
* ltp-commands-kasan-tests
* ltp-containers-64k-page_size-tests
* ltp-containers-kasan-tests
* ltp-cpuhotplug-64k-page_size-tests
* ltp-cpuhotplug-kasan-tests
* ltp-cve-64k-page_size-tests
* ltp-dio-64k-page_size-tests
* ltp-dio-kasan-tests
* ltp-fcntl-locktests-64k-page_size-tests
* ltp-fcntl-locktests-kasan-tests
* ltp-filecaps-64k-page_size-tests
* ltp-filecaps-kasan-tests
* ltp-fs-64k-page_size-tests
* ltp-fs-kasan-tests
* ltp-fs_bind-64k-page_size-tests
* ltp-fs_bind-kasan-tests
* ltp-fs_perms_simple-64k-page_size-tests
* ltp-fs_perms_simple-kasan-tests
* ltp-fsx-64k-page_size-tests
* ltp-fsx-kasan-tests
* ltp-hugetlb-64k-page_size-tests
* ltp-hugetlb-kasan-tests
* ltp-io-64k-page_size-tests
* ltp-io-kasan-tests
* ltp-ipc-64k-page_size-tests
* ltp-ipc-kasan-tests
* ltp-math-64k-page_size-tests
* ltp-math-kasan-tests
* ltp-mm-kasan-tests
* ltp-nptl-64k-page_size-tests
* ltp-nptl-kasan-tests
* ltp-pty-64k-page_size-tests
* ltp-pty-kasan-tests
* ltp-sched-64k-page_size-tests
* ltp-sched-kasan-tests
* ltp-securebits-64k-page_size-tests
* ltp-securebits-kasan-tests
* ltp-syscalls-64k-page_size-tests
* ltp-syscalls-compat-tests
* ltp-syscalls-kasan-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
