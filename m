Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFECC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC93920836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588350636;
	bh=OXb02bI1WpoGKZyUOGQozY1aAUU8jKFmuDBnZRwg4y4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Xi1Itk3B8LAovfvfbcZ1eAH75fW6/idOA75mbbt+QUZ42cvR00ti5KslpuCFaWLMw
	 NjNt1aN/STJG1wopGNFUqjZ2tRBJ1HhCwY1eJJGCqvvf4uknP+h/DAIbMdBcE0YmT3
	 omlWXnhu6cpIZlBD7M5in1XRm1u3kBj43k5X9Q/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgEAQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgEAQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:30:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88613C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 09:30:34 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y26so5400783ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZFbo13vf2wV07Z9Rw/Rb5UPHeQ2gxDTLd7RnWBUNYY=;
        b=iJ1jj+9uj29mf+kASJ6SUBvTuuTjHrib0DC3j8oRbbzAbNcPJee6k1g5j2V+5gLEey
         unvXOu5nkU7cZ03JmDWz+XDhzEpCjA+HYZxy9m9kzq7dL0oB34jCs5i3Dt1RSkUh0v56
         j1A+Mt6uyDIT1Yg9e50BhxUxPffIpRmkBjr0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZFbo13vf2wV07Z9Rw/Rb5UPHeQ2gxDTLd7RnWBUNYY=;
        b=IKsssgBOz+JQqK5bbheZi5qftXWQy9DEk7hE8L9VDsbaYYLoJ4ZM6Cu8BK/8DSmEG8
         HoO8n7RsDK+jL84pU3Np3wYa+4xTt1FtFwmviSv3bPMDbkKDpQsgMpvoacJ4ww2T5Vl7
         71quv8SKGUKCx9G5+pl1M0O63wAWUKsBLm5YsInP3Ozv/2Z/AFjspzlKeL0T6PXZ0ztR
         mQIZZTK8n5R6ObIhT22pd8kSlEb+IMOssplmfr9hHAttrV3k5zhgxSPobQ61Xw63MVJG
         oHw5c3PXmubsQ1U+GkicF0oJ9UmTZK/5jcN0U5ylzWjCPw5+d31pPz0f+HGH2+46qKqu
         LxwQ==
X-Gm-Message-State: AGi0PubDyKLLSYzHCUv+kvAm8pM0NRLB20uZJOCTYjcDiFy/60pbJoof
        tlY0g+ygBv2m0sa22jdjWb6oVw==
X-Google-Smtp-Source: APiQypK0sA8GMasF8F7ZJqVaCHv+QQtf+EfHM9CfJZjEsbjjhxSBR16yz2faTqw2X6RdIj/Ca21SPw==
X-Received: by 2002:a02:6a4e:: with SMTP id m14mr4044212jaf.17.1588350632708;
        Fri, 01 May 2020 09:30:32 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n8sm1451816ili.18.2020.05.01.09.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 09:30:32 -0700 (PDT)
Subject: Re: [PATCH 2/3] selftests/ftrace: Pick only the first kprobe event to
 test
To:     Steven Rostedt <rostedt@goodmis.org>, shuah <shuah@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>, skhan@linuxfoundation.org
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
 <158834027133.28357.11196486193798517250.stgit@devnote2>
 <20200501101718.5a15e557@gandalf.local.home>
 <7751734b-83f1-bf14-9d8e-9092b0b7be3e@kernel.org>
 <20200501122049.46a93bb5@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1bb4a6f8-eafe-7c2d-c6a2-1caae7cc91b9@linuxfoundation.org>
Date:   Fri, 1 May 2020 10:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501122049.46a93bb5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 10:20 AM, Steven Rostedt wrote:
> On Fri, 1 May 2020 09:38:59 -0600
> shuah <shuah@kernel.org> wrote:
> 
>> On 5/1/20 8:17 AM, Steven Rostedt wrote:
>>> On Fri,  1 May 2020 22:37:51 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>    
>>>> Since the kprobe/kprobe_args_type.tc reads out all event logs
>>>> from the trace buffer, the test can fail if there is another
>>>> fork event happens.
>>>> Use head command to pick only the first kprobe event from
>>>> the trace buffer to test the argument types.
>>>>
>>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>> ---
>>>>    .../ftrace/test.d/kprobe/kprobe_args_type.tc       |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> index 1bcb67dcae26..81490ecaaa92 100644
>>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
>>>> @@ -38,7 +38,7 @@ for width in 64 32 16 8; do
>>>>      echo 0 > events/kprobes/testprobe/enable
>>>>    
>>>>      : "Confirm the arguments is recorded in given types correctly"
>>>> -  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>>> +  ARGS=`grep "testprobe" trace | head -n 1 | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
>>>>      check_types $ARGS $width
>>>>    
>>>>      : "Clear event for next loop"
>>>
>>> I think I've manually added this exact change to my tests to keep it from
>>> failing.
>>>
>>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>    
>>
>> Does this conflict with:
>>
>> Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> Date:   Tue Apr 7 14:34:19 2020 +0800
>>
>>       selftests/ftrace: Check the first record for kprobe_args_type.tc
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=f0c0d0cf590f71b2213b29a7ded2cde3d0a1a0ba
>>
>> I went into mainline yesterday in my rc4 pull request.
>>
>> Exact change it appears.
> 
> Ah, then I guess we don't need this patch ;-)
> 

I took the first one. Will wait for patch 3 to finalize.

thanks,
-- Shuah

