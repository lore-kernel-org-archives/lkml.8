Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21ACA20825
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j5oD//7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbgEYTZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgEYTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:25:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:25:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 124so2783623pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ty7oeziIm2YrFAkvwgMsB4GG1xlQWBPE2UTLhS7CAnU=;
        b=j5oD//7+3S2G7OrkW+qjZkFSLljGWPAm5j9P92qKeXfxVFczGg4+rPIIzSH82z0q1h
         XCyutMuFqFAIHasaRmZCs86zOPK9hV2o3Yto+RkAUO2ozL+y2WjRvgOdBOUq61ojxRv0
         8xSkKSIn8PTWrRqdsl0EPMlBWHD2KWWY6kkhuB2HIADDYciRn08uVu7GYLHcaepsVmrX
         +bAbdvxF7RsezU0EVnzPJrzXwHEWORmFmVdKQD74Jd4BfAcFY1HhQdPJF/M/bmjF1T/+
         +cV4DGO5/K33Xqj5LnSQV7aw6Z/6RC8nYMreau5lq/67WA9Or7YetFhMNO5QlQQxU3z6
         aCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ty7oeziIm2YrFAkvwgMsB4GG1xlQWBPE2UTLhS7CAnU=;
        b=rFqNueRrX6r4Rkdj0aHqBuVJWezuHBwAh89DOgO6YvZMW3BoyqDR/ANSrkGF/wPi08
         pQb+amb6t6N/HFGNomow6zby9V52fwocyl/OxfFAUOErTNxK1Ga9X6NUlfZKw9Uujf2V
         CSdueZHPbI6XNWHq5bgYbGdoGMlr2f7DeG7pgPSgBQk88gCtiZm86SdAb+qAOOblO7O4
         IDbVTj/I6ybQEA+KfIZoPGmrFb8wUTQd9zafaHaDLLibKvIcyNa46gnkXOr3UlzPa23s
         kyqZ7pFBz9c9CByvWdKC8AJj5b4btPpe3Oi9237UzJajsGJKWMMG1TyZpE31umsaRnew
         rSUg==
X-Gm-Message-State: AOAM533PdsSguRWskI1WC0Wi+a7/lb+LCYk3E2jqodn0YgiK+ugMEgep
        aYallb6fG5N6ZNz856UymXXhTA==
X-Google-Smtp-Source: ABdhPJyJSxde7i/uiDMJNzbAGs8+fWbMntU+2mEg84/gvbJiJIXBrJyE/gr0K7b+Idfqad0ULJo7Rg==
X-Received: by 2002:a63:ef03:: with SMTP id u3mr27578655pgh.254.1590434725171;
        Mon, 25 May 2020 12:25:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:3c00:cb1c:41a3:c8d? ([2605:e000:100e:8c61:3c00:cb1c:41a3:c8d])
        by smtp.gmail.com with ESMTPSA id e16sm11961151pgg.8.2020.05.25.12.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:25:24 -0700 (PDT)
Subject: Re: io_uring: BUG: kernel NULL pointer dereference
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
References: <20200525103051.lztpbl33hsgv6grz@steredhat>
 <20200525134552.5dyldwmeks3t6vj6@steredhat>
 <b1689238-b236-cc93-9909-c09120e7975c@kernel.dk>
 <20200525192143.GG317569@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c9bba09b-8af7-1aea-8c09-645925c972cf@kernel.dk>
Date:   Mon, 25 May 2020 13:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525192143.GG317569@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 1:21 PM, Peter Zijlstra wrote:
> On Mon, May 25, 2020 at 08:10:27AM -0600, Jens Axboe wrote:
>> I think the odd part here is that task_tick_numa() checks for a
>> valid mm, and queues work if the task has it. But for the sqpoll
>> kthread, the mm can come and go. By the time the task work is run,
>> the mm is gone and we oops on current->mm == NULL.
>>
>> I think the below should fix it:
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 538ba5d94e99..24a8557f001f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2908,7 +2908,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
>>  	/*
>>  	 * We don't care about NUMA placement if we don't have memory.
>>  	 */
>> -	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
>> +	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
>> +	    work->next != work)
>>  		return;
> 
> Ah, I think that's one more instance of '!p->mm' != is_kthread(). A
> while ago someone went and cleaned a bunch of them up. Clearly this one
> was missed.
> 
> I'm thinking just:
> 
> 	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
> 
> should be enough.

Yeah it should, no point in checking both ->mm == NULL and PF_KTHREAD.

-- 
Jens Axboe

