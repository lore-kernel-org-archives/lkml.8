Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45266C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2427920704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgAXQgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbgAXQgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:36:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C478020709;
        Fri, 24 Jan 2020 16:36:11 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:36:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-ID: <20200124113610.662f4afb@gandalf.local.home>
In-Reply-To: <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020 01:31:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steven and Thomas,
> 
> On Fri, 24 Jan 2020 10:07:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This looks like a kernel bug, not a libtraceevent parsing bug.  
> 
> Totally agreed. It was my fault to update the print format.
> Even if still there is a problem on s390, this patch must be
> applied.

Thanks Masami for looking into it.

Thomas,

Please still test this patch. If it works, I'd like to add a
Reported-by and Tested-by tag from you.

-- Steve

> 
> Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
