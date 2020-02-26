Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D8C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447B221744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgBZCTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgBZCTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:19:20 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9919821744;
        Wed, 26 Feb 2020 02:19:19 +0000 (UTC)
Date:   Tue, 25 Feb 2020 21:19:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [for-linus][PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING
 dependency issue
Message-ID: <20200225211918.369b222e@oasis.local.home>
In-Reply-To: <20200225170530.529a7246c1a4aa9b25d51039@linux-foundation.org>
References: <20200225191237.03643f96@gandalf.local.home>
        <20200225170530.529a7246c1a4aa9b25d51039@linux-foundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 17:05:30 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 25 Feb 2020 19:12:37 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Since commit d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by
> > default") also changed the CONFIG_BOOTTIME_TRACING to select
> > CONFIG_BOOT_CONFIG to show the boot-time tracing on the menu,
> > it introduced wrong dependencies with BLK_DEV_INITRD as below.  
> 
> Confusing.  It's described as "for Linus" but d8a953ddde5e isn't in
> Linus's tree.

Ah, it's part of my last "for-linus" series. I usually wait a day to
see if there's issues before sending Linus a pull request. An issue was
found in a randconfig and this patch fixes it. I added the "for-linus"
as it was attached to my pull request that had the commit with the
issue.

I could have added this patch as [for-linus][PATCH 16/15] ;-)

-- Steve
