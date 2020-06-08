Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C460C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FE62076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgFHKad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:30:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58978 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgFHKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:30:33 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 058AUTai079333;
        Mon, 8 Jun 2020 19:30:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Mon, 08 Jun 2020 19:30:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 058AUS5G079324
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 8 Jun 2020 19:30:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
 <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
 <CACT4Y+Z58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D=uffPyA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e51f5885-5508-7574-e5b9-e931a1164d3f@i-love.sakura.ne.jp>
Date:   Mon, 8 Jun 2020 19:30:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z58Z8u1g8SBy-i1WxLMrdmXvggsLFAhfbLc8D=uffPyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/08 16:48, Dmitry Vyukov wrote:
>> (5) Anything else?
> 
> Reading:
> https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config
> It seems that boot config is just a more complex way to provide
> command line arguments. syzbot already supports command line
> arguments, and it looks much simpler and no additional work required.
> Why do we want to use boot config?

Since the max length a bootloader can accept for kernel command line arguments is finite (e.g.
https://bugzilla.redhat.com/show_bug.cgi?id=1239170 ), we can't specify as many arguments as
we want. Since Linus is expecting to specify independently upon boot, length for the kernel
command line arguments might exceed that limit. The boot config is a method for allowing longer
kernel command line arguments, at the cost of mandating use of the initramfs file.

>> (2) The boot-config file is embedded into initramfs file. Since syzkaller builds
>>     kernels with almost-allyesconfig, booting syzkaller kernels do not require
>>     initramfs for loading kernel modules needed for mounting the root partition.
>>     In fact, according to "unexpected kernel reboot" report which contains boot messages,
>>     I can't find "Unpacking initramfs..." message. It seems that syzkaller kernels do not
>>     use initramfs file.
>>
>>     Is it possible for syzkaller to enforce performing steps for creating an initramfs,
>>     embedding the boot-config file
>>     ( https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config),
>>     and loading that initramfs whenever booting the syzkaller kernels?
>>     By the way, I do worry that people forget to perform these steps when they do
>>     their tests without asking syzbot...
> 
> I think we have some confusion between syzkaller and syzbot here.
> syzkaller itself does not enforce/require any kernel configuration,
> hardware nor use or not use of initramfs. In fact, qemu VM type
> supports initramfs today. Or syzkaller can work with bare machines
> where all setup is up to the user.
> syzbot is just one deployment of syzkaller with a particular
> configuration/hardware.

OK.

> 
> If this feature is useful for any linux kernel fuzzing, then we need
> to have a plan for all users and setups.

Build-time switching can support all users and setups, for the kernel is built for intended
environment/purpose only. Assuming that this feature is useful for any linux kernel fuzzing,
we need to care about whether we can specify longer kernel command line arguments on every
environment in order to support boot-time switching.

> 
> And, yes, an additional context is kernel developers reproducing bugs.
> Not all of them may be happy about any additional steps, nor will
> follow them.

But there will be bugs which could not be found unless we twist kernel behavior.
Not mandate specifying appropriate twist options to the kernel command line
arguments can prevent automated/manual testings from finding/reproducing bugs.

> 
> Answering your question, syzkaller can do some sanity checking of the
> provided machine/kernel and reject working with it. If you tell me
> what exactly needs to be checked, I can think where this code should
> go.
> However, again, I am not sure if one is using, say, Android phones and
> they don't envision use of initramfs, then what?

If use of initramfs cannot be mandated, we might fail to specify necessary
twist options to the kernel command line (due to length limitation).

> 
> For syzbot, the build happens here:
> https://github.com/google/syzkaller/blob/7751efd04aebb07bc82b5c0e8eeaca07be1ae112/pkg/build/linux.go#L72
> I don't know if initramfs is supported with GCE machines and what
> exactly is required.

Neither do I. I'm not familiar with bootloaders.

> 
>> (4) Of course, "your-config" file would not change so frequently, but "#syz test" command
>>     relies on external file in "syzkaller tree" makes it impossible to try different
>>     configuration when I have to ask syzbot to test. (Since I don't have hardware which
>>     syzbot is reporting problems, I have to ask syzbot when I can't reproduce the problem
>>     in my environment.)
>>
>>     https://syzkaller.appspot.com/text?tag=Patch&x=135f254a100000 is an example of
>>     need to enforce CONFIG_DEBUG_INFO_BTF=n in order to workaround build failure during
>>     "#syz test" command. If we bring "which twist options should be enabled" to an external
>>     boot-config file, I can't ask syzbot to try different twist options (except directly
>>     patching the kernel source which handles "which twist options should be enabled").
>>     Can syzbot solve this concern?
> 
> The CONFIG_DEBUG_INFO_BTF relates to build config. This can't be
> solved during boot, right? So what is the relation?

This is an approach for embedding twist options into build-time conditions in order to
compensate for lack of ability to temporarily change the kernel command line arguments
(when it is difficult to temporarily change the kernel command line arguments).

