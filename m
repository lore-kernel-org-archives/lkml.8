Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DCCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EE72073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBMJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:51:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:41144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMJvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:51:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86587ADE0;
        Thu, 13 Feb 2020 09:51:47 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 0/3] printk/console: Fix preferred console handling
Date:   Thu, 13 Feb 2020 10:51:30 +0100
Message-Id: <20200213095133.23176-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I send this on behalf of Benjamin who is traveling at the moment.
It is an interesting approach to long terms problems with matching
the console preferred on the command line.

Changes against v3:

	+ better check when accepting pre-enabled consoles
	+ correct reasoning in the 3rd patch
	+ update a comment of CON_CONSDEV definition
	+ fixed checkpatch warnings

Best Regards,
Petr

Benjamin Herrenschmidt (3):
  printk: Move console matching logic into a separate function
  printk: Fix preferred console selection with multiple matches
  printk: Correctly set CON_CONSDEV even when preferred console was not
    registered

 include/linux/console.h         |   2 +-
 kernel/printk/console_cmdline.h |   1 +
 kernel/printk/printk.c          | 122 +++++++++++++++++++++++++---------------
 3 files changed, 80 insertions(+), 45 deletions(-)

-- 
2.16.4

