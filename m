Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EB722BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGaVQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgGaVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:16:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D06B22B43;
        Fri, 31 Jul 2020 21:16:28 +0000 (UTC)
Date:   Fri, 31 Jul 2020 17:16:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian May <ian.may@canonical.com>
Subject: Re: [for-next][PATCH 09/18] tracing: Move pipe reference to trace
 array instead of current_tracer
Message-ID: <20200731171626.2c51e818@oasis.local.home>
In-Reply-To: <20200731193345.GA54749@xps13.dannf>
References: <20200702215812.428188663@goodmis.org>
        <20200702215832.784471709@goodmis.org>
        <20200731193345.GA54749@xps13.dannf>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 13:33:45 -0600
dann frazier <dann.frazier@canonical.com> wrote:

> > This is marked as "Fixes" but is more of a clean up than a true fix.
> > Backport if you want, but its not critical.  
> 
> Thanks Steven! In case it helps backport consideration, I wanted to
> note that this addresses an issue we've seen with users trying to
> change current_tracer when they happen to have rasdaemon
> installed. rasdaemon uses the trace_pipe interface at runtime, which
> therefore blocks changing the current tracer. But of course, unless
> you know about rasdaemon internals, it isn't exactly an obvious
> failure mode.

Ah, then this should probably be backported.

When I push to Linus (during the next merge window) and it gets into
Linus's tree. Feel free to send stable@vger.kernel.org the sha1 of this
commit, and ask for it to be backported for the above stated reason.

-- Steve
