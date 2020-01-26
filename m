Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11808C35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA1221D7D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAZTUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgAZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4690206F0;
        Sun, 26 Jan 2020 19:20:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSG-000zpZ-FM; Sun, 26 Jan 2020 14:20:20 -0500
Message-Id: <20200126191932.984391723@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Some very old (and some new) patches for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Carpenter (1):
      tracing: Remove unneeded NULL check

Hou Pengyang (1):
      tracing: Fix comments about trace/ftrace.h

Josef Bacik (1):
      tracing: Set kernel_stack's caller size properly

Luis Henriques (1):
      tracing: Fix tracing_stat return values in error handling paths

Steven Rostedt (VMware) (3):
      tracing: Fix very unlikely race of registering two stat tracers
      tracing: Decrement trace_array when bootconfig creates an instance
      tracing: Use pr_err() instead of WARN() for memory failures

----
 include/trace/trace_events.h |  9 ++++++---
 kernel/trace/ftrace.c        |  4 ++--
 kernel/trace/trace.c         | 24 ++++++++++++++----------
 kernel/trace/trace.h         | 12 ++++++++++++
 kernel/trace/trace_boot.c    |  1 +
 kernel/trace/trace_entries.h |  2 +-
 kernel/trace/trace_stat.c    | 31 +++++++++++++++++--------------
 7 files changed, 53 insertions(+), 30 deletions(-)
