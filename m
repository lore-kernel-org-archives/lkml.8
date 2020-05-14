Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4503020728
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:58:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8CE206A5;
        Thu, 14 May 2020 12:58:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jZDRi-000G9A-Bo; Thu, 14 May 2020 08:58:42 -0400
Message-ID: <20200514125817.850882486@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 May 2020 08:58:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: A few more fixes for 5.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt (VMware) (3):
      x86/ftrace: Have ftrace trampolines turn read-only at the end of system boot up
      ring-buffer: Don't deactivate the ring buffer on failed iterator reads
      ring-buffer: Remove all BUG() calls

----
 arch/x86/include/asm/ftrace.h  |  6 ++++++
 arch/x86/kernel/ftrace.c       | 29 ++++++++++++++++++++++++++++-
 arch/x86/mm/init_64.c          |  3 +++
 include/linux/ftrace.h         | 23 +++++++++++++++++++++++
 kernel/trace/ftrace_internal.h | 22 ----------------------
 kernel/trace/ring_buffer.c     | 34 +++++++++++++---------------------
 6 files changed, 73 insertions(+), 44 deletions(-)
