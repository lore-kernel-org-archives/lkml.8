Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC209C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88B1206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="echNLHx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgFHVeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:34:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC1C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 14:34:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so407914pjv.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ggOtsrMddgJ70KHu47TjEHmOfrkUHmiWElKeGXU7jk=;
        b=echNLHx9srjMHmq+5UUG2lLx/fvuDhT1/J8+5KiOfks9omgg3UatMBLuCJ0I0uAhrO
         qgemsvt+O5PvhxuzdIjuep0U/cSqOZq38E+u3EHlXOFn3GyAqFXoxtilcVZ8E+wthHSh
         chsbmJGXNK71voRJeQ3INav1q9/t5vJ+9SIXizWPnDmfglbqw7000xkteKYdiHSSKr4X
         93caTFCAV70RkcEUSsVefhfISunnb1OFTbsHOiEAoFWB0gGGdvRbXLiE6L1utb6Sx3D6
         TZFkLoKZULcrUGkm9337IVwSOQ/McmwRAALdYFyeeIl0FJC/rAQVvbE4L8pzdvbrdLUE
         Y2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ggOtsrMddgJ70KHu47TjEHmOfrkUHmiWElKeGXU7jk=;
        b=Onc2M4ncRGoQwrLPZqUsls2Bdfl7+bBTP+rc0/iCr3jEM9TerZJzaXmR8ygQJiG3P5
         HhG296zn8/87AeoGvPLNkINYalryoMVdRpBHHdaUSJRoq/ottz6/wUk3VFGW9/JvB+ar
         UdknoOOHlT6vgxBAN6H3vGi6YGaY+nOhutHqYg5UMcSN0TB0tGUCdk/+QIk/nj7/Woy2
         xZCZY9QbrlRISDQ9HNnuNehrk0KcBjgOXaa+6e0kxdSQHjuTUB7ijzMFzHvB8L29q9DB
         5uB3W4fdDqhV0bIH/Yv/g378s1VDMQ+ym15SYnSIdgYBIn3qd5rI/SucC9CMyFRPh6Hs
         XQWg==
X-Gm-Message-State: AOAM531q7ZPo7PxWN53p/MgGub9qbrcxQVXJOvaYB1ZDoPcUNTYsAgz1
        mxHXmlRJ+TDGXE08uAq1wYbUGg==
X-Google-Smtp-Source: ABdhPJxX59Ybax4LAaHNEMMzXtoWteCxYYgxzXVRJIg0ZbBQ3zYZs9pcdYMonT/727rBxXf9qya9Jw==
X-Received: by 2002:a17:90a:294f:: with SMTP id x15mr1178681pjf.97.1591652067748;
        Mon, 08 Jun 2020 14:34:27 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j26sm7900250pfr.215.2020.06.08.14.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 14:34:27 -0700 (PDT)
Subject: Re: blk-softirq vs smp_call_function_single_async()
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
 <20200608155833.GC2531@hirez.programming.kicks-ass.net>
 <20200608163342.GA5155@infradead.org>
 <20200608164009.GD2531@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a77692f6-0c11-9277-6fe7-58c4fefda5fb@kernel.dk>
Date:   Mon, 8 Jun 2020 15:34:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608164009.GD2531@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 10:40 AM, Peter Zijlstra wrote:
> On Mon, Jun 08, 2020 at 09:33:42AM -0700, Christoph Hellwig wrote:
>> On Mon, Jun 08, 2020 at 05:58:33PM +0200, Peter Zijlstra wrote:
>>>> A request can only be completed once.
>>>
>>> Sure, but that doesn't help.
>>>
>>> CPU0				CPU1
>>>
>>>  raise_blk_irq()		BLOCK_SOFTIRQ
>>>    IPI -> CPU1
>>>
>>> 				// picks up thing from CPU0
>>> 				req->complete(req);
>>>
>>>
>>> 	<big hole where CSD is active and request completed>
>>>
>>> 				<IPI>
>>> 				  trigger_softirq()
>>>
>>>
>>> What happens to a struct request after completion, is it free()d
>>> or reused? If reused, how do we guarantee CSD completion before
>>> free()ing?
>>
>> The request is freed in the block layer sense by __blk_mq_free_request
>> (which doesn't actually free the memory, so it eventually gets reused).
>>
>> __blk_mq_free_request is called from blk_mq_end_request which
>> is called from the drivers ->complete_rq method, which is called
>> from the block softirq.
>>
>> What is the method to guaranteed CSD completion?
> 
> There isn't one, it was meant to be used with static allocations.
> 
> Frederic proposed changing all these to irq_work, and I think I'll go do
> that. First dinner though.

That sounds good to me, and will also shrink struct request a bit,
which is always nice.

-- 
Jens Axboe

