Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E9C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD18208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582238615;
	bh=fqS/GgJhbDw3EiROWcshwv2AULT4Lp4hI49kgB6rvjI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lX5NAFijn/7qgSnfpdJFirB/icXXa3cR8XGFC1qbHZaIESX+iD9C9VnLFYvXcEyB0
	 7pJjmJCDLOFVQn5emnpsz1NUT6EU9Wc3bbYmCBQejqjnBFE7dgFE3Z9TX8Y0098Qqy
	 9qoB+4E4X7JQhiwLk+D8PcWlECbM//OWh9n0cmp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgBTWne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:43:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42861 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBTWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:43:33 -0500
Received: by mail-io1-f65.google.com with SMTP id z1so238589iom.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QMjt5eMffPrxsp8wLASdON0xDaLfdUvYn5lYknm2C7s=;
        b=U5BnmuHOGKVpr/W6Cro6664PAOER/DtOGOsEpfY5j6rtJSGN9oL0XY/pMjcABpYdAK
         nQp3dt8cHofYWcHKPvSP2oThQHseVJShwHXr49gfQrO3wh6N6CB6jYZb725MViJB5CEX
         Oe/gc/VYz5Cz9/0vnBKWZzKirh1zXqDLTtkF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QMjt5eMffPrxsp8wLASdON0xDaLfdUvYn5lYknm2C7s=;
        b=mbc/xvxRe9uHTNlwHKgo0F+NLRg7hTCtY5Ns870MJoWQLYirf8TgQYa8Pva+GcuTPI
         43BE6BpaGh4HU9oUT8hXL4cz9SHYk4LAfe6HMRlUCuZtbUWQ5DdPiZ2Ts/UD6jwkiURl
         ejFBOMxVKC+Lm9qQJdtxtdQwhJ5uaIWPMtaVzkIqSpNSgWRccf0N0XelUp7H77tVHws9
         AN9cluyK1XvW6/Qhjp3DW/yZi0PFl878WJKcuMUtNrtaRqhQA7+/LMZEMWLTrqnolHd2
         cD4VIxc2gn86KlHblUs8S6LfjjU0YDH2ZtVU+d8ICWQ/l5b0pZ0BV2NgsvjG1GnPjyLH
         fUug==
X-Gm-Message-State: APjAAAXxFjLyp6/XQIYaIxcTnrZTruL7RjU+32wKhjNEDIizMERuTg9d
        3fDFNyyMw5nfFa+qzMF6LTkjHq9oPws=
X-Google-Smtp-Source: APXvYqwCY4UOWE++mhaJRMIkoNG+w9qtz8+0BXm1Ky4fUgUzfUISeECpFGgnh904ZRETno0/85HHnQ==
X-Received: by 2002:a5d:8ad8:: with SMTP id e24mr27269446iot.291.1582238611058;
        Thu, 20 Feb 2020 14:43:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h19sm229536ild.76.2020.02.20.14.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:43:30 -0800 (PST)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
 <85385291-b039-c72d-508a-0b988c1302b5@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d3965bbe-973a-ddc2-044d-4a79864710a9@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 15:43:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <85385291-b039-c72d-508a-0b988c1302b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 3:25 PM, Joe Lawrence wrote:
> On 2/19/20 11:42 PM, Michael Ellerman wrote:
>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>> timeout per test") added a 45 second timeout for tests, and also added
>> a way for tests to customise the timeout via a settings file.
>>
>> For example the ftrace tests take multiple minutes to run, so they
>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>> timeout setting").
>>
>> This works when the tests are run from the source tree. However if the
>> tests are installed with "make -C tools/testing/selftests install",
>> the settings files are not copied into the install directory. When the
>> tests are then run from the install directory the longer timeouts are
>> not applied and the tests timeout incorrectly.
>>
>> So add the settings files to TEST_FILES of the appropriate Makefiles
>> to cause the settings files to be installed using the existing install
>> logic.
>>
>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second 
>> timeout per test")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   tools/testing/selftests/ftrace/Makefile    | 2 +-
>>   tools/testing/selftests/livepatch/Makefile | 2 ++
>>   tools/testing/selftests/net/mptcp/Makefile | 2 ++
>>   tools/testing/selftests/rseq/Makefile      | 2 ++
>>   tools/testing/selftests/rtc/Makefile       | 2 ++
>>   5 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/Makefile 
>> b/tools/testing/selftests/ftrace/Makefile
>> index cd1f5b3a7774..d6e106fbce11 100644
>> --- a/tools/testing/selftests/ftrace/Makefile
>> +++ b/tools/testing/selftests/ftrace/Makefile
>> @@ -2,7 +2,7 @@
>>   all:
>>   TEST_PROGS := ftracetest
>> -TEST_FILES := test.d
>> +TEST_FILES := test.d settings
>>   EXTRA_CLEAN := $(OUTPUT)/logs/*
>>   include ../lib.mk
>> diff --git a/tools/testing/selftests/livepatch/Makefile 
>> b/tools/testing/selftests/livepatch/Makefile
>> index 3876d8d62494..1acc9e1fa3fb 100644
>> --- a/tools/testing/selftests/livepatch/Makefile
>> +++ b/tools/testing/selftests/livepatch/Makefile
>> @@ -8,4 +8,6 @@ TEST_PROGS := \
>>       test-state.sh \
>>       test-ftrace.sh
>> +TEST_FILES := settings
>> +
>>   include ../lib.mk
>> diff --git a/tools/testing/selftests/net/mptcp/Makefile 
>> b/tools/testing/selftests/net/mptcp/Makefile
>> index 93de52016dde..ba450e62dc5b 100644
>> --- a/tools/testing/selftests/net/mptcp/Makefile
>> +++ b/tools/testing/selftests/net/mptcp/Makefile
>> @@ -8,6 +8,8 @@ TEST_PROGS := mptcp_connect.sh
>>   TEST_GEN_FILES = mptcp_connect
>> +TEST_FILES := settings
>> +
>>   EXTRA_CLEAN := *.pcap
>>   include ../../lib.mk
>> diff --git a/tools/testing/selftests/rseq/Makefile 
>> b/tools/testing/selftests/rseq/Makefile
>> index d6469535630a..f1053630bb6f 100644
>> --- a/tools/testing/selftests/rseq/Makefile
>> +++ b/tools/testing/selftests/rseq/Makefile
>> @@ -19,6 +19,8 @@ TEST_GEN_PROGS_EXTENDED = librseq.so
>>   TEST_PROGS = run_param_test.sh
>> +TEST_FILES := settings
>> +
>>   include ../lib.mk
>>   $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
>> diff --git a/tools/testing/selftests/rtc/Makefile 
>> b/tools/testing/selftests/rtc/Makefile
>> index de9c8566672a..90fa1a346908 100644
>> --- a/tools/testing/selftests/rtc/Makefile
>> +++ b/tools/testing/selftests/rtc/Makefile
>> @@ -6,4 +6,6 @@ TEST_GEN_PROGS = rtctest
>>   TEST_GEN_PROGS_EXTENDED = setdate
>> +TEST_FILES := settings
>> +
>>   include ../lib.mk
>>
> 
> Looks good to me,
> 
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> 

Thanks for Ack. I already applied it to kselftest fixes branch.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

thanks,
-- Shuah



