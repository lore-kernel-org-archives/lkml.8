Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF50C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E92070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgE3FjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 01:39:20 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52852 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbgE3FjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:39:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wetp.zy@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U-0OSNd_1590817116;
Received: from localhost(mailfrom:wetp.zy@linux.alibaba.com fp:SMTPD_---0U-0OSNd_1590817116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 May 2020 13:38:43 +0800
From:   Wetp Zhang <wetp.zy@linux.alibaba.com>
To:     n-horiguchi@ah.jp.nec.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm, memory_failure: don't send BUS_MCEERR_AO for action required error
Date:   Sat, 30 May 2020 13:38:36 +0800
Message-Id: <1590817116-21281-1-git-send-email-wetp.zy@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes dont't want to be killed early, but in "Action Required"
case, those also may be killed by BUS_MCEERR_AO when sharing memory
with other which is accessing the fail memory.
And sending SIGBUS with BUS_MCEERR_AO for action required error is
strange, so ignore the non-current processes here.

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
---
 mm/memory-failure.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a96364be8ab4..dd3862fcf2e9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -210,14 +210,17 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 {
 	struct task_struct *t = tk->tsk;
 	short addr_lsb = tk->size_shift;
-	int ret;
+	int ret = 0;
 
-	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-		pfn, t->comm, t->pid);
+	if ((t->mm == current->mm) || !(flags & MF_ACTION_REQUIRED))
+		pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+			pfn, t->comm, t->pid);
 
-	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
-		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
-				       addr_lsb);
+	if (flags & MF_ACTION_REQUIRED) {
+		if (t->mm == current->mm)
+			ret = force_sig_mceerr(BUS_MCEERR_AR,
+					 (void __user *)tk->addr, addr_lsb);
+		/* send no signal to non-current processes */
 	} else {
 		/*
 		 * Don't use force here, it's convenient if the signal
-- 
2.14.3 (Apple Git-98)

