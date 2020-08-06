Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E2C433F8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBC122D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IB6QoC49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgHFIqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgHFIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:46:38 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ADDC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 01:46:38 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y18so31324829ilp.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AUV9gwNNNAz81m3MmOY2nRo3UHjqXanOCYEOS2ok5fQ=;
        b=IB6QoC49uRVwqBk5+hSBpu3XAUc3D91Th49QxMSL8T2PaFqfDo6+z36IM+FelVoZr3
         VXZRTp0n9P+csfMH3xmk2W3D/Ugme45j+R6/cJ+5p8nYgnEHqb/pAxCUcUkjmcammuwv
         J3z0cFopM8PQUfuO4eebv8qK0VrAYpUCLTkvKY0bIkx7mJNiIlVLjwjSUcmtj/bGj2w/
         DWi8lX7oRLOIdN1Z4d42y+d5bUn333dJ/UpcVx+BZSvS11GFuAYANr8VGHj1GQ3Udjc1
         N0Srczs+PVMsenhEsWOuqBcj/pqmTi/P2Bn0i5TtsZvxOcu3Z4bOFYx+0jw9EdbR2APp
         LBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AUV9gwNNNAz81m3MmOY2nRo3UHjqXanOCYEOS2ok5fQ=;
        b=iulOg02OwLnsdYiZ2ScEoTUnh694GsYhMTBf4vpkJB4qi5gsORDtxZWp3cR45lmMdh
         qtH6CbwsPMjxwnnAa2WheTBnXXbuCGX4T7cErPnIX0YXVGcmPKP4DeTx0JA7FNwGfEhL
         j0xCDYo5KpM7U17FDXrbiv2c5u8OL1u9Lcj2nA/ZzWsFat/k+e7KUW8eoq+G/EUEIXfe
         hBmIKeLbcIW3oW9IC+ucs7tmhtdT8hgaIkZBD5tMAgHAlFjnZYgMV3sLPELp/MVAxcgp
         u7uizFz3Yr1/3yVPN4XdkKELuyZ5PVv3+Otz3Q2Up4Dq2h7Evsucqlk1cKnqidd8ic/i
         GR/A==
X-Gm-Message-State: AOAM530cYCvE+gUc85CFfpF2g0Tp9lxPPhqTsDClqbnNuKR9Tg83m+tT
        qsKDh/g9iHEtOPe0GXflzx7Qsx6syyGle1HNJ8/20kYi3AsLTg==
X-Google-Smtp-Source: ABdhPJzLlBUXOZ0bsydfJN0TKPYyEaw2QrCqQUV0BErxjUj2+aqp7Si1oKDVuCs402dztEcDZAYvsNfO+dcnHrmskOY=
X-Received: by 2002:a92:96c7:: with SMTP id g190mr9039730ilh.252.1596703597262;
 Thu, 06 Aug 2020 01:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200805195916.183355405@linuxfoundation.org>
In-Reply-To: <20200805195916.183355405@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Aug 2020 14:16:26 +0530
Message-ID: <CA+G9fYs-vNeH=BCbFZAA28-C=dE+iajWEF+0vvgZMwr=yw-5xA@mail.gmail.com>
Subject: Re: [PATCH 5.7 0/7] 5.7.14-rc2 review
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

On Thu, 6 Aug 2020 at 01:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.14 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Aug 2020 19:59:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.14-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 0ceaad177e510974c093f79a5d1f3bb058a4fdf2
git describe: v5.7.13-8-g0ceaad177e51
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.13-8-g0ceaad177e51


No regressions (compared to build v5.7.12-117-gd3223abaf6fd)


No fixes (compared to build v5.7.12-117-gd3223abaf6fd)

Ran 30546 total tests in the following environments and test suites.

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
