Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E8DC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE28206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582298400;
	bh=Pz/YVCCTVrcpTyLaek/Zp0DHQOtfFP7BAoXy7qYHjgM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2LLrP/4AuXZXs+6Wwhr7zAwEqO6gNrOY1ARwjllljMz5LWMtDJEvxfQHSvhS4zyXY
	 HqE8IXicwfBkU/0Ni9YZnrPl4wSKv5oIJwfxTaQrmwmef6p2V/oDK+9n0eqrg6ReJf
	 212xDs6gA/W71pzITasKN001RsrLBRBAEbn1XOB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgBUPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:19:59 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:47103 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgBUPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:19:58 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so1887373ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SX7k/vfQV/dhyQP7ClRzTcNKQX94s9izZKM/kr6C8dY=;
        b=d2szQq4psDdAZ2NrsbGdyppq9zPx9TfbathddBEW7BQkNKcY7+Nvti9PY6H2821yOG
         dCjWcr4TmsHXmCLUbLo8aqbuy9nCnYtsxul9U/skDECmY3z+3uqOQi4BGvIMCrzTWiS6
         mbl0POX5r94ZmNzClM/MaiQ/akzYT1i+qTjNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX7k/vfQV/dhyQP7ClRzTcNKQX94s9izZKM/kr6C8dY=;
        b=KCa/WiQYc/VSA1+BezWocqQaZjpBbuvvDwn7+wOF00OhDUgSVCOWN3w6UStrHGZFMz
         oSr3pilW+2Qkr1zJ5QMwbrCsywnfNR3PFJVjW64Mcgp0Muip8ncUv8uoByns34w/yIQe
         3B5yzk/RNX9tdKwg3iOLLS3+eJFMCbrga4io3cqQZHbO9j1rcckjWyRgOcFiKMJlsS0R
         yOplss/J6T6gRA8XBQNNpAw2NW5UMHfdzk8eSJqXyF4G9Z3aIfDr+e9fpH03fYBHWoDK
         1f5PYFC/RsS+evoXb+jRZJ0kQBlMpP4yX+rsdNu+E74cm/bbMcLIMyEVEb5Te8LbXOii
         gPVA==
X-Gm-Message-State: APjAAAVW4gw+NqRG28/39x/vnVGKgb0/GIiXlHRyDuUiA7YHA4EKcknC
        RD0UZOO4MhQKcmAnxBXGo88oQA==
X-Google-Smtp-Source: APXvYqx/6YGxRHrzHVGYrP6xZGdO28R/mr4KeY/jym1F67fUOQ88DE/jgI3Pg0Z9rtXPhWyPBCPAgA==
X-Received: by 2002:a92:8307:: with SMTP id f7mr38094818ild.73.1582298397884;
        Fri, 21 Feb 2020 07:19:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r10sm771889iot.28.2020.02.21.07.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 07:19:57 -0800 (PST)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
 <202002201450.A4BB99421@keescook>
 <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
 <87o8tsed6s.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cc3be4bc-52a2-a6a1-2a66-66706f62cd32@linuxfoundation.org>
Date:   Fri, 21 Feb 2020 08:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o8tsed6s.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 10:12 PM, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> On 2/20/20 3:51 PM, Kees Cook wrote:
>>> On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
>>>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>>>> timeout per test") added a 45 second timeout for tests, and also added
>>>> a way for tests to customise the timeout via a settings file.
>>>>
>>>> For example the ftrace tests take multiple minutes to run, so they
>>>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>>>> timeout setting").
>>>>
>>>> This works when the tests are run from the source tree. However if the
>>>> tests are installed with "make -C tools/testing/selftests install",
>>>> the settings files are not copied into the install directory. When the
>>>> tests are then run from the install directory the longer timeouts are
>>>> not applied and the tests timeout incorrectly.
>>>
>>> Eek, yes, nice catch.
>>>
>>>> So add the settings files to TEST_FILES of the appropriate Makefiles
>>>> to cause the settings files to be installed using the existing install
>>>> logic.
>>>
>>> Instead, shouldn't lib.mk "notice" the settings file and automatically
>>> include it in TEST_FILES instead of having to do this in each separate
>>> Makefile?
>>>
>>
>> Let's keep it custom per test for now.
> 
> Yeah that seems less magical.
> 
> FWIW the patch below does work, so it's a small patch, but I'm not sure
> it's worth the added complexity vs just listing the file in the few
> tests that need it.

I am not seeing a whole lot of benefit in doing this in lib.mk
Test authors have to think about which files to include in
TEST_FILES and add it to Makefile anyway.

My second reason is I would like authors to think about the settings
as opposed to just duplicate from another test. This timeout changes
the kselftest run-time and behavior.

I am also finding making features generic has downsides to it unless
we are smart about it. We have several overrides already for things
that made perfect sense to make generic.

> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..82086c6ad5e7 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -20,6 +20,10 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>   
> +ifeq ($(wildcard settings),settings)
> +       TEST_FILES += settings
> +endif
> +
>   ifdef KSFT_KHDR_INSTALL
>   top_srcdir ?= ../../../..
>   include $(top_srcdir)/scripts/subarch.include
> 

Thanks for the patch though. We can consider adding it a later time, if
we see value in making this generic.

thanks,
-- Shuah
