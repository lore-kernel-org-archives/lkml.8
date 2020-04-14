Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA1DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82882074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljkywbh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391802AbgDNVQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732367AbgDNVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:16:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3657C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:16:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l25so15064698qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfEBpoByh/EF6RzNjsQpd80C4dsY79aLZ3TtEdxZIzU=;
        b=ljkywbh0N5mD20pRb2kUxBzu2PtcjtaGV+YjeyV+vUzyoOJm561CktJY0po2GRGSer
         soycIhyrbtNaExpkhTfnC+OmqlJHZ1vGDSzYhf8+DHqFcYFMV6w6PJ/CzquVGAUE8aLD
         W9Fq4oNNev7idGdFll9Hm9cogo7BTNnqtWFQ/bovYEhfWROBi6LVhVebi7uh6uPcifuV
         Cxyaf0AH0/bevZyh2XRGYiihntTWOVU7RzXrYybhEvRVhhhtEybs6aQNzmnFIo8Pr05R
         rpBBbxBEMwhM0rRHTRCYaIZrKhNMlOW9uS2rcBN563SCIeKU38OYx8xEdEsmUp90WY5h
         itow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfEBpoByh/EF6RzNjsQpd80C4dsY79aLZ3TtEdxZIzU=;
        b=FkBcChodGkHN5Sv5Y1LPF8znCc2t48T1FFheqBATjH6Ehf7FFe9mEG2yt70Ijf6/hH
         0VWDSAy/YBdPk2tIPD4XIg8egOM7nQ9OjSKUppLOAIJnWYJT1EbKo9OeAslsP1gHUDNK
         AT9WXtzXosrcbhX7nNg9IhCU9lvMOOlWypMb6MUHvz1v6N0IyM1XVru2UBBcTylMn6Ac
         ZkBdaqAyXywWPRRk2Is5+fgzobTgYBe6nOrXdBD+SPLwaHUmGSkaQ2hlo8TwUhO5u9rt
         izoJtuypEXvcaGGvHz9B1q84Z9S8EYffiEt7YEEqPxzXHH0OYF0dhs45ZXhc59pg8DxZ
         G/wA==
X-Gm-Message-State: AGi0PuZj3wl/R7gekEcaY1mkzR7/uai9I4T/Oo6ug+QRP09q6Ep+FmfI
        ZBmbrHfph5+f0DXAB3HbngffqA==
X-Google-Smtp-Source: APiQypKmBlJchqItznjyFCxnnycv8Cu9zEvAt7gbn5ztWS9pDiT3iE8Fu+iubmGKiZaV48sOkGfFRg==
X-Received: by 2002:a37:dd5:: with SMTP id 204mr13977379qkn.321.1586898967524;
        Tue, 14 Apr 2020 14:16:07 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id x18sm3518598qkn.107.2020.04.14.14.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 14:16:06 -0700 (PDT)
Subject: Re: perf: add cond_resched() to task_function_call()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
References: <20200414190351.16893-1-brho@google.com>
 <20200414204208.GI2483@worktop.programming.kicks-ass.net>
From:   Barret Rhoden <brho@google.com>
Message-ID: <bbec4199-37ef-fda2-b18f-3d485c1d5b70@google.com>
Date:   Tue, 14 Apr 2020 17:16:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200414204208.GI2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 4:42 PM, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 03:03:51PM -0400, Barret Rhoden wrote:
>> Under rare circumstances, task_function_call() can repeatedly fail and
>> cause a soft lockup.
>>
>> There is a slight race where the process is no longer running on the cpu
>> we targeted by the time remote_function() runs.  The code will simply
>> try again.  If we are very unlucky, this will continue to fail, until a
>> watchdog fires.  This can happen in a heavily loaded, multi-core virtual
>> machine.
> 
> Sigh,.. virt again :/
> 
>> Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
>> Signed-off-by: Barret Rhoden <brho@google.com>
>> ---
>>   kernel/events/core.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 55e44417f66d..65c2c05e24c2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -99,7 +99,7 @@ static void remote_function(void *data)
>>    *
>>    * returns: @func return value, or
>>    *	    -ESRCH  - when the process isn't running
>> - *	    -EAGAIN - when the process moved away
>> + *	    -ENXIO  - when the cpu the process was on has gone offline
>>    */
> 
> Hurm.. I don't think that was actually intended behaviour.

Yeah, I noticed we never return EAGAIN, so I figured I'd look for any 
other potential return values.

> As long as
> the task lives we ought to retry. Luckily I don't think the current code
> cares much, it'll loop again on the caller side.
> 
> With the exception of perf_cgroup_attach() that is, that might actually
> be broken because of this.
> 
>>   static int
>>   task_function_call(struct task_struct *p, remote_function_f func, void *info)
>> @@ -112,11 +112,15 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>>   	};
>>   	int ret;
>>   
>> -	do {
>> -		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
>> +	while (1) {
>> +		ret = smp_call_function_single(task_cpu(p), remote_function,
>> +					       &data, 1);
>>   		if (!ret)
>>   			ret = data.ret;
>> -	} while (ret == -EAGAIN);
>> +		if (ret != -EAGAIN)
>> +			break;
>> +		cond_resched();
>> +	}
> 
> So how about we make that:
> 
> 	for (;;) {
> 		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
> 		ret = !ret ? data.ret : -EAGAIN;
> 
> 		if (ret != -EAGAIN)
> 			break;
> 
> 		cond_resched();
> 	}
> 
> Or something like that, hmmm?

Can do.  I can put a comment in too.  /* Retry due to any failure in 
smp_call_function */ or something.

Thanks,

Barret



