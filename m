Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B9EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6F3206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 23:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajZpkBzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgFFXNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 19:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFFXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 19:13:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1513C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 16:13:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so676536pgk.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXlIdK3xqEXDiY1I+wnjdXRlmdQOtj2/wMf/SPdH49Q=;
        b=ajZpkBzfGXU3hhfQ5zexseh/sOcpre5DVRSLWZ8UG8E+EX1vfwxlYMZdOmeXTw1SmU
         gp5vK5DFGFQ5tvtAQ4k56wcocvyvrWe47n9uqlEXtyVK/Yho9xjT7kVnqvoK+pAnB9j2
         cXt2Xe0/eaVAVc/MPpF0Ljy32NXnm15eFDjsYJvezQnfGFK4eSQddBWfCqNDdqVsodko
         dDEI6d61im9bwbvoMdhyiXvLXAsGg4pLj1W1vBIBUGksbpdY5o774RbsJtnWs7EEyCWD
         8Pflob/D5ImX3k8+wcThK7fm84KnaU+0VEkmT7e7K1mEzAzliPdUdGcEvJLwgsrXDCiw
         Hm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cXlIdK3xqEXDiY1I+wnjdXRlmdQOtj2/wMf/SPdH49Q=;
        b=mW+7X+lTmjWHh0DxsyJ/f5KsfXEc5Sf/gEIu5dfTv6VpxjFkUJ384ZnOzgNyH0BetB
         oz8KVQaMudEsDOnX0Gk0aNIxX47M7AEuaflyf6JydT4ME7lW5Mla+UlbZc906+yIGOVr
         NP+PEPOp7WXQKoUiNF67qg6MnS/v2o78FsCCHY0jlliyiENGmoz5cdY8kuvX1wrRJfnO
         E2A+Du87ycqkh9SzamnHG6S24hDNsMv05/F51B1Z84XEY4S3sXdonQzcj94z+W+cIARC
         KBpTm8QoDgeq7a+qCBYO+IS9GSAKjmQdQeG0Ak1kCsFmo5d5tV1QkgHczYWhjF3Y9RSz
         tYwQ==
X-Gm-Message-State: AOAM531FESGmNhsvqbkWCNPp1bbF6CPa26Q24TnSmg+hFNRJXl+JMdnR
        lzjmE7L4E6l82tOmD0ZnoPk=
X-Google-Smtp-Source: ABdhPJx/BvlMCx9jUkAj1yyNhHfUnIBM54eBzz/Gs7aBSOzy4gxk/j3RBB6bBGiWqwNbKMMTUgq5RQ==
X-Received: by 2002:a63:b91a:: with SMTP id z26mr14675846pge.444.1591485215646;
        Sat, 06 Jun 2020 16:13:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10sm3109416pfa.166.2020.06.06.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 16:13:34 -0700 (PDT)
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
To:     Eric Biggers <ebiggers@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
Date:   Sat, 6 Jun 2020 16:13:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605161532.GD1373@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/20 9:15 AM, Eric Biggers wrote:
> On Fri, Jun 05, 2020 at 09:41:54AM +0200, Peter Zijlstra wrote:
>> On Thu, Jun 04, 2020 at 05:24:33PM -0700, Eric Biggers wrote:
>>> On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
>>>> On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
>>>>> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
>>>>> got smp_call_function_single_async() subtly wrong. Even though it will
>>>>> return -EBUSY when trying to re-use a csd, that condition is not
>>>>> atomic and still requires external serialization.
>>>>>
>>>>> The change in ttwu_queue_remote() got this wrong.
>>>>>
>>>>> While on first reading ttwu_queue_remote() has an atomic test-and-set
>>>>> that appears to serialize the use, the matching 'release' is not in
>>>>> the right place to actually guarantee this serialization.
>>>>>
>>>>> The actual race is vs the sched_ttwu_pending() call in the idle loop;
>>>>> that can run the wakeup-list without consuming the CSD.
>>>>>
>>>>> Instead of trying to chain the lists, merge them.
>>>>>
>>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>> ---
>>>> ...
>>>>> +	/*
>>>>> +	 * Assert the CSD_TYPE_TTWU layout is similar enough
>>>>> +	 * for task_struct to be on the @call_single_queue.
>>>>> +	 */
>>>>> +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
>>>>> +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
>>>>> +
>>>>
>>>> There is no guarantee in C that
>>>>
>>>> 	type1 a;
>>>> 	type2 b;
>>>>
>>>> in two different data structures means that offsetof(b) - offsetof(a)
>>>> is the same in both data structures unless attributes such as
>>>> __attribute__((__packed__)) are used.
>>>>
>>>> As result, this does and will cause a variety of build errors depending
>>>> on the compiler version and compile flags.
>>>>
>>>> Guenter
>>>
>>> Yep, this breaks the build for me.
>>
>> -ENOCONFIG
> 
> For me, the problem seems to be randstruct.  To reproduce, you can use
> (on x86_64):
> 
> 	make defconfig
> 	echo CONFIG_GCC_PLUGIN_RANDSTRUCT=y >> .config
> 	make olddefconfig
> 	make kernel/smp.o
> 

I confirmed that disabling CONFIG_GCC_PLUGIN_RANDSTRUCT "fixes" the problem
in my test builds. Maybe it would make sense to mark that configuration option
for the time being as BROKEN.

Guenter
