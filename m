Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B7C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59258208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH1WuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgH1Wt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:49:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E44208A9;
        Fri, 28 Aug 2020 22:49:56 +0000 (UTC)
Date:   Fri, 28 Aug 2020 18:49:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel-owner@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, abhishekpandit@google.com,
        briannorris@google.com, drinkcat@google.com, tientzu@google.com
Subject: Re: [for-next][PATCH 2/2] tracing: Use temp buffer when filtering
 events
Message-ID: <20200828184955.6de9b54e@oasis.local.home>
In-Reply-To: <b504b3d7e989cae108669a0cd3072454@codeaurora.org>
References: <20160504135202.422290539@goodmis.org>
        <20160504135241.308454993@goodmis.org>
        <b504b3d7e989cae108669a0cd3072454@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 15:53:06 +0800
Wen Gong <wgong@codeaurora.org> wrote:

> this patch commit id is : 0fc1b09ff1ff404ddf753f5ffa5cd0adc8fdcdc9 which 
> has upstream.
> 
> how much size is the per cpu buffer?
> seems it is initilized in trace_buffered_event_enable,
> it is only 1 page size as below:
> void trace_buffered_event_enable(void)
> {
> ...
> 	for_each_tracing_cpu(cpu) {
> 		page = alloc_pages_node(cpu_to_node(cpu),
> 					GFP_KERNEL | __GFP_NORETRY, 0);
> If the size of buffer to trace is more than 1 page, such as 46680, then 
> it trigger kernel crash/panic in my case while run trace-cmd.
> After debugging, the trace_file->flags in 
> trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is 
> 0x403 while collecting ftrace log.
> 
> Is it have any operation to disable this patch dynamically?

It shouldn't be disabled, this is a bug that needs to be fixed.

Also, if an event is more than a page, it wont be saved in the ftrace
ring buffer, as events are limited by page size minus the headers.

-- Steve
