Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CFC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2556205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgEMNAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:00:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61284 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgEMNAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:00:13 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04DCxVYK024851;
        Wed, 13 May 2020 21:59:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Wed, 13 May 2020 21:59:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04DCxQMq024664
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 May 2020 21:59:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
 <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei> <20200513104938.GW29153@dhcp22.suse.cz>
 <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
 <20200513121942.GK17734@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2173e3ac-7d5e-24da-0c1e-6472df905767@i-love.sakura.ne.jp>
Date:   Wed, 13 May 2020 21:59:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513121942.GK17734@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/13 21:19, Petr Mladek wrote:
> On Wed 2020-05-13 20:24:24, Tetsuo Handa wrote:
>> On 2020/05/13 19:49, Michal Hocko wrote:
>>> On Wed 13-05-20 12:04:13, Petr Mladek wrote:
>>>> What is so special about  OOM dump task so that it would deserve such
>>>> complications?
>  
>> I don't think dump_tasks() is important information to be printed on consoles.
>> But since somebody might think dump_tasks() is important information to be
>> printed on consoles, I suggest switching KERN_NO_CONSOLES using e.g. sysctl.
> 
> You might achieve the same with DEBUG loglevel. Or do I miss anything?

Use of KERN_DEBUG affects userspace syslog daemon. We will have to ask administrators
to configure syslog daemon not to filter KERN_DEBUG messages. And administrators will
be bothered by needless KERN_DEBUG messages. Also,

> 
> [*] It will have no effect when it was disabled by a sysfs knob.

we will have to ask people to "don't make pr_debug() no-op" or
"use KERN_DEBUG instead of pr_debug()".

Your suggestion to change KERN_$LOGLEVEL keeps bothering people. That's bad.

> I know that it is meant as a modifier, like LOGLEVEL_SCHED and
> KERN_CONT.

Right. KERN_NO_CONSOLES is a modifier.

>            But this is another reason to avoid it. We already have
> huge pain with these two modifiers. They both do not work well.

KERN_NO_CONSOLES can not cause pains like LOGLEVEL_SCHED because
KERN_NO_CONSOLES is to say "no need to call console drivers" while
LOGLEVEL_SCHED is to say "don't call console drivers now but have
to call console drivers later".

On 2020/05/13 21:34, Petr Mladek wrote:
> On Wed 2020-05-13 20:03:53, Tetsuo Handa wrote:
>> On 2020/05/13 19:04, Petr Mladek wrote:
>>>> What is wrong with adding NO_CONSOLES ?
>>>
>>> How does it differ from KERN_DEBUG? The debug messages:
>>>
>>>   + can be disabled via sysfs
>>>   + might reach console when this loglevel is enabled
>>
>> KERN_NO_CONSOLES is different from KERN_DEBUG in that KERN_NO_CONSOLES
>> itself does not affect userspace daemon's judgement (whether to filter
>> KERN_$LOGLEVEL messages).
> 
> And that is the evil thing about it. It goes around the loglevel
> filtering.
> 
> The administrator wants to decide what messages are important for him.

Right.

> NO_CONSOLES would mess with this decision. Some messages would suddenly
> get hidden on console but appear in userspace.

Wrong. Console loglevel is already hiding some messages.

>                                                Users would need to
> investigate what the hell is happening. They would need to find the
> new sysfs knob to restore the expected behavior, etc.

That's part of deciding what messages are important for him, as well as
deciding what KERN_$LOGLEVEL messages are worth printing to consoles.

