Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7579E2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHRNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:00:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49356 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgHRNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:00:26 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07ID020B090337;
        Tue, 18 Aug 2020 22:00:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Tue, 18 Aug 2020 22:00:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07ID01QS090334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 18 Aug 2020 22:00:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
 <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
 <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
 <CACT4Y+Y0ptJDj1F89jKQEKB_L8U2yFCUUZ7pwxh+fcE-ZpsBkg@mail.gmail.com>
 <8fc12fea-bf70-874e-fc19-067d504fa5cc@i-love.sakura.ne.jp>
 <CACT4Y+bBdRMCAzOMM8u19m_GopaWEK8eY-VMsgmGRZzYko=DVw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <03ea22ab-3795-1672-f655-dc53f2734b8c@i-love.sakura.ne.jp>
Date:   Tue, 18 Aug 2020 21:59:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bBdRMCAzOMM8u19m_GopaWEK8eY-VMsgmGRZzYko=DVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Ingo and Will. Would you answer (Q1) and (Q2)?

On 2020/08/18 21:02, Dmitry Vyukov wrote:
> On Tue, Aug 18, 2020 at 1:07 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2020/08/18 18:57, Dmitry Vyukov wrote:
>>> On Tue, Aug 4, 2020 at 4:36 AM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> Hello, Peter, Ingo and Will.
>>>>
>>>> (Q1) Can we change the capacity using kernel config?
>>>>
>>>> (Q2) If we can change the capacity, is it OK to specify these constants
>>>>      independently? (In other words, is there inter-dependency among
>>>>      these constants?)
>>>
>>>
>>> I think we should do this.
>>> syzbot uses a very beefy kernel config and very broad load.
>>> We are hitting "BUG: MAX_LOCKDEP_ENTRIES too low!" for the part 428
>>> days and already hit it 96K times. It's just harming overall kernel
>>> testing:
>>> https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
>>>
>>> I think it's better if exact values are not hardcoded, but rather
>>> specified in the config. Today we are switching from 4K to 8K, but as
>>> we enable more configs and learn to reach more code, we may need 16K.
>>
>> For short term, increasing the capacity would be fine. But for long term, I doubt.
>>
>> Learning more locks being held within one boot by enabling more configs, I suspect
>> that it becomes more and more timing dependent and difficult to hold all locks that
>> can generate a lockdep warning.
>>
>>>
>>>
>>>> (Q3) Do you think that we can extend lockdep to be used as a tool for auditing
>>>>      locks held in kernel space and rebuilding lock dependency map in user space?
>>>
>>> This looks like lots of work. Also unpleasant dependencies on
>>> user-space. If there is a user-space component, it will need to be
>>> deployed to _all_ of kernel testing systems and for all users of
>>> syzkaller. And it will also be a dependency for reproducers. Currently
>>> one can run a C reproducer and get the errors message from LOCKDEP. It
>>> seems that a user-space component will make it significantly more
>>> complicated.
>>
>> My suggestion is to detach lockdep warning from realtime alarming.
>>
>> Since not all locks are always held (e.g. some locks are held only if exceeding
>> some threshold), requiring all locks being held within one boot sounds difficult.
>> Such requirement results in flaky bisection like "Fix bisection: failed" in
>> https://syzkaller.appspot.com/bug?id=b23ec126241ad0d86628de6eb5c1cff57d282632 .
>>
>> Then, I'm wishing that we could build non-realtime alarming based on all locks held
>> across all boots on each vmlinux file.
> 
> Unless I am missing something, deployment/maintenance story for this
> for syzbot, syzkaller users, other kernel testing, reproducer
> extraction, bisection, resproducer hermeticity is quite complicated. I
> don't see it outweighing any potential benefit in reporting quality.

What I'm imaging is: do not try to judge lock dependency problems within
syzkaller (or other kernel testing) kernels. That is, no reproducer for
lock dependency problems, no bisection for lock dependency problems.
Utilize their resources for gathering only, and create lock dependency
(like kcov data) in some dedicated userspace component.

> 
> I also don't see how it will improve reproducer/bisection quality: to
> confirm presence of a bug we still need to trigger all cycle edges
> within a single run anyway, it does not have to be a single VM, but
> still needs to be a single test case. And this "having all edges
> within a single test case" seems to be the root problem. I don't see
> how this proposal addresses this problem.
> 
>>>> On 2020/07/25 14:23, Tetsuo Handa wrote:
>>>>>> Also somebody may use it to _reduce_ size of the table for a smaller kernel.
>>>>>
>>>>> Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
>>>>> as soon as lockdep warned the possibility of deadlock.
>>>>>
>>>>> Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
>>>>> checking the same dependency tree. However, the possibility of deadlock can be
>>>>> warned for only locks held within each kernel boot, and it is impossible to hold
>>>>> all locks with one kernel boot.
>>>>>
>>>>> Then, it might be nice if lockdep can audit only "which lock was held from which
>>>>> context and what backtrace" and export that log like KCOV data (instead of evaluating
>>>>> the possibility of deadlock), and rebuild the whole dependency (and evaluate the
>>>>> possibility of deadlock) across multiple kernel boots in userspace.
>>>>
>>

