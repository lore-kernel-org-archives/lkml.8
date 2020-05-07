Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86101C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6723320736
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGFNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:13:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52159 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGFNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:13:44 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0475DfVC006851;
        Thu, 7 May 2020 14:13:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 07 May 2020 14:13:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0475Dea3006806
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 7 May 2020 14:13:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
 <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
 <0d513c80-8c8e-17b6-5b9c-73c7bca77252@i-love.sakura.ne.jp>
 <63f58a1c334d8d44ddf1788091be9b2232054b03.camel@perches.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <36db0dfe-9d7e-0616-cbe6-4bfb99a1f470@i-love.sakura.ne.jp>
Date:   Thu, 7 May 2020 14:13:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <63f58a1c334d8d44ddf1788091be9b2232054b03.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/07 10:02, Joe Perches wrote:
>>> printk_get_level / printk_skip_level and the various
>>> uses of %pV using printk_get_level
>>>
>>
>> Excuse me, but what do you mean?
>>
>> I wish printk() accepts "loglevel" argument detached from "fmt" argument (e.g.
> 
> I think that's a bad idea as it would expand
> _every_ use of printk with another argument
> and overall code size would increase for very
> little value.

I'm not saying that we should add loglevel argument to all printk() callers.
I'm saying that we could add a variant of printk() which accepts loglevel
argument (say, e.g. printkl() and vprintkl()).

I think that some of printk_get_level() users are using printk_get_level() only
for detaching loglevel argument from fmt argument.

For example, fs/f2fs/f2fs.h defines f2fs_{err,warn,notice,info,debug}() which pass
KERN_* to f2fs_printk(), but f2fs_printk() in fs/f2fs/super.c trims KERN_* and passes
it back to printk(). If printkl() were there, f2fs_err() etc. can directly call
printkl() (and avoids printk_get_level(), printk_skip_level() and "struct va_format").

fs/btrfs/ctree.h similarly defines btrfs_{emerg,alert,crit,err,warn,notice,info}() and
their RCU and latelimited variants which pass KERN_* to btrfs_printk(), but
btrfs_printk() in fs/btrfs/super.c trims KERN_* and passes it back to printk().
If printkl() were there, btrfs_emerg() etc. can avoid printk_get_level() and
printk_skip_level().

sound/core/misc.c defines __snd_printk() which allows inserting filename and line number.
If printkl() were there, __snd_printk() can avoid printk_get_level() and printk_skip_level(),
and can constify format argument variable (which is currently writable just in order to embed
loglevel argument).

I don't know how the lockless logbuf will replace printk_safe_flush_buffer(). But I guess
it is possible to avoid printk_safe_flush_buffer() and printk_skip_level() as demonstrated
by https://lkml.kernel.org/r/5e192ca2-3b24-0b45-fc13-51feec43c216@i-love.sakura.ne.jp .

Then, printk_skip_headers() will be the only user of printk_skip_level(). I don't know how
vkdb_printf() works, but vkdb_printf() is currently using printk_skip_level() in order to
remove loglevel argument. We can avoid printk_skip_level() if loglevel argument is detached
 from fmt argument.

> 
> And do look at the code and uses of printk_get_level.

And again, what am I missing?

