Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A47C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8D620706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgHYJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgHYJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:36:50 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E03C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:36:49 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BbP5W1S1Szvjc1; Tue, 25 Aug 2020 11:36:47 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fork: adjust sysctl_max_threads definition to match prototype
Date:   Tue, 25 Aug 2020 11:36:47 +0200
Message-Id: <20200825093647.24263-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
definition of sysctl_max_threads to match its prototype in
linux/sysctl.h which fixes the following sparse error/warning:

kernel/fork.c:3050:47: warning: incorrect type in argument 3 (different address spaces)
kernel/fork.c:3050:47:    expected void *
kernel/fork.c:3050:47:    got void [noderef] __user *buffer
kernel/fork.c:3036:5: error: symbol 'sysctl_max_threads' redeclared with different type (incompatible argument 3 (different address spaces)):
kernel/fork.c:3036:5:    int extern [addressable] [signed] [toplevel] sysctl_max_threads( ... )
kernel/fork.c: note: in included file (through include/linux/key.h, include/linux/cred.h, include/linux/sched/signal.h, include/linux/sched/cputime.h):
./include/linux/sysctl.h:242:5: note: previously declared as:
./include/linux/sysctl.h:242:5:    int extern [addressable] [signed] [toplevel] sysctl_max_threads( ... )

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 04975f582015..494ed46dd061 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3034,7 +3034,7 @@ int unshare_files(struct files_struct **displaced)
 }
 
 int sysctl_max_threads(struct ctl_table *table, int write,
-		       void __user *buffer, size_t *lenp, loff_t *ppos)
+		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int ret;
-- 
2.27.0

