Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329972077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585262029;
	bh=jd4Y+6N5rNGyGPYAl5OwO+RyRTpcNli8YQTfvDwC6Zc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=itivp1VIhVaTOri7/w1AWlm2qwXn3YZpzoUJEhZGHHE/haxPiuGXuMxRsFQAaNrEq
	 0iZKimTwQjIKq3sRPBMqKHIr/UhkAlX2tOJOEQlGW8/bnE/O6FDpqA3WEenfjsha4o
	 C/Syg1B4txQz1cG/YfGD5vhtX1QwFelWoziuvg0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCZWds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:33:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43280 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:33:48 -0400
Received: by mail-il1-f194.google.com with SMTP id g15so6985842ilj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjtLmei14Aqe6drnic5xmk3O+peLFqdWaisNXVkXGdU=;
        b=LDp1HOz4HRDcpEUE/IODV5zUi8p4m/bTmt+Due8jI4CRWUH08jE3IOL0+gMN7atpoA
         gTRYN4GEg+beygpKEJUpyOj5DLy7Aya6zVDZFacmvFjxr0x8yaK+xuZefyLMLtVSCXHQ
         lDcPSqUMxCawAdciC6sGGZPl5FsLBpvCs/cuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjtLmei14Aqe6drnic5xmk3O+peLFqdWaisNXVkXGdU=;
        b=pAzk2nvQu9yUZgKrLPZ8g08Sc19q6qAnWtzCko7MdHKOEPKCZmHTYAnGfHd/dtpqOi
         tSqARnQ5NNYxUct+gh+COgN8p0Wy5pOpnk4Vdgmph8Ynt+X/E5TQfw7GcGTmQ0nTRtwh
         /+v9ZJwcv1sX4Ss2oqiK+bX/uUfH2YxOxdt7c/43O96snArWaYnqjN6Ly+MA9X0X3XVQ
         hczFUs962+IzW8jD9f1jIs+c/9a/J4tftnET4a9QQ+f0ppPifAa+JYKQJMcOPkB/h3P/
         vQJfAdNefhAfL8HqwQ3yBebT4/8Hoj2dJg4LR4N9vZw8xK7ouk8yP0cZVfdRtZhW2Vu9
         7N3g==
X-Gm-Message-State: ANhLgQ1WcyIyCASdgdK+mBjVpDMUmYpEUcdfMFitDU0eJNzReqbG9qJZ
        aK6ctoFxSjGpA6hhLpF2+gSMwA==
X-Google-Smtp-Source: ADFU+vtMO7/dx04DcpOtgDV7w5GSmDnkphd5lBOQl2I1jSMmN1W9RaTneGmqZD3lGbRVl2wtOisAng==
X-Received: by 2002:a92:359b:: with SMTP id c27mr10690452ilf.148.1585262026859;
        Thu, 26 Mar 2020 15:33:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j84sm1238655ili.65.2020.03.26.15.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 15:33:46 -0700 (PDT)
Subject: Re: [PATCH] selftests: Fix memfd to support relocatable build
 (O=objdir)
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200325231709.13122-1-skhan@linuxfoundation.org>
 <MWHPR13MB08955F0F8C5D0B07CA86DA92FDCF0@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3fa8af77-4b4b-c1e2-2467-fb7b9adb3f66@linuxfoundation.org>
Date:   Thu, 26 Mar 2020 16:33:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <MWHPR13MB08955F0F8C5D0B07CA86DA92FDCF0@MWHPR13MB0895.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 4:23 PM, Bird, Tim wrote:
>> -----Original Message-----
>> From: Shuah Khan
>>
>> Fix memfd to support relocatable build (O=objdir). This calls out
>> source files necessary to build tests and simplfies the dependency
>> enforcement.
>>
>> Tested the following:
>>
>> Note that cross-build for fuse_mnt has dependency on -lfuse.
>>
>> make all
>> make clean
>> make kselftest-install O=/arm64_build/ ARCH=arm64 HOSTCC=gcc \
>> CROSS_COMPILE=aarch64-linux-gnu- TARGETS=memfd
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/memfd/Makefile | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
>> index 53a848109f7b..0a15f9e23431 100644
>> --- a/tools/testing/selftests/memfd/Makefile
>> +++ b/tools/testing/selftests/memfd/Makefile
>> @@ -4,9 +4,8 @@ CFLAGS += -I../../../../include/uapi/
>>   CFLAGS += -I../../../../include/
>>   CFLAGS += -I../../../../usr/include/
>>
>> -TEST_GEN_PROGS := memfd_test
>> +TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
>>   TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
>> -TEST_GEN_FILES := fuse_mnt fuse_test
>>
>>   fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
>>
>> @@ -14,7 +13,7 @@ include ../lib.mk
>>
>>   $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
> 
> Sorry to interject here.  This comment doesn't have to do with this patch,
> but the above line is problematical for cross-compilation.
> $(shell pkg-config fuse --libs) will use pkg-config from the host
> machine, and may produce something different from what's
> installed on the target.  For most enterprise and desktop systems
> library paths for are mostly standardized.  The effect is that if
> you're doing 'simple' embedded, the pkg-config output on the
> host will match that of the target board.  However, in some
> embedded products the partition and filesystem setups are
> often quite complicated (e.g. I recently worked on a TV set with 14
> partitions) and things are not in the locations preferred by the
> Filesystem Hierarchy Standard.
> 
> When cross-compiling for our products, we tend to use the pkg-config
> from the filesystem of the target (a copy of which is on the host), rather
> than the host's pkg-config.
> 
Thanks for bringing attention to the issue. This is an existing
issue. Thankfully this is one of the two tests that use pkg-config.

The problem is limited to just two tests that are included in the
Makefile TARGETS.

> I don't have a board in my test lab where this shows up, nor a
> proposed solution at the moment, but I'm just mentioning it as a
> potential host-environment build contamination issue.  Maybe I
> should start keeping a list, and start thinking of possible solutions for
> more of these types of issues.


Thanks for bringing attention to the issue. I will keep an eye out for
this kind of usage during my reviews.

> 
> P.S. I'd ignore this issue for approving this patch.  I'm just bringing
> it up as a red flag for future work.

Thanks. This is an existing problem that can be addressed in a separate
page.

thanks,
-- Shuah
