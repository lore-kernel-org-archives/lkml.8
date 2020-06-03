Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E820772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgFCNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:35:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57305 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:35:06 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 053DZ3U2094511;
        Wed, 3 Jun 2020 22:35:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Wed, 03 Jun 2020 22:35:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 053DZ3eP094496
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 3 Jun 2020 22:35:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: twist: allow disabling reboot request
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
 <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
 <51eaa6cd-33ce-f9d8-942c-c797c0ec6733@i-love.sakura.ne.jp>
 <20200603124405.GA22497@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9203e56c-1d84-bfce-b2d8-b2395ef0168a@i-love.sakura.ne.jp>
Date:   Wed, 3 Jun 2020 22:35:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603124405.GA22497@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/03 21:44, Petr Mladek wrote:
> On Wed 2020-06-03 20:03:28, Tetsuo Handa wrote:
>> On 2020/05/29 22:26, Tetsuo Handa wrote:
>>>     By the way, I do worry that people forget to perform these steps when they do
>>>     their tests without asking syzbot...
>>
>> Here is a draft of boot-time switching. Since kconfig can handle string variable up to
>> 2048 characters, we could hold the content of the "your-config" file inside .config file
>> in order to avoid relying on external file in "syzkaller tree". But since only one kconfig
>> option is used, basically the way to temporarily include/exclude specific options (under
>> automated testing by syzbot) seems to remain directly patching apply_twist_flags(), for
>> https://github.com/google/syzkaller/blob/master/dashboard/config/util.sh will automatically
>> overwrite CONFIG_DEFAULT_TWIST_FLAGS settings. If each twist flag were using independent
>> kconfig option, the way to temporarily include/exclude specific options will become directly
>> patching Kconfig file.
>>
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index 82d91547d122..78fdbb4f17b1 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -1038,4 +1038,12 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>>  	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
>>  	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
>>  	 (perms))
>> +
>> +/* Flags for twisting kernel behavior. */
>> +struct twist_flags {
>> +	bool disable_kbd_k_spec_handler;
>> +	bool disable_reboot_request;
>> +};
>> +extern struct twist_flags twist_flags;
> 
> 
> Why all these options have to be in a single structure?

There will be many options (maybe some dozens).
Do we really want to expose so many options individually?

(If these options were build-time configuration, we won't need
this structure at all.)

> 
> 
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 498d344ea53a..41cfabc74ad7 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2338,4 +2338,9 @@ config HYPERV_TESTING
>>  
>>  endmenu # "Kernel Testing and Coverage"
>>  
>> +menuconfig DEFAULT_TWIST_FLAGS
>> +	string "Default twist options (DANGEROUS)"
>> +	help
>> +	  Don't specify anything unless you know what you are doing.
>> +
>>  endmenu # Kernel hacking
> 
> Why such a crazy build configure option?
> 
> I think that the only way to get this upstream is to:
> 
>    + Add separate boot options that might theoretically be used also
>      by other people.

Like you said

  I am afraid that many of them could not be normal options. They change or
  break some behavior that is necessary by seriously used system.

these options are meant for helping fuzzers to find bugs while protecting
the kernel from legitimate-but-stupid requests from fuzzers. Other people
can include projects other than syzbot, but basically only useful for
debugging projects. (And making these options boot-time configuration
increases garbage/overhead for non-debugging usage.)

> 
>    + Use boot parameters and not build configuration.

That sounds like a very tight restriction for syzbot. Relying on external
files breaks reproducibility; people can fail to specify intended options.
Saving intended options into the .config file is the most robust/reliable
approach.

> 
>    + Avoid the meaningless word "twist" !!!

Then, what do you suggest? I think that we need some keyword for grouping.
https://lkml.kernel.org/r/41a49d42-7119-62b9-085b-aa99cadc4dd1@i-love.sakura.ne.jp

> 
> 
> Best Regards,
> Petr
> 
