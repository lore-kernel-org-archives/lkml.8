Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CE208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgE0XeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:34:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60444 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgE0XeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:34:24 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04RNXamN023579;
        Thu, 28 May 2020 08:33:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Thu, 28 May 2020 08:33:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04RNXaiH023574
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 28 May 2020 08:33:36 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
Date:   Thu, 28 May 2020 08:33:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527155504.GD3529@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/28 0:55, Petr Mladek wrote:
>>> Well, it would be possible to call vsprintf() with NULL buffer. It is
>>> normally used to calculate the length of the message before it is
>>> printed. But it also does all the accesses without printing anything.
>>
>> OK. I think that redirecting pr_debug() to vsnprintf(NULL, 0) will be
>> better than modifying dynamic_debug path, for
> 
> It might get more complicated if you would actually want to see
> pr_debug() messages for a selected module in the fuzzer.

I don't expect that automated testing can afford selectively enabling
DYNAMIC_DEBUG_BRANCH(id) conditions. But we could evaluate all arguments
by calling snprintf(NULL, 0) if the condition to call printk() is false.

> vsprintf(NULL, ) can be called for pr_debug() messages in
> vprintk_store(). It will be again only a single place for
> all printk() wrappers.

I couldn't catch what you mean. The problem of pr_debug() is that
vprintk_store() might not be called because of

  #define no_printk(fmt, ...)                             \
  ({                                                      \
          if (0)                                          \
                  printk(fmt, ##__VA_ARGS__);             \
          0;                                              \
  })

  #define pr_debug(fmt, ...) \
          no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

or

  #define __dynamic_func_call(id, fmt, func, ...) do {    \
          DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);         \
          if (DYNAMIC_DEBUG_BRANCH(id))                   \
                  func(&id, ##__VA_ARGS__);               \
  } while (0)

  #define _dynamic_func_call(fmt, func, ...)                              \
          __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)

  #define dynamic_pr_debug(fmt, ...)                              \
          _dynamic_func_call(fmt, __dynamic_pr_debug,             \
                             pr_fmt(fmt), ##__VA_ARGS__)

  #define pr_debug(fmt, ...) \
          dynamic_pr_debug(fmt, ##__VA_ARGS__)

. Maybe we can append

          else if (IS_BUILTIN(CONFIG_TWIST_ALWAYS_EVALUATE_DEBUG_PRINTK)) \
                  snprintf(NULL, 0, fmt, ##__VA_ARGS__);  \

to no_printk() and __dynamic_func_call().

