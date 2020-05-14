Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB3D207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgENLYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:24:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60621 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:24:45 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04EBO3fI019038;
        Thu, 14 May 2020 20:24:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Thu, 14 May 2020 20:24:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04EBNvuV018914
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 14 May 2020 20:24:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei> <20200513104938.GW29153@dhcp22.suse.cz>
 <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
 <20200513121942.GK17734@linux-b0ei>
 <2173e3ac-7d5e-24da-0c1e-6472df905767@i-love.sakura.ne.jp>
 <20200514080053.GN17734@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7af6fc77-986a-8a6a-ea93-b807db44413c@i-love.sakura.ne.jp>
Date:   Thu, 14 May 2020 20:23:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514080053.GN17734@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/14 17:00, Petr Mladek wrote:
> On Wed 2020-05-13 21:59:23, Tetsuo Handa wrote:
>> On 2020/05/13 21:19, Petr Mladek wrote:
>>> On Wed 2020-05-13 20:24:24, Tetsuo Handa wrote:
>>>> On 2020/05/13 19:49, Michal Hocko wrote:
>>>>> On Wed 13-05-20 12:04:13, Petr Mladek wrote:
>>>>>> What is so special about  OOM dump task so that it would deserve such
>>>>>> complications?
>>>  
>>>> I don't think dump_tasks() is important information to be printed on consoles.
>>>> But since somebody might think dump_tasks() is important information to be
>>>> printed on consoles, I suggest switching KERN_NO_CONSOLES using e.g. sysctl.
>>>
>>> You might achieve the same with DEBUG loglevel. Or do I miss anything?
>>
>> Use of KERN_DEBUG affects userspace syslog daemon. We will have to ask administrators
>> to configure syslog daemon not to filter KERN_DEBUG messages. And administrators will
>> be bothered by needless KERN_DEBUG messages. Also,
> 
> What about using KERN_INFO then? Is there still the same problem?

dump_tasks() is already using KERN_INFO, and the same problem remains. KERN_INFO cannot
prevent printk() from printing to consoles unless console loglevel is tuned. And tuning
console loglevel can prevent all KERN_INFO from printing to consoles. What I want is a
method for allowing administrators to control whether to print each message to consoles.
Such method will be by definition controlled via "+ loglevel assigned to each message".

> 
> Otherwise this looks like a dead end.

Please please please DON'T IGNORE THE SWITCH.

>                                       The above states that
> administrators will not have to do anything when KERN_NO_CONSOLES
> are introduced. But there are people that will not like the new
> behavior. They will have to do something.

Exactly. Therefore, we will need a switch which controls whether to add
KERN_NO_CONSOLES modifier (e.g. extending /proc/sys/vm/oom_dump_tasks if
KERN_NO_CONSOLES were useful to only dump_tasks()). Practically I would
propose /proc/sys/vm/print_oom_messages which is a bitmap for which OOM-
related messages should prevent printk() from being written to consoles.

> 
> 
>>> I know that it is meant as a modifier, like LOGLEVEL_SCHED and
>>> KERN_CONT.
>>
>> Right. KERN_NO_CONSOLES is a modifier.
>>
>>>            But this is another reason to avoid it. We already have
>>> huge pain with these two modifiers. They both do not work well.
>>
>> KERN_NO_CONSOLES can not cause pains like LOGLEVEL_SCHED because
>> KERN_NO_CONSOLES is to say "no need to call console drivers" while
>> LOGLEVEL_SCHED is to say "don't call console drivers now but have
>> to call console drivers later".
> 
> The problem with LOGLEVEL_SCHED is that it is not reliable. It must be
> used for all printk() calls in the critical path. But people are not
> aware of this, or they forget, or it gets complicated in shared code.

I was worrying about difficulty in the callee side, but you are worrying
about difficulty of the caller side. Then, ...

> 
> KERN_NO_CONSOLES will have exactly the same problems.

No. That is a pointless concern.
Forgetting to add KERN_NO_CONSOLES is unrelated to the critical path.

> 
> KERN_CONT is not reliable also from other reasons.

Again, a pointless concern. We can try to eliminate KERN_CONT from printk()
callers when adding KERN_NO_CONSOLES to printk() callers, provided that
KERN_CONT could become a concern.

> 
> 
>>> NO_CONSOLES would mess with this decision. Some messages would suddenly
>>> get hidden on console but appear in userspace.
>>
>> Wrong. Console loglevel is already hiding some messages.
> 
> Exactly and people are aware of it. We should use it when possible
> instead of introducing yet another complexity.

What I'm saying is:

  Don't count on KERN_$LOGLEVEL. Like you said "developers already have
  troubles to decide between the existing 8 loglevels.", there are only 8
  levels which are effectively unchangable/unusable for controlling which
  messages should be printed to consoles. Therefore, allow developers and
  administrators to control which messages should not be printed to consoles
  using SOME SWITCH YOU ARE IGNORING. Majority of kernel messages are not
  urgent enough to require synchronously writing to consoles. Only oops-
  related messages (and possibly watchdog-related messages) would worth
  writing to consoles synchronously. Skip writing non-urgent messages when
  urgent condition happens will be a concern when asynchronous printk() is
  added. If KERN_NO_CONSOLES were introduced, we can allow developers and
  administrators to control which messages are non-urgent messages.

Given that said, if KERN_NO_CONSOLES is not acceptable, I have to again
battle against Michal Hocko regarding how to offload OOM-related messages,
like Sergey Senozhatsky estimated

  "I'd say that lockless logbuf probably will land sometime around 5.8+.
  Async printk() - unknown."

last month.

