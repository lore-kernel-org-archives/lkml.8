Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D2CC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4E22467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfxxUEdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOCJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:09:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgAOCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:09:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so14689745oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 18:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7uM5kBcx/zHaTreKqdDg8fjWc4PLFMKHCKkiwTso/jo=;
        b=ZfxxUEdOVsywPoSBUddAsLUC+kSWA24U3zKvRAPZB2us1gRO+uO0hl4gCP/z5SdBfo
         09dt/YGO0xyTUJuljF/d8wPJXgLPnksvkCZR0yv0P7K4kWZfhR3MajwQhQ8EniSIfKLb
         q7CVm6QQzui7ZL1Zgz2XP6ZOYiuvlEtQUd7D6J8FJhJVbEq5gB9/gc96SF0vxQ3FlSBy
         43nc0kTe8mEDTjobdDGvxsfdOG+xNBHpB8+3dXWQBnLFpJDCuJr8dpl4/IoediMOr/uW
         eDoB1pUu5RHpN1wcOPoTHWRtb8fAx1psmU6N+dbuPUPtqS2J9IdN8U5pmFsDkI99qfpB
         yCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uM5kBcx/zHaTreKqdDg8fjWc4PLFMKHCKkiwTso/jo=;
        b=gjOB7rBIK+lyZPQUA44+mBgV70T2qMOs3ctiRsejHYWRzE42Vcl2Xv706akOzsqkQD
         qUbH4naau9gpn3N/sXBLGqW6dF38G47ms9Vye8tcqBrD+wZn6feFk+xYCDpXF0gN1dHH
         e+7vVYZ4dMl9b+k4YfZr7OCZubhGp1uZQVPENvKlZprbPXVkpoc5UTBXo9DiF5MNEvW0
         RPiX+5DLIQohN05SgD9PL8fHNXDU0wBvAMIxcdmAdPE1xm0RMgZgJrCEakSU79UNqQfB
         8XFoA93cnMCtDRoSq92zLOel4evVZ1tzf+kZHNjAQUBa7AdFKh5He/vLaPcg1rGkNTPt
         ntjQ==
X-Gm-Message-State: APjAAAVv/syFjcVXuGs96TxJNkKZryLvRy6lTms80I2G3U1AtazdM8An
        7QTZ8RsYeC1OaNfes+JQ1x2GTA==
X-Google-Smtp-Source: APXvYqygvcVQdrnEonMD3gUfWOZPAA12WX1BReU9IP6tWFzw6tAB4ckJHD55Cb3XjZNKtDe4fTnLng==
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr1123420otn.140.1579054144624;
        Tue, 14 Jan 2020 18:09:04 -0800 (PST)
Received: from [192.168.17.59] ([189.219.74.147])
        by smtp.gmail.com with ESMTPSA id m68sm5203237oig.50.2020.01.14.18.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 18:09:03 -0800 (PST)
Subject: Re: [PATCH 4.19 00/46] 4.19.96-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200114094339.608068818@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <f69c24e7-fe61-7649-0ea0-b47d25ba4092@linaro.org>
Date:   Tue, 14 Jan 2020 20:09:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/14/20 4:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.96 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.96-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: dfa0afa6c9845af29354433fb8c28e08f11733df
git describe: v4.19.95-47-gdfa0afa6c984
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.95-47-gdfa0afa6c984


No regressions (compared to build v4.19.95)

No fixes (compared to build v4.19.95)

Ran 20866 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* kvm-unit-tests
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
* ltp-fs-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* ssuite
* v4l2-compliance


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


-- 
Linaro LKFT
https://lkft.linaro.org
