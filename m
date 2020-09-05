Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADE8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8791F206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6WsoWXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgIEPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgIEPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:42:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D8C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 08:42:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a8so3233842ilk.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oavwsui6np9I0SfKH1zAjIQ7ScxL8JKCQoJQZLHKCqc=;
        b=R6WsoWXsX3lDoDV9TSgES6XDTt1pcEoS8Le8Le5Fk8z+JYSMc82y/2smFqKPoeZ3dd
         MqroeFGZ2WR5psSrtu0+5AmVDGxoTFmEXiLVrkt4kRvI5AwMCem47nWVGFzAM4nXgfwD
         x2+e30bcBj6cRLA401fxyESjAIuGE7C8Ynf2Xb9uOA+RTS9/cUF0hwKPOUKcIiCoPwcD
         eID/CMQS1b4D+D4oc6dTmrTBgvy36Zv0WEXpnGca84WtkA1xOmRYW1+dspml3u9vFmMf
         063LpY3dlQT8btXVH/eOE9qZexDLFkejTJ0r8MbjatMZouHK7HBZRB6FY2bDeoW6NuTt
         iCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=oavwsui6np9I0SfKH1zAjIQ7ScxL8JKCQoJQZLHKCqc=;
        b=qBCQwz8JHU5Na2y3gXu9p/hh9edtvRvpjlBiUr2IUHsGKhYYSppWrV9L3lTM18OnXR
         NSe8KNhd3ujcRnQ/CPyNxoT13S/lDPbMcXtmyxwwqI4SIMmZdKxe08UjK/V81X1cd8W/
         O+FK0hkBPkr2cC6Kz0V+knjdeGdpAIJIj3vrXm2xLn3YPqxhMVVat/HRYvdOcgY+NPsf
         8o4T1EvpM9z0f4SlUTelwe3KCdy0OEXTxi2C28xUNMVt2P9FBy/cXLIh3IHelwIkMNB6
         anLtd5cKLWtnpkHqxdJKZnA/iPRrkD912Aw2GQe3KRmDBRLPIE0rXonw/MADW1unOVge
         t7eA==
X-Gm-Message-State: AOAM5317Pn6f+UuvrhF+VLRL8QfzWnSYHv2F4NzwZXIXMtyS7eHi15s1
        vedeDjjtQcpgPkHU7E7nWu41Cg==
X-Google-Smtp-Source: ABdhPJxcw6xsEQPHoX5ZPR5XyUr4+XR87kRTiIKJKtBnMz6G01P7DuSk7X6dEo44hRKuMAMUHyjJhA==
X-Received: by 2002:a92:35d0:: with SMTP id c77mr11513440ilf.183.1599320530673;
        Sat, 05 Sep 2020 08:42:10 -0700 (PDT)
Received: from localhost ([2601:441:27f:8f73:89be:770e:7358:ee10])
        by smtp.gmail.com with ESMTPSA id o12sm227414ilq.29.2020.09.05.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 08:42:10 -0700 (PDT)
Date:   Sat, 5 Sep 2020 10:42:09 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 5.8 00/17] 5.8.7-rc1 review
Message-ID: <20200905154209.gpv5povvpn2v3i3o@nuc.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20200904120257.983551609@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904120257.983551609@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:29:59PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.7 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


Summary
------------------------------------------------------------------------

kernel: 5.8.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.8.y
git commit: 072d7559faf2a3b9f3c93e5cc96b276c6f02adec
git describe: v5.8.5-272-g072d7559faf2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.8-oe/build/v5.8.5-272-g072d7559faf2

No regressions (compared to build v5.8.5)

No fixes (compared to build v5.8.5)

Ran 35624 total tests in the following environments and test suites.

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
* igt-gpu-tools
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* ltp-cve-tests
* ltp-sched-tests
* v4l2-compliance
* ltp-open-posix-tests
* network-basic-tests

--
Linaro LKFT
https://lkft.linaro.org
