Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3222075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgE1Ld5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:33:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64409 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgE1Ld4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:33:56 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04SBX8QI037000;
        Thu, 28 May 2020 20:33:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Thu, 28 May 2020 20:33:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04SBX85n036990
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 28 May 2020 20:33:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
 <20200527083747.GA27273@linux-b0ei>
 <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
 <20200527155504.GD3529@linux-b0ei>
 <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528105942.GB11286@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <945213f4-a2c3-b25e-35e4-7c55f836e11c@i-love.sakura.ne.jp>
Date:   Thu, 28 May 2020 20:33:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528105942.GB11286@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/28 19:59, Petr Mladek wrote:
> 2. Add twist into vprintk_store(). In the current, implementation
>    it would do:
> 
>   #if TWIST
> 	return text_len;
>   #endif
> 
> 	return log_output(facility, level, lflags,
> 			  dict, dictlen, text, text_len);

This part could be possible. But

> 1. Add twist into ddebug_add_module() and enable all newly added
>    entries by default. For example, by calling
>    ddebug_exec_query("*:+p", const char *modname) or what is the syntax.
> 
>    This will cause that any pr_devel() variant will always get called.

how to handle

>>   #define no_printk(fmt, ...)                             \
>>   ({                                                      \
>>           if (0)                                          \
>>                   printk(fmt, ##__VA_ARGS__);             \
>>           0;                                              \
>>   })

part used by e.g. pr_devel() ? Since this macro is not using dynamic debug
interface, vprintk_store() will not be called from the beginning. Are you
suggesting that we should convert no_printk() to use dynamic debug interface ?

I don't know whether enabling only in linux-next makes sense. Since not all tests
are equally done on each git tree, available only in linux-next will not be able
to cover all callers. Just using CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS=y
and CONFIG_DYNAMIC_DEBUG=n is the simplest.

