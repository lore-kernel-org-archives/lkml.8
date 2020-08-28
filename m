Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF02F2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgH1DnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:43:00 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59877 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgH1DnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:43:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U73inrt_1598586177;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U73inrt_1598586177)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 11:42:57 +0800
Date:   Fri, 28 Aug 2020 11:42:57 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 0/4] tracing: trivial cleanup
Message-ID: <20200828034257.GA8994@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

Would you like to pick this up?

On Sun, Jul 12, 2020 at 09:10:32AM +0800, Wei Yang wrote:
>Some trivial cleanup for tracing.
>
>v2:
>  * drop patch 1
>  * merge patch 4 & 5
>  * introduce a new patch change the return value of tracing_init_dentry()
>
>Wei Yang (4):
>  tracing: simplify the logic by defining next to be "lasst + 1"
>  tracing: save one trace_event->type by using __TRACE_LAST_TYPE
>  tracing: toplevel d_entry already initialized
>  tracing: make tracing_init_dentry() returns an integer instead of a
>    d_entry pointer
>
> kernel/trace/trace.c                 | 36 ++++++++++++++--------------
> kernel/trace/trace.h                 |  2 +-
> kernel/trace/trace_dynevent.c        |  8 +++----
> kernel/trace/trace_events.c          |  9 ++-----
> kernel/trace/trace_events_synth.c    |  9 +++----
> kernel/trace/trace_functions_graph.c |  8 +++----
> kernel/trace/trace_hwlat.c           |  8 +++----
> kernel/trace/trace_kprobe.c          | 10 ++++----
> kernel/trace/trace_output.c          | 14 +++++------
> kernel/trace/trace_printk.c          |  8 +++----
> kernel/trace/trace_stack.c           | 12 +++++-----
> kernel/trace/trace_stat.c            |  8 +++----
> kernel/trace/trace_uprobe.c          |  9 ++++---
> 13 files changed, 66 insertions(+), 75 deletions(-)
>
>-- 
>2.20.1 (Apple Git-117)

-- 
Wei Yang
Help you, Help me
