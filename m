Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE29C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EB720656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597092517;
	bh=CJxHJyYPh4sd8+xKF1x/GCeV4gWwpq1v2JRe8PQjKxI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RwXyVerfDF+5ypVX7CHdrORKtCUK3SNP9YVJEupzpZmeq+caO44Jk4L23mv3+5V3y
	 MZLbRliGjGYwPJClgZsFQoRVzuQqAXgSYzd13SJPgq4ZNcrh1iWHY+IElw3y2DZXg6
	 A6Ky4sSSAO7DwnaxgsqYJdSANYV2YcexFQKG+11U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHJUsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHJUsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:48:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C98C061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so10214438oid.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HCy6i5v2uQPcGgYPgbWpEYC90RU3lqb1roEUwPBfbUA=;
        b=fZW+MG/wCF4Bnlk4iWk+xw22uu4WXXDFRJQpuKQjSUmw9DPTF+y+coS9v4tFOfi6aI
         wHx8Nkrz9Hv1pV2ZxvuM6CGEH5kb52yV2Mcga8tbMKujSsXmve3xLmfiWmd3KWAuZ8x1
         IdkYIU/eB/zhAIDEnXzrQIbvMqfjK7dGCfgUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HCy6i5v2uQPcGgYPgbWpEYC90RU3lqb1roEUwPBfbUA=;
        b=FSVF9D6RiCeUIalXoYEwPSiotccqL1dQ7/aZGJMZsTcxlaAdQ3KztO4hocccxYKTz3
         EfXuGj4uJEUw8Qgz7WqpG07zlZnyeHbzWKmgRAxJuH1C6p6h6Ym8MwoheVJEeVwnPCSD
         DKv+LS/5BcnWa5DlyFoUvVOG/yfvjNyBgbcUix3RSK0iQ0HOlz/++pJuDBVMWXwZtqnu
         WSAZeQKuLgAfsvbs9Tn75fqhzdFXwUZ5iTUl4klYTlFmbyROLJPpctwk9p8jDqmJnPab
         v4O17GAhjEPGYMnFEnliwPlGBFEH4Kmc1lDMxMPxwk4rqS6o/VFnJHZhSbH3mmYfiC1N
         7OVQ==
X-Gm-Message-State: AOAM533sYSwVRFgiOBa9kt72kAKXV7OEJTQXP0ySRTHFzl3btdGpzCQ0
        gyb5k9kPWxmfqv5uoEMUutexjQ==
X-Google-Smtp-Source: ABdhPJy2B9YVgRyfunUoFHeDPYYOPWC97qorZyFNJmxDPPI3Bm5etCnyi2XAKhl+VMe2WO9nucQ5SQ==
X-Received: by 2002:aca:e144:: with SMTP id y65mr848801oig.101.1597092515295;
        Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m8sm2190593oim.23.2020.08.10.13.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:48:34 -0700 (PDT)
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     John Stultz <john.stultz@linaro.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, joe.lawrence@redhat.com,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
 <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c635a95-0762-9026-edba-bcbf4835f42f@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 14:48:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 3:38 PM, John Stultz wrote:
> On Tue, Mar 17, 2020 at 7:42 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>>
>> The following 4 tests in timers can take longer than the default 45
>> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
>> Add 45 second timeout per test") to run:
>>    * nsleep-lat - 2m7.350s
>>    * set-timer-lat - 2m0.66s
>>    * inconsistency-check - 1m45.074s
>>    * raw_skew - 2m0.013s
>>
>> Thus they will be marked as failed with the current 45s setting:
>>    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>>    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>>    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>>    not ok 7 selftests: timers: raw_skew # TIMEOUT
>>
>> Disable the timeout setting for timers can make these tests finish
>> properly:
>>    ok 3 selftests: timers: nsleep-lat
>>    ok 4 selftests: timers: set-timer-lat
>>    ok 6 selftests: timers: inconsistency-check
>>    ok 7 selftests: timers: raw_skew
>>
>> https://bugs.launchpad.net/bugs/1864626
>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
>> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>> ---
>>   tools/testing/selftests/timers/Makefile | 1 +
>>   tools/testing/selftests/timers/settings | 1 +
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 tools/testing/selftests/timers/settings
>>
>> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
>> index 7656c7c..0e73a16 100644
>> --- a/tools/testing/selftests/timers/Makefile
>> +++ b/tools/testing/selftests/timers/Makefile
>> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>>
>>   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>>
>> +TEST_FILES := settings
>>
>>   include ../lib.mk
>>
>> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
>> new file mode 100644
>> index 0000000..e7b9417
>> --- /dev/null
>> +++ b/tools/testing/selftests/timers/settings
>> @@ -0,0 +1 @@
>> +timeout=0
>> --
> 
> Apologies for missing this before.  I've not tested with this, but it
> sounds sane to me. A number of the timekeeping tests do take a while
> to run.
> 
> Acked-by: John Stultz <john.stultz@linaro.org>
> 

Thanks. I will get this in for 5.9-rc2 fixes update.

thanks,
-- Shuah

