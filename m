Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13072C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75B020814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590761683;
	bh=LaYDDP/aCGgbWGEvHuT/pT04QA8PPM27KnehfyMgMIE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lLeR+cOTjw3zDYm3YrL1ucwokuPkvkdcutJSatOmI3e557YBvVIGMJzFdBZ25CmGD
	 tNTFPTkZ3XF1WIvAGUpzkKNgukqn4taBVOAhlm2do+yr5PywVHVygW++cwR35p7lpB
	 Ct+vikXLLz9mposldwGw3cURU1JookI+lHtsq2mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgE2OOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgE2OOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:14:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD5C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:14:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z3so2001414otp.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwfdBt6MNJ0tS8gZFOZy2adyJ873xKDyxvzwYkXq+q4=;
        b=FtWcJhYo8DaeyqYqrs1fmFDmd/pNzDtwoz0NNOgOtc0UpnlJMkCOVnBJ/zjV/3ckoq
         7u9eJod64sbCWvgOjCLpvLpR1TrslJahPrq+aqT87HyHlYT6laei2vFTt+MkSPbrY/XH
         YqjE7NrL/MEmorW8CTaU/kVke19ceMraHIMCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwfdBt6MNJ0tS8gZFOZy2adyJ873xKDyxvzwYkXq+q4=;
        b=INmmUDH704pd06jN+GrC9IPB6dRrXUq6/z5BIvxUatOOts6KEopalPYaUUi9KI8Tbj
         xGONm72vruzVvBCZjBvb0C4s6yTSZG6pEyVOdT0A6Sz5hzX9s2K1AgO92aZ3FL9wIqHQ
         FbK1L7wF4nD160LCmfOy1ffspJ0B6w0PLlmo8HyvQB686p5tQcxForZabwzbbR7xzptb
         5m/1XOXURHQrYA1Eucpq2kkV2z9qW/ViziGw7b+/bT80ndF4hKtyPue6gFHVm7Gu50Ne
         H155FOeFTC1bENvBl+H+Qjq5rvmtf3XBMKuL0ehrziIIvl3wci1yB/wXBq4e1qtR3RYH
         ux0A==
X-Gm-Message-State: AOAM533IMNP8p4YlV+bucYBRJV9rTlc4zcpq0Omr1n7W7rqlGcjr2nOe
        6JuMYS0WgoEV9MfZxQ0nI/DVUw==
X-Google-Smtp-Source: ABdhPJySK6gsZgroSQhXgG9wNYlbneWRx+x+0IHfUzGT7tDDbhsu+/qEYE9lLrwY48fhUzTVyj8X6Q==
X-Received: by 2002:a9d:400d:: with SMTP id m13mr4694613ote.98.1590761681211;
        Fri, 29 May 2020 07:14:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm2481011otb.47.2020.05.29.07.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 07:14:40 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests, sysctl, lib: Fix prime_numbers and sysctl
 test to run
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <218210da-7d06-5b6e-13af-13a07e8e7064@linuxfoundation.org>
Date:   Fri, 29 May 2020 08:14:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159067751438.229397.6746886115540895104.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 8:51 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Recently, I found some tests were always skipped.
> Here is a series of patches to fix those issues.
> 
> The prime_numbers test is skipped in some cases because
> prime_numbers.ko is not always compiled.
> Since the CONFIG_PRIME_NUMBERS is not independently
> configurable item (it has no title and help), it is enabled
> only if other configs (DRM_DEBUG_SELFTEST etc.) select it.
> 
> To fix this issue, I added a title and help for
> CONFIG_PRIME_NUMBERS.
> 
> The sysctl test is skipped because
>   - selftests/sysctl/config requires CONFIG_TEST_SYSCTL=y. But
>     since lib/test_sysctl.c doesn't use module_init(), the
>     test_syscall is not listed under /sys/module/ and the
>     test script gives up.
>   - Even if we make CONFIG_TEST_SYSCTL=m, the test script checks
>     /sys/modules/test_sysctl before loading module and gives up.
>   - Ayway, since the test module introduces useless sysctl
>     interface to the kernel, it would better be a module.
> 
> This series includes fixes for above 3 points.
>   - Fix lib/test_sysctl.c to use module_init()
>   - Fix tools/testing/selftests/sysctl/sysctl.sh to try to load
>     test module if it is not loaded (nor embedded).
>   - Fix tools/testing/selftests/sysctl/config to require
>     CONFIG_TEST_SYSCTL=m, not y.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>        lib: Make prime number generator independently selectable
>        lib: Make test_sysctl initialized as module
>        selftests/sysctl: Fix to load test_sysctl module
>        selftests/sysctl: Make sysctl test driver as a module
> 
> 
>   lib/math/Kconfig                         |    7 ++++++-
>   lib/test_sysctl.c                        |    2 +-
>   tools/testing/selftests/sysctl/config    |    2 +-
>   tools/testing/selftests/sysctl/sysctl.sh |   13 ++-----------
>   4 files changed, 10 insertions(+), 14 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 

Thanks Masami. I see Kees reviewing patches. I will wait for Luis to
weigh in on patch 2 before pulling this series in.

thanks,
-- Shuah
