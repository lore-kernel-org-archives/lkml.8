Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDDC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8612072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406956AbgDNIFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:05:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49377 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgDNIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:04:31 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03E82xoj042708;
        Tue, 14 Apr 2020 17:02:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 14 Apr 2020 17:02:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03E82xQR042705
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 14 Apr 2020 17:02:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp>
Date:   Tue, 14 Apr 2020 17:02:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/14 3:13, Linus Torvalds wrote:
> On Sun, Apr 12, 2020 at 11:34 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Existing kernel config options are defined based on "whether you want to
>> enable this module/feature or not". And such granularity is sometimes
>> too rough-grained for fuzzing tools which try to find bugs inside each
>> module/feature.
> 
> I still detest making this a hardcoded build-time config option.
> 
> A kernel parameter that sets a flag seems much simpler. More
> importantly, having it be something sanely named, and something you
> can set independently some other way, would allow a regular kernel to
> then run a fuzzer as root.

That approach involves declaration of user-visible behavioral ABI which
will become impossible to change or remove if we once published.

Also, syzkaller does not want to depend on userspace being rich. There are
userspace tools (e.g. SystemTap) that can tweak kernel's behavior. If we could
use SystemTap, we could do some of tweaks using SystemTap. Likewise, use of
runtime flags which can be set from userspace involves modification of userspace
programs, which is a sort of dependency syzkaller does not want to maintain.

The advantage of build-time tweaking is that we don't need to maintain behavioral
ABI. We can change what tweak is doing over time (e.g. narrowing down what the
build-time tweaking guards, improving how to get more useful information).

> 
> Some kind of "not even root" flag, which might be per-process and not
> possible to clear once set (so that your _normal_ system binaries
> could still do the root-only stuff, but then you could start a fuzzing
> process with that flag set, knowing that the fuzzing process - and
> it's children - are not able to do things).

I don't think per-process flags will work. Not every action is taken inside
process context who issued a syscall. Some action might be taken in interrupt
context or in kthread context. Since we have no means to propagate per-process
flags, we will need to give up more than we have to give up.

> 
> Honestly, in a perfect world, it has nothing at all to do with
> fuzzing, and people could even have some local rules like "anybody who
> came in through ssh from the network will also have this flag set".

I think that such restriction should be implemented as LSM modules.
