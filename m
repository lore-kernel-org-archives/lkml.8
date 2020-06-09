Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2DB2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tT1v4+S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgFIXDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:03:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BEC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:03:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ne5so36201pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bD6EdH1oU5zRd6BB/MkvfcXQWcjepFMsVcIrSrnGheM=;
        b=tT1v4+S03JI81sYXWb8Lu7KgbUR4VLf68Dv8fHHVwd4Fp+z32PmgWPlCqR4YSognMj
         22kQBxLH06nqnME8ggeLpHJzaD4FpC7UCPfe6yXx5v/P4NnthVVSd/1r0oZ3Z6+W5Dn2
         4kXgLP7cvbZcWpKRFEQqmAatggf6PErhKNUnFu29GrNxXmuFbMVeAOwvIQIQzZCYX9GZ
         RNDrJp9BWeUrwuHR1QNNe0trRzqGfW0fcU1xPrcVH99lssuBgQ+9hNA+6gE9opqivbd5
         9eb2t9X6cJyZ09BXUunjjA/k2Vi+7TZdSRwfSzlEqIip2z0ZXTkeizoFZ4qN1JisCYmN
         XT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bD6EdH1oU5zRd6BB/MkvfcXQWcjepFMsVcIrSrnGheM=;
        b=eWchlv3csV64RCBJRcXoFtdXxWKUVv3U/lU3R6i39yyPfPIws0v6NjNrOSSJ9cn0RW
         A3gnQNoij8GK2/FmBhRKrdu1CVV7TRI9eEEDOF4voDklpTfXIBWwOSBzDmNvnWlLbgtT
         L3Ca0tQLc5Dj299iJ6UQtIyTeomcQDLsX2VfZNWZXVwSr9U3NOyl/XWBhqbyGNYA0dPG
         aVNeNWgKSIRBqI13UEB+Ok71XoXz0ggOnVIoL5zblwy0WOUYHvnsFyKxmJ8L+1vPEY3X
         NfaRsWW6SChoVfF0lAHX9t/SxNwFV08k9M4yDiobsuMDgtK0WwC2yQCgg+qkxh2NtZJg
         Axcg==
X-Gm-Message-State: AOAM533DULsRrDYiLML0MXCJo+e4iuWVTnNtIgwP835LCEE0EQhX9qyS
        kAL3xYTblDEqA0pEyClMNeEghXWN
X-Google-Smtp-Source: ABdhPJwUa1yAhTkf3Ozlw2d71MpRRMGvGHIveVxG7ATbuQzUv43PjL7K31dMUeQMo+Wrk43IcemR7g==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr97433pje.174.1591743802239;
        Tue, 09 Jun 2020 16:03:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b29sm11075715pfr.159.2020.06.09.16.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 16:03:21 -0700 (PDT)
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
To:     Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net> <20200609213829.GA789@sol.localdomain>
 <20200609220601.GD2514@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e8a57823-3c5a-886a-e114-b5e7b2bb4f01@roeck-us.net>
Date:   Tue, 9 Jun 2020 16:03:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200609220601.GD2514@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 3:06 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2020 at 02:38:29PM -0700, Eric Biggers wrote:
>> Does the struct actually have to be named?  How about:
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index c5d96e3e7fff42..14ca25cda19150 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -653,8 +653,14 @@ struct task_struct {
>>  	unsigned int			ptrace;
>>  
>>  #ifdef CONFIG_SMP
>> -	struct llist_node		wake_entry;
>> -	unsigned int			wake_entry_type;
>> +	/*
>> +	 * wake_entry_type must follow wake_entry, even when
>> +	 * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
>> +	 */
>> +	struct {
>> +		struct llist_node	wake_entry;
>> +		unsigned int		wake_entry_type;
>> +	};
>>  	int				on_cpu;
>>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>>  	/* Current CPU: */
>>
>>
>> However, it would be preferable to not rely on different structs sharing the
>> same field order, but rather write proper C code that uses the same struct
>> everywhere to encapsulate these 2 fields...
> 
> https://lkml.kernel.org/r/20200605093704.GB2948@hirez.programming.kicks-ass.net
> 
> And I have more patches on top to clean up some of the anonymous union
> stuff, that that's quite a lot of frobbing.
> 

That is why I tried to keep it simple as hackish fixup patch.

Guenter
