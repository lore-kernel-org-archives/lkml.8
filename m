Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B33120657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgESMlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:41:51 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:42646 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726471AbgESMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:41:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 91B49100E7B40;
        Tue, 19 May 2020 12:41:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horn52_380766326d0d
X-Filterd-Recvd-Size: 1957
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 12:41:48 +0000 (UTC)
Message-ID: <335067f871a85db5f24650a3dff96f19727bed50.camel@perches.com>
Subject: lockdep tracing and using of printk return value ?
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Tue, 19 May 2020 05:41:47 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except for some ancient code in drivers/scsi, this code
may be the only kernel use of the printk return value.

Code that uses the printk return value in
kernel/locking/lockdep.c is odd because the printk
return length includes both the length of a KERN_<LEVEL>
prefix and the newline.  depth also seems double counted.

Perhaps there's a better way to calculate this?

Maybe:
---
 kernel/locking/lockdep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fadc2635946..265227edc550 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1960,11 +1960,9 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
-			int len = depth;
-
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
-			len += printk(KERN_CONT " at:\n");
-			print_lock_trace(class->usage_traces[bit], len);
+			printk("%*s   %s at:\n", depth, "", usage_str[bit]);
+			print_lock_trace(class->usage_traces[bit],
+					 depth + 3 + strlen(usage_str[bit]);
 		}
 	}
 	printk("%*s }\n", depth, "");


