Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6BAC55185
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811D6206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZBGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:06:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59322 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgDZBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 21:06:18 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03Q16G63028067;
        Sun, 26 Apr 2020 10:06:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Sun, 26 Apr 2020 10:06:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03Q169Lq027990
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 26 Apr 2020 10:06:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCHv3 11/50] c6x: Add show_stack_loglvl()
To:     Joe Perches <joe@perches.com>, Dmitry Safonov <dima@arista.com>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-12-dima@arista.com>
 <38aeb1431d8245b0c37b5d3d7ec6d9e2f33c330e.camel@perches.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <be2773a5-152d-1d0b-c843-d4f528e40541@i-love.sakura.ne.jp>
Date:   Sun, 26 Apr 2020 10:06:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <38aeb1431d8245b0c37b5d3d7ec6d9e2f33c330e.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/26 3:18, Joe Perches wrote:
> On Sat, 2020-04-18 at 21:19 +0100, Dmitry Safonov wrote:
>> Currently, the log-level of show_stack() depends on a platform
>> realization. It creates situations where the headers are printed with
>> lower log level or higher than the stacktrace (depending on
>> a platform or user).
> []
>> diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
> []
>> @@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
>>  
>>  static int kstack_depth_to_print = 48;
>>  
>> -static void show_trace(unsigned long *stack, unsigned long *endstack)
>> +static void show_trace(unsigned long *stack, unsigned long *endstack,
>> +		       const char *loglvl)
>>  {
>>  	unsigned long addr;
>>  	int i;
>>
>> -	pr_debug("Call trace:");
>> +	printk("%sCall trace:", loglvl);
> 
> These are not equivalent transforms as pr_debug
> is compiled to nothing unless DEBUG is defined
> or CONFIG_DYNAMIC_DEBUG is enabled.

I guess this user is expecting pr_debug() as unconditional printk(KERN_DEBUG), for
show_trace() and show_stack() will become waste of code if pr_debug() prints nothing.
If this user wants pr_debug() to be conditional, #ifdef'ing these functions is the better.

> 
> Perhaps all the conversions should be checked
> for these "not the same" object code changes.
> 
