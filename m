Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF6C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DAD2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgBSD0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgBSD0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:26:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EDF824658;
        Wed, 19 Feb 2020 03:26:17 +0000 (UTC)
Date:   Tue, 18 Feb 2020 22:26:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] trace: Move trace data to new section
 _ftrace_data
Message-ID: <20200218222615.713d542d@gandalf.local.home>
In-Reply-To: <899e4e41c4cf5c62a4fbce0923e5796141ef46f0.camel@perches.com>
References: <cover.1582077698.git.joe@perches.com>
        <20200218215328.16744447@gandalf.local.home>
        <899e4e41c4cf5c62a4fbce0923e5796141ef46f0.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 19:09:10 -0800
Joe Perches <joe@perches.com> wrote:

> I don't care about the section name at all.
> 
> I used that name for consistency with _ftrace_event
> in the same file. 
> Perhaps the _ftrace_event section
> name could be renamed to something
> intelligible too.

Yes, that should probably get changed. That's a leftover when we just
called everything "ftrace", but it should have been changed when I
renamed the file from ftrace.h to trace_event.h.

-- Steve
