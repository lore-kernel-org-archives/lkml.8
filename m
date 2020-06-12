Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A909E2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:40:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgFLIkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:40:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BE8BAC79;
        Fri, 12 Jun 2020 08:40:54 +0000 (UTC)
Date:   Fri, 12 Jun 2020 10:40:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] printk for 5.8
Message-ID: <20200612084049.GC4311@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull one more printk fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.8-kdb-nmi

==========================

+ Make sure that messages printed from KDB context are redirected to KDB
  console handlers. It did not work when KDB interrupted NMI or printk_safe
  contexts.

===========================

Arm people started hitting this problem more often recently. I forgot
to add the fix into the previous pull request by mistake.

----------------------------------------------------------------
Petr Mladek (1):
      printk/kdb: Redirect printk messages into kdb in any context

 kernel/printk/printk.c      | 14 +-------------
 kernel/printk/printk_safe.c |  7 +++++++
 2 files changed, 8 insertions(+), 13 deletions(-)
