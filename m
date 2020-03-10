Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A3C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E65208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR3+oVCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgCJWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:20:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37070 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJWUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:20:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id a141so197wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yoO7MPKHueEjV/qh8JLI48qSY1iAaPqrxv7EaGtGVGc=;
        b=NR3+oVCmMj1t9szU2jyxVoeWUT/l1V8WjayJ6wk2ewaRsQqYWB4wrYPu++/rxsneqp
         SCr+y7er87LLQV3x0ruLF1DHFQn8ILKoKV98T67RtvgAEBT/ZW6yWydppJuP2K+Zb4aD
         crw4t65PpulAIBcOPFA9wY1Gtj+A0bzdvDvdCbTdOdRLcSLJZD9PhG2YqIA0igSQN++G
         BfdvzOug1i+tQFLdX9vfiQcdbRzYXFl2Fe7vLznqQXgwOkmrcTBg1SrEvVX3+hh6/lfV
         OaO2eo4/Tni7ty/aodZHxkLKsYUoAcTEXSymFEwUNmRcmqVbV0ASUwldRYs63IaIhGp8
         aM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoO7MPKHueEjV/qh8JLI48qSY1iAaPqrxv7EaGtGVGc=;
        b=PPztC1WYfCLtsfzLmNtP3XyxtB+J/OfpWJQ4oAROqkMb/grD4FUrBQCxhroTKUOv5d
         uCmHaM6eXuCG3dSmMLLn0aLowvDIQhVEou2++0osalQCkvNlOKHkEJGwqGZ6gnNmGYvg
         FMX0cRZPFVpVPgetCpEId0tZ8LGW+XE/nqQKQ/tmjRKL9ARGjWz0ODa4gV6P7FCe8r5k
         4aA/kAqKoIXg8s4NpUEZAcQkYrvd/MHfHJ6uxR3+9MayTzTi/Kx7fIjBdH/cLsGK0XGf
         WlkgBKMPQjJ021hLgCsowanMOlcFgiZsBHhvAQA5cAOx0N+6Ynkww0LGwJ4tTH8H5gEJ
         Eg+w==
X-Gm-Message-State: ANhLgQ2dHF7aI7lcMCuCZOuR1szXMMTTMlopqwpjeUo+aZaiO0DtYkCJ
        R5deQY5y3NSijwvxKDBopSoQfLP6
X-Google-Smtp-Source: ADFU+vvKwEqVdu5myl9pocEDt3VfQWs/wSH6YmPzJNexxldYLKycnV838myJ0bbStDrO1DwBaIy4xA==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr4317450wmi.86.1583878803311;
        Tue, 10 Mar 2020 15:20:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k126sm5826795wme.4.2020.03.10.15.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 15:20:02 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:20:02 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_slots.c: don't reset the cache slot after use
Message-ID: <20200310222002.lr2vurqfk6jvfo2z@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200309090940.34130-1-richard.weiyang@linux.alibaba.com>
 <20200309174854.b6b8c7f019c3dde048c28f94@linux-foundation.org>
 <005f7454-16db-e8b5-dde2-8f2ddaa42932@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005f7454-16db-e8b5-dde2-8f2ddaa42932@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:13:13AM -0700, Tim Chen wrote:
>On 3/9/20 5:48 PM, Andrew Morton wrote:
>> On Mon,  9 Mar 2020 17:09:40 +0800 Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>> 
>>> Currently we would clear the cache slot if it is used. While this is not
>>> necessary, since this entry would not be used until refilled.
>>>
>>> Leave it untouched and assigned the value directly to entry which makes
>>> the code little more neat.
>>>
>>> Also this patch merges the else and if, since this is the only case we
>>> refill and repeat swap cache.
>> 
>> cc Tim, who can hopefully remember how this code works ;)
>> 
>>> --- a/mm/swap_slots.c
>>> +++ b/mm/swap_slots.c
>>> @@ -309,7 +309,7 @@ int free_swap_slot(swp_entry_t entry)
>>>  
>>>  swp_entry_t get_swap_page(struct page *page)
>>>  {
>>> -	swp_entry_t entry, *pentry;
>>> +	swp_entry_t entry;
>>>  	struct swap_slots_cache *cache;
>>>  
>>>  	entry.val = 0;
>>> @@ -336,13 +336,10 @@ swp_entry_t get_swap_page(struct page *page)
>>>  		if (cache->slots) {
>>>  repeat:
>>>  			if (cache->nr) {
>>> -				pentry = &cache->slots[cache->cur++];
>>> -				entry = *pentry;
>>> -				pentry->val = 0;
>
>The cache entry was cleared after assignment for defensive programming,  So there's
>little chance I will be using a slot that has been assigned to someone else.
>When I wrote swap_slots.c, this code was new and I want to make sure
>that if something went wrong, and I assigned a swap slot that I shouldn't,
>I will be able to detect quickly as I will only be stepping on entry 0.
>
>Otherwise such bug will be harder to detect as we will have two users of some random
>swap slot stepping on each other.
>
>I'm okay if we want to get rid of this logic, now that the code has been
>working correctly long enough.  But I think is good hygiene to clear the
>cached entry after it has been assigned. 
>

This is fine to keep the logic, while I am wondering whether we need to do
this through pointer. cache->slots[] contain the value, we can get and reset
without pointer.

The following code looks more obvious about the logic.

		entry = cache->slots[cache->cur];
		cache->slots[cache->cur++].val = 0;


>>> +				entry = cache->slots[cache->cur++];
>>>  				cache->nr--;
>>> -			} else {
>>> -				if (refill_swap_slots_cache(cache))
>>> -					goto repeat;
>>> +			} else if (refill_swap_slots_cache(cache)) {
>
>This change looks fine.
>>> +				goto repeat;
>>>  			}
>
>Tim

-- 
Wei Yang
Help you, Help me
