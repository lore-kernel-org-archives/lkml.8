Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7158EC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566AF2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDRPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:09:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56007 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgDRPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 11:09:39 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03IF8QuH065064;
        Sun, 19 Apr 2020 00:08:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sun, 19 Apr 2020 00:08:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03IF8JI6064953
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 19 Apr 2020 00:08:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200413081426.GA2791586@kroah.com>
 <85d9c411-f205-56bf-df6b-6d4fa39a134b@i-love.sakura.ne.jp>
 <20200418143924.GA3485638@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <41a49d42-7119-62b9-085b-aa99cadc4dd1@i-love.sakura.ne.jp>
Date:   Sun, 19 Apr 2020 00:08:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418143924.GA3485638@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/18 23:39, Greg Kroah-Hartman wrote:
>> Well, we could add some more text (like shown below), but this option itself
>> is neutral. This option is not limiting the target to fuzzers.
>> Below 3 patches are an example of "a set of fine-grained configs" with
>> "some umbrella uber-config" approach. Linus, are you OK with this approach?
> 
> Note, the word "tweak" is usually used where people want to get the most
> performance out of a system, while here you are using it to remove
> functionality out of the system.  You might want to pick a different
> word, naming is hard :(

Then, what about "twist" ?

>> @@ -633,6 +633,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
>>  	     kbd->kbdmode == VC_OFF) &&
>>  	     value != KVAL(K_SAK))
>>  		return;		/* SAK is allowed even in raw mode */
>> +	if (IS_ENABLED(CONFIG_TWEAK_DISABLE_KBD_K_SPEC_HANDLER))
>> +		return;
> 
> Are you sure this is correct?  It seems like you just cut off a number
> of other keyboard function handlers instead of just the ctrl-alt-del
> functionality.  Did you really want to do that?

Maybe someday we update this filter more fine-grained. But I think this
granularity is what syzkaller wants for now. The ctrl-alt-del ( k_spec()
=> fn_boot_it() => ctrl_alt_del()) is simply one of them. There was RCU
stall report caused by repeating SysRq-t from this path ( k_spec() =>
fn_show_state() => show_state()) due to too much printk() calls.

