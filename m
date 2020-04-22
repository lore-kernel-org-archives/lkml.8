Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27062C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0062082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgDVQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVQ1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:27:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2C82076E;
        Wed, 22 Apr 2020 16:27:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRIE2-000O3m-AS; Wed, 22 Apr 2020 12:27:50 -0400
Message-Id: <20200422162539.808362933@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 12:25:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: [PATCH 0/3] x86/ftrace: Make created trampolines not call direct code
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

These three patches are built on top of your patch series.

This is what I was thinking of having. This isn't fully tested
(as your patch series is still running on my test suite).

-- Steve


Steven Rostedt (VMware) (3):
      x86/ftrace: Make non direct case the default in ftrace_regs_caller
      x86/ftrace: Only have the builtin ftrace_regs_caller call direct hooks
      x86/ftrace: Do not jump to direct code in created trampolines

----
 arch/x86/kernel/ftrace.c    | 14 +++++++++++---
 arch/x86/kernel/ftrace_64.S | 29 ++++++++++++++---------------
 kernel/trace/ftrace.c       |  8 ++++++++
 3 files changed, 33 insertions(+), 18 deletions(-)
