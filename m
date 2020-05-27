Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD762088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgE0KNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:13:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63372 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgE0KNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:13:39 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04RADbjT001274;
        Wed, 27 May 2020 19:13:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Wed, 27 May 2020 19:13:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04RADal2001271
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 May 2020 19:13:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
 <20200527083747.GA27273@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
Date:   Wed, 27 May 2020 19:13:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527083747.GA27273@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/27 17:37, Petr Mladek wrote:
> On Mon 2020-05-25 19:43:04, Tetsuo Handa wrote:
>> On 2020/05/25 17:42, Petr Mladek wrote:
>>> I see few drawbacks with this patch:
>>>
>>> 1. It will cause adding much more messages into the logbuffer even
>>>    though they are not flushed to the console. It might cause that
>>>    more important messages will get overridden before they reach
>>>    console. They might also make hard to read the full log.
>>
>> Since the user of this twist option will select console loglevel in a way
>> KERN_DEBUG messages are not printed to consoles, KERN_DEBUG messages will
>> be immediately processed (and space for future messages will be reclaimed).
>> Therefore, I don't think that more important messages will get overridden.
> 
> This is not fully true. More important messages will still be printed
> to the console. The debug messages will not be skipped before the
> older messages are proceed.
> 
> I mean that many debug messages might cause losing more important ones
> before the old important messages are proceed.

Then, this reasoning will be also applicable to

  [PATCH] printk: Add loglevel for "do not print to consoles".

in a sense that "don't try to quickly queue a lot of messages" rule. This concern
cannot be solved even if asynchronous printk() and per console loglevel are
supported someday, and oom_dump_tasks() is not allowed to count on these for
solving the stall problem caused by reporting all OOM victim candidates at once.

> 
> 
>> This twist option might increase possibility of mixing KERN_DEBUG messages
>> and non-KERN_DEBUG messages due to KERN_CONT case.
>>
>> But if these concerns turn out to be a real problem, we can redirect
>> pr_devel()/pr_debug() to simple snprintf() which evaluates arguments
>> but discards the result without storing into the logbuffer.
>>
>>>
>>> 2. Crash inside printk() causes recursive messages. They are currently
>>>    printed into the printk_safe() buffers and there is a bigger risk
>>>    that they will not reach the console.
>>
>> Currently "static char textbuf[LOG_LINE_MAX];" is "static" because it is used
>> under logbuf_lock. If we remove "static", we can use "char textbuf[LOG_LINE_MAX];"
>> without logbuf_lock. Then, we can bring potentially dangerous-and-slow vscnprintf()
>> in vprintk_store() to earlier stage (and vprintk_store() will need to do simple
>> copy) so that oops in printk() will happen before entering printk-safe context.
>> I think that this change follows a direction which lockless logbuf will want.
> 
> No, LOG_LINE_MAX is too big to be allocated on stack.

We could assign per task_struct buffers and per CPU interrupt context buffers
(like we discussed about how to handle KERN_CONT problem). But managing these
off stack buffers is out of scope for this patch.

> 
> Well, it would be possible to call vsprintf() with NULL buffer. It is
> normally used to calculate the length of the message before it is
> printed. But it also does all the accesses without printing anything.

OK. I think that redirecting pr_debug() to vsnprintf(NULL, 0) will be
better than modifying dynamic_debug path, for

> 
> 
>>> Have you tested this patch by the syzcaller with many runs, please?
>>> Did it helped to actually discover more bugs?
>>> Did it really made things easier?
>>
>> syzbot can't test with custom patches. The only way to test this patch is
>> to send to e.g. linux-next.git which syzbot is testing.
> 
> OK, we could try this via some test branch that will go into
> linux-next but it would not be scheduled for the next merge window.
> 
> For the testing, this patch might be good enough.
> 
> For eventual upstreaming, I would prefer to handle this in
> lib/dynamic_debug.c by enabling all entries by default. This
> would solve all DYNAMIC_DEBUG_BRANCH() users at one place.

since "enabling all entries by default" will redirect pr_debug() calls to
printk(KERN_DEBUG), the "don't try to quickly queue too much messages" above
remains (i.e. it is essentially same with what this patch is doing).

> 
> Anyway, I would like to see a proof that it really helped to find
> some bugs an easier way before upstreaming.
> 
> Best Regards,
> Petr
> 

