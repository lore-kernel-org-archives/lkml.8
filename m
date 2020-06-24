Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3492C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CEC2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgFXDjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:39:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DED2085B;
        Wed, 24 Jun 2020 03:39:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jnwG5-003u7z-FS; Tue, 23 Jun 2020 23:39:33 -0400
Message-ID: <20200624033858.651927570@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 23 Jun 2020 23:38:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for 5.8-rc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (2):
      tracing/boot: Fix config dependency for synthedic event
      tracing: Fix event trigger to accept redundant spaces

Sascha Ortmann (1):
      tracing/boottime: Fix kprobe multiple events

Steven Rostedt (VMware) (1):
      ring-buffer: Zero out time extend if it is nested and not absolute

----
 kernel/trace/ring_buffer.c          |  2 +-
 kernel/trace/trace_boot.c           | 10 +++++++---
 kernel/trace/trace_events_trigger.c | 21 +++++++++++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)
