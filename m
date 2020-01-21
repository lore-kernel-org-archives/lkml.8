Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07FC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A42E2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAUDna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:43:30 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49716 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgAUDna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:43:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ToGbvL3_1579578206;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToGbvL3_1579578206)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 11:43:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OCFS2: remove dlm_lock_is_remote
Date:   Tue, 21 Jan 2020 11:43:23 +0800
Message-Id: <1579578203-254451-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macros is also not used from it was introduced. better to remove
it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com> 
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
Cc: Kate Stewart <kstewart@linuxfoundation.org> 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Richard Fontana <rfontana@redhat.com> 
Cc: ocfs2-devel@oss.oracle.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ocfs2/dlm/dlmthread.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 2dd9727537fe..0da9ffc40a88 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -39,8 +39,6 @@
 static int dlm_thread(void *data);
 static void dlm_flush_asts(struct dlm_ctxt *dlm);
 
-#define dlm_lock_is_remote(dlm, lock)     ((lock)->ml.node != (dlm)->node_num)
-
 /* will exit holding res->spinlock, but may drop in function */
 /* waits until flags are cleared on res->state */
 void __dlm_wait_on_lockres_flags(struct dlm_lock_resource *res, int flags)
-- 
1.8.3.1

