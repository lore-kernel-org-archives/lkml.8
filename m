Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED35C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265E421775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQiUrx5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgD2WGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:06:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497CAC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:06:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so4376419wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCQp738aB3EKIql2WfuztXLmbJQqMy+ioYt0kyitzeg=;
        b=UQiUrx5f5W1aLl+2WI8LlsiEdNagBQjTtcRSovBQy059wBqGokeFUEbSo3Drtq86zm
         vWNpZJ8q2Gm0f3ziAQHtNwrKkq8eZHM/pQX599+6PWCKKp58kH3nZKjKuBBKLUvgwYy9
         kpHzRrtMlOlHW7rMc8nkipoxJ/++Gkekh0VvMhNj1ifSas81oApZi3lUPmd6YhT0oyc7
         2njxRhXRxorJM8gm9dN+X5boHUw2sGJ/hmY/PSAdrmb9+Nec85Y62A+GsL/uMtE2KmD8
         u5t2pUaDlV7e/pH10rJCijeDHNEyo2IyTqHgZP+Vk7QoVk67vVwusbH5+Rdk0+rbvS63
         QVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCQp738aB3EKIql2WfuztXLmbJQqMy+ioYt0kyitzeg=;
        b=JzPrQPdXrnLtoJpUDoqYcBRiuqS4C6VhQXuYzb7ebnvJJy9zBfTYvMyUN0PMZ3/Kjk
         XELjbjYRBEQRiB7BDiqpO1W5YgytEELoCJnterx1lPGGfw5ivN0LHalEP4wDNJ+Ns1XK
         z+ZEwX5kv7B7ujxBs9vYXaZQLVFDy1hQdviEX1nqB5wc9y0SgWN9PHgAkIPTXuHGHtjy
         m83/mcPhZ4i5INlRxsc2E86v3SyQhZoknvR1zpdo4L3/oj5fqHoWnf5OX9xbQkUpq0AW
         /fBC4ozZpSQ1ZVSM4nFZ8VrqSIzuK8qTP5OzkFa6Fv30PkmNW43Zown1rQvlTfPjbZx0
         4iGw==
X-Gm-Message-State: AGi0PuZ7MfjoAoHJyVbVANLAgGU+nFgCbumTQDD0UxqUBGzZp70/jfnp
        Avk8lLtUbbPNb0E26q7s+HqwkUN0
X-Google-Smtp-Source: APiQypIyFGxtCjZpfmnuieRhdwIzSZesVXbYO4+TkIHwwrXDnYpMdgq9g1PXPVdj35DT57PiuSi0zQ==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr37758wrx.295.1588197980770;
        Wed, 29 Apr 2020 15:06:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 185sm11208606wmc.32.2020.04.29.15.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 15:06:19 -0700 (PDT)
Date:   Wed, 29 Apr 2020 22:06:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/swapfile.c: simplify the scan loop in
 scan_swap_map_slots()
Message-ID: <20200429220619.f6xhmo7jm36xf64b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200422214111.19370-1-richard.weiyang@gmail.com>
 <87d07y2181.fsf@yhuang-dev.intel.com>
 <20200423131507.2rgrk3okh42oo6gh@master>
 <87r1wdzlm5.fsf@yhuang-dev.intel.com>
 <20200425003012.uuqh547feq3kz4y5@master>
 <87tv17xdfk.fsf@yhuang-dev.intel.com>
 <20200426211958.m7aheswirqaj2nte@master>
 <87d07tycfu.fsf@yhuang-dev.intel.com>
 <20200428212230.3aobygpy62bto4gz@master>
 <874kt3xgdf.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kt3xgdf.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:52:44AM +0800, Huang, Ying wrote:
