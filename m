Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C779206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbgEYImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbgEYImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77D14AF52;
        Mon, 25 May 2020 08:42:22 +0000 (UTC)
Date:   Mon, 25 May 2020 10:42:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
Message-ID: <20200525084218.GC5300@linux-b0ei>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-05-24 23:50:34, Tetsuo Handa wrote:
> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> because pr_debug() was no-op [1].
> 
>   pr_debug("fallback-read subflow=%p",
>            mptcp_subflow_ctx(ssock->sk));
>   copied = sock_recvmsg(ssock, msg, flags);

The NULL pointer deference was found even without this patch.
This patch would just cause that it will manifest itself on another
place. What is the benefit, please?


> Since console loglevel used by syzkaller will not print KERN_DEBUG
> messages to consoles, always evaluating pr_devel()/pr_debug() messages
> will not cause too much console output. Thus, let's allow fuzzers to
> always evaluate pr_devel()/pr_debug() messages.

I see few drawbacks with this patch:

1. It will cause adding much more messages into the logbuffer even
   though they are not flushed to the console. It might cause that
   more important messages will get overridden before they reach
   console. They might also make hard to read the full log.

2. Crash inside printk() causes recursive messages. They are currently
   printed into the printk_safe() buffers and there is a bigger risk
   that they will not reach the console.

3. pr_debug() messages are not printed by default. It is possible that
   nobody used them for ages. You might get many errors in less
   maintained code instead in the really used one. I mean that you
   will get more noise with less gain.



Have you tested this patch by the syzcaller with many runs, please?
Did it helped to actually discover more bugs?
Did it really made things easier?

I am not able to judge usefulness without more data. My intuition
tells me that we should keep the number of syzcaller-related twists
as small as possible. Otherwise, syscaller will diverge more and
more from reality.

Best Regards,
Petr
