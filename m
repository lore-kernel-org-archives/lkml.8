Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FDD206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHFRjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgHFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D542311F;
        Thu,  6 Aug 2020 13:11:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k3fgB-006KTV-QT; Thu, 06 Aug 2020 09:11:31 -0400
Message-ID: <20200806131108.374130743@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Aug 2020 09:11:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Last three patches (hopefully) before my pull request
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 37f9e8b51dbe7f69d9f80aec98f1514f0cd4085e


Masami Hiramatsu (1):
      bootconfig: Fix to find the initargs correctly

Muchun Song (1):
      kprobes: Fix compiler warning for !CONFIG_KPROBES_ON_FTRACE

Steven Rostedt (VMware) (1):
      tracing: Use trace_sched_process_free() instead of exit() for pid tracing

----
 init/main.c                 | 14 ++++++++------
 kernel/kprobes.c            | 17 ++++++++++++++---
 kernel/trace/ftrace.c       |  4 ++--
 kernel/trace/trace_events.c |  4 ++--
 4 files changed, 26 insertions(+), 13 deletions(-)
