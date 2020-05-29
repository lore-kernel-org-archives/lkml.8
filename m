Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A505A20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437922AbgE2AHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:07:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57510 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437671AbgE2AHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:07:36 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04T07WfL052160;
        Fri, 29 May 2020 09:07:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Fri, 29 May 2020 09:07:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04T07WeR052144
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 May 2020 09:07:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei>
 <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
Date:   Fri, 29 May 2020 09:07:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/29 4:50, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 8:17 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> CONFIG_TWIST_FOR_SYZKALLER_TESTING is meant for linux-next only.
>> But CONFIG_TWIST_KERNEL_BEHAVIOR is meant for Linus's tree.
> 
> I really absolutely still detest this all. I don't see the point. The
> naming is completely random (both "twist" and then options like
> "TWIST_FOR_SYZKALLER_TESTING" that have no conceptual meaning.

Oh, I made copy&paste error. I wanted to say

  CONFIG_TWIST_KERNEL_BEHAVIOR and CONFIG_TWIST_FOR_SYZKALLER_TESTING are
  meant for Linus's tree.

  CONFIG_DEBUG_AID_FOR_SYZBOT is meant for linux-next only, and will be
  removed after CONFIG_TWIST_FOR_SYZKALLER_TESTING went to Linus's tree.

If you don't like the name "CONFIG_TWIST_FOR_SYZKALLER_TESTING", I'm happy
to rename it.

> 
> I still don't understand why this small set of random options couldn't
> just be kernel options that get set on the command line, and that have
> independent and sane and explainable behavior?

You mean "export these behavior as kernel command line options"? That will
involve run-time costs (while build-time branching based on #ifdef can
completely eliminate run-time costs). Also, as number of options which
can be controlled at boot-time grows, the kernel command line will become
too long to specify all of these behavior. Also, making these options
controllable at boot-time involves making these options as user-visible ABI
(which is bad, for the twists which we want might change in the future).

> Why this odd mentality of "syzkaller is special"?

Why do you think "syzkaller is special" ? There is no syzkaller-specific
choice. CONFIG_TWIST_FOR_SYZKALLER_TESTING is intended for eliminating the
need of managing CONFIG_TWIST_* options on each kernel tree/commit. When
a different fuzzer (or some kernel testing project) appears, they can define
their own CONFIG_TWIST_FOR_$projectname_TESTING as well.

> 
> I've complained about this whole thing before. I'm getting really fed
> up with this whole concept of "magic crazy config options".
> 
> The kernel configuration phase is just about the _worst_ part of the
> kernel, we shouldn't make these pointless things make it even worse.

Current kernel is not well segmented enough to allow switching based on
per process flags. We can't distinguish whether some kernel message was
caused by a process with such flags.

All we could afford is to switch based on kernel boot command line. But
that will entail a lot of code/data (and runtime-cost) which is not used
if the administrator does not turn on the switches.

After all, switching at the kernel configuration phase is the most simple
approach.

On 2020/05/29 5:01, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 12:50 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I still don't understand why this small set of random options couldn't
>> just be kernel options that get set on the command line, and that have
>> independent and sane and explainable behavior? Why this odd mentality
>> of "syzkaller is special"?
> 
> And just to clarify: the kernel option wouldn't be "syzcaller_twist"
> or something insane like that.
> 
> It would be something like "kbd-disable-hotkeys" or whatever: actual
> real text that says what it does.

If you don't like the name "CONFIG_TWIST_FOR_SYZKALLER_TESTING", please
suggest an example name you would accept. But if you don't like switching
based on the kernel configuration options, I can't find a better solution.
