Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77610C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768B20738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591115555;
	bh=v+Lmvib+NCsRI5ziuPVAAr+k1HI+OxAfCHs4MqKV0S8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=BUXA0CA8bnBL7o6dEtE+Cstzb5T/+sEKGGOyu5CCYp47FJhEf9CrR0iwWTMedo1RI
	 qbycyGHjSsBQi6ootNvwoF8bFCPRK2CGuafP0PwCu4myaCh4ou/02l2aTGjmv54JDc
	 eWv0RWgFy05/z1RwVryw0cIm0taQFPI14VC9EzK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgFBQce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:32:33 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD82C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:32:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id p70so7886315oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIPqrxkSqnuynSyRY7vRQBZYHR+WMgRkEpmVgbjrHTc=;
        b=HG6Wxw5rrMdJqd7hGhdtskkbbmAPB2XQ3eAV+2Qcl4rpBYsCOjygxljQAyM2Jy1kkk
         XFsQwe32kPYBzlFBb+/7mRLKidJ8bE8akWMH+cBzQ8TYU6c/cKGrZwdDuhsQkBuWfPbB
         rvCONwG6lFEiU8Bpx5royuU3hazmbnnAxlavo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIPqrxkSqnuynSyRY7vRQBZYHR+WMgRkEpmVgbjrHTc=;
        b=aFR12Ui0aGfP4ULfrADbJKJdgcMbj70jk1uL31WOKKR3JVxMvj9jPAG9V/ZAy5sBap
         /AG6Mua7ULiGqwsywxuNkY8ulkJPLqkCcb8+wU34gKgzl7wEoum0VPX0n7o0VZPsQErf
         fNQ2XSm3ZfSp/hn3q5fLOhmNAcNrS1Boai1HkMDKm+KKYFSyysIcruIMmlwgav5ns7D0
         kOLUMqVlvn1xmFKZ46LYKvSeaQjPaaWW9T+RB7Ta+bP8bO9baiB6goMm6SliftnXLeTl
         +RZ+s3cocS/6Z5iWjAVKGX5eUPsK7YY9/FAtNMWg5kbVpUmfPzqQrRj2TgGM5s7gsJJv
         iT8Q==
X-Gm-Message-State: AOAM53194qNj776sjeC8Z/M7Nf1qHlySqn6ctgQDFZCcy7WzUgZ5J5J+
        R6ynIWkIDfYE60HUyHKpFUgLYw==
X-Google-Smtp-Source: ABdhPJyuZvnoCIiugarIgnNCPIIZA/ndxaeoH02CojLkcB8mkMHhNJzZuOixiJQetxBh///FWvlBuA==
X-Received: by 2002:aca:4c15:: with SMTP id z21mr3660499oia.85.1591115552974;
        Tue, 02 Jun 2020 09:32:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 33sm751060ott.0.2020.06.02.09.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 09:32:32 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and sysctl
 test to run
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
 <20200529233942.a47bbd8e918175e9af3fefab@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <834784a5-835f-d42d-9cdb-2dbf3139f0b5@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 10:32:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529233942.a47bbd8e918175e9af3fefab@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 8:39 AM, Masami Hiramatsu wrote:
> On Fri, 29 May 2020 08:14:39 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 5/28/20 8:51 AM, Masami Hiramatsu wrote:
>>> Hi,
>>>
>>> Recently, I found some tests were always skipped.
>>> Here is a series of patches to fix those issues.
>>>
>>> The prime_numbers test is skipped in some cases because
>>> prime_numbers.ko is not always compiled.
>>> Since the CONFIG_PRIME_NUMBERS is not independently
>>> configurable item (it has no title and help), it is enabled
>>> only if other configs (DRM_DEBUG_SELFTEST etc.) select it.
>>>
>>> To fix this issue, I added a title and help for
>>> CONFIG_PRIME_NUMBERS.
>>>
>>> The sysctl test is skipped because
>>>    - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
>>>      since lib/test_sysctl.c doesn't use module_init(), the
>>>      test_syscall is not listed under /sys/module/ and the
>>>      test script gives up.
>>>    - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
>>>      /sys/modules/test_sysctl before loading module and gives up.
>>>    - Ayway, since the test module introduces useless sysctl
>>>      interface to the kernel, it would better be a module.
>>>
>>> This series includes fixes for above 3 points.
>>>    - Fix lib/test_sysctl.c to use module_init()
>>>    - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
>>>      test module if it is not loaded (nor embedded).
>>>    - Fix tools/testing/selftests/sysctl/config to require
>>>      CONFIG_TEST_SYSCTL=m, not y.
>>>
>>> Thank you,
>>>
>>> ---
>>>
>>> Masami Hiramatsu (4):
>>>         lib: Make prime number generator independently selectable
>>>         lib: Make test_sysctl initialized as module
>>>         selftests/sysctl: Fix to load test_sysctl module
>>>         selftests/sysctl: Make sysctl test driver as a module
>>>
>>>
>>>    lib/math/Kconfig                         |    7 ++++++-
>>>    lib/test_sysctl.c                        |    2 +-
>>>    tools/testing/selftests/sysctl/config    |    2 +-
>>>    tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
>>>    4 files changed, 10 insertions(+), 14 deletions(-)
>>>
>>> --
>>> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
>>>
>>
>> Thanks Masami. I see Kees reviewing patches. I will wait for Luis to
>> weigh in on patch 2 before pulling this series in.
> 
> OK, Thanks Shuah!
> 
> 

Applied to linux-kselftest next for Linux 5.8-rc1.

thanks,
-- Shuah
