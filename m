Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93BF2078E
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytKWBar2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgIEPfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgIEPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:35:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA1C061245
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 08:35:00 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so9999171iol.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FgE5DBRJlBr/4aFWGhAUrsUktVhmprhT+4kWUP8qkyA=;
        b=ytKWBar2ju/kJ2uyu3g7iL9+cwyYfW6avu1XsLMsiSKLt/m+txSYCX88h1BFkM03Sl
         y1C7klZu7VjLT1ng/I6Yby1sc4xrZLZ+cKX+bop1XIz/OnZ7ZBZBMc0zDRoIgFxGfmco
         +0eMrkTaM3sF6doQ6+OftV67LPXNpyY9kI2ZfO4XflWgWblof1uEMpdy6RIzKPt6jkh1
         gaWHlE/87+apLJR02YsWThwGdLVkCV6F6/E33n7acp+cn2LyEbNnRuANVzwFLtSyxoJB
         0yovv8LqncnrOopXb9FzDJuGq5RUvrAI7nrjWT4bsQickxOAXC2oH66HHRyGqkxrxjXL
         eHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FgE5DBRJlBr/4aFWGhAUrsUktVhmprhT+4kWUP8qkyA=;
        b=SARSE4OMhRMQcYWRmdzxOcbHR18BwloVsmqDndKVs9c//9JQffGOBTzbexGduwP+Sp
         FJfqjPTiBjaxv+xdOgi4Nr4dip4IUwSzGMmeliU4nOTZc5X5JEvHR0n1a6QLZfpdF2+m
         PQW8gjuuOug/ECtYYWWg/VL6NNutc6ujZXODd6hg4VhSPx1d+NexWoztRHKCZ2z94IWj
         XE5l1I9R18eG+ZiE2HuPwca/ZAgxa+x4J0JHDmCYw+4IS0O4+FhbBhhUWuEUI3DaB9fI
         4xnPxIQaU9ke61EheF1ZH5Lpj63+BiCR8WrcA8vEcB3AQDWdojMEnvRBe4TH6mDyKFkM
         CdhQ==
X-Gm-Message-State: AOAM532akeqG0uAxmRDxNmisgMRSVZWDuGEESJidh2Jqd6PgqqpGaUm6
        8h5eu9mFQZv35ZfB7SsvI7uD7Q==
X-Google-Smtp-Source: ABdhPJwtDyPFYkx3bRMWHw2afDq7/faVp8JQRyjI34W4VqvXeShBnwHbs5SPu9JfnKyKMl2LOwEhPA==
X-Received: by 2002:a02:11c2:: with SMTP id 185mr12488654jaf.35.1599320099391;
        Sat, 05 Sep 2020 08:34:59 -0700 (PDT)
Received: from localhost ([2601:441:27f:8f73:89be:770e:7358:ee10])
        by smtp.gmail.com with ESMTPSA id p17sm5135259ilj.81.2020.09.05.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 08:34:58 -0700 (PDT)
Date:   Sat, 5 Sep 2020 10:34:58 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 5.4 00/16] 5.4.63-rc1 review
Message-ID: <20200905153458.hdamqfp6eq4oyeq6@nuc.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20200904120257.203708503@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904120257.203708503@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:29:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.63 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Sorry for the delay - we are short handed this weekend and I got
confused looking at results yesterday and thought we had a systems
problem. In fact, the problem was that tags/releases weren't pushed to
stable-rc which split-brains our results and I just forgot about that
possibility. Is it possible on your side to automate updating the
stable-rc repo when you publish a stable release?


Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


Summary
------------------------------------------------------------------------

kernel: 5.4.63-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.4.y
git commit: ef2051e79e05700a5c8814fe4d5b7a8a93503251
git describe: v5.4.61-231-gef2051e79e05
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/build/v5.4.61-231-gef2051e79e05

No regressions (compared to build v5.4.61)

No fixes (compared to build v5.4.61)

Ran 34712 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* v4l2-compliance
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-sched-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-tracing-tests
* network-basic-tests
* igt-gpu-tools

--
Linaro LKFT
https://lkft.linaro.org
