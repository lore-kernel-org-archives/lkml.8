Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425BFC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1313D2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAQPdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:33:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34313 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgAQPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:33:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so18668520lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qgaoobV7bKNqi2Zsqn0KyypbdkTxAYnF6KUnLKeoNT0=;
        b=K4UyVuT7G5W7/Bm9nHCfTdWIr5B8exyX5mo+pDvaoJeVF35zyx6t6A+X7W3wgsHYG5
         Bsfbql8u5VdIsrbQgmUDAon4UHEUNV3PIlP8eT1ukBn2L9xd551VjP00837lnrfAMXp2
         vPGLKk5IcNfSBf9KzUxSBQIm2yjbR8iEIkXkc1dGHnUXrYnUAG6USTQuY0lBIv9mNiTE
         907423qPBnF9dtP7LN16msGsOE84WSoFZLml7GxBz3vpmL+Yq+6j4ked5YnYqyNddm/Y
         28ka5Lis1YrkbbFqRn3ODezAN6+LdPjntF5+o6V5//vMo4M7VYeCSzus9qeCxXWl5Nh7
         my0A==
X-Gm-Message-State: APjAAAUM7K99XAhHZPp3vTapeFxxBidHUdRCjPfb2BT66EdSXRkkP59o
        rGP3QLbqKGOJm9TqhEKqEpc=
X-Google-Smtp-Source: APXvYqzxwZ7+RD73KI5Ga9z+sKuTBcoNztUwYghBwZrunc7F8c4rSuKZUpBzIkh9kM97YPCs1s/QQQ==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr5606003lfh.43.1579275217117;
        Fri, 17 Jan 2020 07:33:37 -0800 (PST)
Received: from [192.168.42.234] ([213.87.159.95])
        by smtp.gmail.com with ESMTPSA id h14sm12212758lfc.2.2020.01.17.07.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:33:36 -0800 (PST)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH 1/1] timer: Warn about schedule_timeout() called for tasks
 in TASK_RUNNING state
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, notify@kernel.org
References: <20200116140218.1328022-1-alex.popov@linux.com>
 <20200116095220.7368a604@gandalf.local.home>
From:   Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <6c9e68c5-22d7-b0a9-4094-3ab5b02e0052@linux.com>
Date:   Fri, 17 Jan 2020 18:33:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116095220.7368a604@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2020 17:52, Steven Rostedt wrote:
> On Thu, 16 Jan 2020 17:02:18 +0300
> Alexander Popov <alex.popov@linux.com> wrote:
> 
>> When we were preparing the patch 6dcd5d7a7a29c1e, we made a mistake noticed
>> by Linus: schedule_timeout() was called without setting the task state to
>> anything particular. It calls the scheduler, but doesn't delay anything,
>> because the task stays runnable. That happens because sched_submit_work()
>> does nothing for tasks in TASK_RUNNING state.
>>
>> Let's add a WARN_ONCE() under CONFIG_SCHED_DEBUG to detect such kernel
>> API misuse.
>>
>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>> ---
>>  kernel/time/timer.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 4820823515e9..52ad2d6ce352 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1887,6 +1887,11 @@ signed long __sched schedule_timeout(signed long timeout)
>>  		}
>>  	}
>>  
>> +#ifdef CONFIG_SCHED_DEBUG
>> +	WARN_ONCE(current->state == TASK_RUNNING,
>> +			"schedule_timeout for TASK_RUNNING\n");
>> +#endif
>> +
> 
> But this can trigger false warnings. For example, if we are waiting on
> an event with a timeout:
> 
> 
> 	DEFINE_WAIT(wait);
> 
> 	for (;;) {
> 		prepare_to_wait(&waitq, &wait, TASK_UNINTERRUPTIBLE);
> 		if (event)
> 			break;
> 		timeout = schedule_timeout(timeout);
> 		if (!timeout)
> 			break;
> 	}
> 	finish_wait(&waitq, &wait);
> 
> 
> If the event happens between "prepare_to_wait" and just before
> schedule_timeout(), the wait queue will set this task's state to
> TASK_RUNNING, which in turn triggers your warning.

Steven, thanks for the explanation.

If I understand you right, it is the intended behavior of schedule_timeout() in
some sense.

So the best thing I can do here is adding an explanatory comment to the
schedule_timeout() description.

Maybe that would help against such situations:
https://lore.kernel.org/lkml/CAHk-=wgE-veRb7+mw9oMmsD97BLnL+q8Gxu0QRrK65S2yQfMdQ@mail.gmail.com/#t

I'll come with the patch soon.

Best regards,
Alexander
