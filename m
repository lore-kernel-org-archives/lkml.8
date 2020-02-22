Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DB8C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF36206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzwZMXsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgBVUaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:30:09 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39556 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgBVUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 15:30:08 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so3311129ywc.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 12:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pANl/cm25p8F7Lt7z5k41FBh3oTmXfWPQ7SyjpUDE8Q=;
        b=uzwZMXsZ1fOemjV1cTeEtqu2Pximz+vGvTZVICFgZmdLJ6WaqZ5ECT8yhqvj5ZIl07
         Q4biIGn/bg+v8fwT/LP9u53pbs+3MFKRTHZBMCIqGAyGco3VC86Wpcy9lLyhfNvai7V1
         U/Hfw1fmdHFMXKfk0l88pbUYQ5601tPNa1HXSWdfeMJDoLUoCXfKnWveMo9D6etvwcGi
         giqEJXn8Z2q0AtrP0KFvhqDV0Xg+G5dWf/6lw1akWUDgtD6DGzNMS6UxMF/rtfs1aIDG
         VrWjgrszll6A0CM5iq9FWWgLmb35lNgCkSnv0qL3VJOEkmE8i39JNHkXELs1Lpy4M6sO
         Ta1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pANl/cm25p8F7Lt7z5k41FBh3oTmXfWPQ7SyjpUDE8Q=;
        b=fJYgYZ1Y+TXlOVijTYagQoYti7z18EiWNla4N3K6K1hRUvUCzLOcH49oXClD07qL6t
         BT6ro6xxtYRwrm1ZAtRtHeNGkidLxLhL1Qd6u8LIFy+cySahrbMzMyivqUd2BtyDmcso
         A2vVzxXrL5al4qY8tAhb9IRD0pfr5jHzTLYvzzZwJ1gdRv0aWB0xEVoDnynmEJM6vrvb
         mzJzpjYPOphwKiO9KTGIc6APrTEGCp3hUcngTbZ8Vxt2MZZukwJ7VQ7tlw7PdMksY4wv
         TEwbWbtlSTsX0X+4fcODL2TaW+qC7DRl34i48vU1z30K1EZMTR3KdbCohi/lxtd8i8pn
         iFTA==
X-Gm-Message-State: APjAAAXIKCwiqHtpEbAzuJnzrtOcglyNdUz6qPn61j9cXLZPZU1Wf/+L
        hA1eBVg3s15aZzWA3On8f6N1nQ==
X-Google-Smtp-Source: APXvYqzzaO8D9fokNAtf0hXUAlkdIik9A2Frknot08xibcIOGDViuUDGqKYawE8vDmpbfKFo3eY5Aw==
X-Received: by 2002:a81:49d2:: with SMTP id w201mr36607726ywa.123.1582403407405;
        Sat, 22 Feb 2020 12:30:07 -0800 (PST)
Received: from localhost (c-75-72-120-152.hsd1.mn.comcast.net. [75.72.120.152])
        by smtp.gmail.com with ESMTPSA id m15sm3028600ywh.78.2020.02.22.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 12:30:06 -0800 (PST)
Date:   Sat, 22 Feb 2020 14:30:05 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/344] 5.4.22-stable review
Message-ID: <20200222203005.b6ahcn2h3bu2tiyb@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20200221072349.335551332@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 08:36:39AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.22 release.
> There are 344 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
Regression detected - no results for 32-bit arm due to build failure
reported at
https://lore.kernel.org/lkml/529a5a4a-974e-995a-9556-c2a14d09bb5d@nvidia.com.

No regressions on arm64, x86_64, and i386.


Summary
------------------------------------------------------------------------

kernel: 5.4.22-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.4.y
git commit: bae6e9bf73af8cae01e99a54d0bedee266637ff8
git describe: v5.4.21-345-gbae6e9bf73af
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/build/v5.4.21-345-gbae6e9bf73af

Regressions (compared to build v5.4.21)
------------------------------------------------------------------------

x15:
  build:
    * build_process


No fixes (compared to build v5.4.21)

Ran 25765 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
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
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
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
* ltp-cve-kasan-tests
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

-- 
Linaro LKFT
https://lkft.linaro.org
