Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4545C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEB620B80
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgGBHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:44:12 -0400
Received: from mail1.windriver.com ([147.11.146.13]:36355 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgGBHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:44:11 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0627hsM6005513
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 2 Jul 2020 00:43:55 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 00:43:35 -0700
From:   <qiang.zhang@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] locking/percpu-rwsem: Remove WQ_FLAG_EXCLUSIVE flags
Date:   Wed, 1 Jul 2020 13:57:20 +0800
Message-ID: <20200701055720.38092-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Remove WQ_FLAG_EXCLUSIVE from "wq_entry.flags", using function
__add_wait_queue_entry_tail_exclusive substitution.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/locking/percpu-rwsem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 8bbafe3e5203..48e1c55c2e59 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -148,8 +148,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	 */
 	wait = !__percpu_rwsem_trylock(sem, reader);
 	if (wait) {
-		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
-		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
+		wq_entry.flags |= reader * WQ_FLAG_CUSTOM;
+		__add_wait_queue_entry_tail_exclusive(&sem->waiters, &wq_entry);
 	}
 	spin_unlock_irq(&sem->waiters.lock);
 
-- 
2.24.1

