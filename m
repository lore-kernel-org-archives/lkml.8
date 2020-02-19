Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C86C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794F22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBSCxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgBSCxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:53:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13ACA22B48;
        Wed, 19 Feb 2020 02:53:29 +0000 (UTC)
Date:   Tue, 18 Feb 2020 21:53:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] trace: Move trace data to new section
 _ftrace_data
Message-ID: <20200218215328.16744447@gandalf.local.home>
In-Reply-To: <cover.1582077698.git.joe@perches.com>
References: <cover.1582077698.git.joe@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 18:03:16 -0800
Joe Perches <joe@perches.com> wrote:

> Move the trace data to a separate section to make it easier to
> examine the amount of actual data in an object file.

Not that I'm against this patch set, but can you elaborate more on
"make it easier to examine the amount of actual data in an object file".

Also, don't use "_ftrace" as the section name. "ftrace" should be
reserved for the function hook part of tracing, which trace events do
not apply to. "_trace_event_data" would be more appropriate.

-- Steve


> 
> Joe Perches (2):
>   trace: Move data to new section _ftrace_data
>   trace_events/trace_export: Use __section
> 
>  include/trace/trace_events.h | 36 +++++++++++++++++++++---------------
>  kernel/trace/trace_export.c  | 13 ++++++++-----
>  2 files changed, 29 insertions(+), 20 deletions(-)
> 

