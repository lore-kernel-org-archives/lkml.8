Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A10C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A634A20814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405046AbgE2CNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:13:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53884 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404344AbgE2CNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:13:35 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04T2DVaU065086;
        Fri, 29 May 2020 11:13:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Fri, 29 May 2020 11:13:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04T2DVHe065067
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 May 2020 11:13:31 +0900 (JST)
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
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
Date:   Fri, 29 May 2020 11:13:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/29 9:28, Linus Torvalds wrote:
>> Current kernel is not well segmented enough to allow switching based on
>> per process flags. We can't distinguish whether some kernel message was
>> caused by a process with such flags.
> 
> Who said anything at all about per process?
> 

You said

  Some kind of "not even root" flag, which might be per-process and not
  possible to clear once set (so that your _normal_ system binaries
  could still do the root-only stuff, but then you could start a fuzzing
  process with that flag set, knowing that the fuzzing process - and
  it's children - are not able to do things).

  Honestly, in a perfect world, it has nothing at all to do with
  fuzzing, and people could even have some local rules like "anybody who
  came in through ssh from the network will also have this flag set".

at https://lkml.kernel.org/r/CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com
and I said

  I don't think per-process flags will work. Not every action is taken inside
  process context who issued a syscall. Some action might be taken in interrupt
  context or in kthread context. Since we have no means to propagate per-process
  flags, we will need to give up more than we have to give up.

at https://lkml.kernel.org/r/f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp .



>> Why do you think "syzkaller is special" ? There is no syzkaller-specific
>> choice.
> 
> ALL of these are designed to be totally about syzkaller. Nobody else
> has ever asked for the TWIST options. And if they have, they'd still
> make more sense as generic real actual options than as some odd
> "twist" thing.

Because syzkaller is the first user who needs the TWIST options. syzkaller is
creative enough to trigger unexpected syscalls with unexpected arguments.
Some of unexpected arguments can be filtered out by sanitization steps, but not all
arguments can be filtered out. Some examples which syzkaller expects the TWIST options
to filter out are described at https://github.com/google/syzkaller/issues/1622 .

Who can implement a fuzzer which never triggers unexpected syscalls with unexpected
arguments? If somebody implemented one, that fuzzer will not be testing as deep as
syzkaller does. It is natural that nobody else has ever asked for the TWIST options.

> And if it's about things like "disable sysrq-k", and it might be
> useful to somebody else than syzkaller, then it would be *much* better
> off as a boot option so that you don't have to recompile the kernel to
> pick it.

Recompiling the kernel to pick something is not a difficult thing. Avoiding bugs
caused by allowing runtime enable/disable is far more difficult thing, for fuzz
testing might unexpectedly overwrite flag variables due to unexpected arguments
or memory corruption.

>> After all, switching at the kernel configuration phase is the most simple
>> approach.
> 
> No it isn't. It's the UGLIEST possible approach, forcing a nasty
> horrible config process to be even worse, forcing a compile-time
> decision for something that isn't at all obvious should be
> compile-time, and forcing crazy ugly config option names because they
> are all just odd.

If the code is fixed at build-time and the data does not contain flag variables,
it improves the reliability/robustness of fuzz testing.

Given that one of TWIST switches allows administrator to disable reboot() syscall,
who would use that switch? Only kernel fuzzing projects would use that switch. How
allowing administrators to control such switch at kernel command line can be useful?

> Some things might even be worth having a runtime option for.

If somebody starts asking for boot time switching of the TWIST options, we can consider
it then. Until then, I don't think supporting boot time switching is worth the effort.

> But this "put random options, give them random names, and force them
> all as compile-time options in a nasty kernel config process" just
> smells.

Switching at build-time has a reason for switching at build-time; it is to
improve the reliability/robustness of fuzz testing.

> And if they are _so_ specialized that only syzkaller could possibly
> care, I still maintain that they shouldn't go upstream at all.

Without the support from the kernel side, we will fail to find deep kernel bugs
because we will fail upon unexpected syscalls with unexpected arguments.

The TWIST options are not only for syzkaller. Any fuzzers which try to find deep
kernel bugs will need the TWIST options.

You are free to add runtime switches for things like "disable sysrq-k".
Please don't consider the TWIST options as "for userspace's convenience".
The TWIST options are intended for "improving the quality of kernel testing".

