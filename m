Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24715C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D369A20771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 23:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x6M2QeVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLXNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 19:13:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A1C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 16:13:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so3467875pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b9wDu1zAPtNAxre/T+5M4GIuWs7X5c6GRL6Q/3of22I=;
        b=x6M2QeVMZGbSL5gTLozabAiuxd2SXNztUx9ThEpwUQ05HV3mCBERljfties7hVtXlf
         mYEEx+OzzvszK6jKi1+d19Bc7jlnL1VNVNgSu5CWJ4XbWs2PdZZN9HsejhCbhZD1xcM+
         JujFnjfoqHpM3HJ9hPYl1kI6WmDgQGupfhBUUVQtldPOZ+4Ka11ARRwIlDqW42q+LShv
         TJw0waYkk+whSUMx+l9i7YE6qbpyiW6xVtzrkla0lI3E9LjDTzib3E6IttBBnytXE+Bx
         st70qK3tLVvEPJqH4yGpoiuAvxdY6cvyGpPfbaU6kMt2Ak33PQnn7QzX76Ndy1wZn4zZ
         5S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b9wDu1zAPtNAxre/T+5M4GIuWs7X5c6GRL6Q/3of22I=;
        b=Tc5b32BP/QJuRgDOLeD1uiqEJMT/+EsWjBqDzRpQ4frw5tY5ixC3/IbB2JpIBS2L6i
         qYPsox3ittTpdazDHyNan8hnZhyCQTeWwDxf2UMsPSvwphexg/vF3YCuF/r0PE6vClA8
         U6Wy+1DZinWCYWU66feZGqXquQcnahFtv9NYn4PUO+nrEmZWClSv0M18WCGmFyz8W8QD
         NJir7XoDUJlCh+jBiXW+RCsaOjwC8wbPoGNisg4vcwmGKRrl7quNLeNJts5ZBlhqprWY
         w7UXwSl+QNqnIOaG22Op6w1W3WEzoAmNIJisMTaV8bHt87DHiGURGwxpVxsk47DkQMPW
         D/EQ==
X-Gm-Message-State: AOAM532JCh8Kz/F0D++Vs0pLD//MqBkQD0Dwtjn/h9DPadNYId74gvsE
        VomtKjiEe+0/uQGyRL0zEbL/dw4TH28=
X-Google-Smtp-Source: ABdhPJwz/V/SrycSTwuG4kiDqATjY60TioZEnMgXbr7+2TH0jZ83SGqH1Kayz1pqQoNO8YWPR5Cj6w==
X-Received: by 2002:a17:902:d30b:: with SMTP id b11mr1504288plc.107.1597274027592;
        Wed, 12 Aug 2020 16:13:47 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e8sm3507964pfd.34.2020.08.12.16.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 16:13:46 -0700 (PDT)
Subject: Re: [PATCH] task_work: only grab task signal lock when needed
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
 <20200811152310.GF21797@redhat.com> <20200812145422.GA10232@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c0eca6b-a9aa-4228-6abf-2eb4372f8fa7@kernel.dk>
Date:   Wed, 12 Aug 2020 17:13:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812145422.GA10232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/20 8:54 AM, Oleg Nesterov wrote:
> On 08/11, Oleg Nesterov wrote:
>>
>> On 08/11, Jens Axboe wrote:
>>>
>>> --- a/kernel/task_work.c
>>> +++ b/kernel/task_work.c
>>> @@ -42,7 +42,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
>>>  		set_notify_resume(task);
>>>  		break;
>>>  	case TWA_SIGNAL:
>>> -		if (lock_task_sighand(task, &flags)) {
>>> +		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
>>> +		    lock_task_sighand(task, &flags)) {
>>
>> Aaaaah, sorry Jens, now I think this is racy. So I am glad I didn't add
>> this optimization into the initial version ;)
>>
>> It is possible that JOBCTL_TASK_WORK is set but ->task_works == NULL. Say,
>> task_work_add(TWA_SIGNAL) + task_work_cancel(), or the target task can call
>> task_work_run() before it enters get_signal().
>>
>> And in this case another task_work_add(tsk, TWA_SIGNAL) can actually race
>> with get_signal() which does
>>
>> 	current->jobctl &= ~JOBCTL_TASK_WORK;
>> 	if (unlikely(current->task_works)) {
>> 		spin_unlock_irq(&sighand->siglock);
>> 		task_work_run();
>>
>> nothing guarantees that get_signal() sees ->task_works != NULL. Probably
>> this is what Jann meant.
>>
>> We can probably add a barrier into get_signal() but I didn't sleep today,
>> I'll try to think tomorrow.
> 
> I see nothing better than the additional change below. Peter, do you see
> another solution?
> 
> This needs a comment to explain that this mb() pairs with another barrier
> provided by cmpxchg() in task_work_add(). It ensures that either get_signal()
> sees the new work added by task_work_add(), or task_work_add() sees the
> result of "&= ~JOBCTL_TASK_WORK".
> 
> Oleg.
> 
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -2541,7 +2541,7 @@ bool get_signal(struct ksignal *ksig)
>  
>  relock:
>  	spin_lock_irq(&sighand->siglock);
> -	current->jobctl &= ~JOBCTL_TASK_WORK;
> +	smp_store_mb(current->jobctl, current->jobctl & ~JOBCTL_TASK_WORK);
>  	if (unlikely(current->task_works)) {
>  		spin_unlock_irq(&sighand->siglock);
>  		task_work_run();
> 

I think this should work when paired with the READ_ONCE() on the
task_work_add() side. I haven't managed to reproduce badness with the
existing one that doesn't have the smp_store_mb() here, so can't verify
much beyond that...

Are you going to send this out as a complete patch?

-- 
Jens Axboe

