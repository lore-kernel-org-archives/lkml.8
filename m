Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812DEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E93020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDJEjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:39:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52073 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgDJEjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:39:39 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03A4cVn0033184;
        Fri, 10 Apr 2020 13:38:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Fri, 10 Apr 2020 13:38:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03A4cUnb033180
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 10 Apr 2020 13:38:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
 <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
 <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <7728c978-d359-227f-0f3e-f975c45ca218@i-love.sakura.ne.jp>
 <CACT4Y+YEYYNv-=AgNthQvLkeK-8uEeRs4XEuRqphfZBhc2hc5g@mail.gmail.com>
 <55c906c8-ca70-9d1b-a90f-49660773856b@i-love.sakura.ne.jp>
Message-ID: <fea03f73-89d1-93f6-0d72-f5dff388098f@i-love.sakura.ne.jp>
Date:   Fri, 10 Apr 2020 13:38:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55c906c8-ca70-9d1b-a90f-49660773856b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we resume this topic?

On 2020/03/26 20:10, Tetsuo Handa wrote:
> CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING option remains there in order to
> avoid needlessly prompting choices to users who do not intend to build
> for fuzz testing.
> 

Is CONFIG_TWIST_KERNEL_BEHAVIOR or CONFIG_TWEAK_KERNEL_BEHAVIOR
better-named than CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING, for there
might be small modifications which would be beneficial to things
other than fuzz testing (e.g. adding some more information when
dumping backtrace, reporting locks held by TASK_RUNNING threads) ?
