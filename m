Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8885AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D677206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2Er4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:47:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62675 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Er4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:47:56 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04T4lq3r004873;
        Fri, 29 May 2020 13:47:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Fri, 29 May 2020 13:47:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04T4lqYR004870
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 May 2020 13:47:52 +0900 (JST)
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
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
Date:   Fri, 29 May 2020 13:47:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/29 11:24, Linus Torvalds wrote:
> Some flags do end up having to be practically system-wide, because
> they end up being used in contexts other than the test environment (ie
> anything that ends up doing workqueues or networking or VM or whatever
> - it's a "global context").

Right. And since fuzz testing can't determine whether it will involve
"global context", the options for fuzz testing (currently referenced as
"twist") can't be "per process". It might be possible to make the twist
options "per boot", but we are conflicting on whether making the twist
options "per boot" worth the effort.

> At the same time, some of the flags might well be "in the test
> environment" if they act on behavior that is all synchronous. Then
> other testers can use them on production machines for testing, even
> when the kernel might be used for other things at the same time.

I don't think that people use their machines for testing and non-testing
at the same time. When testing kernels, people enable a lot of debugging
kernel config options (e.g. KASAN, lockdep) because finding bugs has
higher priority than faster kernels. Some of debugging functionality
could be enabled/disabled using kernel command line, but it is hardly
possible to convert such debugging functionality into "per process".
It is much safer to run a qemu-kvm instance on their machines if they
want to test kernels without affecting the rest of their machines.

> And absolutely none of this should be named "twist". If you can't make
> a config have a sane name that talks about what it does, then it
> shouldn't exist at all.

CONFIG_TWIST_* options are analogy of CONFIG_DEBUG_* options.
The TWIST part is a prefix for grouping. If you don't like the grouping,
it is just a matter of renaming CONFIG_TWIST_* options.

> And making that a build-time option is the worst of all worlds.

Can we avoid discussing "the config option naming" (which is build-time
things) and "the kernel command line option" (which is boot-time things)
at the same time? What I am saying is

 THE TWIST OPTIONS ARE INTENDED FOR "IMPROVING THE QUALITY OF KERNEL TESTING"

which will in turn help improving the quality of kernel itself, and your
insistence on making them boot-time things (which might increase flexibility
for users) can decrease the reliability/robustness of testing.

