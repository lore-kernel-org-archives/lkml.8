Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5CB20409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgCZLLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:11:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62199 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCZLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:11:18 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02QBA2lL021666;
        Thu, 26 Mar 2020 20:10:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 26 Mar 2020 20:10:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02QBA2aM021662
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 26 Mar 2020 20:10:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <55c906c8-ca70-9d1b-a90f-49660773856b@i-love.sakura.ne.jp>
Date:   Thu, 26 Mar 2020 20:10:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YEYYNv-=AgNthQvLkeK-8uEeRs4XEuRqphfZBhc2hc5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/24 19:37, Dmitry Vyukov wrote:
>> So, we have three questions.
>>
>> Q1: Can we agree with adding build-time branching (i.e. kernel config options) ?
>>
>>     I fear bugs (e.g. unexpectedly overwrting flag variables) in run-time
>>     branching mechanisms. Build-time branching mechanisms cannot have such bugs.
> 
> My vote is for build config. It's simplest to configure (every testing
> system should already have control over config) and most reliable
> (e.g. fuzzer figures out a way to disable a runtime option).

Right. For example, console loglevel has been unexpectedly changed via syscall
arguments. For another example, /dev/mem has been unexpectedly accessed using
mount operation ( https://github.com/google/syzkaller/issues/1436 ). Providing
an interface (e.g. debugfs files) for branching after boot has a risk of
unexpectedly overwriting flag variables.

Since it seems that there is no objection to Q1, I think that we can go with
build-time branching.

>> Q3: If we can agree with kernel config options but we can't start with single
>>     (or fewer) kernel config option, can we agree with adding another kernel
>>     config option which selects all options (e.g.
>>     ) ?
> 
> I think this option is the best. It both allows fine-grained control
> (and documentation for each switch), and coarse-grained control for
> testing systems.
> We could also add "depends on DEBUG_KERNEL" just to make sure.
> 

OK. But I think that KERNEL_BUILT_FOR_FUZZ_TESTING_SELECT_ALL might fail to
work, for it is possible that a new option was added but that option was not
added to "select" list of KERNEL_BUILT_FOR_FUZZ_TESTING_SELECT_ALL. Also,
there might be cases where a new option was added but that option should not
be selected for some fuzzers (e.g. syzkaller wants to hardcode console loglevel
to foo while fuzzer1 and fuzzer2 want to hardcode console loglevel to bar).
That is, something like

      config KERNEL_BUILT_FOR_FUZZ_TESTING
             bool "Build kernel for fuzz testing"

      config KERNEL_BUILT_FOR_SYZKALLER
             bool "Build kernel for syzkaller testing"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING
             select KERNEL_DISABLE_FOO1
             select KERNEL_DISABLE_BAR1
             select KERNEL_DISABLE_BUZ1
             select KERNEL_ENABLE_BAR2

      config KERNEL_BUILT_FOR_FUZZER1
             bool "Build kernel for fuzzer1 testing"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING
             select KERNEL_DISABLE_FOO1
             select KERNEL_DISABLE_BAR1

      config KERNEL_BUILT_FOR_FUZZER2
             bool "Build kernel for fuzzer2 testing"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING
             select KERNEL_DISABLE_FOO1
             select KERNEL_DISABLE_BUZ1

      config KERNEL_DISABLE_FOO1
             bool "Disable foo1"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING

      config KERNEL_DISABLE_BAR1
             bool "Disable bar1"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING

      config KERNEL_DISABLE_BUZ1
             bool "Disable buz1"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING

      config KERNEL_CHANGE_FOO2
             bool "Change foo2"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING

      config KERNEL_ENABLE_BAR2
             bool "Enable bar2"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING

in order to allow each testing system to select what it wants with
"only two options" ("CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y" and one of
"CONFIG_KERNEL_BUILT_FOR_SYZKALLER=y" or "CONFIG_KERNEL_BUILT_FOR_FUZZER1=y"
or "CONFIG_KERNEL_BUILT_FOR_FUZZER2=y").

CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING option remains there in order to
avoid needlessly prompting choices to users who do not intend to build
for fuzz testing.

