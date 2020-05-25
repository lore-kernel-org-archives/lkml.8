Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6D120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgEYKoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:44:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63595 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:44:02 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04PAhF5Z018356;
        Mon, 25 May 2020 19:43:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Mon, 25 May 2020 19:43:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04PAhAF7018283
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 25 May 2020 19:43:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
Date:   Mon, 25 May 2020 19:43:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200525091157.GF755@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/25 17:42, Petr Mladek wrote:
> I see few drawbacks with this patch:
> 
> 1. It will cause adding much more messages into the logbuffer even
>    though they are not flushed to the console. It might cause that
>    more important messages will get overridden before they reach
>    console. They might also make hard to read the full log.

Since the user of this twist option will select console loglevel in a way
KERN_DEBUG messages are not printed to consoles, KERN_DEBUG messages will
be immediately processed (and space for future messages will be reclaimed).
Therefore, I don't think that more important messages will get overridden.

This twist option might increase possibility of mixing KERN_DEBUG messages
and non-KERN_DEBUG messages due to KERN_CONT case.

But if these concerns turn out to be a real problem, we can redirect
pr_devel()/pr_debug() to simple snprintf() which evaluates arguments
but discards the result without storing into the logbuffer.

> 
> 2. Crash inside printk() causes recursive messages. They are currently
>    printed into the printk_safe() buffers and there is a bigger risk
>    that they will not reach the console.

Currently "static char textbuf[LOG_LINE_MAX];" is "static" because it is used
under logbuf_lock. If we remove "static", we can use "char textbuf[LOG_LINE_MAX];"
without logbuf_lock. Then, we can bring potentially dangerous-and-slow vscnprintf()
in vprintk_store() to earlier stage (and vprintk_store() will need to do simple
copy) so that oops in printk() will happen before entering printk-safe context.
I think that this change follows a direction which lockless logbuf will want.

> 
> 3. pr_debug() messages are not printed by default. It is possible that
>    nobody used them for ages. You might get many errors in less
>    maintained code instead in the really used one. I mean that you
>    will get more noise with less gain.

Given that potentially dangerous-and-slow vscnprintf() is done outside of
printk-safe context, we can get more test coverage without difficult things.

> 
> 
> Have you tested this patch by the syzcaller with many runs, please?
> Did it helped to actually discover more bugs?
> Did it really made things easier?

syzbot can't test with custom patches. The only way to test this patch is
to send to e.g. linux-next.git which syzbot is testing.

> 
> I am not able to judge usefulness without more data. My intuition
> tells me that we should keep the number of syzcaller-related twists
> as small as possible. Otherwise, syscaller will diverge more and
> more from reality.

The twist options are not specific to syzkaller. Anyone can selectively
enable the twist options.



On 2020/05/25 18:11, Sergey Senozhatsky wrote:
> On (20/05/25 10:42), Petr Mladek wrote:
>> On Sun 2020-05-24 23:50:34, Tetsuo Handa wrote:
>>> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
>>> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
>>> because pr_debug() was no-op [1].
>>>
>>>   pr_debug("fallback-read subflow=%p",
>>>            mptcp_subflow_ctx(ssock->sk));
>>>   copied = sock_recvmsg(ssock, msg, flags);
>>
>> The NULL pointer deference was found even without this patch.
>> This patch would just cause that it will manifest itself on another
>> place. What is the benefit, please?

It would help localizing the bug in this specific case.

It's not only about %p, even %d can crash kernel or leak sensitive
info (if it happens after-free/out-of-bounds/uninit). Overall it
increases code coverage and allows to catch more bugs earlier. 

> 
> Right, I don't get this patch. A NULL-deref is still a NULL pointer deref.
> pr_debug() will fault reading one byte from the address and print something
> like "fallback-read subflow=(efault)" to printk-safe buffer, but then
> sock_recvmsg() is still going to do its thing.

Since this NULL pointer dereference already happens before calling pr_debug(),
we won't store "fallback-read subflow=(efault)" to printk-safe buffer.

Just evaluating pr_devel()/pr_debug() arguments would help finding some bugs.
Again, we can change this twist option to redirect pr_devel()/pr_debug() to
simple snprintf() which evaluates arguments but discards the result without
storing into the logbuffer.