>Wei Yang <richard.weiyang@gmail.com> writes:
>
>> On Mon, Apr 27, 2020 at 08:55:33AM +0800, Huang, Ying wrote:
>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>
>>>> On Sun, Apr 26, 2020 at 09:07:11AM +0800, Huang, Ying wrote:
>>>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>>>
>>>>>> On Fri, Apr 24, 2020 at 10:02:58AM +0800, Huang, Ying wrote:
>>>>>>>Wei Yang <richard.weiyang@gmail.com> writes:
>>>>>>>
>>>>>> [...]
>>>>>>>>>
>>>>>>>>>if "offset > si->highest_bit" is true and "offset < scan_base" is true,
>>>>>>>>>scan_base need to be returned.
>>>>>>>>>
>>>>>>>>
>>>>>>>> When this case would happen in the original code?
>>>>>>>
>>>>>>>In the original code, the loop can still stop.
>>>>>>>
>>>>>>
>>>>>> Sorry, I don't get your point yet.
>>>>>>
>>>>>> In original code, there are two separate loops
>>>>>>
>>>>>>     while (++offset <= si->highest_bit) {
>>>>>>     }
>>>>>>
>>>>>>     while (offset < scan_base) {
>>>>>>     }
>>>>>>
>>>>>> And for your condition, (offset > highest_bit) && (offset < scan_base), which
>>>>>> terminates the first loop and fits the second loop well.
>>>>>>
>>>>>> Not sure how this condition would stop the loop in original code?
>>>>>
>>>>>Per my understanding, in your code, if some other task changes
>>>>>si->highest_bit to be less than scan_base in parallel.  The loop may
>>>>>cannot stop.
>>>>
>>>> When (offset > scan_base), (offset >  si->highest_bit) means offset will be
>>>> set to si->lowest_bit.
>>>>
>>>> When (offset < scan_base), next_offset() would always increase offset till
>>>> offset is scan_base.
>>>>
>>>> Sorry, I didn't catch your case. Would you minding giving more detail?
>>>
>>>Don't think in single thread model.  There's no lock to prevent other
>>>tasks to change si->highest_bit simultaneously.  For example, task B may
>>>change si->highest_bit to be less than scan_base in task A.
>>>
>>
>> Yes, I am trying to think about it in parallel mode.
>>
>> Here are the cases, it might happen in parallel when task B change highest_bit
>> to be less than scan_base.
>>
>> (1)
>>                                                      offset
>>                                                        v
>>           +-------------------+------------------+
>> 	  ^                   ^                  ^
>>           lowest_bit       highest_bit    scan_base
>>
>>
>> (2)
>>                                        offset
>>                                          v
>>           +-------------------+------------------+
>> 	  ^                   ^                  ^
>>           lowest_bit       highest_bit    scan_base
>>
>
>This is the case in my mind.  But my original understanding to your code
>wasn't correct.  As you said, loop can stop because offset is kept
>increasing.  Sorry about that.
>

NP.

>But I still don't like your new code.  It's not as obvious as the
>original one.

Sure, thanks for your time.

>
>Best Regards,
>Huang, Ying
>
>> (3)
>>                        offset
>>                          v
>>           +-------------------+------------------+
>> 	  ^                   ^                  ^
>>           lowest_bit       highest_bit    scan_base
>>
>> Case (1), (offset > highest) && (offset > scan_base),  offset would be set to
>> lowest_bit. This  looks good.
>>
>> Case (2), (offset > highest) && (offset < scan_base),  since offset is less
>> than scan_base, it wouldn't be set to lowest. Instead it will continue to
>> scan_base.
>>
>> Case (3), almost the same as Case (2).
>>
>> In Case (2) and (3), one thing interesting is the loop won't stop at
>> highest_bit, while the behavior is the same as original code.
>>
>> Maybe your concern is this one? I still not figure out your point about the
>> infinite loop. Hope you would share some light on it.
>>
>>
>>>Best Regards,
>>>Huang, Ying
>>>
>>>>>
>>>>>Best Regards,
>>>>>Huang, Ying
>>>>>
>>>>>>>Best Regards,
>>>>>>>Huang, Ying
>>>>>>>
>>>>>>>>>Again, the new code doesn't make it easier to find this kind of issues.
>>>>>>>>>
>>>>>>>>>Best Regards,
>>>>>>>>>Huang, Ying

-- 
Wei Yang
Help you, Help me
