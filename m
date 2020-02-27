Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB8C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4742469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgB0WLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:11:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52073 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0WLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:11:34 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01RMAILC044809;
        Fri, 28 Feb 2020 07:10:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Fri, 28 Feb 2020 07:10:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 01RMADxR044793
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 28 Feb 2020 07:10:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Matthew Garrett <mjg59@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu>
 <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
 <CACT4Y+ZLaR=GR2nssb_buGC0ULNpQW6jvX0p8NAE-vReDY5fPA@mail.gmail.com>
 <CACT4Y+Y1NTsRmifm2QLCnGom_=TnOo5Nf4EzQ=7gCJLYzx9gKA@mail.gmail.com>
 <CACdnJut=Sp9fF7ysb+Giiky0QRfakczJyK2AH2puJPYWQQKhdQ@mail.gmail.com>
 <4abd90ad-dc1a-7228-1f1c-b106097bcaef@i-love.sakura.ne.jp>
Message-ID: <9e5b7fde-4a18-a10b-fc53-c025bf96e8f9@i-love.sakura.ne.jp>
Date:   Fri, 28 Feb 2020 07:10:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4abd90ad-dc1a-7228-1f1c-b106097bcaef@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/18 19:54, Tetsuo Handa wrote:
> On 2020/01/03 4:57, Matthew Garrett wrote:
>> On Tue, Dec 17, 2019 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>> +Matthew for a lockdown question
>>> We are considering [ab]using lockdown (you knew this will happen!) for
>>> fuzzing kernel. LOCKDOWN_DEBUGFS is a no-go for us and we may want a
>>> few other things that may be fuzzing-specific.
>>> The current inflexibility comes from the global ordering of levels:
>>>
>>> if (kernel_locked_down >= level)
>>> if (kernel_locked_down >= what) {
>>>
>>> Is it done for performance? Or for simplicity?
>>
>> Simplicity. Based on discussion, we didn't want the lockdown LSM to
>> enable arbitrary combinations of lockdown primitives, both because
>> that would make it extremely difficult for userland developers and
>> because it would make it extremely easy for local admins to
>> accidentally configure policies that didn't achieve the desired
>> outcome. There's no inherent problem in adding new options, but really
>> right now they should fall into cases where they're protecting either
>> the integrity of the kernel or preventing leakage of confidential
>> information from the kernel.
>>
> 
> Can we resume this topic?
> 
> I think build-time lockdown (i.e. kernel config option) is more reliable
> and easier to use.
> 

Here is an example of need to lockdown specific ations. Can we proceed?

https://lkml.kernel.org/r/CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com
