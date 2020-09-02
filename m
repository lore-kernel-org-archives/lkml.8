Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E73C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4AB208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXiCD4p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgIBPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgIBNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:31:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696CC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so2182791pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QqnE1mjS+I4FTToYrCF01Tknyh8nbuS0HjQ3DvAj0xw=;
        b=ZXiCD4p1lUsT0bZRCCEYoZGItvSknNp0exOkzELJmz1TIQjcZmqGjB4j7wiVKc0SH6
         0yEKtD874m9oFGzsu4s/HTOpURwgUIx6t1RJqbT+7TBc9hSFHpFjPDrJLpRo06izCRar
         DL9j5wQZbsm9HHFr4eeHFLXi8V4vJ/+HfnuFdOykaqBuFLykHPLmL1cYjqHpFIDz2t22
         ygMnszhybso7OvuDOMSfgctqy/UO1LrW+YQt5RXyp9Lf6bErZ2rdRSW82RN0Vt0Nwb5k
         e4B1jTK+8GgWLspb39iRfUFzoyBgzz0PSCq+pK3fHMucY0kP1O/nAmZadowB6vSkGaHN
         NIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QqnE1mjS+I4FTToYrCF01Tknyh8nbuS0HjQ3DvAj0xw=;
        b=WAq4Raf9CI3CaJm9fL+XjEkfVlc0zXWOcKkTCnM/OE913w5rSQenXZcTLhWCyvwjeC
         b55SnBc5Rbvd5EQZJf9DD1FUf4qTSSEhhcLLO8sQ0PIXjPFFoQ/m+6dFujHCPwrO5YfX
         U00/3Cr/grD2NJu7Sotc9WDEW/BfZgeTkoMxl8BY3Ctss1nozFi6rUceDhCOTsPoNWYj
         cAiwxr2Ad5mz/L7VS6zGyWaALbQrHUeOZv750UtWw3UWmdDUUZQpKaAc9f90NnAYiAQR
         nzO5sifW3M4dfi0B99sxj0Tz9ANGqEKjtr3VMEUgmMVadaKmqA2u4wxH7BD4QgimvKCo
         XzjQ==
X-Gm-Message-State: AOAM530NQnjXOTPZvXeAVzuG2E4uoJorbUFDnRQcK/c9grb9DBnfqa0a
        CGBRojVwgxhf6NU1PPEkKqpV9KiGvto=
X-Google-Smtp-Source: ABdhPJwu9F6G1e7nNgGx3JhPwduWrQzLJUG0NDK0txYyjtnvOQizMo+j1yn2yJDI8yO9Y30EouT70A==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr2059327pln.166.1599052891941;
        Wed, 02 Sep 2020 06:21:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u22sm5203555pgi.85.2020.09.02.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 06:21:31 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902072432.GI2674@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <44e1d3a7-3cd5-8fa8-7fb2-f82b83a019d7@roeck-us.net>
Date:   Wed, 2 Sep 2020 06:21:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902072432.GI2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 12:24 AM, peterz@infradead.org wrote:
> On Tue, Sep 01, 2020 at 08:51:46PM -0700, Guenter Roeck wrote:
>> On Fri, Aug 21, 2020 at 10:47:49AM +0200, Peter Zijlstra wrote:
>>> The lockdep tracepoints are under the lockdep recursion counter, this
>>> has a bunch of nasty side effects:
>>>
>>>  - TRACE_IRQFLAGS doesn't work across the entire tracepoint
>>>
>>>  - RCU-lockdep doesn't see the tracepoints either, hiding numerous
>>>    "suspicious RCU usage" warnings.
>>>
>>> Pull the trace_lock_*() tracepoints completely out from under the
>>> lockdep recursion handling and completely rely on the trace level
>>> recusion handling -- also, tracing *SHOULD* not be taking locks in any
>>> case.
>>>
>>
>> Wonder what is worse - the problem or its fix. This patch results in
>> a number of WARNING backtraces for several archtectures/platforms.
>> Reverting it fixes the problems.
> 
> Without all this there was a recursion that could crash. But yes,
> tedious.
> 
> OTOH the warnings are about real bugs that were pre-existing, we now see
> them and can fix them.
> 
> I'll reply to ARM separately, but let's have a peek at s390.
> 
>> s390:
>>
>> [   19.490586] =============================
>> [   19.490752] WARNING: suspicious RCU usage
>> [   19.490921] 5.9.0-rc3 #1 Not tainted
>> [   19.491086] -----------------------------
>> [   19.491253] include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!
> 
>> [   19.493147]  [<00000000001d5de2>] lock_acquire+0x41a/0x498
>> [   19.493320]  [<0000000000103b72>] enabled_wait+0xca/0x198
>> [   19.493493]  [<0000000000103f80>] arch_cpu_idle+0x20/0x38
> 
> Does this help?
> 
> ---
> 
> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index c73f50649e7e..f7f1e64e0d98 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -39,14 +39,13 @@ void enabled_wait(void)
>  	local_irq_restore(flags);
>  
>  	/* Account time spent with enabled wait psw loaded as idle time. */
> -	/* XXX seqcount has tracepoints that require RCU */
> -	write_seqcount_begin(&idle->seqcount);
> +	raw_write_seqcount_begin(&idle->seqcount);
>  	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
>  	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
>  	idle->idle_time += idle_time;
>  	idle->idle_count++;
>  	account_idle_time(cputime_to_nsecs(idle_time));
> -	write_seqcount_end(&idle->seqcount);
> +	raw_write_seqcount_end(&idle->seqcount);
>  }
>  NOKPROBE_SYMBOL(enabled_wait);
>  

Yes, it does.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
