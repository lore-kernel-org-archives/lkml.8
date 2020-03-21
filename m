Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B6C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E0620732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 04:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCUEun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 00:50:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57445 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUEun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 00:50:43 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02L4nUum016014;
        Sat, 21 Mar 2020 13:49:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Sat, 21 Mar 2020 13:49:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02L4nP9d015877
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 21 Mar 2020 13:49:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7728c978-d359-227f-0f3e-f975c45ca218@i-love.sakura.ne.jp>
Date:   Sat, 21 Mar 2020 13:49:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/10 15:30, Dmitry Vyukov wrote:
> Re making it a single config vs a set of fine-grained configs. I think
> making it fine-grained is a proper way to do it, but the point Tetsuo
> raised is very real and painful as well -- when a kernel developer
> adds another option, they will not go and update configs on all
> external testing systems. This problem is also common for "enable all
> boot tests that can run on this kernel", or "configure a 'standard'
> debug build". Currently doing these things require all of expertise,
> sacred knowledge, checking all configs one-by-one as well as checking
> every new kernel patch and that needs to be done by everybody doing
> any kernel testing.
> I wonder if this can be solved by doing fine-grained configs, but also
> adding some umbrella uber-config that will select all of the
> individual options. Config system allows this, right? With "select" or
> "default if" clauses. What would be better: have the umbrella option
> select all individual, or all individual default to y if umbrella is
> selected?

So, we have three questions.

Q1: Can we agree with adding build-time branching (i.e. kernel config options) ?

    I fear bugs (e.g. unexpectedly overwrting flag variables) in run-time
    branching mechanisms. Build-time branching mechanisms cannot have such bugs.

Q2: If we can agree with kernel config options, can we start with single (or
    fewer) kernel config option (e.g. CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y) ?

Q3: If we can agree with kernel config options but we can't start with single
    (or fewer) kernel config option, can we agree with adding another kernel
    config option which selects all options (e.g.

      config KERNEL_BUILT_FOR_FUZZ_TESTING
             bool "Build kernel for fuzz testing"
      
      config KERNEL_BUILT_FOR_FUZZ_TESTING_SELECT_ALL
             bool "Select all options for Build kernel for fuzz testing"
             depends on KERNEL_BUILT_FOR_FUZZ_TESTING
             select KERNEL_DISABLE_FOO1
             select KERNEL_DISABLE_BAR1
             select KERNEL_DISABLE_BUZ1
             select KERNEL_CHANGE_FOO2
             select KERNEL_ENABLE_BAR2
      
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

    ) ?

