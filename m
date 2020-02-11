Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754D22467C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgBKNuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgBKNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:49:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E7E20714;
        Tue, 11 Feb 2020 13:49:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j1VvJ-001aog-Rw; Tue, 11 Feb 2020 08:49:57 -0500
Message-Id: <20200211134941.229027482@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 11 Feb 2020 08:49:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: A few more patches for 5.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami Hiramatsu (2):
      bootconfig: Allocate xbc_nodes array dynamically
      tools/bootconfig: Suppress non-error messages

Tom Zanussi (3):
      tracing: Add missing nest end to synth_event_trace_start() error case
      tracing: Don't return -EINVAL when tracing soft disabled synth events
      tracing: Consolidate trace() functions

----
 include/linux/trace_events.h              |   2 +-
 kernel/trace/trace_events_hist.c          | 227 +++++++++++-------------------
 lib/bootconfig.c                          |  15 +-
 tools/bootconfig/include/linux/memblock.h |  12 ++
 tools/bootconfig/main.c                   |  28 ++--
 tools/bootconfig/test-bootconfig.sh       |   9 ++
 6 files changed, 134 insertions(+), 159 deletions(-)
 create mode 100644 tools/bootconfig/include/linux/memblock.h
