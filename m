Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF500C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB6A233F6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLLHIkUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFTEJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 00:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgFTEJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:09:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A86AC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 21:09:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so8872336ote.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 21:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l9K8ae+lidtyP5UW9uUxlzFHevmMqcLSZnLDpYLMTFE=;
        b=WLLHIkUcEj/EblWurrwwuMxHT6siwfMLCeM/oAufRIUTFaBrC2nwASuaTS/GC2TR3x
         0zhi4vnqVKnSXzsKitGHhoqlYnwgIG5f46bRznMTMjhbPcCE2ZLV04ahlZPe8leBIbWo
         lknb+3Ui8/LWH+oUNeODjwr4twwQfldfD+QzlC/aUBkcEFCB0BKwBLOaS5QJHjlULOAM
         hc39aCZFpevSO+GabqG7OZLtQaxfOvlCNm0mSQ/UPDseq74GjswhkSnFw3DZHumSsU0+
         qS7ZUgLPuBqOYm0jJVyzzzIeUZP/dYb6NtoeF0j18V44XERwoL9hLUIw+TAryEmeOHen
         xTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9K8ae+lidtyP5UW9uUxlzFHevmMqcLSZnLDpYLMTFE=;
        b=GnQxwawKPNXLz/pKmQzMGS6fzwwFuHIZphK9MDrF+s/oE70WINa9sgrh+LRIVFZIvY
         ZBRFTfTrTrzFKh8VK3hl02Od6yJf2nBwneHBibB4wpiyPni6gcUpy0vYKrBuHz5IcjXT
         0d71FhT7VB0vxPgtm6869A3HiUrRWGPp5BNRwWGac/t1CmGWrAgAvr7AeM5DDpqO6lHW
         fzZm6kDtCcTOv9qEWpzpefRZY/Rep3e3May6vv56Mpa/gAqdnVZ9NF42sE4kve3W1peb
         7d4YE5Dg5PBTqNWcJhafCBjYOHE80LaeIkj4Q+mn+AWTM//plVvP/rNMDzG3aX3EhvKF
         KAZg==
X-Gm-Message-State: AOAM531cJvQOkdXA9zTWE6ehP8quQALSnYfcPn5tnyFXGe4TJxAyIfOy
        6sVg1QzSEECLLdgOkCwR4LrZBQ==
X-Google-Smtp-Source: ABdhPJxNyiOETnxWNWj6BhThnhrjVRFWpY+PAc4gJDUsVoJ+NpVn31fvhb8Ea69z65L06x9/lUsgUg==
X-Received: by 2002:a9d:1445:: with SMTP id h63mr5495105oth.32.1592626150749;
        Fri, 19 Jun 2020 21:09:10 -0700 (PDT)
Received: from [192.168.17.59] (CableLink-189-219-73-211.Hosts.InterCable.net. [189.219.73.211])
        by smtp.gmail.com with ESMTPSA id v132sm1702345oif.6.2020.06.19.21.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 21:09:09 -0700 (PDT)
Subject: Re: [PATCH 4.19 000/267] 4.19.129-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200619141648.840376470@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <ec4b0b96-5d1f-448d-5f3c-da58ea07368a@linaro.org>
Date:   Fri, 19 Jun 2020 23:09:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/19/20 9:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.129 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 21 Jun 2020 14:15:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.129-rc1.gz
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

kernel: 4.19.129-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.19.y
git commit: a00c59b6375644f707a3554536d03d4ecaf17c05
git describe: v4.19.128-268-ga00c59b63756
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.128-268-ga00c59b63756

No regressions (compared to build v4.19.128)

No fixes (compared to build v4.19.128)

Ran 34131 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* v4l2-compliance

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
