Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0A520578
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgETDjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:39:54 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:58208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726352AbgETDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:39:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BEB2F1802DDF9;
        Wed, 20 May 2020 03:39:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twig72_020d59926d12
X-Filterd-Recvd-Size: 1986
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2020 03:39:51 +0000 (UTC)
Message-ID: <8db90830ee62b7561641ac8ff6979cf33555c90f.camel@perches.com>
Subject: [PATCH V2] lockdep: Use different indentation in
 print_lock_class_header/print_lock_trace
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Date:   Tue, 19 May 2020 20:39:50 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code that uses the printk return value in
kernel/locking/lockdep.c is odd because the printk
return value includes both the length of a KERN_<LEVEL>
prefix and a newline.  depth is also double counted.

Change the code to use depth + 3 + strlen.

Signed-off-by: Joe Perches <joe@perches.com>
---

v2: sigh: add missing close parenthesis, dunno what happened

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
+					 depth + 3 + strlen(usage_str[bit]));
 		}
 	}
 	printk("%*s }\n", depth, "");




