Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF92C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F42072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbgAXPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbgAXPu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:50:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D81A2071E;
        Fri, 24 Jan 2020 15:50:26 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:50:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 0/7] seq_file .next functions should increase position
 index
Message-ID: <20200124105024.18d24572@gandalf.local.home>
In-Reply-To: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
References: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 10:02:36 +0300
Vasily Averin <vvs@virtuozzo.com> wrote:

> 
> I've sent patches into maillists of affected subsystems already,
> this patch-set fixes the problem in files related to 
> pstore, tracing, gcov, sysvipc  and other subsystems processed 
> via linux-kernel@ mailing list directly

Since you sent the patches out individually, and not as the usually way
of replying to the 0/7 patch (this email), do you expect the patches to
just be accepted by the individual maintainers, and not as a series?

-- Steve

> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> 
> Vasily Averin (7):
>   pstore_ftrace_seq_next should increase position index
>   gcov_seq_next should increase position index
>   t_next should increase position index
>   fpid_next should increase position index
>   eval_map_next should increase position index
>   trigger_next should increase position index
>   sysvipc_find_ipc should increase position index
> 
>  fs/pstore/inode.c                   | 2 +-
>  ipc/util.c                          | 2 +-
>  kernel/gcov/fs.c                    | 2 +-
>  kernel/trace/ftrace.c               | 9 ++++++---
>  kernel/trace/trace.c                | 4 +---
>  kernel/trace/trace_events_trigger.c | 5 +++--
>  6 files changed, 13 insertions(+), 11 deletions(-)
> 

