Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5855DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3504E2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbgE1K7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387926AbgE1K7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:59:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFA69AB5C;
        Thu, 28 May 2020 10:59:43 +0000 (UTC)
Date:   Thu, 28 May 2020 12:59:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
Message-ID: <20200528105942.GB11286@linux-b0ei>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
 <20200527083747.GA27273@linux-b0ei>
 <35d76737-8d23-9fb2-8e55-507109317f44@i-love.sakura.ne.jp>
 <20200527155504.GD3529@linux-b0ei>
 <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 08:33:37, Tetsuo Handa wrote:
> On 2020/05/28 0:55, Petr Mladek wrote:
> >>> Well, it would be possible to call vsprintf() with NULL buffer. It is
> >>> normally used to calculate the length of the message before it is
> >>> printed. But it also does all the accesses without printing anything.
> >>
> >> OK. I think that redirecting pr_debug() to vsnprintf(NULL, 0) will be
> >> better than modifying dynamic_debug path, for
> > 
> > It might get more complicated if you would actually want to see
> > pr_debug() messages for a selected module in the fuzzer.
> 
> I don't expect that automated testing can afford selectively enabling
> DYNAMIC_DEBUG_BRANCH(id) conditions. But we could evaluate all arguments
> by calling snprintf(NULL, 0) if the condition to call printk() is false.
> 
> > vsprintf(NULL, ) can be called for pr_debug() messages in
> > vprintk_store(). It will be again only a single place for
> > all printk() wrappers.
> 
> I couldn't catch what you mean. The problem of pr_debug() is that
> vprintk_store() might not be called because of
> 
>   #define no_printk(fmt, ...)                             \
>   ({                                                      \
>           if (0)                                          \
>                   printk(fmt, ##__VA_ARGS__);             \
>           0;                                              \
>   })
> 
>   #define pr_debug(fmt, ...) \
>           no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> 
> or
> 
>   #define __dynamic_func_call(id, fmt, func, ...) do {    \
>           DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);         \
>           if (DYNAMIC_DEBUG_BRANCH(id))                   \
>                   func(&id, ##__VA_ARGS__);               \
>   } while (0)
> 
>   #define _dynamic_func_call(fmt, func, ...)                              \
>           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
> 
>   #define dynamic_pr_debug(fmt, ...)                              \
>           _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>                              pr_fmt(fmt), ##__VA_ARGS__)
> 
>   #define pr_debug(fmt, ...) \
>           dynamic_pr_debug(fmt, ##__VA_ARGS__)

That is exactly the problem. Your current patch [1] adds checks
for the CONFIG_TWIST into 15 different locations.

This is perfectly fine for testing in linux-next whether this twist
is worth the effort. But I do not like this as a long term solution.

If the testing shows that it was really helpful and you would want
to get this into Linus' tree. Then I would like to do the twist at different
level:

1. Add twist into ddebug_add_module() and enable all newly added
   entries by default. For example, by calling
   ddebug_exec_query("*:+p", const char *modname) or what is the syntax.

   This will cause that any pr_devel() variant will always get called.


2. Add twist into vprintk_store(). In the current, implementation
   it would do:

  #if TWIST
	return text_len;
  #endif

	return log_output(facility, level, lflags,
			  dict, dictlen, text, text_len);

   Something similar would need to be done also in printk_safe().
   Hot you could ignore this because it would be used only in
   very few scenarios.

  In the lock_less variant, we would need to format the message
  into small buffer on stack to detect the log level from the first
  few bytes.


The approach will cause that pr_devel() message will never get really
printed when this TWIST is enabled. But you mention that automatic
testing would not do so anyway.

[1] https://lore.kernel.org/r/20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp

Best Regards,
Petr
