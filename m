Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589FC2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596657075;
	bh=j63MAwl01weAgVUq7FF6PNkkZ3MlN8FVYIe4cGDMSu8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pUhA4n6uMoGlg28AF82HQd4MFc04wA+XIrZ3FxWD95FoSBE0nVFScjkYwEFKEa+j8
	 aN6/jB1wdF65B5YwbgRo/DryU4dk7ylQiWWxX6jpqOEyKsGdaQ07AIsX+cCyk3zRMq
	 f8dLXleAia4WH7De/tNDP+WMyxqOVozIyd1InZ0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHETvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgHETuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:50:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38296C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 12:50:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x24so10192332otp.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VuI/sJKChWIgcA9YX17Vw0/G7XG/JpOM9iBt62Uihj0=;
        b=QyMrRJ2Sdo1u1Ywbj9MGXheY1I0xnqtLQfoPR3Om141/eW9ET5BsyaqPDvXBZB4GTs
         v0A3L/WNkHm9SCfyID7NAx9JCGgnfJfc9Go+T9kxD8QefiCVxXfGfLoezYJQYdUqjoWp
         snrKykkM1x5AvEB4ZkAGuuGfzAjmCDL3T3xMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VuI/sJKChWIgcA9YX17Vw0/G7XG/JpOM9iBt62Uihj0=;
        b=E6FjQWibGYUQAM+x26vGwYADNFNvr+WvO5+v8Zr5N9NB9WMv6WckZXjXBqj/0zsfm/
         1thuxyb/ofwzYZYk21NLbILgL+arDa9A/lbXd3+rqtW63BOStcWuT14XXUpFXzocGfca
         vpVfqXKLaP5zUS5aAj4s/cRqPjEXn8AIESRZMPedxGKVoJhKjHJOPHWHlCfvCqypxawX
         JogfmjXoNBpLJ/MFxsj2TmxniRLz1MDGFtxcWb0mTyrz3/LRJNX9nanIRiwFH3nd/wyN
         CRTXqkrPUedKk4P+vGAWQFh7Xq77lk2B++x58kKMUgSj/adVJsqnzpIDRpyayOP8mK1j
         /ugA==
X-Gm-Message-State: AOAM530h3sD0DeGZcUh74jJ2zCAnkuYo3QOGeU4J7XZXsf1rhQo+312Q
        E/CVd/IaJpJ2eHKMEi0UOkyM5Q==
X-Google-Smtp-Source: ABdhPJzVbpJRF9EmzEMLmBRCP07DM7eTcfR++AGDxEhQrnCm23HC8AzoYmVBFzNMocQQh1OVmG5p2g==
X-Received: by 2002:a9d:3bb5:: with SMTP id k50mr3971985otc.361.1596657043297;
        Wed, 05 Aug 2020 12:50:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a66sm638956oob.44.2020.08.05.12.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:50:42 -0700 (PDT)
Subject: Re: [PATCH] selftests: more general make nesting support
To:     Greg Thelen <gthelen@google.com>, Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200728073241.3625015-1-gthelen@google.com>
 <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d949545-a7f2-4057-1204-600eabfd8f28@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 13:50:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHH2K0bU7w_rbKN_f0Fe_ZdGLtgBz_GVKS3eottTtm8P7QGoJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 1:36 PM, Greg Thelen wrote:
> On Tue, Jul 28, 2020 at 12:32 AM Greg Thelen <gthelen@google.com> wrote:
>>
>> selftests can be built from the toplevel kernel makefile (e.g. make
>> kselftest-all) or directly (make -C tools/testing/selftests all).
>>
>> The toplevel kernel makefile explicitly disables implicit rules with
>> "MAKEFLAGS += -rR", which is passed to tools/testing/selftests.  Some
>> selftest makefiles require implicit make rules, which is why
>> commit 67d8712dcc70 ("selftests: Fix build failures when invoked from
>> kselftest target") reenables implicit rules by clearing MAKEFLAGS if
>> MAKELEVEL=1.
>>
>> So far so good.  However, if the toplevel makefile is called from an
>> outer makefile then MAKELEVEL will be elevated, which breaks the
>> MAKELEVEL equality test.
>> Example wrapped makefile error:
>>    $ cat ~/Makefile
>>    all:
>>          $(MAKE) defconfig
>>          $(MAKE) kselftest-all
>>    $ make -sf ~/Makefile
>>      futex_wait_timeout.c /src/tools/testing/selftests/kselftest_harness.h   /src/tools/testing/selftests/kselftest.h ../include/futextest.h ../include/atomic.h ../include/logging.h -lpthread -lrt -o /src/tools/testing/selftests/futex/functional/futex_wait_timeout
>>    make[4]: futex_wait_timeout.c: Command not found
>>
>> Rather than checking $(MAKELEVEL), check for $(LINK.c), which is a more
>> direct side effect of "make -R".  This enables arbitrary makefile
>> nesting.
>>
>> Signed-off-by: Greg Thelen <gthelen@google.com>
>> ---
>>   tools/testing/selftests/Makefile | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 1195bd85af38..289a2e4b3f6f 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -84,10 +84,10 @@ endif
>>   # of the targets gets built.
>>   FORCE_TARGETS ?=
>>
>> -# Clear LDFLAGS and MAKEFLAGS if called from main
>> -# Makefile to avoid test build failures when test
>> -# Makefile doesn't have explicit build rules.
>> -ifeq (1,$(MAKELEVEL))
>> +# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
>> +# implicit rules to sub-test Makefiles which avoids build failures in test
>> +# Makefile that don't have explicit build rules.
>> +ifeq (,$(LINK.c))
>>   override LDFLAGS =
>>   override MAKEFLAGS =
>>   endif
>> --
>> 2.28.0.rc0.142.g3c755180ce-goog
> 
> Is there any feedback on this patch?  It's not high priority but something that
> will help me make more use of selftests.
> 

No issues with the patch. I will apply it once the merge window ends.

thanks,
-- Shuah
